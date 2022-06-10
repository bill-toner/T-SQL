-- 1
Select * 
From Vendors v
Join Invoices i
  on v.VendorID = i.VendorID;

-- 2
Select v.VendorName, i.InvoiceNumber, i.InvoiceDate, InvoiceTotal - (PaymentTotal + CreditTotal) as [Balance]
From Vendors v
Join Invoices i
  on v.VendorID = i.VendorID
Where InvoiceTotal - (PaymentTotal + CreditTotal) > 0
Order By v.VendorName;

-- 3
Select v.VendorName, v.DefaultAccountNo, gl.AccountDescription
From Vendors v
Join GLAccounts gl
  on v.DefaultAccountNo = gl.AccountNo
Order By gl.AccountDescription, v.VendorName;

-- 4
Select v.VendorName, i.InvoiceNumber, i.InvoiceDate, InvoiceTotal - (PaymentTotal + CreditTotal) as [Balance]
From Vendors v, Invoices i
Where InvoiceTotal - (PaymentTotal + CreditTotal) > 0
Order By v.VendorName;

-- 5
Select v.VendorName as [Vendor], 
  i.InvoiceDate as [Date],
  i.InvoiceNumber as [Number],
  li.InvoiceSequence as [#],
  li.InvoiceLineItemAmount as [LineItem]
From Vendors v
Join Invoices i
  on v.VendorID = i.VendorID
Join InvoiceLineItems li
  on i.InvoiceID = li.InvoiceID
Order By Vendor, [Date], [Number], [#];

-- 6
Select v.VendorID, v.VendorName, 
  v.VendorContactFName + ' ' + v.VendorContactLName as [Name]
From Vendors v
Join Vendors vv
  on v.VendorID = vv.VendorID
Where v.VendorContactFName = vv.VendorContactFName
Order By [Name];




