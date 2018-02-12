CREATE TABLE CUSTOMERS
    (ID             VARCHAR2(30) NOT NULL
      CONSTRAINT cus_id_pk PRIMARY KEY,
     PASSWORD       VARCHAR2(30) NOT NULL,
     CUST_NAME      VARCHAR2(30) NOT NULL,
     BIRTH_DATE     DATE,
     EMAIL          VARCHAR2(50) NOT NULL,
     HOME_PHONE     VARCHAR2(30),
     MOBILE_PHONE   VARCHAR2(30),
     POST_CODE      VARCHAR2(20),
     ADDRESS        VARCHAR2(100),
     POINT          NUMBER(10) DEFAULT 0
);

comment on column CUSTOMERS.ID is '��ID';
comment on column CUSTOMERS.PASSWORD is '��ȣ';
comment on column CUSTOMERS.CUST_NAME is '����';
comment on column CUSTOMERS.BIRTH_DATE is '�������';
comment on column CUSTOMERS.EMAIL is '�̸���';
comment on column CUSTOMERS.HOME_PHONE is '�� ��ȭ��ȣ';
comment on column CUSTOMERS.MOBILE_PHONE is '�޴��� ��ȣ';
comment on column CUSTOMERS.POST_CODE is '�����ȣ';
comment on column CUSTOMERS.ADDRESS is '�ּ�';
comment on column CUSTOMERS.POINT is '����Ʈ';


CREATE TABLE PROVIDERS
    (PRO_NO         VARCHAR2(30) NOT NULL
       CONSTRAINT pro_pro_no_pk PRIMARY KEY,
     PRO_NAME       VARCHAR2(30) NOT NULL,
     PRO_CEO        VARCHAR2(30),
     PRO_PHONE      VARCHAR2(30),
     PRO_FAX        VARCHAR2(30),
     PRO_POST       VARCHAR2(20),
     PRO_ADDRESS    VARCHAR2(100),
     PRO_EMAIL      VARCHAR2(50) 
);

comment on column PROVIDERS.PRO_NO IS '����ڵ�Ϲ�ȣ';
comment on column PROVIDERS.PRO_NAME IS '����ڸ�';
comment on column PROVIDERS.PRO_CEO IS '��ǥ�̻� �̸�';
comment on column PROVIDERS.PRO_PHONE IS '��ǥ ��ȭ��ȣ';
comment on column PROVIDERS.PRO_FAX IS '��ǥ �ѽ���ȣ';
comment on column PROVIDERS.PRO_POST IS '�����ȣ';
comment on column PROVIDERS.PRO_ADDRESS IS '�ּ�';
comment on column PROVIDERS.PRO_EMAIL IS '�̸���';




CREATE TABLE PRODUCTS
    (PROD_CODE          VARCHAR2(20)
      CONSTRAINT prod_prod_code_pk PRIMARY KEY,
     PROD_NAME          VARCHAR2(100) NOT NULL,
     PROD_SIZE          VARCHAR2(50),
     PROD_PIC           VARCHAR2(100),
     PROD_DETAIL        VARCHAR2(4000),
     PROD_COST          NUMBER(10),
     PROD_STOCK         NUMBER(5),
     PROD_STOCK_MIN     NUMBER(5),
     PRO_NO             VARCHAR(30) NOT NULL
      CONSTRAINT prod_pro_no_fk REFERENCES PROVIDERS (PRO_NO)
);

comment on column PRODUCTS.PROD_CODE IS '��ǰ �ڵ�';
comment on column PRODUCTS.PROD_NAME IS '��ǰ��';
comment on column PRODUCTS.PROD_SIZE IS '������';
comment on column PRODUCTS.PROD_PIC IS '����';
comment on column PRODUCTS.PROD_DETAIL IS '�󼼼���';
comment on column PRODUCTS.PROD_COST IS '�ܰ�';
comment on column PRODUCTS.PROD_STOCK IS '���' ;
comment on column PRODUCTS.PROD_STOCK_MIN IS '�ּ��������';
comment on column PRODUCTS.PRO_NO IS '����ڵ�Ϲ�ȣ';



INSERT INTO CUSTOMERS
VALUES ('CSKIM', 'CSKIM1234', '��ö��', TO_DATE('1990, 04, 27', 'YY/MM/DD'), 'CSKIM', '02-111-1111', '010-1111-1111', '111-111', '���� ������', 0);

INSERT INTO CUSTOMERS
VALUES ('YHLEE', 'YHLEE1234', '�̿���', TO_DATE('1983, 12, 16', 'YY/MM/DD'), 'YHLEE', '031-222-2222', '010-2222-2222', '222-222', '�λ� ����', 0);

INSERT INTO CUSTOMERS
VALUES ('JKCHOI', 'JKCHOI1234', '������', TO_DATE('1987, 05, 21', 'YY/MM/DD'), 'JKCHOI', '064-333-3333', '010-3333-3333', '333-333', '���� ������', 0);


INSERT INTO PROVIDERS
VALUES ('111-11-11111', '�����ٳ�', '��ö��', '02-123-4567', '02-123-7568', '135-111', '����� ������', 'GIO');

INSERT INTO PROVIDERS
VALUES ('222-22-22222', '������', '�ֹ�ȣ', '02-234-5678', '02-234-5679', '134-222', '����� ������', 'TONG');

INSERT INTO PROVIDERS
VALUES ('333-33-33333', '��', '������', '02-345-6789', '02-345-6788', '142-333', '����� ���ϱ�', 'GAP');

INSERT INTO PRODUCTS
VALUES ('G001', '�����', 'XL', 'G001.PNG', '�����ٳ� �����', 30000, 50, 5, '111-11-11111');
INSERT INTO PRODUCTS
VALUES ('G002', '����������Ƽ����', 'L', 'G002.PNG', '�����ٳ� ��Ʈ������ Ƽ����', 50000, 30, 5, '111-11-11111');
INSERT INTO PRODUCTS
VALUES ('B001', '����Ƽ����', 'S', 'B001.PNG', '������ ����Ƽ����', 20000, 50, 5, '222-22-22222');

SELECT * FROM CUSTOMERS;
SELECT * FROM PROVIDERS;
SELECT * FROM PRODUCTS;