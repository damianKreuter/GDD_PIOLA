/*
-------------------------------------------------------------------------------
SECCIONES
-------------------------------------------------------------------------------
SECCION_0 : HISTORIAL DE CAMBIOS
SECCION_1 : CREACION DEL ESQUEMA
SECCION_2 : ELIMINACIÓN DE TABLAS
SECCION_3 : CREACIÓN DE LAS TABLAS 
SECCION_4 : DEFINICIÓN DE CONSTRAINTS
SECCION_5 : MIGRACION DE DATOS DE TABLA MAESTRA
SECCION_6 : CONTROL POS CARGA SI LOS HUBIERA
SECCION_7 : CREACIÓN DE VIEWS
SECCION_8 : CREACIÓN DE FUNCTIONS, PROCEDURES, TRIGGERS


-------------------------------------------------------------------------------
*/

/* ****************************************************************************
* SECCION_0 : HISTORIAL DE CAMBIOS
**************************************************************************** */

/*

FECHA			DESCRIPCIÓN DEL CAMBIO
-------------------------------------------------------------------------------
12/MAY/2018		Creación del DER.
26/MAY/2018     Realización de la carga Incial.
*/

--Indicamos DB a utilizar
USE GD1C2018;


/* ****************************************************************************
* SECCION_1 : CREACION DEL ESQUEMA
**************************************************************************** */
PRINT 'Creando el Esquema ...';

--Si no existe el esquema, entonces, lo creamos
IF (NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'Recaptchat'))
	BEGIN
		PRINT 'Creando schema ...';
		EXEC ('CREATE SCHEMA Recaptchat AUTHORIZATION gdHotel2018');
	END;

PRINT 'Esquema Creado ...';
/* ****************************************************************************
* SECCION_2 : ELIMINACIÓN DE TABLAS
**************************************************************************** */

PRINT 'Eliminando Tablas ...';


--17
	IF OBJECT_ID('Recaptchat.ITEM_FACTURA') IS NOT NULL
	DROP TABLE Recaptchat.ITEM_FACTURA;

--16
	IF OBJECT_ID('Recaptchat.FACTURA') IS NOT NULL
	DROP TABLE Recaptchat.FACTURA;

--15
	IF OBJECT_ID('Recaptchat.CONSUMIBLES') IS NOT NULL
	DROP TABLE Recaptchat.CONSUMIBLES;

--14
	IF OBJECT_ID('Recaptchat.ESTADIA') IS NOT NULL
	DROP TABLE Recaptchat.ESTADIA;

--13
	IF OBJECT_ID('Recaptchat.RESERVA') IS NOT NULL
	DROP TABLE Recaptchat.RESERVA;

--12
	IF OBJECT_ID('Recaptchat.REGIMEN_ESTADIA') IS NOT NULL
	DROP TABLE Recaptchat.REGIMEN_ESTADIA;

--11
	IF OBJECT_ID('Recaptchat.CLIENTE') IS NOT NULL
	DROP TABLE Recaptchat.CLIENTE;

--10
	IF OBJECT_ID('Recaptchat.HABITACION') IS NOT NULL
	DROP TABLE Recaptchat.HABITACION;

--10
	IF OBJECT_ID('Recaptchat.HABITACION_TIPO') IS NOT NULL
	DROP TABLE Recaptchat.HABITACION_TIPO;

--08
	IF OBJECT_ID('Recaptchat.ESTADO_HOTEL') IS NOT NULL
	DROP TABLE Recaptchat.ESTADO_HOTEL;

--07
	IF OBJECT_ID('Recaptchat.HOTEL_X_USUARIO') IS NOT NULL
	DROP TABLE Recaptchat.HOTEL_X_USUARIO;

--06
	IF OBJECT_ID('Recaptchat.HOTEL') IS NOT NULL
	DROP TABLE Recaptchat.HOTEL;

--05
	IF OBJECT_ID('Recaptchat.FUNCIONALIDAD_X_ROL') IS NOT NULL
	DROP TABLE Recaptchat.FUNCIONALIDAD_X_ROL;

--04
	IF OBJECT_ID('Recaptchat.FUNCIONALIDAD') IS NOT NULL
	DROP TABLE Recaptchat.FUNCIONALIDAD;

--03
	IF OBJECT_ID('Recaptchat.ROL_X_USUARIO') IS NOT NULL
	DROP TABLE Recaptchat.ROL_X_USUARIO;

--02
	IF OBJECT_ID('Recaptchat.ROL') IS NOT NULL
	DROP TABLE Recaptchat.ROL;

--01
	IF OBJECT_ID('Recaptchat.USUARIO') IS NOT NULL
	DROP TABLE Recaptchat.USUARIO;

PRINT 'Tablas Eliminadas ...';

/* ****************************************************************************
* SECCION_3 : CREACIÓN DE LAS TABLAS 
**************************************************************************** */

PRINT 'Creando Tablas ...';
-- ORDEN DE CRACION DE TABLAS
--01
	CREATE TABLE Recaptchat.USUARIO (
	usua_codigo				INT IDENTITY(1,1)	NOT NULL, -- [PK]
	usua_username			VARCHAR(255)		NOT NULL,
	usua_password			VARBINARY(255)		NOT NULL,
	usua_fecha_creacion		DATETIME,
	usua_login_fallidos		TINYINT,
	usua_estado_activo		BIT,
	usua_nombre				VARCHAR(255),
	usua_apellido			VARCHAR(255),
	usua_doc_tipo			VARCHAR(255),
	usua_doc_nro			NUMERIC(18,0),
	usua_mail				VARCHAR(255),
	usua_telefono			NUMERIC(18,0),
	usua_dir_nombre			VARCHAR(255),
	usua_dir_nro			NUMERIC(18,0),
	usua_fecha_nacimiento	DATETIME
	);

