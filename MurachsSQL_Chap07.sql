/*
  Murach's SQL Server Chapter 07
*/

Use AP;

--1
Select *
Into VendorCopy 
From AP.dbo.Vendors;

Select * 
Into InvoiceCopy
From AP.dbo.Invoices;

--2
Select Top 1 *
From AP.dbo.InvoiceCopy;

Insert Into AP.dbo.InvoiceCopy (VendorID, 
								InvoiceTotal, 
								TermsID, 
								InvoiceNumber, 
								PaymentTotal, 
								InvoiceDueDate, 
								InvoiceDate, 
								CreditTotal, 
								PaymentDate)
Values (32, 434.58, 2, 'AX-014-027', 0.00, '2023-05-08', '2023-04-21', 0, null);

Select * 
From AP.dbo.InvoiceCopy
Where InvoiceNumber = 'AX-014-027';

--3
Insert Into AP.dbo.VendorCopy 
	(VendorName, VendorAddress1, VendorAddress2, VendorCity, VendorState, VendorZipCode, 
	VendorContactFName, VendorContactLName, DefaultTermsID, DefaultAccountNo)
Select VendorName, VendorAddress1, VendorAddress2, VendorCity, VendorState, VendorZipCode,
	VendorContactFName, VendorContactLName, DefaultTermsID, DefaultAccountNo
From AP.dbo.Vendors
Where VendorState <> 'CA';

--4
Update AP.dbo.VendorCopy
Set DefaultAccountNo = 403
Where DefaultAccountNo = 400;

--5
Update AP.dbo.InvoiceCopy
Set PaymentTotal = InvoiceTotal, PaymentDate = GetDate()
Where InvoiceTotal - (PaymentTotal + CreditTotal) > 0;

Select * 
From AP.dbo.InvoiceCopy
Where PaymentDate = '2023-06-25';

--6
Update AP.dbo.InvoiceCopy
Set TermsID = 2
Where VendorID in (
  Select VendorID
  From AP.dbo.VendorCopy
  Where DefaultTermsID = 2);

--7
Update AP.dbo.InvoiceCopy
Set TermsID = 2
From AP.dbo.InvoiceCopy ic
Join AP.dbo.VendorCopy vc
  on ic.VendorID = vc.VendorID
Where vc.DefaultTermsID = 2;

--8
Delete
From AP.dbo.VendorCopy
Where VendorState = 'MN';

--9
Delete
From AP.dbo.VendorCopy
Where VendorState Not in (
	Select Distinct VendorState
	From AP.dbo.VendorCopy vc
	Join AP.dbo.InvoiceCopy ic
	  on vc.VendorID = ic.VendorID);