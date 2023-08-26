/*
  Murach's SQL Server 2022 Chapter 3
*/

--1
Select VendorContactFName, VendorContactLName, VendorName
From AP.dbo.Vendors
Order By VendorContactLName, VendorContactFName;

--2
Select InvoiceNumber as 'Number',
	InvoiceTotal as 'Total',
	PaymentTotal + CreditTotal as 'Credits',
	InvoiceTotal - (PaymentTotal + CreditTotal) as 'Balance'
From AP.dbo.Invoices;

--3
Select VendorContactLName + ', ' + VendorContactFName as 'Full Name'
From AP.dbo.Vendors
Order By VendorContactLName, VendorContactFName;

--4
Select InvoiceTotal,
	InvoiceTotal * 0.1 as '10%',
	InvoiceTotal * 1.1 as 'Plus 10%'
From AP.dbo.Invoices
Where InvoiceTotal - (PaymentTotal + CreditTotal) > 1000
Order By InvoiceTotal Desc;

--5
Select InvoiceNumber as 'Number',
	InvoiceTotal as 'Total',
	PaymentTotal + CreditTotal as 'Credits',
	InvoiceTotal - (PaymentTotal + CreditTotal) as 'Balance'
From AP.dbo.Invoices
Where InvoiceTotal Between 500 and 10000;

--6
Select VendorContactLName + ', ' + VendorContactFName as 'Full Name'
From AP.dbo.Vendors
Where VendorContactLName Like '[ABCE]%'
Order By VendorContactLName, VendorContactFName;

--7
Select *
From AP.dbo.Invoices
Where (PaymentDate Is Not Null and InvoiceTotal - (PaymentTotal + CreditTotal) > 0)
	or (PaymentDate Is Null and InvoiceTotal - (PaymentTotal + CreditTotal) = 0);

--Select Top 1 * From Invoices;