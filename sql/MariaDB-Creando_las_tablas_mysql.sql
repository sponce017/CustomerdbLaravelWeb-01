
DROP TABLE cb_customer;
DROP TABLE cb_enterprise;
DROP TABLE cb_paymentmethod;
DROP TABLE cb_address;
DROP TABLE cb_addresses;
DROP TABLE cb_country;
DROP TABLE cb_currency;
DROP TABLE cb_language;



-- Table: cb_language

-- DROP TABLE cb_language;

CREATE TABLE cb_language
(
  idlanguage VARCHAR(6) NOT NULL COMMENT 'Como clave primaria usamos la codificación del idioma i18n e i10n, las principales: es_ES y en_EN, que serán las que se usarán por defecto.',
  namelanguage VARCHAR(60) NOT NULL COMMENT 'Nombre del idioma en el idioma por defecto del sistema (castellano).',
  isactive VARCHAR(1) NOT NULL DEFAULT 'N',
  languageiso VARCHAR(2),
  countrycode VARCHAR(2),
  isbaselanguage VARCHAR(1) NOT NULL DEFAULT 'N',
  issystemlanguage VARCHAR(1) NOT NULL DEFAULT 'N',
CONSTRAINT pk_cb_language PRIMARY KEY (idlanguage),
CONSTRAINT u_cb_language_namelanguage UNIQUE (namelanguage),
CONSTRAINT ch_cb_language_isactive_check CHECK (isactive IN ('Y', 'N')),
CONSTRAINT ch_cb_language_isbaselang_check CHECK(isbaselanguage IN ('Y', 'N')),    
CONSTRAINT ch_cb_language_issysang_check CHECK (issystemlanguage IN ('Y', 'N'))
) 
ENGINE = InnoDB
COMMENT='Como clave primaria usamos la codificación del idioma i18n e i10n, las principales: es_ES y en_EN, que serán las que se usarán por defecto.';
GRANT ALL ON TABLE cb_language TO xulescode;


-- Table: cb_currency

-- DROP TABLE cb_currency;

CREATE TABLE cb_currency
(
  idcurrency INT NOT NULL AUTO_INCREMENT,
  currency VARCHAR(60) NOT NULL,
  description  VARCHAR(255) NOT NULL ,
  isactive VARCHAR(1) NOT NULL DEFAULT 'N',
  isocode VARCHAR(3) NOT NULL,
  cursymbol VARCHAR(10),
  precisionstd DECIMAL(10,0) NOT NULL,
  precisioncost DECIMAL(10,0) NOT NULL,
  precisionprize DECIMAL(10,0) NOT NULL DEFAULT 0,
  CONSTRAINT pk_cb_currency PRIMARY KEY (idcurrency),
  CONSTRAINT u_cb_currency_currency UNIQUE (currency),
  CONSTRAINT u_cb_currency_isocode UNIQUE (isocode)
)
ENGINE = InnoDB
COMMENT='Tabla  donde se definen las monedas disponibles y sus relaciones a partir de las monedas bases.';
GRANT ALL ON TABLE cb_currency TO xulescode;


-- Table: cb_country

-- DROP TABLE cb_country;

CREATE TABLE cb_country
(
  idcountry INT NOT NULL AUTO_INCREMENT,
  country VARCHAR(100) NOT NULL,
  description VARCHAR(255),
  countrycode VARCHAR(2) NOT NULL,
  hasregion VARCHAR(1) NOT NULL DEFAULT 'N',
  regionname VARCHAR(60),
  expressionphone VARCHAR(20),
  displaysequence VARCHAR(20) NOT NULL,
  isdefault  VARCHAR(1) NOT NULL DEFAULT 'N',
  ibannodigits NUMERIC,
  ibancountry VARCHAR(2),
  isactive BOOLEAN NOT NULL DEFAULT true,
  idlanguage VARCHAR(6),
  idcurrency INT,
  CONSTRAINT pk_cb_country PRIMARY KEY (idcountry),
  CONSTRAINT fk_cb_country_idcurrency FOREIGN KEY (idcurrency)
      REFERENCES cb_currency (idcurrency) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cb_country_idlanguage FOREIGN KEY (idlanguage)
      REFERENCES cb_language (idlanguage) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT un_cb_country_countrycode UNIQUE (countrycode),
  CONSTRAINT ch_cb_country_hasregion_check CHECK (hasregion IN ('Y', 'N')),
  CONSTRAINT ch_cb_country_isdefault_check CHECK (isdefault IN ('Y', 'N'))
)
ENGINE=InnoDB
COMMENT='Tabla donde se definen todos los países con sus características principales: idioma, nombre, ..., y diferentes datos íntrinsecos a cada país.';
GRANT ALL ON TABLE cb_country TO xulescode;



