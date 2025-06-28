-- Date Bucket Example
Select Date_Bucket(Month, 1, InvoiceDate) as Month, 
  Sum(InvoiceTotal) as InvoiceTotal, 
  Avg(InvoiceTotal) as InvoiceAverage
From Invoices
Group By Date_Bucket(Month, 1, InvoiceDate);