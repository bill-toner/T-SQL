/*
  Murach's SQL Server 2022 Chapter 13
*/

--1
Use AP;

Create View InvoiceBasic as
Select v.VendorName, i.InvoiceNumber, i.InvoiceTotal 
From AP.dbo.Invoices as i
Join AP.dbo.VendorCopy as v
  on i.VendorID = v.VendorID;

--2
Select * 
From InvoiceBasic
Where VendorName like '[N,O,P]%'
Order By VendorName;

--3
Create View Top10PaidInvoices as
Select Top 10 v.VendorName, 
	Max(i.InvoiceDate) as 'Last Invoice', 
	Sum(i.InvoiceTotal) as 'Sum of Invoices'
From AP.dbo.Invoices i
Join AP.dbo.Vendors v
  on i.VendorID = v.VendorID
Where i.InvoiceTotal - (i.CreditTotal + i.PaymentTotal) = 0
Group By v.VendorName
Order By Sum(i.InvoiceTotal) Desc;

Select * 
From Top10PaidInvoices;

--4
Create View VendorAddress as 
Select VendorID, VendorAddress1, VendorAddress2, 
		VendorCity, VendorState, VendorZipCode
From AP.dbo.Vendors;

--5
Select *
From VendorAddress
Where VendorID = 4;

--6
Update VendorAddress
Set VendorAddress1 = '1990 Westwood Blvd', 
    VendorAddress2 = 'Ste 260'
Where VendorID = 4;

--7
Select * 
From sys.foreign_keys;