--02
	CREATE TABLE Recaptchat.ROL (
	rol_codigo				TINYINT	IDENTITY(1,1) NOT NULL, -- [PK]
	rol_nombre				NVARCHAR(255)		  NOT NULL,
	rol_estado_activo		BIT
    );

--03
	CREATE TABLE Recaptchat.ROL_X_USUARIO (
	rxu_usua_codigo			INT NOT NULL,       -- [FK] Ref a USUARIO.usua_codigo
	rxu_rol_codigo			TINYINT NOT NULL,	-- [FK] Ref a ROL.rol_codigo'
    );

--04
    CREATE TABLE Recaptchat.FUNCIONALIDAD (
	func_codigo				INT IDENTITY(1,1) NOT NULL, -- [PK]
	func_nombre				NVARCHAR(225)
	);

--05
	CREATE TABLE Recaptchat.FUNCIONALIDAD_X_ROL (
	fxr_rol_codigo			TINYINT NOT NULL,  -- [FK] Ref a ROL.rol_codigo
	fxr_func_codigo			INT NOT NULL,      -- [FK] Ref a FUNCIONALIDAD.func_codigo
	);

--06
	CREATE TABLE Recaptchat.HOTEL (
	hote_codigo				INT IDENTITY(1,1) NOT NULL,-- [PK] 
	hote_nombre				NVARCHAR(255),
	hote_mail				NVARCHAR(255),
	hote_tel				NUMERIC(18,0),
	hote_dir_calle			NVARCHAR(255),----
	hote_dir_numero			NUMERIC(18,0),----
	hote_cant_estrellas		NUMERIC(18,0),----
	hote_ciudad				NVARCHAR(255),----
	hote_pais				NVARCHAR(50),
	hote_tipo_regimen		NVARCHAR(255),
	hote_fecha_creacion		DATETIME,
	hote_recarga_estrellas	NUMERIC(18,0),----
	hote_estado_activo		BIT 
	);

--07
	CREATE TABLE Recaptchat.HOTEL_X_USUARIO (
	hxu_hote_codigo			INT NOT NULL, -- [FK] Ref a HOTEL.hote_codigo
	hxu_usua_codigo			INT NOT NULL, -- [FK] Ref a USUARIO.usua_codigo
	);

--08
	CREATE TABLE Recaptchat.ESTADO_HOTEL (
	esho_hote_codigo		INT NOT NULL, -- [FK] Ref a HOTEL.hote_codigo
	esho_estado_activo		BIT, 
	esho_fecha_inicio		DATETIME,
	esho_fecha_fin			DATETIME,
	esho_motivo				NVARCHAR(255),

	);

--09
	CREATE TABLE Recaptchat.HABITACION_TIPO (
	habi_tipo               NUMERIC(18,0) NOT NULL,-- [PK],---- 
	habi_descripcion        NVARCHAR(255),----
	habi_porcentual         NUMERIC(18,0),----
	);

--10
	CREATE TABLE Recaptchat.HABITACION (
	habi_codigo				INT IDENTITY(1,1) NOT NULL,-- [PK]
	habi_hote_codigo        INT, -- [FK] Ref a HOTEL.hote_codigo
	habi_numero				NUMERIC(18,0),----
	habi_piso               NUMERIC(18,0),----
	habi_ubicacion_frente   NVARCHAR(50),----
	habi_tipo               NUMERIC(18,0),---- [FK] Ref a HABITACION_TIPO.habi_tipo
	habi_estado_activo      BIT,
	
	);

--11
   	CREATE TABLE Recaptchat.CLIENTE (
	clie_codigo            INT IDENTITY(1,1) NOT NULL, --[PK]
	clie_acomp_codigo      INT, -- [FK] Ref a CLIENTE.clie_codigo
	clie_doc_tipo          NVARCHAR(255),
	clie_doc_numero        NUMERIC(18,0),----  
	clie_nombre            NVARCHAR(255),----
	clie_apellido          VARCHAR(255),---- 
	clie_fecha_nacimiento  DATETIME,--
	clie_mail              NVARCHAR(255),----
	clie_telefono          NUMERIC(18,0),
	clie_dir_nombre        NVARCHAR(255),----
	clie_dir_numero        NUMERIC(18,0),----
	clie_dir_piso          NUMERIC(18,0),----
	clie_dir_dpto          NVARCHAR(50),----
	clie_localidad         NVARCHAR(255),
	clie_pais_origen       NVARCHAR(255),
	clie_nacionalidad      NVARCHAR(255),----
	clie_estado_activo     BIT
	);
	
--12
	CREATE TABLE Recaptchat.REGIMEN_ESTADIA (
	regi_codigo            INT IDENTITY(1,1) NOT NULL, --[PK]         
	regi_descripcion       NVARCHAR(255),----
	regi_precio_base       NUMERIC(18,0),----
	regi_estado_activo     BIT,
	);

--13
	CREATE TABLE Recaptchat.RESERVA (
	rese_codigo             NUMERIC(18,0) NOT NULL,---- [PK]
	rese_clie_codigo        INT , -- [FK] Ref a CLIENTE.clie_codigo
	rese_habi_codigo	    INT , -- [FK] Ref a HABITACION.habi_codigo
	rese_regi_codigo        INT , -- [FK] Ref a REGIMEN_ESTADIA.regi_codigo
	rese_fecha_reserva      DATETIME,
	rese_fecha_desde        DATETIME,----
	rese_fecha_hasta        DATETIME,
	rese_cant_noches        NUMERIC(18,0),----
	rese_estado             NVARCHAR(255),
	rese_fecha_cancelacion  DATETIME,
	rese_motivo_cancelacion NVARCHAR(255)
	);

