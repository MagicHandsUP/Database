/* Este codigo crea las tablas */

CREATE TABLE Cliente (
  ID_cliente int NOT NULL,
  nombre_completo varchar(100) NOT NULL,
  email varchar(100) UNIQUE,
  celular varchar(9) UNIQUE);

CREATE TABLE Solicitud (
  ID_solicitud int NOT NULL,
  fecha_y_hora_de_solicitud datetime NOT NULL DEFAULT GETDATE(),
  ID_cliente int NOT NULL);

CREATE TABLE Servicio (
  ID_servicio int NOT NULL,
  fecha_del_servicio date NOT NULL,
  CONSTRAINT fecha_de_servicio_valida CHECK (fecha_del_servicio > GETDATE()),
  hora_de_inicio time NOT NULL,
  numero_de_horas int NOT NULL,
  requerimientos_especificos char,
  precio_servicio float NOT NULL,
  comision_empresa float NOT NULL,
  pago_a_trabajador float NOT NULL,
  precio_productos float NOT NULL,
  ID_solicitud int NOT NULL,
  ID_direccion int NOT NULL,
  ID_trabajador int NOT NULL);

CREATE TABLE Calificacion_de_servicio(
  ID_calificacion int NOT NULL,
  nivel_de_calificacion tinyint NOT NULL,
  CONSTRAINT rango_de_calificacion CHECK (nivel_de_calificacion <= 5),-- El nivel de calificación es un numero entero entre 1 y 5
  comentario varchar(250), -- El comentario es opcional
  ID_servicio int NOT NULL);

CREATE TABLE Trabajador (
  ID_trabajador int NOT NULL,
  dni varchar(8) NOT NULL UNIQUE,
  nombres varchar(100) NOT NULL,
  apellidos varchar(100) NOT NULL,
  contacto_de_emergencia varchar(250) NOT NULL,
  direccion varchar(250),
  disponible bit NOT NULL DEFAULT 1); -- Bit se usa como boolean, si el trabajador esta disponible tiene valor de 1; caso contrario, valor 0.

CREATE TABLE Proveedor (
  ID_proveedor int NOT NULL,
  RUC varchar(11) NOT NULL UNIQUE,
  razon_social varchar(100) UNIQUE,
  email varchar(100) UNIQUE,
  celular varchar(9) UNIQUE);

CREATE TABLE Distrito (
  ID_distrito int NOT NULL,
  nombre varchar(50) NOT NULL,
  provincia varchar(50) NOT NULL,
  region varchar(50) NOT NULL,
  disponible bit NOT NULL); --La variable disponible toma el valor de 1 cuando en el distrito sí se presta servicio; caso contrario es 0

CREATE TABLE Direccion (
  ID_direccion int NOT NULL,
  direccion varchar(250) NOT NULL,
  referencias varchar(250) NOT NULL,
  ID_distrito int NOT NULL,
  ID_cliente int NOT NULL);

CREATE TABLE Producto (
  ID_producto int NOT NULL,
  nombre varchar(250) NOT NULL,
  presentacion varchar(100) NOT NULL,
  marca varchar(100) NOT NULL,
  stock_disponible int NOT NULL,
  precio_de_venta float NOT NULL);

CREATE TABLE Producto_por_servicio (
  ID_producto_por_servicio int NOT NULL,
  cantidad int NOT NULL,
  precio float NOT NULL,
  ID_producto int NOT NULL,
  ID_servicio int NOT NULL);

CREATE TABLE Proveedor_por_producto(
  ID_proveedor_por_producto int NOT NULL,
  ID_proveedor int NOT NULL,
  ID_producto int NOT NULL);

/* Primary Keys */
ALTER TABLE Cliente ADD CONSTRAINT PK_cliente PRIMARY KEY(ID_cliente);
ALTER TABLE Solicitud ADD CONSTRAINT PK_solicitud PRIMARY KEY(ID_solicitud);
ALTER TABLE Servicio ADD CONSTRAINT PK_servicio PRIMARY KEY(ID_servicio);
ALTER TABLE Calificacion_de_servicio ADD CONSTRAINT PK_calificacion PRIMARY KEY(ID_calificacion);
ALTER TABLE Trabajador ADD CONSTRAINT PK_trabajador PRIMARY KEY(ID_trabajador);
ALTER TABLE Proveedor ADD CONSTRAINT PK_proveedor PRIMARY KEY(ID_proveedor);
ALTER TABLE Distrito ADD CONSTRAINT PK_distrito PRIMARY KEY(ID_distrito);
ALTER TABLE Direccion ADD CONSTRAINT PK_direccion PRIMARY KEY(ID_direccion);
ALTER TABLE Producto ADD CONSTRAINT PK_producto PRIMARY KEY(ID_producto);
ALTER TABLE Producto_por_servicio ADD CONSTRAINT PK_producto_por_servicio PRIMARY KEY(ID_producto_por_servicio);
ALTER TABLE Proveedor_por_producto ADD CONSTRAINT PK_proveedor_por_producto PRIMARY KEY(ID_proveedor_por_producto);

/* Relaciones */
ALTER TABLE Solicitud ADD CONSTRAINT FK_Solicitud_Cliente FOREIGN KEY(ID_cliente) REFERENCES Cliente (ID_cliente);
ALTER TABLE Servicio ADD CONSTRAINT FK_Servicio_Solicitud FOREIGN KEY(ID_solicitud) REFERENCES Solicitud (ID_solicitud);
ALTER TABLE Servicio ADD CONSTRAINT FK_Servicio_Direccion FOREIGN KEY(ID_direccion) REFERENCES Direccion (ID_direccion);
ALTER TABLE Servicio ADD CONSTRAINT FK_Servicio_Trabajador FOREIGN KEY(ID_trabajador) REFERENCES Trabajador (ID_trabajador);
ALTER TABLE Calificacion_de_servicio ADD CONSTRAINT FK_Calificacion_Servicio FOREIGN KEY(ID_servicio) REFERENCES Servicio (ID_servicio);
ALTER TABLE Direccion ADD CONSTRAINT FK_Direccion_Distrito FOREIGN KEY(ID_distrito) REFERENCES Distrito (ID_distrito);
ALTER TABLE Direccion ADD CONSTRAINT FK_Direccion_Cliente FOREIGN KEY(ID_cliente) REFERENCES Cliente (ID_cliente);
ALTER TABLE Producto_por_servicio ADD CONSTRAINT FK_Producto_por_servicio_Producto FOREIGN KEY(ID_producto) REFERENCES Producto (ID_producto);
ALTER TABLE Producto_por_servicio ADD CONSTRAINT FK_Producto_por_servicio_Servicio FOREIGN KEY(ID_servicio) REFERENCES Servicio (ID_servicio);
ALTER TABLE Proveedor_por_producto ADD CONSTRAINT FK_Proveedor_por_producto_Proveedor FOREIGN KEY(ID_proveedor) REFERENCES Proveedor (ID_proveedor);
ALTER TABLE Proveedor_por_producto ADD CONSTRAINT FK_Proveedor_por_producto_Producto FOREIGN KEY(ID_producto) REFERENCES Producto (ID_producto);
