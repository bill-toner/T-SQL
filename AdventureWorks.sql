/*
  T-SQL on MS Learn
  We are having an Adventure Works
*/

Select c.CompanyName, soh.SalesOrderID, soh.TotalDue, a.AddressLine1, a.AddressLine2, a.City, a.StateProvince, a.PostalCode
From SalesLT.Customer as c
Join SalesLT.SalesOrderHeader as soh  
  on c.CustomerID = soh.CustomerID
Join SalesLT.CustomerAddress as ca  
  on c.CustomerID = ca.CustomerID
Join SalesLT.Address as a  
  on ca.AddressID = a.AddressID;


Select c.CustomerID, c.FirstName, c.LastName, soh.SalesOrderID, soh.TotalDue
From SalesLT.Customer as c
Left Join SalesLT.SalesOrderHeader as soh  
  on c.CustomerID = soh.CustomerID
Order By soh.TotalDue Desc;


Select c.CustomerID, c.CompanyName, c.FirstName, c.LastName, c.Phone
From SalesLT.Customer as c
Left Join SalesLT.CustomerAddress as ca  
  on c.CustomerID = ca.CustomerID
Left Join SalesLT.Address as a  
  on ca.AddressID = a.AddressID
Where a.AddressLine1 Is Null;


Select ppc.Name, pc.Name, p.Name
From SalesLT.ProductCategory as pc
Join SalesLT.ProductCategory as ppc  
  on pc.ParentProductCategoryID = ppc.ProductCategoryID
Join SalesLT.Product as p  
  on p.ProductCategoryID = pc.ProductCategoryID;