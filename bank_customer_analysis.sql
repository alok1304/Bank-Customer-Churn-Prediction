-- Queries for the 'Churn_Modelling' table (from Churn_Modelling.csv)
-- These queries help you understand your customer base and who is churning.

-- Query 1: Calculate the overall customer churn rate.
-- 'Exited' = 1 means the customer churned.
SELECT
  (SUM(Exited) * 100.0) / COUNT(*) AS OverallChurnRatePercent
FROM churn_modelling; 
-- result: 20.31

-- Query 2: Find the churn rate broken down by 'Geography'.
-- This helps identify if customers in certain regions are more likely to leave.
SELECT
  Geography,
  COUNT(*) AS TotalCustomers,
  SUM(Exited) AS ChurnedCustomers,
  (SUM(Exited) * 100.0) / COUNT(*) AS ChurnRatePercent
FROM churn_modelling
GROUP BY Geography
ORDER BY ChurnRatePercent DESC;

-- Query 3: Find the churn rate broken down by 'Gender'.
SELECT
  Gender,
  COUNT(*) AS TotalCustomers,
  SUM(Exited) AS ChurnedCustomers,
  (SUM(Exited) * 100.0) / COUNT(*) AS ChurnRatePercent
FROM churn_modelling
GROUP BY Gender;

-- Query 4: Compare the average profile of customers who churned vs. those who stayed.
-- This shows key differences between the two groups.
SELECT
  CASE WHEN Exited = 1 THEN 'Churned' ELSE 'Stayed' END AS CustomerStatus,
  AVG(CreditScore) AS AvgCreditScore,
  AVG(Age) AS AvgAge,
  AVG(Tenure) AS AvgTenure,
  AVG(Balance) AS AvgBalance,
  AVG(NumOfProducts) AS AvgNumOfProducts,
  AVG(EstimatedSalary) AS AvgEstimatedSalary
FROM churn_modelling
GROUP BY Exited;

-- Query 5: List high-value customers who churned.
-- e.g., Customers with high balance and good credit score who still left.
SELECT
  CustomerId,
  Surname,
  CreditScore,
  Balance,
  Age
FROM churn_modelling
WHERE
  Exited = 1
  AND Balance > 150000
  AND CreditScore > 700
ORDER BY Balance DESC;


-- Queries for the 'bank_churn_results' table (from bank_churn_results.csv)
-- These queries help you evaluate the performance of your churn prediction model.

-- Query 1: Calculate the overall model accuracy.
-- How often did the model's prediction match the actual outcome?
SELECT
  (SUM(CASE WHEN Exited = Predicted_Churn THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS ModelAccuracyPercent
FROM bank_churn_results;

-- Query 2: Generate the components of a Confusion Matrix.
-- This is the most important query for understanding model performance.
SELECT
  SUM(CASE WHEN Exited = 1 AND Predicted_Churn = 1 THEN 1 ELSE 0 END) AS TruePositives,
  SUM(CASE WHEN Exited = 0 AND Predicted_Churn = 0 THEN 1 ELSE 0 END) AS TrueNegatives,
  SUM(CASE WHEN Exited = 0 AND Predicted_Churn = 1 THEN 1 ELSE 0 END) AS FalsePositives,
  SUM(CASE WHEN Exited = 1 AND Predicted_Churn = 0 THEN 1 ELSE 0 END) AS FalseNegatives
FROM bank_churn_results;

-- Query 3: List the "False Negatives"
-- These are the MOST critical errors: Customers who CHURNED (Exited = 1)
-- but the model predicted they would STAY (Predicted_Churn = 0).
-- The bank needs to know who these people are.
SELECT
  CreditScore,
  Age,
  Tenure,
  Balance,
  NumOfProducts,
  EstimatedSalary
FROM bank_churn_results
WHERE
  Exited = 1 AND Predicted_Churn = 0;

-- Query 4: List the "False Positives"
-- Customers who STAYED (Exited = 0) but the model predicted
-- they would CHURN (Predicted_Churn = 1).
-- This represents wasted effort (e.g., giving discounts to happy customers).
SELECT
  CreditScore,
  Age,
  Tenure,
  Balance,
  NumOfProducts,
  EstimatedSalary
FROM bank_churn_results
WHERE
  Exited = 0 AND Predicted_Churn = 1;

-- Queries that join 'churn_modelling' (t1) and 'bank_churn_results' (t2).
-- This allows you to connect model predictions back to specific customer names.

-- NOTE: These files don't have a perfect shared key.
-- We will join them on a combination of features.
-- This assumes the combination of these columns is unique for each customer.

-- Query 1: Get the names of the "False Negatives"
-- This connects the critical errors from the model back to actual customer names.
SELECT
  t1.CustomerId,
  t1.Surname,
  t1.Geography,
  t1.Age,
  t1.Balance
FROM
  churn_modelling AS t1
JOIN
  bank_churn_results AS t2
  ON t1.CreditScore = t2.CreditScore
  AND t1.Age = t2.Age
  AND t1.Tenure = t2.Tenure
  AND t1.Balance = t2.Balance
  AND t1.NumOfProducts = t2.NumOfProducts
  AND t1.EstimatedSalary = t2.EstimatedSalary
  AND t1.Exited = t2.Exited
WHERE
  t2.Exited = 1 AND t2.Predicted_Churn = 0; -- The "False Negative" condition


-- Query 2: Check model predictions for high-balance customers from Germany.
-- This lets you spot-check how the model is performing on a specific segment.
SELECT
  t1.CustomerId,
  t1.Surname,
  t1.Balance,
  t1.Exited AS Actual_Churn,
  t2.Predicted_Churn
FROM
  churn_modelling AS t1
JOIN
  bank_churn_results AS t2
  ON t1.CreditScore = t2.CreditScore
  AND t1.Age = t2.Age
  AND t1.Tenure = t2.Tenure
  AND t1.Balance = t2.Balance
  AND t1.NumOfProducts = t2.NumOfProducts
  AND t1.EstimatedSalary = t2.EstimatedSalary
  AND t1.Exited = t2.Exited
WHERE
  t1.Geography = 'Germany'
  AND t1.Balance > 0
ORDER BY
  t1.Balance DESC;

