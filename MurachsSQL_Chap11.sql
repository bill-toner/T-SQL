/*
  Murach's SQL Server 2022 Chap 11
*/

--1
Create Database Membership;

--2
Use Membership;

Create Table Individuals
(
	IndividualID  int  Not Null  Identity  Primary Key,
	FirstName  varchar  Not Null,
	LastName  varchar  Not Null,
	Address  varchar  Null,
	Phone  varchar  Null
);

Create Table Groups
(
	GroupID  int  Not Null Identity  Primary Key,
	GroupName  varchar  Not Null,
	Dues  money  Not Null  Default 0 Check (Dues > 0)
);

Create Table GroupMembership
(
	GroupID  int Not Null References Groups(GroupID),
	IndividualID  int Not Null  References Individuals(IndividualID)
);

--3
Create Clustered Index IX_GroupID
  on GroupMemberShip(GroupID);

Create Index IX_IndividualID
  on GroupMembership(IndividualID);

--4
Alter Table Individuals
Add DuesPaid  bit  Not Null  Default 0;

--5
Use AP;

Alter Table AP.dbo.Invoices
Add Check ((PaymentDate  Is Null and PaymentTotal = 0)  or
  (PaymentDate Is Not Null  and PaymentTotal > 0)),
  Check (PaymentTotal + CreditTotal <= InvoiceTotal);

--6
Use Membership;

Drop Table If Exists dbo.GroupMembership;

Create Table GroupMembership
(
	GroupID  int Not Null References Groups(GroupID),
	IndividualID  int Not Null  References Individuals(IndividualID),
	Unique (GroupID, IndividualID)
);

--7
Use Membership;

Select name, collation_name
From sys.databases
Where name = 'Membership';

--8
Alter Table Membership.dbo.Groups
Alter Column GroupName varchar(200)
  Collate Latin1_General_100_CI_AS_SC_UTF8;
