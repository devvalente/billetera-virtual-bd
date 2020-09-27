--CREAMOS LA BASE DE DATOS
CREATE DATABASE billetera;
--SETEAMOS A LA BASE DE DATOS
USE billetera;
--CREAMOS LAS TABLAS CORRESPONDIENTES
--CLIENTES
	CREATE TABLE clientes (
		id int NOT NULL AUTO_INCREMENT,
		documento varchar(11) NOT NULL,
		primer_nombre varchar(20) NOT NULL,
		primer_apellido varchar(20) NOT NULL, 
		email varchar(30) NOT NULL,
		celular varchar(15) NOT NULL, 

		CONSTRAINT PK_clientes_id PRIMARY KEY (id),
		CONSTRAINT UC_clientes_documento UNIQUE (documento),
		CONSTRAINT UC_clientes_email UNIQUE (email)
	);
--BILLETERAS
	CREATE TABLE billeteras(
		id int NOT NULL AUTO_INCREMENT,
		documento_id int NOT NULL,
		saldo decimal(7,2),

		CONSTRAINT PK_billeteras_id PRIMARY KEY (id),
		CONSTRAINT FK_billeteras_documento FOREIGN KEY (documento_id) REFERENCES clientes(documento)
	);

--COMPRAS
	CREATE TABLE compras(
		id int NOT NULL AUTO_INCREMENT, 
		billetera_id int NOT NULL,
		subtotal decimal(7,2),
		iva decimal(4,2),
		total decimal(7,2),
		fecha timestamp,
		status boolean,

		CONSTRAINT PK_compras_id PRIMARY KEY (id),
		CONSTRAINT FK_compras_billetera_id FOREIGN KEY (billetera_id) REFERENCES billeteras(id)
	);

--PAGAR-PRODUCTO:: token_pagos
	CREATE TABLE token_pagos(
		id int NOT NULL AUTO_INCREMENT,
		billetera_id int NOT NULL, 
		email varchar(30) NOT NULL,
		token varchar(6) NOT NULL, 
		compra_id int NOT NULL,
		expiracion timestamp,

		CONSTRAINT PK_token_pagos_id PRIMARY KEY (id),
		CONSTRAINT FK_token_pagos_billetera FOREIGN KEY (billetera_id) REFERENCES billeteras(id),
		CONSTRAINT UC_token_pagos_token UNIQUE (token),
		CONSTRAINT FK_token_pagos_compra FOREIGN KEY (compra_id) REFERENCES compras(compra_id)

	);