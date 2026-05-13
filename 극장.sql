-- ============================================
-- 테이블 삭제 (순서 중요)
-- ============================================
DROP TABLE 예약;
DROP TABLE 상영관;
DROP TABLE 고객;
DROP TABLE 극장;
-- ============================================
-- 테이블 생성
-- ============================================
-- 극장 테이블
CREATE TABLE 극장 (
극장번호 NUMBER PRIMARY KEY,
극장이름 VARCHAR2(100) NOT NULL,
위치 VARCHAR2(100)
);
-- 상영관 테이블 (복합 PK)
CREATE TABLE 상영관 (
극장번호 NUMBER,
상영관번호 NUMBER,
영화제목 VARCHAR2(200) NOT NULL,
가격 NUMBER,
좌석수 NUMBER,
CONSTRAINT pk_상영관 PRIMARY KEY (극장번호, 상영관번호),
CONSTRAINT fk_상영관_극장 FOREIGN KEY (극장번호) REFERENCES 극장(극장번호)
);
-- 고객 테이블
CREATE TABLE 고객 (
고객번호 NUMBER PRIMARY KEY,
이름 VARCHAR2(100) NOT NULL,
주소 VARCHAR2(200)
);
-- 예약 테이블 (복합 PK)
CREATE TABLE 예약 (
극장번호 NUMBER,
상영관번호 NUMBER,
고객번호 NUMBER,
좌석번호 NUMBER,
날짜 DATE,
CONSTRAINT pk_예약 PRIMARY KEY (극장번호, 상영관번호, 고객번호),
CONSTRAINT fk_예약_상영관 FOREIGN KEY (극장번호, 상영관번호)
REFERENCES 상영관(극장번호, 상영관번호),
CONSTRAINT fk_예약_고객 FOREIGN KEY (고객번호) REFERENCES 고객(고객번호)
);
-- ============================================
-- 예시 데이터 삽입
-- ============================================
-- 극장 데이터 (5개 극장)
INSERT INTO 극장 VALUES (1, '강남극장', '강남');
INSERT INTO 극장 VALUES (2, '강동극장', '강동');
INSERT INTO 극장 VALUES (3, '홍대극장', '마포');
INSERT INTO 극장 VALUES (4, '신촌극장', '서대문');
INSERT INTO 극장 VALUES (5, '잠실극장', '송파');
-- 상영관 데이터 (극장별 2~3개 상영관)
INSERT INTO 상영관 VALUES (1, 1, '아바타', 12000, 150);
INSERT INTO 상영관 VALUES (1, 2, '범죄도시4', 11000, 120);
INSERT INTO 상영관 VALUES (1, 3, '파묘', 9000, 80);
INSERT INTO 상영관 VALUES (2, 1, '듄2', 13000, 200);
INSERT INTO 상영관 VALUES (2, 2, '건국전쟁', 8000, 60);
INSERT INTO 상영관 VALUES (3, 1, '오펜하이머', 12000, 180);
INSERT INTO 상영관 VALUES (3, 2, '서울의봄', 10000, 100);
INSERT INTO 상영관 VALUES (3, 3, '밀수', 9000, 90);
INSERT INTO 상영관 VALUES (4, 1, '콘크리트유토피아', 11000, 130);
INSERT INTO 상영관 VALUES (4, 2, '외계+인', 7000, 70);
INSERT INTO 상영관 VALUES (5, 1, '탑건매버릭', 13000, 250);
INSERT INTO 상영관 VALUES (5, 2, '앤트맨', 10000, 110);
-- 고객 데이터 (8명)
INSERT INTO 고객 VALUES (1, '김철수', '서울시 강남구 역삼동');
INSERT INTO 고객 VALUES (2, '이영희', '서울시 강동구 천호동');
INSERT INTO 고객 VALUES (3, '박민준', '서울시 마포구 홍대동');
INSERT INTO 고객 VALUES (4, '최수연', '서울시 서대문구 신촌동');
INSERT INTO 고객 VALUES (5, '정하늘', '서울시 송파구 잠실동');
INSERT INTO 고객 VALUES (6, '한지민', '서울시 강북구 수유동');
INSERT INTO 고객 VALUES (7, '강감찬', '서울시 용산구 이태원동');
INSERT INTO 고객 VALUES (8, '장내윤', '서울시 성동구 왕십리동');
-- 예약 데이터 (다양한 날짜와 좌석)
INSERT INTO 예약 VALUES (1, 1, 1, 15, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (1, 1, 2, 23, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (1, 2, 3, 7, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (1, 3, 4, 11, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (2, 1, 1, 50, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (2, 1, 5, 88, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (2, 2, 6, 3, TO_DATE('2024-10-12', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (3, 1, 2, 77, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (3, 2, 7, 45, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (3, 3, 8, 62, TO_DATE('2024-10-18', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (4, 1, 3, 19, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (4, 2, 4, 33, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 1, 5, 100, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 1, 6, 120, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 2, 7, 55, TO_DATE('2024-10-25', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 2, 8, 67, TO_DATE('2024-10-25', 'YYYY-MM-DD'));
COMMIT;

--[단순질의]
--1. 극장테이블에서 극장이름, 위치를 추출하시오
--(풀이)
select 극장이름, 위치 from 극장;
--2. 극장 테이블에서 위치가 '서울'인 극장의 극장이름을 조회하시오.
--(풀이)
select 극장이름 from 극장 where 위치 like '서울';
--3. 상영관 테이블에서 가격이 10000원 이상인 상영관의 극장번호, 상영관번호, 영화제목을 조
--회하시오.
--(풀이)
select 극장번호, 상영관번호, 영화제목 from 상영관 where 가격 >= 10000;
--4. 상영관 테이블에서 영화제목별 상영관 수를 조회하시오.
--(풀이)
select 영화제목, count(*) as "상영관 수" from 상영관 group by 영화제목;
--5. 예약 테이블에서 날짜가 '2024-01-01'인 모든 예약 정보를 조회하시오.
--(풀이)
select * from 예약 where 날짜 like '2024-01-01';
--6. 고객 테이블에서 주소별 고객 수를 조회하시오.
--(풀이)
select 주소, count(*) as "고객 수" from 고객 group by 주소;
--7. 상영관 테이블에서 좌석수가 가장 많은 상영관의 극장번호와 상영관번호를 조회하시오.
--(풀이)
select 극장번호, 상영관번호 from 상영관 where 좌석수 = (select max(좌석수) from 상영관);
--8. 예약 테이블에서 고객번호별 예약 횟수를 조회하시오.
--(풀이)
select 고객번호, count(*) as "예약 횟수" from 예약 group by 고객번호;
--9. 상영관 테이블에서 극장번호별 평균 가격을 조회하시오.
--(풀이)
select 극장번호, avg(가격) as "평균 가격" from 상영관 group by 극장번호;
--10. 고객 테이블에서 이름이 '김'으로 시작하는 고객의 이름과 주소를 조회하시오.
--(풀이)
select 이름, 주소 from 고객 where 이름 like '김%';

--[조인질의]
--11. 극장과 상영관 테이블을 조인하여 극장이름과 해당 극장의 영화제목을 조회하시오.
--(풀이)
select 극장.극장이름, 상영관.영화제목 from 극장, 상영관 where 극장.극장번호 = 상영관.극장번호;
--12. 극장, 상영관, 예약 테이블을 조인하여 극장이름, 영화제목, 예약 날짜를 조회하시오.
--(풀이)
select ㄱ.극장이름, ㅅ.영화제목, ㅇ.날짜 from 극장 ㄱ, 상영관 ㅅ, 예약 ㅇ where ㄱ.극장번호 = ㅅ.극장번호 and ㅅ.극장번호 = ㅇ.극장번호 and ㅅ.상영관번호 = ㅇ.상영관번호;
--13. 고객과 예약 테이블을 조인하여 고객 이름과 해당 고객의 예약 날짜를 조회하시오.
--(풀이)
select ㄲ.이름, ㅇ.날짜 from 고객 ㄲ, 예약 ㅇ where ㄲ.고객번호 = ㅇ.고객번호;
--14. 극장, 상영관, 예약, 고객 테이블을 모두 조인하여 극장이름, 영화제목, 고객이름, 좌석번
--호를 조회하시오.
--(풀이)
select ㄱ.극장이름, ㅅ.영화제목, ㄲ.이름, ㅇ.좌석번호 from 극장 ㄱ, 상영관 ㅅ, 고객 ㄲ, 예약 ㅇ where ㄱ.극장번호 = ㅅ.극장번호
                                                                                        and ㅅ.극장번호 = ㅇ.극장번호 and ㅅ.상영관번호 = ㅇ.상영관번호
                                                                                        and ㅇ.고객번호 = ㄲ.고객번호;
--15. 상영관과 예약 테이블을 조인하여 영화제목별 총 예약 수를 조회하시오.
--(풀이)
select ㅅ.영화제목, count(*) as "총 예약 수" from 상영관 ㅅ, 예약 ㅇ where ㅅ.극장번호 = ㅇ.극장번호 and ㅅ.상영관번호 = ㅇ.상영관번호 group by ㅅ.영화제목;
--16. 극장과 상영관 테이블을 조인하여 위치가 '서울'인 극장에서 상영 중인 영화제목과 가격
--을 조회하시오.
--(풀이)
select ㅅ.영화제목, ㅅ.가격 from 극장 ㄱ, 상영관 ㅅ where ㄱ.극장번호 = ㅅ.극장번호 and ㄱ.위치 like '서울';
--17. 고객과 예약 테이블을 LEFT JOIN하여 예약이 한 건도 없는 고객의 이름을 조회하시오.
--(풀이)
select ㄲ.이름 from 고객 ㄲ left join 예약 ㅇ on ㄲ.고객번호 = ㅇ.고객번호 where ㅇ.고객번호 is null;
select ㄲ.이름 from 고객 ㄲ where ㄲ.고객번호 not in(select ㅇ.고객번호 from 예약 ㅇ where ㅇ.고객번호 is not null);
select ㄲ.이름 from 고객 ㄲ where not exists(select 1 from 예약 ㅇ where ㅇ.고객번호 = ㄲ.고객번호);
--18. 극장, 상영관, 예약 테이블을 조인하여 극장별 총 예약 수를 조회하시오.
--(풀이)
select ㄱ.극장이름, count(*) as "총 예약 수" from 극장 ㄱ join 상영관 ㅅ on ㄱ.극장번호 = ㅅ.극장번호 
                                                      join 예약 ㅇ on ㅅ.극장번호 = ㅇ.극장번호 and ㅅ.상영관번호 = ㅇ.상영관번호 
                                                      group by ㄱ.극장이름;
--19. 상영관과 예약 테이블을 조인하여 가격이 15000원 이상인 상영관을 예약한 고객번호와
--영화제목을 조회하시오.
--(풀이)
select ㅇ.고객번호, ㅅ.영화제목 from 예약 ㅇ join 상영관 ㅅ on ㅇ.극장번호 = ㅅ.극장번호 and ㅇ.상영관번호 = ㅅ.상영관번호 where ㅅ.가격 >= 15000;
--20. 극장, 상영관, 예약, 고객 테이블을 조인하여 고객별 총 예약 횟수와 이름을 조회하시오.
--(풀이)
select ㄲ.이름, count(*) as "총 예약 횟수" from 극장 ㄱ join 상영관 ㅅ on ㄱ.극장번호 = ㅅ.극장번호
                                                        join 예약 ㅇ on ㅅ.극장번호 = ㅇ.극장번호 and ㅅ.상영관번호 = ㅇ.상영관번호
                                                        join 고객 ㄲ on ㅇ.고객번호 = ㄲ.고객번호
                                                        group by ㄲ.이름; --고객이랑 예약만 조인해도 됨 그룹은 보통 고객번호도 같이 해줘야함(동명이인)

--[부속질의]
--21. 예약 테이블에서 가장 많은 예약이 발생한 극장번호를 조회하시오.
--(풀이)
select 극장번호, count(*) as "예약 수" from 예약 group by 극장번호 having count(*) = (select max(count(*)) from 예약 group by 극장번호);
--22. 고객 테이블에서 예약 테이블에 예약 기록이 있는 고객의 이름과 주소를 조회하시오. (IN
--사용)
--(풀이)
select 이름, 주소 from 고객 where 고객번호 in(select 고객번호 from 예약);
--23. 극장 테이블에서 상영관이 3개 이상 등록된 극장의 극장이름을 조회하시오.
--(풀이)
select 극장이름 from 극장 where 극장번호 in(select 극장번호 from 상영관 group by 극장번호 having count(*) >= 3);
--24. 상영관 테이블에서 전체 상영관 평균 가격보다 비싼 상영관의 영화제목과 가격을 조회하
--시오.
--(풀이)
select 영화제목, 가격 from 상영관 where 가격 > (select avg(가격) from 상영관);
--25. 고객 테이블에서 예약 테이블에 예약 기록이 전혀 없는 고객의 이름을 조회하시오.
--(NOT IN 사용)
--(풀이)
select 이름 from 고객 where 고객번호 not in(select 고객번호 from 예약);
--26. 극장 테이블에서 예약 테이블에 예약된 적이 없는 극장의 극장이름을 조회하시오.
--(풀이)
select ㄱ.극장이름 from 극장 ㄱ where not exists(select 1 from 예약 ㅇ where ㅇ.극장번호 = ㄱ.극장번호);
--27. 예약 테이블에서 예약 횟수가 전체 고객 평균 예약 횟수보다 많은 고객번호를 조회하시
--오.
--(풀이)
select 고객번호 from 예약 group by 고객번호 having count(*) > (select avg(count(*)) from 예약 group by 고객번호);
--28. 상영관 테이블에서 좌석수가 가장 적은 상영관이 속한 극장의 극장이름을 조회하시오.
--(풀이)
select 극장이름 from 극장 where 극장번호 = (select 극장번호 from 상영관 where 좌석수 = (select min(좌석수) from 상영관));
--29. 예약 테이블에서 '2024-01-01'에 예약이 발생한 상영관의 영화제목을 조회하시오.
--(풀이)
select ㅅ.영화제목 from 상영관 ㅅ join 예약 ㅇ on ㅅ.극장번호 = ㅇ.극장번호 and ㅅ.상영관번호 = ㅇ.상영관번호 where ㅇ.날짜 = (select 날짜 from 예약 where 날짜 like '2024-01-01');
--30. 고객 테이블에서 두 번 이상 예약한 고객의 이름을 조회하시오.
--(풀이)
select 이름 from 고객 where 고객번호 in(select 고객번호 from 예약 group by 고객번호 having count(*) >= 2);

--[상관부속질의]
--31. 고객 테이블에서 예약 테이블에 본인 고객번호로 예약 기록이 존재하는 고객의 이름을
--조회하시오. (EXISTS 사용)
--(풀이)
select ㄲ.이름 from 고객 ㄲ where exists(select 1 from 예약 ㅇ where ㅇ.고객번호 = ㄲ.고객번호);
--32. 상영관 테이블에서 같은 극장 내 상영관들의 평균 가격보다 비싼 상영관의 영화제목과 가
--격을 조회하시오.
--(풀이)
select ㅅ1.영화제목, ㅅ1.가격 from 상영관 ㅅ1 where ㅅ1.가격 > (select avg(ㅅ2.가격) from 상영관 ㅅ2 group by ㅅ2.극장번호 having ㅅ2.극장번호 = ㅅ1.극장번호);
--33. 극장 테이블에서 해당 극장에 예약된 건수가 5건 이상인 극장의 극장이름을 조회하시오.
--(풀이)
select ㄱ.극장이름 from 극장 ㄱ where ㄱ.극장번호 in(select ㅇ.극장번호 from 예약 ㅇ where ㄱ.극장번호 = ㅇ.극장번호 group by ㅇ.극장번호 having count(*) >= 5);
--34.고객 테이블에서 예약 테이블에 본인 고객번호로 예약한 좌석번호가 'A1'인 기록이 존재하
--는 고객의 이름을 조회하시오.
--(풀이)
 select ㄲ.이름 from 고객 ㄲ where ㄲ.고객번호 in(select ㅇ.고객번호 from 예약 ㅇ where ㅇ.고객번호 = ㄲ.고객번호 and ㅇ.좌석번호 like 'A1');
--35. 상영관 테이블에서 해당 상영관에 예약된 기록이 하나도 없는 상영관의 영화제목을 조회
--하시오. (NOT EXISTS 사용)
--(풀이)
select ㅅ.영화제목 from 상영관 ㅅ where not exists(select 1 from 예약 ㅇ where ㅅ.극장번호 = ㅇ.극장번호 and ㅅ.상영관번호 = ㅇ. 상영관번호);
--36. 예약 테이블에서 같은 고객이 동일 날짜에 두 건 이상 예약한 고객번호와 날짜를 조회하
--시오.
--(풀이)
select ㅇ.고객번호, ㅇ.날짜 from 예약 ㅇ where ㅇ.고객번호 in(select ㅇㅇ.고객번호 from 예약 ㅇㅇ 
                                                            where ㅇ.고객번호 = ㅇㅇ.고객번호 and ㅇ.날짜 = ㅇㅇ.날짜 
                                                            group by ㅇㅇ.고객번호 
                                                            having count(*) >= 2);
--37. 극장 테이블에서 소속된 모든 상영관의 가격이 10000원 이상인 극장의 극장이름을 조회
--하시오. (NOT EXISTS 활용)
--(풀이)
select ㄱ.극장이름 from 극장 ㄱ where not exists(select 1 from 상영관 ㅅ where ㅅ.극장번호 = ㄱ.극장번호 and 가격 < 10000);
--38. 고객 테이블에서 예약 테이블에 서로 다른 극장에 2곳 이상 예약한 고객의 이름을 조회
--하시오
--(풀이)
select ㄲ.이름 from 고객 ㄲ where (select count(distinct ㅇ.극장번호) from 예약 ㅇ where ㅇ.고객번호 = ㄲ.고객번호) >= 2;
--39. 상영관 테이블에서 같은 극장 내에서 좌석수가 가장 많은 상영관의 영화제목을 조회하시
--오.
--(풀이)
select ㅅ.영화제목 from 상영관 ㅅ where ㅅ.좌석수 in(select max(ㅆ.좌석수) from 상영관 ㅆ where ㅆ.극장번호 = ㅅ.극장번호);
--40. 고객 테이블에서 가장 최근 날짜에 예약한 고객의 이름을 조회하시오.
--(풀이)
select ㄲ.이름 from 고객 ㄲ join 예약 ㅇ on ㄲ.고객번호 = ㅇ.고객번호 where not exists(select 1 from 예약 ㅇㅇ where ㅇㅇ.날짜 > ㅇ.날짜);















