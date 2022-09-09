CREATE TABLE "ORDERS_AST" (
	"order_id" NUMBER(10) NOT NULL,
	"client_id" NUMBER(10) NOT NULL,
	"shop_id" NUMBER(10) NOT NULL,
	"employee_id" NUMBER(10) NOT NULL,
	"order_status" VARCHAR2(25) NOT NULL,
	"order_date" TIMESTAMP NOT NULL,
	"shippment_date" TIMESTAMP NOT NULL,
	constraint ORDERS_PK PRIMARY KEY ("order_id"));

CREATE sequence "ORDERS_ORDER_ID_SEQ";

ALTER TABLE ORDERS_AST DROP ("shippment_date", "order_date");

CREATE trigger "ORDERS_ORDER_ID"
  before insert on "ORDERS_AST"
  for each row
begin
  select "ORDERS_ORDER_ID_SEQ".nextval into :NEW."order_id" from dual;
end;

CREATE TABLE "EMPLOYEES_AST" (
	"employee_id" NUMBER(10) NOT NULL,
	"shop_id" NUMBER(10) NOT NULL,
	"manager_id" NUMBER(10) NOT NULL,
	"first_name" VARCHAR2(50) NOT NULL,
	"last_name" VARCHAR2(50) NOT NULL,
	"phone_number" NUMBER(15) NOT NULL,
	constraint EMPLOYEES_PK PRIMARY KEY ("employee_id"));
    
ALTER TABLE EMPLOYEES_AST
MODIFY "manager_id" NULL;

CREATE sequence "EMPLOYEES_EMPLOYEE_ID_SEQ";

CREATE trigger "EMPLOYEES_EMPLOYEE_ID"
  before insert on "EMPLOYEES_AST"
  for each row
begin
  select "EMPLOYEES_EMPLOYEE_ID_SEQ".nextval into :NEW."employee_id" from dual;
end;

CREATE TABLE "ORDER_DETAILS_AST" (
	"order_id" NUMBER(10) NOT NULL,
	"product_id" NUMBER(10) NOT NULL,
	"quantity" NUMBER(10) NOT NULL,
	"price" FLOAT(4) NOT NULL,
	constraint ORDER_DETAILS_PK PRIMARY KEY ("order_id","product_id"));
    
    
CREATE TABLE "PRODUCTS_AST" (
	"product_id" NUMBER(10) NOT NULL,
	"product_name" VARCHAR2(50) NOT NULL,
	"price" FLOAT(4) NOT NULL,
	"type_id" NUMBER(10) NOT NULL,
	constraint PRODUCTS_PK PRIMARY KEY ("product_id"));

CREATE sequence "PRODUCTS_PRODUCT_ID_SEQ";

CREATE trigger "PRODUCTS_PRODUCT_ID"
  before insert on "PRODUCTS_AST"
  for each row
begin
  select "PRODUCTS_PRODUCT_ID_SEQ".nextval into :NEW."product_id" from dual;
end;

CREATE TABLE "CLIENTS_AST" (
	"client_id" NUMBER(10) NOT NULL,
	"first_name" VARCHAR2(50) NOT NULL,
	"last_name" VARCHAR2(50) NOT NULL,
	"phone_number" NUMBER(15) NOT NULL,
	"city" VARCHAR2(50) NOT NULL,
	"street" VARCHAR2(50) NOT NULL,
	"street_number" NUMBER(5) NOT NULL,
	"zip_code" NUMBER(15) NOT NULL,
	constraint CLIENTS_PK PRIMARY KEY ("client_id"));

CREATE sequence "CLIENTS_CLIENT_ID_SEQ";

CREATE trigger "CLIENTS_CLIENT_ID"
  before insert on "CLIENTS_AST"
  for each row
begin
  select "CLIENTS_CLIENT_ID_SEQ".nextval into :NEW."client_id" from dual;
end;

ALTER TABLE CLIENTS_AST
  MODIFY ("phone_number" VARCHAR2(15),
            "zip_code" VARCHAR2(15));
            
ALTER TABLE EMPLOYEES_AST       
MODIFY "phone_number" VARCHAR2(15);

CREATE TABLE "TYPES_AST" (
	"type_id" NUMBER(10) NOT NULL,
	"type_name" VARCHAR2(50) NOT NULL,
	constraint TYPES_PK PRIMARY KEY ("type_id"));

