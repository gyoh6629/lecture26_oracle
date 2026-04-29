--DROP TABLE Orders CASCADE CONSTRAINT;
--DROP TABLE Book CASCADE CONSTRAINT;
--DROP TABLE Customer CASCADE CONSTRAINT;
--DROP TABLE Imported_Book CASCADE CONSTRAINT;

CREATE TABLE Book (
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR2(40),
publisher VARCHAR2(40),
price NUMBER(8)
);

CREATE TABLE Customer (
custid NUMBER(2) PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(50),
phone VARCHAR2(20)
);

CREATE TABLE Orders (
orderid NUMBER(2) PRIMARY KEY,
custid NUMBER(2) REFERENCES Customer(custid),
bookid NUMBER(2) REFERENCES Book(bookid),
saleprice NUMBER(8),
orderdate DATE
);

/* Book, Customer, Orders 데이터 생성 */
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구 아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '배구 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스터', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');
INSERT INTO Customer VALUES (3, '김연경', '대한민국 경기도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전', NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, TO_DATE('2025-07-01','yyyy-mm-dd'));
INSERT INTO Orders VALUES (2, 1, 3, 21000, TO_DATE('2025-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, TO_DATE('2025-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (4, 3, 6, 6000, TO_DATE('2025-07-04','yyyy-mm-dd'));
INSERT INTO Orders VALUES (5, 4, 7, 20000, TO_DATE('2025-07-05','yyyy-mm-dd'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, TO_DATE('2025-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, TO_DATE('2025-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, TO_DATE('2025-07-08','yyyy-mm-dd'));
INSERT INTO Orders VALUES (9, 2, 10, 7000, TO_DATE('2025-07-09','yyyy-mm-dd'));
INSERT INTO Orders VALUES (10, 3, 8, 13000, TO_DATE('2025-07-10','yyyy-mm-dd'));

CREATE TABLE Imported_Book (
bookid NUMBER,
bookname VARCHAR(40),
publisher VARCHAR(40),
price NUMBER(8)
);

INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

COMMIT;

/* 01 다음은 마당서점 고객이 알고 싶어 하는 내용이다. 각 문항에 맞는 SQL 문을 작성하시오 */
/* (1) 도서번호가 1인 도서의 이름 */
SELECT bookname FROM Book WHERE bookid = 1;
/* (2) 가격이 20,000원 이상인 도서의 이름 */
SELECT bookname FROM Book WHERE price >= 20000;
/* (3) '박지성'의 총구매액 */
select sum(orders.saleprice) as "총구매액" from customer, orders where customer.custid = orders.custid and customer.name like '박지성';
/* (4) '박지성'이 구매한 도서의 수 */
select count(*) as "구매한 도서의 수" from customer, orders where customer.custid = orders.custid and customer.name like '박지성';

/* 02 다음은 마당서점 운영자와 경영자가 알고 싶어 하는 내용이다. 각 문항에 맞는 SQL 문을 작성하시오. */
/* (1) 마당서점 도서의 총수 */
select count(*) as "도서의 총수" from book;
/* (2) 마당서점에 도서를 출고하는 출판사의 총수 */
select count(distinct publisher) as "출판사의 총수" from book;
/* (3) 모든 고객의 이름, 주소 */
select name, address from customer;
/* (4) 2025년 7월 4일부터 7월 7일 사이에 주문받은 도서의 주문번호 */
select orderid from orders where orderdate >= '20250704' and orderdate <= '20250707';
/* (5) 2025년 7월 4일부터 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호 */
select orderid from orders where orderid not in (select orderid from orders where orderdate >= '20250704' and orderdate <= '20250707');
/* (6) 성이 '김' 씨인 고객의 이름과 주소 */
select name, address from customer where name like '김%';
/* (7) 성이 '김' 씨이고 이름이 '아'로 끝나는 고객의 이름과 주소 */
select name, address from customer where name like '김%아';