--14
	CREATE TABLE Recaptchat.ESTADIA (
	esta_rese_codigo                NUMERIC(18,0) NOT NULL,--[FK] Ref a RESERVA.rese_codigo
	esta_fecha_inicio               DATETIME,
	esta_cant_noches                NUMERIC(18,0),
	esta_forma_pago                 NVARCHAR(255),
	esta_forma_pago_descripcion     NVARCHAR(255),
	);

--15
	CREATE TABLE Recaptchat.CONSUMIBLES (
	cons_codigo            NUMERIC(18,0) NOT NULL,---- [PK]
	cons_descripcion       NVARCHAR(255),----
	cons_precio            NUMERIC(18,0),----
	); 

--16
	CREATE TABLE Recaptchat.FACTURA (
	fact_numero            NUMERIC(18,0) NOT NULL,---- [PK]
	fact_clie_codigo       INT NOT NULL,            -- [FK] Ref a CLIENTE.clie_codigo
	fact_fecha             DATETIME,--
	fact_total             NUMERIC(18,0),----
	);

--17
	CREATE TABLE Recaptchat.ITEM_FACTURA (
	item_fact_numero       NUMERIC(18,0), -- [FK]  -- [FK] Ref a FACTURA.fact_numero
	item_cons_codigo       NUMERIC(18,0), -- [FK]  -- [FK] Ref a CONSUMIBLES.cons_codigo
	item_cons_cantidad     NUMERIC(18,0),
	item_descripcion	   NVARCHAR(255),
	item_monto             NUMERIC(18,0)
	);

PRINT 'Tablas Creadas ...';

/* ****************************************************************************
* SECCION_4 : DEFINICIÓN DE CONSTRAINTS
**************************************************************************** */

PRINT 'Definiendo Constraints  Claves Primarias,  Check,  Unique ...';

-- ORDEN DE DEFINICION DE CONSTRAINTS

--01
	ALTER TABLE Recaptchat.USUARIO ADD CONSTRAINT PK_usua_codigo PRIMARY KEY(usua_codigo);
	ALTER TABLE Recaptchat.USUARIO ADD CONSTRAINT UNQ_usua_username UNIQUE (usua_username);
	ALTER TABLE Recaptchat.USUARIO ADD CONSTRAINT CK_usua_estado_activo CHECK (usua_estado_activo = 0 OR usua_estado_activo = 1);
	ALTER TABLE Recaptchat.USUARIO ADD CONSTRAINT DF_usua_estado_activo DEFAULT 1 FOR usua_estado_activo;
	ALTER TABLE Recaptchat.USUARIO ADD CONSTRAINT UNQ_usua_mail UNIQUE (usua_mail);
	ALTER TABLE Recaptchat.USUARIO ADD CONSTRAINT CK_usua_codigo CHECK (usua_codigo >= 0);
	ALTER TABLE Recaptchat.USUARIO ADD CONSTRAINT CK_usua_doc_nro CHECK (usua_doc_nro >= 0);
	ALTER TABLE Recaptchat.USUARIO ADD CONSTRAINT CK_usua_telefono CHECK (usua_telefono >= 0);
	ALTER TABLE Recaptchat.USUARIO ADD CONSTRAINT CK_usua_dir_nro CHECK (usua_dir_nro >= 0); 

--02
	ALTER TABLE Recaptchat.ROL ADD CONSTRAINT PK_rol_codigo PRIMARY KEY(rol_codigo);
	ALTER TABLE Recaptchat.ROL ADD CONSTRAINT CK_rol_codigo CHECK (rol_codigo >= 0);
	ALTER TABLE Recaptchat.ROL ADD CONSTRAINT CK_rol_estado_activo CHECK (rol_estado_activo = 0 OR rol_estado_activo = 1);
	ALTER TABLE Recaptchat.ROL ADD CONSTRAINT DF_rol_estado_activo DEFAULT 1 FOR rol_estado_activo;

--03
	-- Recaptchat.ROLxUSUARIO NO TIENE PK

--04
   	ALTER TABLE Recaptchat.FUNCIONALIDAD ADD CONSTRAINT PK_func_codigo PRIMARY KEY(func_codigo);
	ALTER TABLE Recaptchat.FUNCIONALIDAD ADD CONSTRAINT CK_func_codigo	 CHECK (func_codigo	 >= 0); 

--05
	-- Recaptchat.FUNCIONALIDADxROL TIENE PK

--06
	ALTER TABLE Recaptchat.HOTEL ADD CONSTRAINT PK_hote_codigo PRIMARY KEY(hote_codigo);
	ALTER TABLE Recaptchat.HOTEL ADD CONSTRAINT CK_hote_codigo	 CHECK (hote_codigo >= 0);
	ALTER TABLE Recaptchat.HOTEL ADD CONSTRAINT CK_hote_tel	 CHECK (hote_tel >= 0);
	ALTER TABLE Recaptchat.HOTEL ADD CONSTRAINT CK_hote_dir_numero	 CHECK (hote_dir_numero >= 0);
	ALTER TABLE Recaptchat.HOTEL ADD CONSTRAINT CK_hote_estado_activo CHECK (hote_estado_activo = 0 OR hote_estado_activo = 1);
	ALTER TABLE Recaptchat.HOTEL ADD CONSTRAINT DF_hote_estado_activo DEFAULT 1 FOR hote_estado_activo;

