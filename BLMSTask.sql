DROP DATABASE IF EXISTS BLMS2;
CREATE DATABASE BLMS2;
USE BLMS2;

-- 1. BRANCHES TABLE
CREATE TABLE branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) UNIQUE NOT NULL,
    location VARCHAR(100)
);

INSERT INTO branches (branch_name, location)
VALUES ('Cairo Branch', '9 St El Mokattam');

-- 2. CUSTOMERS TABLE (Added 'age' column)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT NOT NULL,
    national_id CHAR(14) UNIQUE NOT NULL,
    nid_expiry_date DATE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    age INT NOT NULL CHECK (age > 21), 
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);


insert into customers( branch_id, national_id, nid_expiry_date, full_name, date_of_birth, age ,email, phone)
values
( 1 ,12345678910123,'2026-09-20' ,'Osama helmy salama kandel', '2002-09-20', 25 ,'osama@gmail.com', '0101234567'),
( 1 ,22345678910123,'2026-11-20 ','Mohamed helmy salama kandel', '2002-04-04',22 ,'Mohamed@gmail.com', '011111115');

-- 3. ACCOUNTS TABLE
CREATE TABLE accounts (
    account_number INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
	deposit DECIMAL(15,2) NOT NULL CHECK (deposit > 10000),
    account_type ENUM('Savings', 'Current', 'Loan', 'Overdraft', 'Wallet') NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00 CHECK (balance >= 0),
    account_status VARCHAR(50) CHECK (account_status IN ('active', 'not_active', 'blocked')),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
insert into accounts(deposit, customer_id, account_type, balance, account_status)
values
(50000 , 1, 'Savings' ,1000000, 'active'),
(20000, 2, 'Loan' ,50000, 'active');
select * from accounts;

-- 4. LOANS TABLE (Added total_collateral_amount & collateral_details)
CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    account_number INT NOT NULL,
    principal_amount DECIMAL(15,2) CHECK (principal_amount > 0),
    interest_rate DECIMAL(5,2) CHECK (interest_rate > 0),
    start_date DATE NOT NULL,
    term_months INT CHECK (term_months > 0),
    iScore INT NOT NULL CHECK (iScore BETWEEN 300 AND 850),
    loan_status VARCHAR(50) CHECK (loan_status IN ('approved', 'rejected', 'under review')),
    loan_type VARCHAR(50) CHECK (loan_type IN ('auto_loans', 'personal_loans', 'students_loans', 'Mortgages')),
    total_collateral_amount DECIMAL(15,2) DEFAULT 0.00,
    collateral_details TEXT,
    FOREIGN KEY (account_number) REFERENCES accounts(account_number)
);

INSERT INTO loans (account_number, principal_amount, interest_rate, start_date, term_months, iScore, loan_status, loan_type,total_collateral_amount,collateral_details)
VALUES
('2', '500000', '20', STR_TO_DATE('2/9/2026', '%d/%m/%Y'), 24, 600, 'under review', 'Mortgages','1000000','Property-Gold');
select * from loans;
-- 5. COLLATERALS TABLE
CREATE TABLE collaterals (
    collateral_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL,
    type ENUM('Property', 'Vehicle', 'Gold', 'Other') NOT NULL,
    value DECIMAL(15,2) CHECK (value >= 0),
    attachment BLOB not null,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

insert into collaterals(loan_id, type, value, attachment)
values (1, 'Gold', '5000000', 'Done');

-- 6. TRANSACTIONS TABLE
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_number INT NOT NULL,
    transaction_type ENUM('deposit', 'withdrawal', 'loan Disbursement', 'repayment') NOT NULL,
    transaction_amount DECIMAL(15,2) CHECK (transaction_amount > 0),
    transaction_date DATE NOT NULL,
    FOREIGN KEY (account_number) REFERENCES accounts(account_number)
);

insert into transactions(account_number, transaction_type, transaction_amount, transaction_date)
values (2, 'loan Disbursement', 10000,STR_TO_DATE('6/9/2026', '%d/%m/%Y'));

-- 7. FEES TABLE
DROP TABLE IF EXISTS fees;

