# 🏦 Bank Loan Management System — Database Testing Project

### A Comprehensive Database Testing Project | MySQL • SQL • Jira

![Project Type](https://img.shields.io/badge/Project-Database%20Testing-0052CC?style=for-the-badge)
![Database](https://img.shields.io/badge/Database-MySQL-4479A1?style=for-the-badge\&logo=mysql\&logoColor=white)
![Test Management](https://img.shields.io/badge/Test%20Management-Jira-0052CC?style=for-the-badge\&logo=jira\&logoColor=white)
![Testing](https://img.shields.io/badge/Testing-Manual%20%7C%20SQL-2E8B57?style=for-the-badge)

## 📌 Project Overview

The **Bank Loan Management System — Database Testing Project** is a comprehensive software testing project focused on validating the functionality, integrity, consistency, and reliability of a banking database using SQL queries and structured testing methodologies.

The project simulates core banking operations, including customer management, account creation, loan processing, financial transactions, and related banking activities.

The primary objective is to ensure that database operations behave according to business requirements, relationships between tables remain consistent, and financial data is handled accurately.

The project covers the testing lifecycle, starting with requirements analysis and test planning and continuing through test design, execution, defect reporting, User Acceptance Testing (UAT), and test closure.

> **Project Focus:** Database Testing, SQL Validation, Requirements Analysis, Test Design, Defect Management, and Business Rule Verification.

---

## 🔗 Project Links

| Resource              | Link                                                                                                               |
| --------------------- | ------------------------------------------------------------------------------------------------------------------ |
| 📂 GitHub Repository  | [BLMS-Database](https://github.com/AmrMohamed222/BLMS-Database)                                                    |
| 🎯 Jira Project Board | [Bank Loan Management System — Jira](https://amrm91432.atlassian.net/jira/software/projects/RHA/boards/34/backlog) |

---

## 🛠️ Tools & Technologies

| Tool / Technology  | Purpose                                                       |
| ------------------ | ------------------------------------------------------------- |
| **MySQL**          | Database queries, data validation, and test execution         |
| **SQL**            | Data retrieval, insertion, updates, and database verification |
| **Jira**           | Test management, defect tracking, and project monitoring      |
| **Manual Testing** | Functional testing and business rule validation               |
| **Excel / CSV**    | Test documentation and structured test data, where applicable |
| **Git & GitHub**   | Project version control and portfolio presentation            |

---

## 🏗️ System Modules Under Test

The project covers the following core banking modules:

| Module                     | Testing Scope                                                          |
| -------------------------- | ---------------------------------------------------------------------- |
| **Branch Management**      | Branch records, data validity, and relationships                       |
| **Customer Management**    | Customer information, required fields, and data integrity              |
| **Account Management**     | Account creation, account data, and customer relationships             |
| **Loan Management**        | Loan information, loan parameters, and status validation               |
| **Collateral Management**  | Collateral records and their relationships with loans                  |
| **Transaction Management** | Deposits, withdrawals, loan disbursements, and transaction consistency |
| **Fees & Penalties**       | Fee and penalty records and applicable business rules                  |
| **Employee Management**    | Employee information and database integrity                            |

---

## 🔍 Testing Activities & Methodology

### 1. Requirements Analysis

* Reviewed the provided requirements and database-related specifications.
* Analyzed expected system behavior and business rules.
* Identified requirement gaps, ambiguities, and missing validation rules.
* Discussed unclear requirements with the relevant stakeholder/instructor.
* Translated requirements into testable scenarios.

### 2. Test Planning & Estimation

* Prepared the Test Plan.
* Defined the testing scope and objectives.
* Identified the required test scenarios and testing activities.
* Performed test analysis and estimation.
* Organized test documentation and execution activities.

### 3. Test Design

* Designed test cases based on requirements and SQL queries.
* Covered positive and negative testing scenarios.
* Validated required fields, data types, constraints, and relationships.
* Designed scenarios for database operations and business rule verification.
* Documented preconditions, test steps, test data, test environments, and expected results.

### 4. Database Testing & SQL Validation

Executed database-focused validation using SQL queries, including:

* Data insertion and record creation.
* Data retrieval and query result validation.
* Data updates and verification of modified values.
* Validation of Primary Keys and Foreign Keys.
* Referential integrity and relationship validation.
* Required-field and constraint validation.
* Duplicate and invalid data scenarios.
* Business rule verification.
* Validation of database state against expected results.

### 5. Defect Management

* Identified and documented defects during testing.
* Recorded reproduction steps, expected results, actual results, and relevant test environments.
* Reported and tracked defects using Jira.
* Verified fixes through retesting where applicable.
* Evaluated the impact of defects on data integrity and business operations.

### 6. User Acceptance Testing (UAT)

* Validated database behavior against business requirements.
* Reviewed whether the tested functionality met the expected acceptance criteria.
* Verified relevant database records and query results.
* Documented testing observations and outcomes.

### 7. Test Reporting & Closure

* Prepared test execution summaries.
* Documented testing outcomes and outstanding issues.
* Reviewed the status of test cases and reported defects.
* Prepared Test Summary and Test Closure documentation.

---

## 💳 Banking Business Rules Validation

A major part of the project focuses on verifying banking-related business rules and maintaining financial data consistency.

Examples of testing scenarios include:

* Verify that valid customer information can be stored correctly.
* Verify that account records maintain valid relationships with customer records.
* Verify that loan records contain valid and consistent loan information.
* Verify that transactions are recorded with the correct transaction details.
* Verify that deposits and withdrawals are reflected correctly in account balances, according to the applicable requirements.
* Verify that withdrawals exceeding the available balance are rejected when required by the business rules.
* Verify that loan disbursement transactions are handled consistently with the expected account balance behavior.
* Verify that invalid or inconsistent relational data is rejected where database constraints apply.
* Verify that database updates produce the expected results.

**Important:** These scenarios represent the intended validation scope. Actual pass/fail results depend on the executed test cases and their documented outcomes.

---

## 🧪 Test Documentation

The project uses structured test documentation to support traceability, repeatability, and defect investigation.

### Test Cases

Test cases are documented using fields such as:

* Test Case ID
* Test Case Title
* Preconditions
* Test Steps
* Test Data
* Test Environment
* Expected Result
* Actual Result
* Execution Status

### Bug Reports

Defects are documented with relevant information, including:

* Bug ID
* Bug Title
* Description
* Preconditions
* Steps to Reproduce
* Expected Result
* Actual Result
* Environment
* Status

### Test Management

Jira is used to organize project activities and track testing work, including test cases, reported defects, and project progress.

📌 **Explore the project:** [Open the Jira Project Board](https://amrm91432.atlassian.net/jira/software/projects/RHA/boards/34/backlog)

---

## 📊 Project Highlights

The project demonstrates practical experience in:

* Requirements analysis and gap identification.
* Test planning and test estimation.
* Test case design and execution.
* SQL-based database verification.
* Data integrity and referential integrity testing.
* Validation of database constraints and business rules.
* Defect reporting and tracking through Jira.
* Retesting and test documentation.
* User Acceptance Testing.
* Test Summary and Test Closure reporting.

---

## 💡 Key Challenges & Learning Outcomes

### Challenge: Requirements Gaps

**Approach:** Analyzed ambiguous or missing requirements, identified gaps, and discussed the necessary clarifications before defining the relevant test scenarios.

### Challenge: Database Relationships

**Approach:** Validated relationships between banking entities and checked the consistency of related records using SQL queries and database constraints.

### Challenge: Financial Data Consistency

**Approach:** Designed scenarios to validate transaction records and expected account balance behavior against the applicable banking business rules.

### Challenge: Defect Documentation

**Approach:** Documented defects with reproducible steps and clear expected-versus-actual results to support investigation and retesting.

---

## 🎯 Skills Demonstrated

`Database Testing` · `SQL` · `MySQL` · `Manual Testing` · `Requirements Analysis` · `Gap Analysis` · `Test Planning` · `Test Estimation` · `Test Case Design` · `Test Execution` · `Data Integrity Testing` · `Referential Integrity` · `Business Rule Validation` · `Negative Testing` · `Defect Reporting` · `Jira` · `UAT` · `Test Summary` · `Test Closure`

---

## 📁 Repository Structure

The repository contains the project materials available in the GitHub repository.

Typical project artifacts may include:

* Database schema and table definitions.
* SQL scripts and validation queries.
* Test cases and supporting test data.
* Testing documentation and reports.
* Other project-related resources.

Refer to the repository files for the actual available artifacts.

---

## 👨‍💻 Author

**Amr Mohamed**

Software Tester | Database Testing | SQL | MySQL | Jira

🔗 **GitHub:** [AmrMohamed222](https://github.com/AmrMohamed222)

🔗 **LinkedIn:** [Amr Mohamed](https://www.linkedin.com/in/amr-mohamed-46b303215)

---

⭐ If you find this project useful, feel free to explore the repository and review the project documentation.
