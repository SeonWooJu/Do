DROP TABLE "USER_INFO" CASCADE CONSTRAINTS;
DROP TABLE "AC_INFO" CASCADE CONSTRAINTS;
DROP TABLE "USER_AC" CASCADE CONSTRAINTS;
DROP TABLE "AC_TRADE" CASCADE CONSTRAINTS;

CREATE TABLE "USER_INFO" (
	"USER_CODE"	NUMBER(10)		NOT NULL,
	"USER_NAME"	VARCHAR2(50)		NOT NULL,
	"PRODUCTION_DATE"	VARCHAR2(10)		NOT NULL,
	"ID"	VARCHAR2(20)		NOT NULL,
	"PW"	VARCHAR2(50)		NOT NULL
);

CREATE TABLE "AC_INFO" (
	"AC_NUMBER"	NUMBER(6)		NOT NULL,
	"HOLDING_AMOUNT"	NUMBER(10)		NOT NULL,
	"AC_TYPE"	NUMBER(1)		NOT NULL
);

CREATE TABLE "USER_AC" (
	"USER_CODE"	NUMBER(10)		NOT NULL,
	"AC_NUMBER"	NUMBER(6)		NOT NULL
);

CREATE TABLE "AC_TRADE" (
	"TRANSACTION_NUMBER"	NUMBER(38)		NOT NULL,
	"AC_NUMBER_IN"	NUMBER(6)		NOT NULL,
	"AC_NUMBER_OUT"	NUMBER(6)		NOT NULL,
	"TRANSACTION_TIME"	VARCHAR2(50)		NOT NULL,
	"MONEY"	NUMBER(38)		NOT NULL,
	"TRANSACTION_METHOD"	NUMBER(38)		NOT NULL
);

ALTER TABLE "USER_INFO" ADD CONSTRAINT "PK_USER_INFO" PRIMARY KEY (
	"USER_CODE"
);

ALTER TABLE "AC_INFO" ADD CONSTRAINT "PK_AC_INFO" PRIMARY KEY (
	"AC_NUMBER"
);

ALTER TABLE "USER_AC" ADD CONSTRAINT "PK_USER_AC" PRIMARY KEY (
	"USER_CODE",
	"AC_NUMBER"
);

ALTER TABLE "AC_TRADE" ADD CONSTRAINT "PK_AC_TRADE" PRIMARY KEY (
	"TRANSACTION_NUMBER"
);

ALTER TABLE "USER_AC" ADD CONSTRAINT "FK_USER_INFO_TO_USER_AC_1" FOREIGN KEY (
	"USER_CODE"
)
REFERENCES "USER_INFO" (
	"USER_CODE"
);

ALTER TABLE "USER_AC" ADD CONSTRAINT "FK_AC_INFO_TO_USER_AC_1" FOREIGN KEY (
	"AC_NUMBER"
)
REFERENCES "AC_INFO" (
	"AC_NUMBER"
);



INSERT INTO USER_INFO VALUES(20501,'강동현',TO_DATE('2003-01-01','YYYY-MM-DD'),'kang1','kang1');
INSERT INTO USER_INFO VALUES(20502,'강응찬',TO_DATE('2003-01-02','YYYY-MM-DD'),'kang2','kang2');

DELETE FROM AC_TRADE WHERE TRANSACTION_NUMBER = 1;

INSERT INTO AC_INFO VALUES(110001,100000,1);
INSERT INTO AC_INFO VALUES(110002,100000,1);
INSERT INTO AC_INFO VALUES(110003,100000,1);

INSERT INTO USER_AC VALUES(20501,110001);
INSERT INTO USER_AC VALUES(20502,110002);
INSERT INTO USER_AC VALUES(20501,110003);

INSERT INTO AC_TRADE VALUES((select nvl(max(TRANSACTION_NUMBER),0) + 1 from AC_TRADE),110001,110002,TO_CHAR(SYSDATE,'YYYY/MM/DD HH24:MI:SS'),5000,1);

SELECT * FROM USER_INFO;
SELECT * FROM AC_INFO;
SELECT * FROM USER_AC;

SELECT AC_NUMBER, HOLDING_AMOUNT, AC_TYPE FROM AC_INFO;
SELECT * FROM USER_INFO WHERE USER_CODE = 20501;
SELECT AC_NUMBER FROM USER_AC WHERE USER_CODE = 20501;
SELECT AC_NUMBER

UPDATE AC_INFO SET HOLDING_AMOUNT = 10000 WHERE AC_NUMBER = '110-001';
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') SYS_DATE24 FROM DUAL;

--계좌
SELECT * FROM AC_TRADE
WHERE AC_NUMBER_IN = 110001 OR AC_NUMBER_OUT = 110001
ORDER BY TRANSACTION_NUMBER DESC;

--통장 총합 잔액조회
SELECT U.USER_CODE,SUM(A.HOLDING_AMOUNT) AS HOLDING_AMOUNT
FROM USER_AC U, AC_INFO A
WHERE U.AC_NUMBER = A.AC_NUMBER AND U.USER_CODE = 20501
GROUP BY U.USER_CODE

--계좌 상품가입
SELECT MAX(AC_NUMBER) + 1 FROM AC_INFO;
INSERT INTO AC_INFO VALUES(110001,0,1);
INSERT INTO USER_AC VALUES(20501,(SELECT MAX(AC_NUMBER) FROM AC_INFO));

--계좌별 잔액
SELECT a.AC_NUMBER AS AC_NUMBER, A.HOLDING_AMOUNT, DECODE(AC_TYPE,'1','예금','2','적금') AS AC_TYPE
FROM USER_AC U, AC_INFO A
WHERE U.AC_NUMBER = A.AC_NUMBER AND U.USER_CODE = 20501

--아이디 비번으로 개인코드 출력
SELECT * FROM USER_INFO WHERE ID = 'kong3' AND PW = 'kong3';