CREATE sequence "TYPES_TYPE_ID_SEQ";

CREATE trigger "TYPES_TYPE_ID"
  before insert on "TYPES_AST"
  for each row
begin
  select "TYPES_TYPE_ID_SEQ".nextval into :NEW."type_id" from dual;
end;

CREATE TABLE "SHOPS_AST" (
	"shop_id" NUMBER(10) NOT NULL,
	"shop_name" VARCHAR2(50) NOT NULL,
	"city" VARCHAR2(50) NOT NULL,
	"street" VARCHAR2(50) NOT NULL,
	"street_number" VARCHAR2(50) NOT NULL,
	"zip_code" VARCHAR2(50) NOT NULL,
	constraint SHOPS_PK PRIMARY KEY ("shop_id"));

CREATE sequence "SHOPS_SHOP_ID_SEQ";

CREATE trigger "SHOPS_SHOP_ID"
  before insert on "SHOPS_AST"
  for each row
begin
  select "SHOPS_SHOP_ID_SEQ".nextval into :NEW."shop_id" from dual;
end;

CREATE TABLE "STOCKS_AST" (
	"shop_id" NUMBER(10) NOT NULL,
	"product_id" NUMBER(10) NOT NULL,
	"quantity" NUMBER(10),
	constraint STOCKS_PK PRIMARY KEY ("shop_id","product_id"));
    
    
ALTER TABLE "ORDERS_AST" ADD CONSTRAINT "ORDERS_fk0" FOREIGN KEY ("client_id") REFERENCES "CLIENTS_AST"("client_id");
ALTER TABLE "ORDERS_AST" ADD CONSTRAINT "ORDERS_fk1" FOREIGN KEY ("shop_id") REFERENCES "SHOPS_AST"("shop_id");
ALTER TABLE "ORDERS_AST" ADD CONSTRAINT "ORDERS_fk2" FOREIGN KEY ("employee_id") REFERENCES "EMPLOYEES_AST"("employee_id");

ALTER TABLE "EMPLOYEES_AST" ADD CONSTRAINT "EMPLOYEES_fk0" FOREIGN KEY ("shop_id") REFERENCES "SHOPS_AST"("shop_id");
ALTER TABLE "EMPLOYEES_AST" ADD CONSTRAINT "EMPLOYEES_fk1" FOREIGN KEY ("manager_id") REFERENCES "EMPLOYEES_AST"("employee_id");

ALTER TABLE "ORDER_DETAILS_AST" ADD CONSTRAINT "ORDER_DETAILS_fk0" FOREIGN KEY ("order_id") REFERENCES "ORDERS_AST"("order_id");
ALTER TABLE "ORDER_DETAILS_AST" ADD CONSTRAINT "ORDER_DETAILS_fk1" FOREIGN KEY ("product_id") REFERENCES "PRODUCTS_AST"("product_id");

ALTER TABLE "PRODUCTS_AST" ADD CONSTRAINT "PRODUCTS_fk0" FOREIGN KEY ("type_id") REFERENCES "TYPES_AST"("type_id");

ALTER TABLE "STOCKS_AST" ADD CONSTRAINT "STOCKS_fk0" FOREIGN KEY ("shop_id") REFERENCES "SHOPS_AST"("shop_id");
ALTER TABLE "STOCKS_AST" ADD CONSTRAINT "STOCKS_fk1" FOREIGN KEY ("product_id") REFERENCES "PRODUCTS_AST"("product_id");

INSERT INTO clients_ast("first_name", "last_name", "phone_number", "city", "street", "street_number", "zip_code")
VALUES ('Ion', 'Popescu', '0769-999-999', 'Bucuresti', 'Florilor', 6, '110165');
INSERT INTO clients_ast("first_name", "last_name", "phone_number", "city", "street", "street_number", "zip_code")
VALUES ('Mircea', 'Radulescu', '0769-999-998', 'Bucuresti', 'Ciresilor', 1, '022452');
INSERT INTO clients_ast("first_name", "last_name", "phone_number", "city", "street", "street_number", "zip_code")
VALUES ('Anca', 'Petrov', '0769-999-997', 'Cluj', 'Rozelor', 10, '113265');

INSERT INTO TYPES_AST("type_name")
VALUES ('tablou');
INSERT INTO TYPES_AST("type_name")
VALUES ('figurina');
INSERT INTO TYPES_AST("type_name")
VALUES ('comic book');

