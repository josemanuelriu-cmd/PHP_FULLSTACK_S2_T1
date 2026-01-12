/*Llista quants productes de tipus “Begudes” s'han venut en una determinada localitat.*/
SELECT 
	p.idproduct,
	p.name, 
    SUM(op.productQuantity) AS Total_Begudes
FROM pizzeria.products p 
JOIN pizzeria.orders_has_products op 
	ON p.idproduct = op.products_idproduct    
JOIN pizzeria.orders o
	ON o.idorders = op.orders_idorders
JOIN pizzeria.stores s
	ON s.idOrder = o.idorders
JOIN pizzeria.addresses a
	ON a.idAddress=s.idAddress
WHERE 
	a.City= 'Barcelona' 
    AND
    p.ProductType='5';
    
/*Llista quantes comandes ha efectuat un determinat empleat/da.*/
SELECT 	
	e.Name, 
    COUNT(o.idorders) AS 'Total comandes'
    /*o.idorders*/
FROM pizzeria.employees e
JOIN pizzeria.orders o
	ON o.idEmployee = e.idEmployee
WHERE 
	e.idEmployee=1;