CREATE TABLE fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    account_number INT NOT NULL,
    transaction_id INT,
    loan_id INT,
    fee_type VARCHAR(50) NOT NULL,
    percentage DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    amount DECIMAL(15,2) NOT NULL CHECK (amount >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_number) REFERENCES accounts(account_number),
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id) ON DELETE CASCADE,
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);
insert into fees(account_number, transaction_id, loan_id, fee_type, percentage, amount)
values (1, 1, 1, 'Overdraft', 5,50);
-- 8. EMPLOYEES TABLE
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    branch_id INT NOT NULL,
    department_employee VARCHAR(100) NOT NULL,
    location_employee VARCHAR(100) NOT NULL,
    phone_number_employee VARCHAR(20) UNIQUE NOT NULL,
    email_employee VARCHAR(50) UNIQUE NOT NULL,
    national_id_employee VARCHAR(14) UNIQUE NOT NULL,
    nid_expiry_date DATE NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- ==========================================
-- TRIGGERS SECTION (Automations & Validations)
-- ==========================================
DELIMITER $$

CREATE TRIGGER trg_calculate_transaction_fee
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    DECLARE fee_rate DECIMAL(5,2) DEFAULT 0.00;
    DECLARE calculated_fee DECIMAL(15,2) DEFAULT 0.00;
    DECLARE calculated_fee_type VARCHAR(50);

    -- Determine fee percentage based on transaction type
    IF NEW.transaction_type = 'withdrawal' THEN
        SET fee_rate = 2.00;
        SET calculated_fee_type = 'Withdrawal Fee';
    ELSEIF NEW.transaction_type = 'loan Disbursement' THEN
        SET fee_rate = 5.00;
        SET calculated_fee_type = 'Loan Administrative Fee';
    ELSEIF NEW.transaction_type = 'repayment' THEN
        SET fee_rate = 1.00;
        SET calculated_fee_type = 'Repayment Processing Fee';
    ELSEIF NEW.transaction_type = 'deposit' THEN
        SET fee_rate = 0.00;
        SET calculated_fee_type = 'Deposit Fee';
    END IF;

    -- Calculate exact fee amount
    SET calculated_fee = (NEW.transaction_amount * fee_rate) / 100.00;

    -- Insert record into fees table and update account balance if fee > 0
    IF calculated_fee > 0 THEN
        INSERT INTO fees (account_number, transaction_id, fee_type, percentage, amount)
        VALUES (NEW.account_number, NEW.transaction_id, calculated_fee_type, fee_rate, calculated_fee);

        UPDATE accounts
        SET balance = balance - calculated_fee
        WHERE account_number = NEW.account_number;
    END IF;
END$$

DELIMITER ;









DELIMITER $$

-- A. Validate Customer (Age >= 21, NID Expiry, Calculate Age)
CREATE TRIGGER trg_customers_before_insert
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    SET NEW.age = TIMESTAMPDIFF(YEAR, NEW.date_of_birth, CURDATE());

    IF NEW.nid_expiry_date <= CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction Failed: National ID is already expired.';
    END IF;

    IF NEW.age < 21 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction Failed: Customer must be at least 21 years old.';
    END IF;
END$$

-- B. Validate Employee NID Expiry
CREATE TRIGGER trg_employees_before_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.nid_expiry_date <= CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction Failed: Employee National ID is already expired.';
    END IF;
END$$

-- C. Prevent Opening Account if Customer is under 21 (Double Check)
CREATE TRIGGER trg_accounts_before_insert
BEFORE INSERT ON accounts
FOR EACH ROW
BEGIN
    DECLARE cust_age INT;
    SELECT age INTO cust_age FROM customers WHERE customer_id = NEW.customer_id;
    
    IF cust_age < 21 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Transaction Failed: Cannot open account. Customer is under 21 years old.';
    END IF;
END$$

-- D. Automate Account Balance based on Transactions
CREATE TRIGGER trg_transactions_after_insert
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    IF NEW.transaction_type = 'deposit' THEN
        UPDATE accounts SET balance = balance + NEW.transaction_amount WHERE account_number = NEW.account_number;
    ELSEIF NEW.transaction_type = 'withdrawal' THEN
        UPDATE accounts SET balance = balance - NEW.transaction_amount WHERE account_number = NEW.account_number;
    ELSEIF NEW.transaction_type = 'loan Disbursement' THEN
        UPDATE accounts SET balance = balance + NEW.transaction_amount WHERE account_number = NEW.account_number;
    ELSEIF NEW.transaction_type = 'repayment' THEN
        UPDATE accounts SET balance = balance - NEW.transaction_amount WHERE account_number = NEW.account_number;
    END IF;
