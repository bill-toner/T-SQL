/*
  Murach's SQL Server Chapter 06
*/

--1
Select Distinct VendorName
From Vendors
Where VendorID in (Select VendorID
       From Invoices)
Order By VendorName;

--2
Select InvoiceNumber, InvoiceTotal
From AP.dbo.Invoices
Where InvoiceTotal >
	(Select Avg(InvoiceTotal)
	From AP.dbo.Invoices
	Where InvoiceTotal - (PaymentTotal + CreditTotal) = 0)
Order By InvoiceTotal Desc;

--3
Select InvoiceNumber, PaymentTotal
From AP.dbo.Invoices
Where PaymentTotal > All
  -- Top 50 Percent sorted Ascending to find the median
  (Select Top 50 Percent PaymentTotal
   From AP.dbo.Invoices
   Where PaymentTotal <> 0
   Order By PaymentTotal);

--4
Select AccountNo, AccountDescription
From AP.dbo.GLAccounts gl
Where Not Exists (Select AccountNo
					From AP.dbo.InvoiceLineItems li
					Where gl.AccountNo = li.AccountNo)
Order By AccountNo;

--5
Select v.VendorName, i.InvoiceID, li.InvoiceSequence, li.InvoiceLineItemAmount
From Vendors v
Join Invoices i
  on v.VendorID = i.VendorID
Join InvoiceLineItems li
  on li.InvoiceID = i.InvoiceID
Where i.InvoiceID in (Select InvoiceID
       From InvoiceLineItems
	   Where InvoiceSequence > 1);

--6
Select Sum(InvoiceTotal) as 'Max Unpaid'
From (
Select Max(InvoiceTotal) as 'InvoiceTotal'
From AP.dbo.Invoices
Where InvoiceTotal - (PaymentTotal + CreditTotal) > 0
Group By VendorID) as MaxInvoices;

--7
Select VendorName, VendorCity, VendorState
From AP.dbo.Vendors
Where VendorCity + VendorState Not In (
  Select VendorCity + VendorState
  From AP.dbo.Vendors
  Group By VendorCity + VendorState
  Having Count(*) > 1)
Order By VendorName;

--8
Select v.VendorName, i.InvoiceNumber, i.InvoiceDate, i.InvoiceTotal
From AP.dbo.Vendors v
Join AP.dbo.Invoices i
  on v.VendorID = i.VendorID
Where i.InvoiceDate = (
 Select Min(InvoiceDate)
 From Invoices subi
 Where i.VendorID = subi.VendorID);

--9
With MaxInvoices as (
	Select Max(InvoiceTotal) as 'InvoiceTotal'
	From AP.dbo.Invoices
	Where InvoiceTotal - (PaymentTotal + CreditTotal) > 0
	Group By VendorID)
Select Sum(InvoiceTotal) as 'Max Total'
From MaxInvoices;