--07
	-- Recaptchat.HOTELxUSUARIO NO TIENE PK

--08
    -- Recaptchat.ESTADO_HOTEL NO TIENE PK
	 
	ALTER TABLE Recaptchat.ESTADO_HOTEL ADD CONSTRAINT CK_esho_estado_activo CHECK (esho_estado_activo = 0 OR esho_estado_activo = 1);
	ALTER TABLE Recaptchat.ESTADO_HOTEL ADD CONSTRAINT DF_esho_estado_activo DEFAULT 1 FOR esho_estado_activo;

--09 
   	ALTER TABLE Recaptchat.HABITACION_TIPO ADD CONSTRAINT PK_habi_tipo PRIMARY KEY(habi_tipo);


--10
	ALTER TABLE Recaptchat.HABITACION ADD CONSTRAINT PK_habi_codigo PRIMARY KEY(habi_codigo);
	ALTER TABLE Recaptchat.HABITACION ADD CONSTRAINT CK_habi_codigo CHECK (habi_codigo >= 0);
	ALTER TABLE Recaptchat.HABITACION ADD CONSTRAINT CK_habi_numero CHECK (habi_numero >= 0);
	ALTER TABLE Recaptchat.HABITACION ADD CONSTRAINT CK_habi_estado_activo CHECK (habi_estado_activo = 0 OR habi_estado_activo = 1);
	ALTER TABLE Recaptchat.HABITACION ADD CONSTRAINT DF_habi_estado_activo DEFAULT 1 FOR habi_estado_activo;

--11
	ALTER TABLE Recaptchat.CLIENTE ADD CONSTRAINT PK_clie_codigo PRIMARY KEY(clie_codigo);
	ALTER TABLE Recaptchat.CLIENTE ADD CONSTRAINT CK_clie_codigo  CHECK (clie_codigo  >= 0);
	ALTER TABLE Recaptchat.CLIENTE ADD CONSTRAINT CK_clie_doc_nro CHECK (clie_doc_numero >= 0);
	--ALTER TABLE Recaptchat.CLIENTE ADD CONSTRAINT UNQ_clie_mail UNIQUE (clie_mail);
	ALTER TABLE Recaptchat.CLIENTE ADD CONSTRAINT CK_clie_telefono CHECK (clie_telefono >= 0);
	ALTER TABLE Recaptchat.CLIENTE ADD CONSTRAINT CK_clie_dir_nro  CHECK (clie_dir_numero >= 0);

--12
	ALTER TABLE Recaptchat.REGIMEN_ESTADIA ADD CONSTRAINT PK_regi_codigo PRIMARY KEY(regi_codigo);
	ALTER TABLE Recaptchat.REGIMEN_ESTADIA ADD CONSTRAINT CK_regi_codigo  CHECK (regi_codigo >= 0);
	ALTER TABLE Recaptchat.REGIMEN_ESTADIA ADD CONSTRAINT CK_regi_estado_activo CHECK (regi_estado_activo = 0 OR regi_estado_activo = 1);
	ALTER TABLE Recaptchat.REGIMEN_ESTADIA ADD CONSTRAINT DF_regi_estado_activo DEFAULT 1 FOR regi_estado_activo;

--13
 	ALTER TABLE Recaptchat.RESERVA ADD CONSTRAINT PK_rese_codigo PRIMARY KEY(rese_codigo);
	ALTER TABLE Recaptchat.RESERVA ADD CONSTRAINT CK_rese_codigo CHECK (rese_codigo >= 0);
	ALTER TABLE Recaptchat.RESERVA ADD CONSTRAINT CK_rese_cant_noches CHECK (rese_cant_noches >= 0);
	

--14
	--  Recaptchat.ESTADIA NO TIENE PK

	ALTER TABLE Recaptchat.ESTADIA ADD CONSTRAINT CK_esta_cant_noches CHECK (esta_cant_noches >= 0);

--15
	ALTER TABLE Recaptchat.CONSUMIBLES ADD CONSTRAINT PK_cons_codigo PRIMARY KEY(cons_codigo);
	ALTER TABLE Recaptchat.CONSUMIBLES ADD CONSTRAINT CK_cons_codigo CHECK (cons_codigo >= 0);
	ALTER TABLE Recaptchat.CONSUMIBLES ADD CONSTRAINT CK_cons_precio CHECK (cons_precio >= 0);
	

--16
	ALTER TABLE Recaptchat.FACTURA ADD CONSTRAINT PK_fact_numero PRIMARY KEY(fact_numero);
	ALTER TABLE Recaptchat.FACTURA ADD CONSTRAINT CK_fact_numero CHECK (fact_numero >= 0);
	ALTER TABLE Recaptchat.FACTURA ADD CONSTRAINT CK_fact_total CHECK (fact_total >= 0);

--17
	-- Recaptchat.ITEM_FACTURA NO TIENE PK
	
	ALTER TABLE Recaptchat.ITEM_FACTURA ADD CONSTRAINT CK_item_monto CHECK (item_monto>= 0);

PRINT 'Definiendo Constraints  Claves Foraneas ...';

--01
	-- Recaptchat.USUARIO NO TIENE FK
	
--02
	-- Recaptchat.ROL NO TIENE FK

--03
	ALTER TABLE Recaptchat.ROL_X_USUARIO ADD CONSTRAINT FK_rxu_usua_codigo FOREIGN KEY (rxu_usua_codigo) REFERENCES Recaptchat.USUARIO(usua_codigo);
		
	ALTER TABLE Recaptchat.ROL_X_USUARIO ADD CONSTRAINT FK_rxu_rol_codigo FOREIGN KEY (rxu_rol_codigo) REFERENCES Recaptchat.ROL(rol_codigo);