END$$

-- E. Automate Collateral Totals & Details in Loans Table (AFTER INSERT)
CREATE TRIGGER trg_collaterals_after_insert
AFTER INSERT ON collaterals
FOR EACH ROW
BEGIN
    UPDATE loans
    SET total_collateral_amount = (
            SELECT COALESCE(SUM(value), 0) FROM collaterals WHERE loan_id = NEW.loan_id
        ),
        collateral_details = (
            SELECT GROUP_CONCAT(CONCAT(type, ': $', value) SEPARATOR ' | ') FROM collaterals WHERE loan_id = NEW.loan_id
        )
    WHERE loan_id = NEW.loan_id;
END$$

-- F. Automate Collateral Totals & Details in Loans Table (AFTER UPDATE)
CREATE TRIGGER trg_collaterals_after_update
AFTER UPDATE ON collaterals
FOR EACH ROW
BEGIN
    UPDATE loans
    SET total_collateral_amount = (
            SELECT COALESCE(SUM(value), 0) FROM collaterals WHERE loan_id = NEW.loan_id
        ),
        collateral_details = (
            SELECT GROUP_CONCAT(CONCAT(type, ': $', value) SEPARATOR ' | ') FROM collaterals WHERE loan_id = NEW.loan_id
        )
    WHERE loan_id = NEW.loan_id;
    
    IF OLD.loan_id <> NEW.loan_id THEN
        UPDATE loans
        SET total_collateral_amount = (
                SELECT COALESCE(SUM(value), 0) FROM collaterals WHERE loan_id = OLD.loan_id
            ),
            collateral_details = (
                SELECT GROUP_CONCAT(CONCAT(type, ': $', value) SEPARATOR ' | ') FROM collaterals WHERE loan_id = OLD.loan_id
            )
        WHERE loan_id = OLD.loan_id;
    END IF;
END$$

-- G. Automate Collateral Totals & Details in Loans Table (AFTER DELETE)
CREATE TRIGGER trg_collaterals_after_delete
AFTER DELETE ON collaterals
FOR EACH ROW
BEGIN
    UPDATE loans
    SET total_collateral_amount = (
            SELECT COALESCE(SUM(value), 0) FROM collaterals WHERE loan_id = OLD.loan_id
        ),
        collateral_details = (
            SELECT GROUP_CONCAT(CONCAT(type, ': $', value) SEPARATOR ' | ') FROM collaterals WHERE loan_id = OLD.loan_id
        )
    WHERE loan_id = OLD.loan_id;
END$$

DELIMITER ;

-- ================s==========================
-- TEST DATA INSERTS
-- ==========================================

-- Insert Customers (Notice age is calculated automatically)
INSERT INTO customers (deposit, branch_id, national_id, nid_expiry_date, full_name, date_of_birth, email, phone)
VALUES
(50000.00, 1, '12345678913123', '2028-12-31', 'Osama Helmy Salama', '2002-01-20', 'Sosama@gmail.com', '0101234567'),
(50000.00, 1, '22345678914123', '2029-06-15', 'Mohamed Helmy Salama', '2000-04-04', 'Smohamed@gmail.com', '0111111115');

-- Insert Accounts
INSERT INTO accounts (customer_id, account_type, balance, account_status)
VALUES (1, 'Savings', 1000000.00, 'active'), (2, 'Loan', 50000.00, 'active');

-- Insert Loan (Watch the collateral columns update automatically after next step)
INSERT INTO loans (account_number, principal_amount, interest_rate, start_date, term_months, iScore, loan_status, loan_type)
VALUES (2, 500000.00, 20.00, '2026-09-02', 24, 600, 'under review', 'Mortgages');

-- Insert Collaterals (Triggers E will fire here and update the Loans table)
INSERT INTO collaterals (loan_id, type, value, attachment)
VALUES 
(1, 'Gold', 500000.00, 1),
(1, 'Property', 1500000.00, 1),
(1, 'Vehicle', 300000.00, 0);

-- Insert Transactions (Trigger D will fire here to update account balances)
INSERT INTO transactions (account_number, transaction_type, transaction_amount, transaction_date)
VALUES (1, 'deposit', 50000.00, '2026-09-02');

-- View the results for Loans to see the automated Totals and Details
SELECT loan_id, principal_amount, total_collateral_amount, collateral_details FROM loans;