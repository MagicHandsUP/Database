/* Consultas */
SELECT * FROM Distrito;
SELECT * FROM Cliente;
SELECT * FROM Proveedor;
SELECT * FROM Producto;
SELECT ID_trabajador, dni, nombres, apellidos, contacto_de_emergencia FROM Trabajador;
SELECT * FROM Direccion;
SELECT * FROM Proveedor_por_producto;
SELECT COUNT(*) FROM Cliente; -- Muestra el número de clientes registrados
SELECT COUNT(*) FROM Distrito WHERE disponible = 1; -- Muestra el número de distritos en los que sí se presta servicio
SELECT COUNT(DISTINCT region) FROM Distrito; -- Muestra en cuantas regiones únicas están disponibles los servicios
