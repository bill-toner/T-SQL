/*
  Murach's SQL Server Chapter 08
*/

Use AP;

--1
Select Cast(InvoiceTotal as decimal(10,2)) as 'Decimal Cast',
	   Cast(InvoiceTotal as varchar(10)) as 'VarChar Cast',
	   Convert(decimal(10,2), InvoiceTotal) as 'Decimal Convert',
	   Convert(varchar(10), InvoiceTotal, 1) as 'VarChar Convert'
From AP.dbo.Invoices;

--2
Select Cast(InvoiceDate as varchar(10)) as 'VarChar Cast',
	   Try_Convert(varchar(10), InvoiceDate, 1) as 'Try Convert VarChar Style 1',
	   Try_Convert(varchar(10), InvoiceDate, 10) as 'Try Convert VarChar Style 10'
From AP.dbo.Invoices;