INSERT INTO PRODUCTS_AST("type_id","product_name","price")
VALUES(1,'Peisaj de iarna', 100);
INSERT INTO PRODUCTS_AST("type_id","product_name","price")
VALUES(1,'Ilustratie Void Chicken', 60);
INSERT INTO PRODUCTS_AST("type_id","product_name","price")
VALUES(2,'Figurina Lux Lyfeld', 110);
INSERT INTO PRODUCTS_AST("type_id","product_name","price")
VALUES(3,'Lux si Nox Volumul 1', 50);

INSERT INTO SHOPS_AST("shop_name","city","street","street_number","zip_code")
VALUES('Artistique','Bucuresti','Roua',21,'0713435');
INSERT INTO SHOPS_AST("shop_name","city","street","street_number","zip_code")
VALUES('Beart','Bucuresti','Laleaua',3,'02142435');
INSERT INTO SHOPS_AST("shop_name","city","street","street_number","zip_code")
VALUES('Bookify','Bucuresti','Roua',15,'07138563');

INSERT INTO EMPLOYEES_AST("manager_id","shop_id","first_name","last_name","phone_number")
VALUES(Null,1,'Robert','Cristea','0768-967-012');
INSERT INTO EMPLOYEES_AST("manager_id","shop_id","first_name","last_name","phone_number")
VALUES(1,1,'Rares','Neagu','0768-961-012');
INSERT INTO EMPLOYEES_AST("manager_id","shop_id","first_name","last_name","phone_number")
VALUES(Null,2,'Marin','Marian','0768-967-142');
INSERT INTO EMPLOYEES_AST("manager_id","shop_id","first_name","last_name","phone_number")
VALUES(3,2,'Andrei','Popa','0768-967-012');
INSERT INTO EMPLOYEES_AST("manager_id","shop_id","first_name","last_name","phone_number")
VALUES(Null,3,'Matei','Cosmin','0768-967-992');
INSERT INTO EMPLOYEES_AST("manager_id","shop_id","first_name","last_name","phone_number")
VALUES(5,3,'Miruna','Irinel','0768-967-432');
INSERT INTO EMPLOYEES_AST("manager_id","shop_id","first_name","last_name","phone_number")
VALUES(5,3,'Ana','Constantin','0748-967-422');

INSERT INTO STOCKS_AST("shop_id", "product_id", "quantity")
VALUES(1,1,10);
INSERT INTO STOCKS_AST("shop_id", "product_id", "quantity")
VALUES(1,2,10);
INSERT INTO STOCKS_AST("shop_id", "product_id", "quantity")
VALUES(1,3,10);
INSERT INTO STOCKS_AST("shop_id", "product_id", "quantity")
VALUES(2,1,10);
INSERT INTO STOCKS_AST("shop_id", "product_id", "quantity")
VALUES(2,2,10);
INSERT INTO STOCKS_AST("shop_id", "product_id", "quantity")
VALUES(2,3,10);
INSERT INTO STOCKS_AST("shop_id", "product_id", "quantity")
VALUES(3,1,10);
INSERT INTO STOCKS_AST("shop_id", "product_id", "quantity")
VALUES(3,2,10);
INSERT INTO STOCKS_AST("shop_id", "product_id", "quantity")
VALUES(3,3,10);

INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(1,1,1,'shipped');
INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(1,1,2,'arrived');
INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(1,1,2,'arrived');
INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(1,3,5,'arrived');
INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(1,3,6,'arrived');
INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(2,1,1,'shipped');
INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(3,1,2,'arrived');
INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(3,3,5,'shipped');
INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(3,3,6,'arrived');
INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(3,2,1,'arrived');
INSERT INTO ORDERS_AST("client_id","shop_id","employee_id","order_status")
VALUES(2,1,2,'arrived');

INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(1,1,100,1);
INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(2,1,300,3);
INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(3,3,50,1);
INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(4,3,100,2);
INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(5,1,60,2);
INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(6,3,110,1);
INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(7,3,550,5);
INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(8,1,200,2);
INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(9,1,100,1);
INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(10,3,110,1);
INSERT INTO ORDER_DETAILS_AST("order_id", "product_id", "price", "quantity")
VALUES(11,4,50,1);