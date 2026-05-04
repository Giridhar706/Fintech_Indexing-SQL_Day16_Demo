
-- FINTECH INDEXING STRATEGY (EXACT USER STORIES)

USE BankDB;
GO

--US3: PRIMARY KEY (Unique Transaction ID)
  
IF OBJECT_ID('Transactions', 'U') IS NULL
BEGIN
    CREATE TABLE Transactions (
        TxnID INT PRIMARY KEY,     -- US3
        AccountID INT,
        Amount DECIMAL(10,2),
        TxnDate DATETIME,
        Status VARCHAR(20),
        MerchantID INT
    );
END
GO

/* US1: WHERE AccountID = ?
   Non-Clustered Index */
  
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes 
    WHERE name = 'IX_Transactions_AccountID'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Transactions_AccountID
    ON Transactions(AccountID);
END
GO

/* US2: ORDER BY TxnDate DESC
   Clustered Index (Handled carefully) */
   
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes 
    WHERE object_id = OBJECT_ID('Transactions') AND type = 1
)
BEGIN
    CREATE CLUSTERED INDEX IX_Transactions_TxnDate
    ON Transactions(TxnDate DESC);
END
GO

/* US4: WHERE AccountID AND Status
   Composite Index */

IF NOT EXISTS (
    SELECT 1 FROM sys.indexes 
    WHERE name = 'IX_Transactions_AccountID_Status'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Transactions_AccountID_Status
    ON Transactions(AccountID, Status);
END
GO

/* US5: WHERE Status = 'FAILED'
   Filtered Index */
 
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes 
    WHERE name = 'IX_Transactions_Failed'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Transactions_Failed
    ON Transactions(Status)
    WHERE Status = 'FAILED';
END
GO

-- SAMPLE DATA (FOR OUTPUT)
  
IF NOT EXISTS (SELECT 1 FROM Transactions)
BEGIN
    INSERT INTO Transactions VALUES
    (1, 101, 500.00, GETDATE(), 'SUCCESS', 201),
    (2, 102, 1200.00, GETDATE(), 'FAILED', 202),
    (3, 101, 300.00, GETDATE(), 'SUCCESS', 203);
END
GO

-- TEST QUERIES (MATCH USER STORIES)

-- US1
SELECT * FROM Transactions WHERE AccountID = 101;

-- US2
SELECT TOP 5 * FROM Transactions ORDER BY TxnDate DESC;

-- US4
SELECT * FROM Transactions 
WHERE AccountID = 101 AND Status = 'SUCCESS';

-- US5
SELECT * FROM Transactions 
WHERE Status = 'FAILED';