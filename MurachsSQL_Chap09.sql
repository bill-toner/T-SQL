/*
  Murach's SQL Server 2022 Chapter 09
*/

Use AP;

--1
Select VendorContactFName + ' ' + Substring(VendorContactLName, 1, 1) + '.' as 'Contact',
  Substring(VendorPhone, 2, 3) as 'Phone'
From AP.dbo.Vendors
Where Substring(VendorPhone, 2, 3) = '559';


--2
Select InvoiceNumber, 
  InvoiceTotal - (PaymentTotal + CreditTotal) as 'BalanceDue',
  InvoiceDueDate
From AP.dbo.Invoices
Where InvoiceTotal - (PaymentTotal + CreditTotal) > 0
  and InvoiceDueDate > (GetDate() - 180);

--6
Select InvoiceNumber, 
  InvoiceTotal - (PaymentTotal + CreditTotal) as 'BalanceDue',
  InvoiceDueDate, 
  Rank() Over ( Order By InvoiceTotal - PaymentTotal - CreditTotal Desc) as 'Balance Rank'
From AP.dbo.Invoices
Where InvoiceTotal - (PaymentTotal + CreditTotal) > 0
  and InvoiceDueDate > (GetDate() - 180);
