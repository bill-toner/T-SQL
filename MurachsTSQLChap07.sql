Insert Into InvoiceCopy (
   VendorID,
   InvoiceTotal,
   TermsID,
   InvoiceNumber,
   PaymentTotal,
   InvoiceDueDate,
   InvoiceDate,
   CreditTotal,
   PaymentDate
)
Values (
	32,
	$434.58,
	2,
	'AX-014-027',
	$0.00,
	'05/08/2020',
	'04/21/2020',
	$0.00,
	null
	)

Select * 
From InvoiceCopy
Where VendorID = 32;

Insert Into VendorCopy
Select VendorName, VendorAddress1, VendorAddress2, VendorCity, VendorState,
	VendorZipCode, VendorPhone,	VendorContactLName, VendorContactFName, DefaultTermsID, DefaultAccountNo
From Vendors
Where VendorState <> 'CA';


Select * From VendorCopy;

Update VendorCopy
Select * From VendorCopy
--Set DefaultAccountNo = 403
Where DefaultAccountNo = 403;

Update InvoiceCopy
Set PaymentDate = GetDate(), PaymentTotal = (InvoiceTotal - PaymentTotal - CreditTotal)


Select * From InvoiceCopy;


Update InvoiceCopy
Set TermsID = 2
From InvoiceCopy Join VendorCopy 
  on InvoiceCopy.VendorID = VendorCopy.VendorID
Where DefaultTermsID = 2;


Delete From VendorCopy
Where VendorState = 'MI';

Delete from VendorCopy
Where VendorState Not In (Select Distinct vc.VendorState
							From VendorCopy vc
							Join InvoiceCopy ic on vc.VendorID = ic.VendorID)