--04
	-- Recaptchat.FUNCIONALIDAD NO TIENE FK

--05
	ALTER TABLE Recaptchat.FUNCIONALIDAD_X_ROL ADD CONSTRAINT FK_fxr_rol_codigo FOREIGN KEY (fxr_rol_codigo) REFERENCES Recaptchat.ROL(rol_codigo);
	ALTER TABLE Recaptchat.FUNCIONALIDAD_X_ROL ADD CONSTRAINT FK_fxr_func_codigo FOREIGN KEY (fxr_func_codigo) REFERENCES Recaptchat.FUNCIONALIDAD(func_codigo);

--06
	-- GDD_404.HOTEL NO TIENE FK

--07
	ALTER TABLE Recaptchat.HOTEL_X_USUARIO ADD CONSTRAINT FK_hxu_hote_codigo FOREIGN KEY (hxu_hote_codigo) REFERENCES Recaptchat.HOTEL(hote_codigo);
	ALTER TABLE Recaptchat.HOTEL_X_USUARIO ADD CONSTRAINT FK_hxu_usua_codigo FOREIGN KEY (hxu_usua_codigo) REFERENCES Recaptchat.USUARIO(usua_codigo);

--08
	ALTER TABLE Recaptchat.ESTADO_HOTEL ADD CONSTRAINT FK_esho_hote_codigo FOREIGN KEY (esho_hote_codigo) REFERENCES Recaptchat.HOTEL(hote_codigo);

--09
	-- Recaptchat.HABITACION_TIPO NO TIENE FK

--10
	ALTER TABLE Recaptchat.HABITACION ADD CONSTRAINT FK_habi_hote_codigo FOREIGN KEY (habi_hote_codigo) REFERENCES Recaptchat.HOTEL(hote_codigo);
    ALTER TABLE Recaptchat.HABITACION ADD CONSTRAINT FK_habi_tipo FOREIGN KEY (habi_tipo) REFERENCES Recaptchat.HABITACION_TIPO(habi_tipo);

--11
	ALTER TABLE Recaptchat.CLIENTE ADD CONSTRAINT FK_clie_acomp_codigo FOREIGN KEY (clie_acomp_codigo) REFERENCES Recaptchat.CLIENTE(clie_codigo);

--12
   -- Recaptchat.REGIMEN_ESTADIA NO TIENE FK

-- 13
	ALTER TABLE Recaptchat.RESERVA ADD CONSTRAINT FK_rese_clie_codigo FOREIGN KEY (rese_clie_codigo) REFERENCES Recaptchat.CLIENTE(clie_codigo);
	ALTER TABLE Recaptchat.RESERVA ADD CONSTRAINT FK_rese_habi_codigo FOREIGN KEY (rese_habi_codigo) REFERENCES Recaptchat.HABITACION(habi_codigo);
	ALTER TABLE Recaptchat.RESERVA ADD CONSTRAINT FK_rese_regi_codigo FOREIGN KEY (rese_regi_codigo) REFERENCES Recaptchat.REGIMEN_ESTADIA(regi_codigo);

--14
	ALTER TABLE Recaptchat.ESTADIA ADD CONSTRAINT FK_esta_rese_codigo  FOREIGN KEY (esta_rese_codigo) REFERENCES Recaptchat.RESERVA(rese_codigo);

--15
	-- Recaptchat.CONSUMIBLES NO TIENE FK

--16
	ALTER TABLE Recaptchat.FACTURA ADD CONSTRAINT FK_fact_clie_codigo FOREIGN KEY (fact_clie_codigo) REFERENCES Recaptchat.CLIENTE(clie_codigo);

--17
	ALTER TABLE Recaptchat.ITEM_FACTURA ADD CONSTRAINT FK_item_fact_numero FOREIGN KEY (item_fact_numero) REFERENCES Recaptchat.FACTURA(fact_numero);
	ALTER TABLE Recaptchat.ITEM_FACTURA ADD CONSTRAINT FK_item_cons_codigo FOREIGN KEY (item_cons_codigo) REFERENCES Recaptchat.CONSUMIBLES(cons_codigo);


PRINT 'Constraints Definidas ...';

PRINT 'Eliminar Constrains ...';
	ALTER TABLE Recaptchat.ROL_X_USUARIO DROP CONSTRAINT FK_rxu_usua_codigo
		ALTER TABLE Recaptchat.ROL_X_USUARIO DROP CONSTRAINT FK_rxu_rol_codigo
		ALTER TABLE Recaptchat.FUNCIONALIDAD_X_ROL DROP CONSTRAINT FK_fxr_rol_codigo
		ALTER TABLE Recaptchat.FUNCIONALIDAD_X_ROL DROP CONSTRAINT FK_fxr_func_codigo
		ALTER TABLE Recaptchat.HOTEL_X_USUARIO DROP CONSTRAINT FK_hxu_hote_codigo
		ALTER TABLE Recaptchat.HOTEL_X_USUARIO DROP CONSTRAINT FK_hxu_usua_codigo
		ALTER TABLE Recaptchat.ESTADO_HOTEL DROP CONSTRAINT FK_esho_hote_codigo
		ALTER TABLE Recaptchat.HABITACION DROP CONSTRAINT FK_habi_hote_codigo
		ALTER TABLE Recaptchat.HABITACION DROP CONSTRAINT FK_habi_tipo
		ALTER TABLE Recaptchat.CLIENTE DROP CONSTRAINT FK_clie_acomp_codigo
		ALTER TABLE Recaptchat.RESERVA DROP CONSTRAINT FK_rese_clie_codigo
		ALTER TABLE Recaptchat.RESERVA DROP CONSTRAINT FK_rese_habi_codigo
		ALTER TABLE Recaptchat.RESERVA DROP CONSTRAINT FK_rese_regi_codigo
		ALTER TABLE Recaptchat.ESTADIA DROP CONSTRAINT FK_esta_rese_codigo
		ALTER TABLE Recaptchat.FACTURA DROP CONSTRAINT FK_fact_clie_codigo
		ALTER TABLE Recaptchat.ITEM_FACTURA DROP CONSTRAINT FK_item_fact_numero
		ALTER TABLE Recaptchat.ITEM_FACTURA DROP CONSTRAINT FK_item_cons_codigo
