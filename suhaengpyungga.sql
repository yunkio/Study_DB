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

comment on column CUSTOMERS.ID is '고객ID';
comment on column CUSTOMERS.PASSWORD is '암호';
comment on column CUSTOMERS.CUST_NAME is '고객명';
comment on column CUSTOMERS.BIRTH_DATE is '생년월일';
comment on column CUSTOMERS.EMAIL is '이메일';
comment on column CUSTOMERS.HOME_PHONE is '집 전화번호';
comment on column CUSTOMERS.MOBILE_PHONE is '휴대폰 번호';
comment on column CUSTOMERS.POST_CODE is '우편번호';
comment on column CUSTOMERS.ADDRESS is '주소';
comment on column CUSTOMERS.POINT is '포인트';


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

comment on column PROVIDERS.PRO_NO IS '사업자등록번호';
comment on column PROVIDERS.PRO_NAME IS '사업자명';
comment on column PROVIDERS.PRO_CEO IS '대표이사 이름';
comment on column PROVIDERS.PRO_PHONE IS '대표 전화번호';
comment on column PROVIDERS.PRO_FAX IS '대표 팩스번호';
comment on column PROVIDERS.PRO_POST IS '우편번호';
comment on column PROVIDERS.PRO_ADDRESS IS '주소';
comment on column PROVIDERS.PRO_EMAIL IS '이메일';




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

comment on column PRODUCTS.PROD_CODE IS '상품 코드';
comment on column PRODUCTS.PROD_NAME IS '상품명';
comment on column PRODUCTS.PROD_SIZE IS '사이즈';
comment on column PRODUCTS.PROD_PIC IS '사진';
comment on column PRODUCTS.PROD_DETAIL IS '상세설명';
comment on column PRODUCTS.PROD_COST IS '단가';
comment on column PRODUCTS.PROD_STOCK IS '재고' ;
comment on column PRODUCTS.PROD_STOCK_MIN IS '최소유지재고';
comment on column PRODUCTS.PRO_NO IS '사업자등록번호';



INSERT INTO CUSTOMERS
VALUES ('CSKIM', 'CSKIM1234', '김철수', TO_DATE('1990, 04, 27', 'YY/MM/DD'), 'CSKIM', '02-111-1111', '010-1111-1111', '111-111', '서울 강남구', 0);

INSERT INTO CUSTOMERS
VALUES ('YHLEE', 'YHLEE1234', '이영희', TO_DATE('1983, 12, 16', 'YY/MM/DD'), 'YHLEE', '031-222-2222', '010-2222-2222', '222-222', '부산 서면', 0);

INSERT INTO CUSTOMERS
VALUES ('JKCHOI', 'JKCHOI1234', '최진국', TO_DATE('1987, 05, 21', 'YY/MM/DD'), 'JKCHOI', '064-333-3333', '010-3333-3333', '333-333', '제주 동광양', 0);


INSERT INTO PROVIDERS
VALUES ('111-11-11111', '지오다노', '이철수', '02-123-4567', '02-123-7568', '135-111', '서울시 강남구', 'GIO');

INSERT INTO PROVIDERS
VALUES ('222-22-22222', '베네통', '최민호', '02-234-5678', '02-234-5679', '134-222', '서울시 강동구', 'TONG');

INSERT INTO PROVIDERS
VALUES ('333-33-33333', '갭', '강병수', '02-345-6789', '02-345-6788', '142-333', '서울시 강북구', 'GAP');

INSERT INTO PRODUCTS
VALUES ('G001', '면바지', 'XL', 'G001.PNG', '지오다노 면바지', 30000, 50, 5, '111-11-11111');
INSERT INTO PRODUCTS
VALUES ('G002', '스프라이프티셔츠', 'L', 'G002.PNG', '지오다노 스트라이프 티셔츠', 50000, 30, 5, '111-11-11111');
INSERT INTO PRODUCTS
VALUES ('B001', '긴팔티셔츠', 'S', 'B001.PNG', '베네통 긴팔티셔츠', 20000, 50, 5, '222-22-22222');

SELECT * FROM CUSTOMERS;
SELECT * FROM PROVIDERS;
SELECT * FROM PRODUCTS;