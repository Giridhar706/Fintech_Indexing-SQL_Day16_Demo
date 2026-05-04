# FinTech Indexing Strategy (SQL Server)

## 📌 Overview

This project demonstrates how indexing improves database performance in a FinTech banking system.

It focuses on:

* Faster transaction lookups
* Efficient fraud detection
* Optimized query performance for reporting

---

## 🧩 Problem Statement

The system faced:

* Slow transaction searches
* Delay in fraud detection queries
* High latency in dashboards

---

## 🗂️ Table Used

**Transactions**
(TxnID, AccountID, Amount, TxnDate, Status, MerchantID)

---

## 🚀 Indexing Strategy (User Stories)

### ✅ US1: Fast lookup by AccountID

* Implemented using: **Non-Clustered Index on AccountID**

### ✅ US2: Latest transactions sorted by date

* Implemented using: **Index on TxnDate**

### ✅ US3: Unique Transaction ID

* Implemented using: **Primary Key on TxnID**

### ✅ US4: Multi-condition filtering

* Implemented using: **Composite Index (AccountID, Status)**

### ✅ US5: Fraud detection (FAILED transactions)

* Implemented using: **Filtered Index on Status = 'FAILED'**

---

## 🛠️ Key Features

* Safe script (runs multiple times without errors)
* Uses `IF NOT EXISTS` checks
* Designed for real-world FinTech scenarios

---

## 🧪 Sample Data

| TxnID | AccountID | Amount  | TxnDate      | Status  | MerchantID |
| ----- | --------- | ------- | ------------ | ------- | ---------- |
| 1     | 101       | 500.00  | Current Date | SUCCESS | 201        |
| 2     | 102       | 1200.00 | Current Date | FAILED  | 202        |
| 3     | 101       | 300.00  | Current Date | SUCCESS | 203        |

---

## 📊 Sample Output

### 🔹 US1: Transactions by AccountID

```sql
SELECT * FROM Transactions WHERE AccountID = 101;
```

| TxnID | AccountID | Amount | Status  |
| ----- | --------- | ------ | ------- |
| 1     | 101       | 500.00 | SUCCESS |
| 3     | 101       | 300.00 | SUCCESS |

---

### 🔹 US2: Latest Transactions

```sql
SELECT TOP 5 * FROM Transactions ORDER BY TxnDate DESC;
```

| TxnID | AccountID | Amount  | Status  |
| ----- | --------- | ------- | ------- |
| 1     | 101       | 500.00  | SUCCESS |
| 2     | 102       | 1200.00 | FAILED  |
| 3     | 101       | 300.00  | SUCCESS |

---

### 🔹 US4: Filter by AccountID + Status

```sql
SELECT * FROM Transactions WHERE AccountID = 101 AND Status = 'SUCCESS';
```

| TxnID | AccountID | Amount |
| ----- | --------- | ------ |
| 1     | 101       | 500.00 |
| 3     | 101       | 300.00 |

---

### 🔹 US5: Fraud Detection (FAILED)

```sql
SELECT * FROM Transactions WHERE Status = 'FAILED';
```

| TxnID | AccountID | Amount  |
| ----- | --------- | ------- |
| 2     | 102       | 1200.00 |

---

## 🎯 Conclusion

The implemented indexing strategy significantly improves query performance, reduces scan time, and ensures efficient handling of high-frequency financial transactions.

---

## 👩‍💻 Author

Giridhar Gopal