-- Table: cb_addresses

-- DROP TABLE cb_addresses;

CREATE TABLE cb_addresses
(
  idaddresses INT NOT NULL AUTO_INCREMENT,
  addressesentity VARCHAR(100) NOT NULL,
  CONSTRAINT pk_cb_addresses PRIMARY KEY (idaddresses)
)
ENGINE=InnoDB
COMMENT='Agrupación de las direcciones asignadas a una entidad.';
GRANT ALL ON TABLE cb_addresses TO xulescode;


-- Table: cb_address

-- DROP TABLE cb_address;

CREATE TABLE cb_address
(
  idaddress INT NOT NULL AUTO_INCREMENT,
  idaddresses INT,
  address VARCHAR(500),
  postalnumber VARCHAR(20),
  mainphone VARCHAR(100),
  movilephone VARCHAR(100),
  phone2 VARCHAR(100),
  phone3 VARCHAR(100),
  carrier VARCHAR(200),
  addresstype VARCHAR(100),
  locality VARCHAR(250),
  estate VARCHAR(250),
  idcountry INT,
  notes1 VARCHAR(500),
  CONSTRAINT pk_cb_address PRIMARY KEY (idaddress),
  CONSTRAINT fk_cb_address_idaddresses FOREIGN KEY (idaddresses)
      REFERENCES cb_addresses (idaddresses) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cb_address_idcountry FOREIGN KEY (idcountry)
      REFERENCES cb_country (idcountry) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
ENGINE=InnoDB
COMMENT='Direcciones para: Clientes, Empresas,... ';
GRANT ALL ON TABLE cb_address TO xulescode;


-- Table: cb_paymentmethod

-- DROP TABLE cb_paymentmethod;

CREATE TABLE cb_paymentmethod
(
  idpaymentmethod INT NOT NULL AUTO_INCREMENT,
  paymentmethod VARCHAR(100) NOT NULL,
  description VARCHAR(150),
  paymentterms VARCHAR(250),
  paymententity VARCHAR(50),
  CONSTRAINT pk_cb_paymentmethod PRIMARY KEY (idpaymentmethod),
  CONSTRAINT un_cb_paymentmethod_paymentmethod UNIQUE (paymentmethod)
)
ENGINE=InnoDB
COMMENT='';
GRANT ALL ON TABLE cb_paymentmethod TO xulescode;

-- Table: cb_enterprise

-- DROP TABLE cb_enterprise;

CREATE TABLE cb_enterprise
(
  identerprise INT NOT NULL,
  enterprise VARCHAR(150),
  description VARCHAR(250),
  enterprisealias VARCHAR(100),
  contact VARCHAR(250),
  estate VARCHAR(30),
  balance DECIMAL(10,3),
  ei VARCHAR(100),
  enterprisepayer VARCHAR(20),
  idcountry INT,
  idcurrency INT,
  idlanguage VARCHAR(6),
  CONSTRAINT pk_enterprise PRIMARY KEY (identerprise),
  CONSTRAINT cb_enterprise_idlanguage FOREIGN KEY (idlanguage)
      REFERENCES cb_language (idlanguage) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cb_enterprise_idcountry FOREIGN KEY (idcountry)
      REFERENCES cb_country (idcountry) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cb_enterprise_idcurrency FOREIGN KEY (idcurrency)
      REFERENCES cb_currency (idcurrency) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
ENGINE=InnoDB
COMMENT='Tabla para controlar las empresas que se usan en la aplicación, la aplicación se desarrolla en función de estos parámetros ya que habrá algunas tablas que serán comunes a las empresa y otras que no, por ejemplo, cada empresa tendrá sus propios productos, pero tendrá los mismos tipos de documentos de trabajo.';
GRANT ALL ON TABLE cb_enterprise TO xulescode;


-- Table: cb_customer

-- DROP TABLE cb_customer;

CREATE TABLE cb_customer
(
  idcustomer INT NOT NULL AUTO_INCREMENT,
  identerprise INT,
  customer VARCHAR(15) NOT NULL,
  customername VARCHAR(150),
  customeralias VARCHAR(100),
  contact VARCHAR(250),
  customerstate VARCHAR(30),
  sale DECIMAL(10,3),
  identitynumber VARCHAR(100),
  customerpayer VARCHAR(20),
  idpaymentmethod INT,
  idcountry INT,
  idcurrency INT,
  idlanguage VARCHAR(6),
  idaddresses INT,
  CONSTRAINT pk_cb_customer PRIMARY KEY (idcustomer),
  CONSTRAINT fk_cb_customer_idaddresses FOREIGN KEY (idaddresses)
      REFERENCES cb_addresses (idaddresses) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cb_customer_idcountry FOREIGN KEY (idcountry)
      REFERENCES cb_country (idcountry) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cb_customer_idcurrency FOREIGN KEY (idcurrency)
      REFERENCES cb_currency (idcurrency) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cb_customer_identerprise FOREIGN KEY (identerprise)
      REFERENCES cb_enterprise (identerprise) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cb_customer_idlanguage FOREIGN KEY (idlanguage)
      REFERENCES cb_language (idlanguage) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_cb_customer_idpaymentmethod FOREIGN KEY (idpaymentmethod)
      REFERENCES cb_paymentmethod (idpaymentmethod) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT un_cb_customer_cb_enterprise UNIQUE (identerprise, customer)
)
ENGINE=InnoDB
COMMENT='Tabla donde se almacenarán los clientes de las diferentes empresas, se entiende cliente como aquel que compra a una empresa.';
GRANT ALL ON TABLE cb_customer TO xulescode;

/*

INDEX `fk_employee_company` (`company` ASC) ,


auto_increment
;
;
;
http://blog.jbaysolutions.com/2011/09/19/jpa-2-relationships-onetomany/

 CREATE  TABLE IF NOT EXISTS `jpatutorial2`.`company` (
   `idcompany` INT NOT NULL AUTO_INCREMENT ,
   `name` VARCHAR(45) NOT NULL ,
   `address` VARCHAR(45) NOT NULL ,
   PRIMARY KEY (`idcompany`) )
 ENGINE = InnoDB;

 CREATE  TABLE IF NOT EXISTS `jpatutorial2`.`employee` (
   `idemployee` INT NOT NULL AUTO_INCREMENT ,
   `company` INT NOT NULL ,
   `name` VARCHAR(45) NOT NULL ,
   `phone` VARCHAR(45) NOT NULL ,
   PRIMARY KEY (`idemployee`) ,
   
   CONSTRAINT `fk_employee_company`
     FOREIGN KEY (`company` )
     REFERENCES `jpatutorial2`.`company` (`idcompany` )
     ON DELETE NO ACTION
     ON UPDATE NO ACTION)
 ENGINE = InnoDB;


Creación de una clave foránea en Mysql:

INDEX `fk_employee_company` (`company` ASC) ,
   CONSTRAINT `fk_employee_company`
     FOREIGN KEY (`company` )
     REFERENCES `jpatutorial2`.`company` (`idcompany` )
     ON DELETE NO ACTION
     ON UPDATE NO ACTION)
*/
