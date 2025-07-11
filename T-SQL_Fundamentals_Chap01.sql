Use TSQLV6;

Drop Table If Exists dbo.Employees;

Create Table dbo.Employees
(
  EmpID  Int Not Null
  , FirstName Varchar(30)  Not Null
  , LastName  Varchar(30)  Not Null
  , HireDate  Date  Not Null 
  , MgrID  Int  Null
  , SSN  Varchar(20)  Not Null
  , Salary  Money  Not Null
);

-- PK Constraints
Alter Table dbo.Employees
Add Constraint PK_Employees
Primary Key(EmpID);

-- Unique Constraints
Alter Table dbo.Employees
Add Constraint UNQ_Employees_ssn
Unique(SSN);

-- Foreign Key Constraints
Drop Table If Exists dbo.Orders;

Create Table dbo.Orders
(
  OrderID  Int  Not Null
  , EmpID  Int  Not Null
  , CustID  Varchar(10)  Not Null
  , OrderTS  Datetime2  Not Null
  , Qty  Int  Not Null
  Constraint PK_Orders
    Primary Key(OrderID)
);

Alter Table dbo.Orders
  Add Constraint  FK_Orders_Employees
  Foreign Key(EmpID)
  References  dbo.Employees(EmpID);

Alter Table dbo.Employees
  Add Constraint FK_Employees_Employees
  Foreign Key(MgrID)
  References dbo.Employees(EmpID);

-- Check Constraints
Alter Table dbo.Employees
  Add Constraint  CHK_Employees_salary
  Check(Salary > 0.00);

-- Default Constraints
Alter Table dbo.Orders
  Add Constraint DFT_Orders_orderts
  Default(SysDateTime()) For OrderTS;

-- Drop Table If Exists dbo.Orders, dbo.Employees;