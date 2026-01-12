/* Llista el total de compres d’un client/a. */
SELECT 
	c.Nom,
	v.IDVenta,
	v.IDUllera,
	u.Marca	
FROM 
	culampolla.clients c
JOIN culampolla.vendes v
	ON v.IDClient = c.IDClient
JOIN culampolla.ulleres u
	ON u.IDUllera = v.IDUllera
WHERE 
	c.nom='client 1';

/* Llista les diferents ulleres que ha venut un empleat durant un any. */
SELECT 
	e.Nom,
    u.Marca,
    v.`Data venta`
FROM
	culampolla.empleats e
JOIN culampolla.vendes v
	ON v.IDEmpleat = e.IDEmpleat
JOIN culampolla.ulleres u	
	ON u.IDUllera = v.IDUllera
WHERE
	YEAR(v.`Data venta`)='2026'
    AND
    e.Nom='Empleat 1';
    
/* Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica. */
SELECT 
	p.Nom,
    u.Marca,
    v.`Data venta`
FROM
	culampolla.proveidors p
JOIN culampolla.ulleres u	
	ON u.IDProveidor = p.IDProveidor
JOIN culampolla.vendes v
	ON v.IDUllera = u.IDUllera;