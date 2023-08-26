/*
  Murach's SQL Server Chapter 14
*/

--1
Use Ap;

Declare @invoiceCount int,
	@totalDue money;

Select @invoiceCount = Count(*), 
  @totalDue = Sum(InvoiceTotal - (CreditTotal + PaymentTotal))
From dbo.Invoices
Where InvoiceTotal - (CreditTotal + PaymentTotal) > 0

If @totalDue >= 30000
  Begin
	  Print 'Invoice count: ' + Convert(varchar, @invoiceCount)
	  Print 'Total due:     ' + Convert(varchar, @totalDue);
  End
Else
  Print 'Total balance is less that $30,000';


--2
Use Ap;

Declare @balanceDue money;
Declare @balances table
		(
		VendorName varchar(50),
		InvoiceNumber varchar(50),
		InvoiceDueDate date,
		Balance money
		);

Select @balanceDue = Sum(InvoiceTotal - CreditTotal - PaymentTotal)
From dbo.Invoices;

If @balanceDue > 10000
  Begin
	Insert @balances
	Select v.VendorName, i.InvoiceNumber, i.InvoiceDueDate, 
	   i.InvoiceTotal - i.CreditTotal - i.PaymentTotal as 'Balance'
	From dbo.Invoices  i
	Join dbo.Vendors v on i.VendorID = v.VendorID
	Order By i.InvoiceDueDate;
	Select *
	From @balances;
  End
Else
  Print 'Balance due is less than $10,000';

--3
Use Ap;

Drop Table If Exists #temp;

Select VendorName, FirstInvoiceDate, InvoiceTotal
Into #temp
From Invoices i
  Join (Select VendorID, Min(InvoiceDate) as FirstInvoiceDate
       From Invoices
	   Group By VendorID) as fi
	on i.VendorID = fi.VendorID
	and i.InvoiceDate = fi.FirstInvoiceDate
  Join Vendors v
    on i.VendorID = v.VendorID
Order By VendorName, FirstInvoiceDate;

Select * 
From #temp;

--4
Use Ap;

Drop View If Exists vw_FirstInvoices;
Go

Create View vw_FirstInvoices
as
Select VendorID, Min(InvoiceDate) as FirstInvoiceDate
From dbo.Invoices
Group By VendorID;
Go

Select VendorName, FirstInvoiceDate, InvoiceTotal
From Invoices i
Join vw_FirstInvoices fi
  on i.VendorID = fi.VendorID
  and i.InvoiceDate = fi.FirstInvoiceDate
Join Vendors v
  on i.VendorID = v.VendorID
Order By VendorName, FirstInvoiceDate;

--5
Use Ap;

Drop Table If Exists #InvoiceCopy;

Select * 
Into #InvoiceCopy 
From dbo.Invoices;

Update #InvoiceCopy
Set CreditTotal = CreditTotal + 100
Where (InvoiceTotal - CreditTotal - PaymentTotal) > 100;

Select * 
From #InvoiceCopy;

--6
Use Ap;

Drop Table If Exists #InvoiceCopy;

Select * 
Into #InvoiceCopy 
From dbo.Invoices;

While (Select Count(*)
      From #InvoiceCopy 
	  Where (InvoiceTotal - CreditTotal - PaymentTotal > 100)) > 0
  Begin
	Update #InvoiceCopy
	Set CreditTotal = CreditTotal + 100
	Where (InvoiceTotal - CreditTotal - PaymentTotal) > 100;
  End

Select * 
From #InvoiceCopy;

--7
Use Ap;

Begin Try
  Update Invoices
  Set InvoiceDate = Null;
  Print 'Row update succeeded'
End Try
Begin Catch
  Print 'Error ' + Convert(varchar, Error_Number(), 1) + ': ' + Error_Message();
End Catch;