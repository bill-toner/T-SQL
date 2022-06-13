--1 
Select Distinct VendorName
From Vendors
--Join Invoices on Vendors.VendorID = Invoices.VendorID
Where VendorID in (Select Distinct VendorID from Invoices)

Order By VendorName;

--2
With EarliestInvoices as (
  Select VendorID, Min(InvoiceDate) as 'InvoiceDate'
  From Invoices
  Group By VendorID)

Select VendorName, InvoiceNumber, ei.InvoiceDate, InvoiceTotal
From Vendors v
Join Invoices i on v.VendorID = i.VendorID
Join EarliestInvoices ei on v.VendorID = ei.VendorID
Order By InvoiceDate;

--3 
Select  InvoiceNumber, InvoiceTotal
From Invoices
Where PaymentTotal > All (
  Select Top 50 Percent PaymentTotal From Invoices Where PaymentTotal <> 0 Order By PaymentTotal)
Order By InvoiceTotal Desc;

--5
Select VendorName, i.InvoiceId, InvoiceSequence, InvoiceLineItemAmount
From Vendors v
Join Invoices i on v.VendorID = i.VendorID
Join InvoiceLineItems li on i.InvoiceID = li.InvoiceID
Where InvoiceSequence > 2;

--6
Select Sum(InvoiceTotal) as Sum_Of_Highest_InvoiceTotals 
From
(Select Max(InvoiceTotal) as InvoiceTotal
From Invoices
Group By VendorID) as HighestInvoiceTotals;

--8
With EarliestInvoices as (
  Select VendorID, Min(InvoiceDate) as 'InvoiceDate'
  From Invoices
  Group By VendorID)

Select VendorName, InvoiceNumber, ei.InvoiceDate, InvoiceTotal
From Vendors v
Join Invoices i on v.VendorID = i.VendorID
Join EarliestInvoices ei on v.VendorID = ei.VendorID
Order By InvoiceDate;