PRINT 'Constrains Eliminadas ...';

PRINT 'Truncate todas las tablas ...';

Truncate table Recaptchat.USUARIO
Truncate table Recaptchat.REGIMEN_ESTADIA
Truncate table Recaptchat.FUNCIONALIDAD
Truncate table Recaptchat.HOTEL
Truncate table Recaptchat.CONSUMIBLES
Truncate table Recaptchat.ROL
Truncate table Recaptchat.ROL_X_USUARIO
Truncate table Recaptchat.FUNCIONALIDAD_X_ROL
Truncate table Recaptchat.HOTEL_X_USUARIO
Truncate table Recaptchat.ESTADO_HOTEL
Truncate table Recaptchat.HABITACION
Truncate table Recaptchat.CLIENTE
Truncate table Recaptchat.RESERVA
Truncate table Recaptchat.ESTADIA
Truncate table Recaptchat.FACTURA
Truncate table Recaptchat.ESTADIA
PRINT 'Tablas Trunqueadas ...';


/* ****************************************************************************
* SECCION_5 : MIGRACION DE DATOS DE TABLA MAESTRA
**************************************************************************** */

PRINT 'Cargando las Tablas ...';

--01 Carga de Tabla "ROL"

	INSERT INTO Recaptchat.ROL 
		(rol_nombre)
	VALUES
	 	('ADMINISTRADOR'),
	    ('RECEPCIONISTA'),
		('GUEST')


	--	Select * from Recaptchat.ROL 

-- 02 Carga de Tabla "FUNCIONALIDAD"

	INSERT INTO Recaptchat.FUNCIONALIDAD 
		(func_nombre)
	VALUES 
		('Administrar'),
		('Empleado'),
		('Huesped')

--	Select * from Recaptchat.FUNCIONALIDAD
	

		
--03 Carga de Tabla "FUNCIONALIDAD_X_ROL"

	INSERT INTO Recaptchat.FUNCIONALIDAD_X_ROL (fxr_rol_codigo, fxr_func_codigo)
	VALUES 
		((SELECT rol_codigo FROM  Recaptchat.Rol  WHERE rol_nombre = 'ADMINISTRADOR'), (SELECT func_codigo FROM Recaptchat.Funcionalidad WHERE func_nombre = 'Administrar')),
		((SELECT rol_codigo FROM  Recaptchat.Rol  WHERE rol_nombre = 'RECEPCIONISTA'), (SELECT func_codigo FROM Recaptchat.Funcionalidad WHERE func_nombre = 'Empleado')),
		((SELECT rol_codigo FROM  Recaptchat.Rol  WHERE rol_nombre = 'GUEST'), (SELECT func_codigo FROM Recaptchat.Funcionalidad WHERE func_nombre = 'Huesped'))	

--	Select * from Recaptchat.FUNCIONALIDAD_X_ROL

--04 Carga de Tabla "USUARIO"

	INSERT INTO Recaptchat.USUARIO 
		(usua_username,usua_password, usua_fecha_creacion,usua_nombre,usua_apellido, usua_mail) 
	VALUES 
		('admin',HASHBYTES('SHA2_256','w23e'), GETDATE(),'admin','admin','ejemplo1@gmail.com'),  
		('gaston',HASHBYTES('SHA2_256','gaston'), GETDATE(),'Gastón','Di filippo','ejemplo2@gmail.com'),
		('damian',HASHBYTES('SHA2_256','damian'), GETDATE(),'Damián','','ejemplo3@gmail.com'),
		('ariel',HASHBYTES('SHA2_256','ariel'), GETDATE(),'Ariel','','ejemplo4@gmail.com'),
		('jose',HASHBYTES('SHA2_256','jose'), GETDATE(),'José','Quispealaya','ejemplo5@gmail.com')

--	Select * from Recaptchat.USUARIO  

--05 Carga de Tabla "ROL_X_USUARIO"

	INSERT INTO Recaptchat.ROL_X_USUARIO 
		(rxu_usua_codigo, rxu_rol_codigo) 
    VALUES
	    ((SELECT usua_codigo FROM  Recaptchat.USUARIO WHERE  usua_codigo = 1 ), (SELECT rol_codigo FROM Recaptchat.ROL WHERE rol_codigo = 1)),
		((SELECT usua_codigo FROM  Recaptchat.USUARIO WHERE  usua_codigo = 2 ), (SELECT rol_codigo FROM Recaptchat.ROL WHERE rol_codigo = 2)),
		((SELECT usua_codigo FROM  Recaptchat.USUARIO WHERE  usua_codigo = 3 ), (SELECT rol_codigo FROM Recaptchat.ROL WHERE rol_codigo = 2)),
		((SELECT usua_codigo FROM  Recaptchat.USUARIO WHERE  usua_codigo = 4 ), (SELECT rol_codigo FROM Recaptchat.ROL WHERE rol_codigo = 3)),
		((SELECT usua_codigo FROM  Recaptchat.USUARIO WHERE  usua_codigo = 5 ), (SELECT rol_codigo FROM Recaptchat.ROL WHERE rol_codigo = 3))

