# 🏦 Bank Customer Churn Prediction  

### 📘 Overview  
This project predicts whether a customer will **churn (leave the bank)** using demographic and account activity data.  
It demonstrates an **end-to-end data analytics and machine learning workflow**, including data cleaning, EDA, model training, and insight visualization.  

The goal is to help banks identify at-risk customers early and design retention strategies.

---

## 🚀 Project Workflow  

| Step | Description |
|------|--------------|
| **1. Data Loading & Understanding** | Loaded the dataset of 10,000+ bank customers from Kaggle. |
| **2. Data Cleaning & Preprocessing** | Handled missing values, encoded categorical variables, and standardized numeric features. |
| **3. Exploratory Data Analysis (EDA)** | Visualized churn distribution, geography-wise churn, and correlations using Seaborn & Matplotlib. |
| **4. Model Building** | Trained Logistic Regression and Random Forest classifiers to predict churn. |
| **5. Model Evaluation** | Compared models using accuracy, recall, precision, F1-score, and ROC-AUC. |
| **6. Insights & Visualization** | Highlighted key churn drivers and created a Power BI dashboard for business interpretation. |

---

## 🧠 Machine Learning Models  
| Model | Accuracy | ROC-AUC | Recall (Churn=1) | Comments |
|--------|-----------|----------|------------------|-----------|
| Logistic Regression | 81% | 0.58 | 0.20 | Baseline linear model |
| Random Forest | 87% | 0.72 | 0.48 | Best performance; captures non-linear relationships |

---

## 📊 Key Insights  

- **Geography:** Customers from Germany had the highest churn rate.  
- **Tenure:** Customers with shorter tenure were more likely to churn.  
- **Activity Level:** Inactive customers showed significantly higher churn probability.  
- **Credit Score:** Lower credit scores correlated with higher churn rates.  

---

## 🧰 Tech Stack  

**Languages & Libraries:**  
- Python (Pandas, NumPy, scikit-learn, Seaborn, Matplotlib)  
- Power BI (for visualization)  

**Tools:**  
- Google Colab (for implementation)  
- Kaggle (for dataset)  

---

## 📈 Results Summary  

- Achieved **87% accuracy** and **0.72 ROC-AUC** using Random Forest.  
- Identified key churn drivers influencing customer retention.  
- Created a Power BI dashboard to support **data-driven retention strategies**.  

## 📎 Dataset  
**Source:** [Kaggle - Bank Customer Churn Dataset](https://www.kaggle.com/datasets/mathchi/churn-for-bank-customers)  
**Rows:** 10,000  
**Target:** `Exited` (1 = churned, 0 = retained)

