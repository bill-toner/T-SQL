-- 1
Select VendorContactFName, VendorContactLName, VendorName
From Vendors
Order By VendorContactLName, VendorContactFName;

-- 2
Select InvoiceNumber as Number,
	InvoiceTotal as Total,
	PaymentTotal + CreditTotal as Credits,
	InvoiceTotal - (PaymentTotal + CreditTotal) as Balance
From Invoices;

-- 3
Select VendorContactLName + ', ' + VendorContactFName as [Full Name]
From Vendors
Order By VendorContactLName, VendorContactFName;

-- 4
Select InvoiceTotal,
	InvoiceTotal * 0.1 as [10%],
	InvoiceTotal * 1.1 as [Plus 10%]
From Invoices
Where InvoiceTotal > 1000
Order By InvoiceTotal Desc;

-- 5
Select InvoiceNumber as Number,
	InvoiceTotal as Total,
	PaymentTotal + CreditTotal as Credits,
	InvoiceTotal - (PaymentTotal + CreditTotal) as Balance
From Invoices
Where InvoiceTotal >= 500 and InvoiceTotal <= 10000;

-- 6
Select VendorContactLName + ', ' + VendorContactFName as [Full Name]
From Vendors
Where VendorContactLName Not Like '[A,B,C,E]%'
Order By VendorContactLName, VendorContactFName;

-- 7
Select *
From Invoices
Where (PaymentDate Is Null and (InvoiceTotal - PaymentTotal) = 0)
  or (PaymentDate Is Not Null and (InvoiceTotal - PaymentTotal) > 0);