Select * from Recaptchat.ROL_X_USUARIO 

--06 Carga de Tabla "HOTEL"

	INSERT INTO Recaptchat.HOTEL
		(hote_ciudad,hote_dir_calle, hote_dir_numero, hote_cant_estrellas, hote_tipo_regimen,  hote_recarga_estrellas)

	(SELECT distinct Hotel_Ciudad, Hotel_Calle, Hotel_Nro_Calle, Hotel_CantEstrella, Regimen_Descripcion, Hotel_Recarga_Estrella FROM  gd_esquema.Maestra)

Select hote_ciudad, hote_dir_calle, hote_dir_numero, hote_tipo_regimen from Recaptchat.HOTEL
order by hote_dir_numero desc
	
--07 Carga de Tabla "HOTEL_X_USUARIO"
	INSERT INTO Recaptchat.HOTEL_X_USUARIO
		(hxu_hote_codigo, hxu_usua_codigo)
	VALUES
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 1), (SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 2)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 2), (SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 2)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 3), (SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 2)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 4), (SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 2)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 5), (SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 3)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 6), (SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 3)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 7), (SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 3)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 8), (SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 3)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 9), (SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 4)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 10),(SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 4)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 11),(SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 4)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 12),(SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 4)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 13),(SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 5)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 14),(SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 5)),
		((SELECT hote_codigo FROM  Recaptchat.HOTEL WHERE hote_codigo = 15),(SELECT usua_codigo FROM Recaptchat.USUARIO WHERE usua_codigo = 5))
	
	select * from Recaptchat.HOTEL_X_USUARIO

-- 08 Carga de Tabla "ESTADO_HOTEL"

	INSERT INTO Recaptchat.ESTADO_HOTEL
		(esho_hote_codigo)

	(SELECT hote_codigo FROM Recaptchat.HOTEL)

	select * from Recaptchat.ESTADO_HOTEL
	
--09 Carga de Tabla "HABITACION_TIPO"

	INSERT INTO Recaptchat.HABITACION_TIPO
		(habi_tipo, habi_descripcion, habi_porcentual)

	(SELECT DISTINCT Habitacion_Tipo_Codigo, Habitacion_Tipo_Descripcion, Habitacion_Tipo_Porcentual FROM gd_esquema.Maestra)  

	Select * from Recaptchat.HABITACION_TIPO

--10 Carga de Tabla "HABITACION"

	INSERT INTO Recaptchat.HABITACION
		(habi_hote_codigo, habi_tipo, habi_numero, habi_piso, habi_ubicacion_frente)
	   (Select Distinct HT.hote_codigo, M1.Habitacion_Tipo_Codigo, M1.Habitacion_Numero, M1.Habitacion_Piso, Habitacion_Frente
		from Recaptchat.HOTEL HT
			JOIN gd_esquema.Maestra M1 on	M1.Hotel_Calle = HT.hote_dir_calle AND 
											M1.Hotel_Nro_Calle = M1.Hotel_Nro_Calle AND
											M1.Hotel_Ciudad = M1.Hotel_Ciudad)
/*	(SELECT (SELECT DISTINCT HT.hote_codigo FROM Recaptchat.HOTEL HT 
	     WHERE HT.hote_dir_calle = M1.Hotel_Calle AND HT.hote_dir_numero = M1.Hotel_Nro_Calle ),
	     M1.Habitacion_Tipo_Codigo, M1.Habitacion_Numero, M1.Habitacion_Piso, Habitacion_Frente FROM gd_esquema.Maestra M1)
*/
	

	Select * from Recaptchat.HABITACION

--11 Carga de Tabla "CLIENTE"

	INSERT INTO Recaptchat.CLIENTE
		(clie_doc_numero,clie_doc_tipo, clie_nombre, clie_apellido, clie_fecha_nacimiento, clie_mail, clie_dir_nombre, clie_dir_numero, clie_dir_piso, clie_dir_dpto,clie_nacionalidad)

		(SELECT DISTINCT Cliente_Pasaporte_Nro, 'Pasaporte', Cliente_Nombre, Cliente_Apellido, Cliente_Fecha_Nac, Cliente_Mail, Cliente_Dom_Calle, Cliente_Nro_Calle, Cliente_Piso, Cliente_Depto, Cliente_Nacionalidad FROM gd_esquema.Maestra )

select * from Recaptchat.CLIENTE

--12 Carga de Tabla "REGIMEN_ESTADIA"

	INSERT INTO Recaptchat.REGIMEN_ESTADIA
	     (regi_descripcion, regi_precio_base)
		 
		 (SELECT Distinct Regimen_Descripcion, Regimen_Precio FROM gd_esquema.Maestra)

	Select * from Recaptchat.REGIMEN_ESTADIA

		 
		 /*************HASTA AQUI FUNCIONA PERFECTAMENTE***********************/


----------------------------------------------------------------------------------------------

--13
SELECT * FROM Recaptchat.RESERVA

	INSERT INTO Recaptchat.RESERVA
	(rese_codigo, rese_habi_codigo, rese_regi_codigo, rese_fecha_desde, rese_fecha_hasta, rese_cant_noches)

	(
	Select Distinct M.Reserva_Codigo, 
			hab.habi_hote_codigo,
			reg.regi_codigo,	
			M.Reserva_Fecha_Inicio, 
			M.Reserva_Fecha_Inicio + M.Reserva_Cant_Noches, 
			M.Reserva_Cant_Noches
	 From gd_esquema.Maestra M
		join Recaptchat.HOTEL H ON H.hote_ciudad = M.Hotel_Ciudad AND 
									H.hote_dir_calle = M.Hotel_Calle AND 
									H.hote_dir_numero = M.Hotel_Nro_Calle
		Join Recaptchat.REGIMEN_ESTADIA reg ON reg.regi_descripcion = H.hote_tipo_regimen 
		join Recaptchat.HABITACION hab on H.hote_codigo = hab.habi_hote_codigo
		)

	/*				(SELECT DISTINCT HB.habi_codigo FROM Recaptchat.HABITACION HB 
					JOIN Recaptchat.HOTEL HT ON 
										HB.habi_hote_codigo = HT.hote_codigo 
										AND HT.hote_dir_calle = M.Hotel_Calle AND 
						HT.hote_dir_numero = M.Hotel_Nro_Calle),
	*/
	Select Distinct M.Reserva_Codigo  From gd_esquema.Maestra M
	order by M.Reserva_Codigo desc

	-- RESERVA_X_CLIENTE

	Select Distinct M.Reserva_Codigo, 
		C.clie_codigo
	 From gd_esquema.Maestra M
		JOIN Recaptchat.CLIENTE C on C.clie_doc_numero = M.Cliente_Pasaporte_Nro
	Order by M.Reserva_Codigo desc


	Select Distinct M.Reserva_Codigo, 
--			C.clie_codigo,
			hab.habi_hote_codigo as Habitacion_reservada,
			H.hote_tipo_regimen,	
			M.Reserva_Fecha_Inicio as rese_fecha_desde, 
			M.Reserva_Fecha_Inicio + M.Reserva_Cant_Noches as rese_fecha_hasta, 
			M.Reserva_Cant_Noches as rese_cant_noches
	 From gd_esquema.Maestra M
--		Join Recaptchat.CLIENTE C on C.clie_doc_numero = M.Cliente_Pasaporte_Nro
		join Recaptchat.HOTEL H ON H.hote_tipo_regimen = M.Regimen_Descripcion
		join Recaptchat.HABITACION hab on H.hote_codigo = hab.habi_hote_codigo
--		join Recaptchat.HABITACION_TIPO HT on HT.habi_tipo = hab.habi_tipo 
		 Where H.hote_ciudad = M.Hotel_Ciudad AND 
									H.hote_dir_calle = M.Hotel_Calle AND 
									H.hote_dir_numero = M.Hotel_Nro_Calle


/* CON SELECTS Y SUBSELECTS A LO INDIO */
Select 
	(Select Distinct M.Reserva_Codigo, C.clie_codigo,
			hab.habi_hote_codigo as Habitacion_reservada,
			H.hote_tipo_regimen,	
			M.Reserva_Fecha_Inicio as rese_fecha_desde, 
			M.Reserva_Fecha_Inicio + M.Reserva_Cant_Noches as rese_fecha_hasta, 
			M.Reserva_Cant_Noches as rese_cant_noches
			from Recaptchat.HABITACION hab, gd_esquema.Maestra M, Recaptchat.CLIENTE C, Recaptchat.HOTEL H
			where C.clie_doc_numero = M.Cliente_Pasaporte_Nro AND
					H.hote_tipo_regimen = M.Regimen_Descripcion AND
					H.hote_codigo = hab.habi_hote_codigo)

	/*		C.clie_codigo,
			hab.habi_hote_codigo as Habitacion_reservada,
			H.hote_tipo_regimen,	
			M.Reserva_Fecha_Inicio as rese_fecha_desde, 
			M.Reserva_Fecha_Inicio + M.Reserva_Cant_Noches as rese_fecha_hasta, 
			M.Reserva_Cant_Noches as rese_cant_noches
			*/
	 From gd_esquema.Maestra M, Recaptchat.CLIENTE C, Recaptchat.HOTEL H

update Recaptchat.RESERVA 
set rese_clie_codigo = (Select Distinct clie_codigo from Recaptchat.CLIENTE)

SELECT HA.habi_Codigo FROM gd_esquema.Maestra M1 JOIN Recaptchat.HOTEL H1
	ON M1.Hotel_Calle = H1.hote_dir_calle 
	AND M1.Hotel_Nro_Calle = H1.hote_dir_numero
	JOIN Recaptchat.HABITACION HA ON HA.habi_numero = M1.Habitacion_Numero
		WHERE HA.habi_hote_codigo = H1.hote_codigo

Select Distinct hab.habi_codigo, hab.habi_numero from Recaptchat.HOTEL H
	join gd_esquema.Maestra M ON H.hote_ciudad = M.Hotel_Ciudad AND 
									H.hote_dir_calle = M.Hotel_Calle AND 
									H.hote_dir_numero = M.Hotel_Nro_Calle
								-- AND H.hote_tipo_regimen = M.Regimen_Descripcion
	join Recaptchat.HABITACION hab on H.hote_codigo = hab.habi_hote_codigo
order by hab.habi_codigo

--14 Carga de Tabla "ESTADIA"
	
	INSERT INTO Recaptchat.ESTADIA
	( esta_rese_codigo, esta_fecha_inicio, esta_cant_noches)


--		FALTA HACER EL RESTO		
--	Select r.rese_codigo, r.rese_fecha_desde, r.rese_cant_noches from Recaptchat.RESERVA r


--15 Carga de Tabla "FACTURA"

	INSERT INTO Recaptchat.FACTURA
	   (fact_clie_codigo, fact_fecha, fact_total )
	(SELECT  FROM gd_esquema.Maestra)           
	
	Select cl.clie_codigo from Recaptchat.CLIENTE cl
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           