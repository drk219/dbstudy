-- 1. 대소문자 변환하기----------------------------------------------------------------
SELECT UPPER('apple')  --APPLE
, LOWER('APPLE')       --apple
, INITCAP('APPLE')     --Apple
FROM DUAL;

-- 2. 글자수/바이트수 변환하기---------------------------------------------------------
select name
, LENGTH(NAME) AS 글자수
, LENGTHB(NAME) AS 바이트수
from employee_t;

-- 3. 문자 연결하기--------------------------------------------------------------------
-- 1) || : 연결 연산자 (오라클에서만 사용 가능)
-- 2) CONCAT(A, B) : 연결함수 (2개 까지만 가능)  <=권장
SELECT 'A' || 'B' || 'C'
, CONCAT(CONCAT('A', 'B'), 'C')
FROM DUAL;

SELECT *
FROM employee_t
WHERE NAME LIKE '한' || '%';     -- <=권장


-- 4. 특정 문자의 위치 반환
-- 1) 문자의 위치는 1부터 시작한다.
-- 2) 못 찾으면 0을 반환한다.
SELECT NAME
, INSTR(NAME, '이')
FROM EMPLOYEE_T;

-- 5. 일부 문자열 반환------------------------------------------------------------------
SELECT NAME
, SUBSTR(NAME, 1, 1) AS 성 --1번째 글자부터 한 글자를 반환
, SUBSTR(NAME, 2) AS 이름 --2번째 글자부터 끝까지 반환
FROM EMPLOYEE_T;

-- 구*민, 김*서, 이*영, 한*일 이름 조회하기
SELECT SUBSTR(NAME, 1, 1) || '*' || SUBSTR(NAME, 3) AS 이름
FROM EMPLOYEE_T;

SELECT SUBSTR(NAME, 1, 1) || '*' || SUBSTR(NAME, LENGTH(NAME)) AS 이름
FROM EMPLOYEE_T;

-- 6. 찾아 바꾸기-----------------------------------------------------------------------
SELECT REPLACE(DEPT_NAME, '부', '팀') AS 부서 --'부'를 '팀'으로 바꾸기
FROM DEPARTMENT_T;

SELECT REPLACE(DEPT_NAME, '부', '') AS 부서  --'부'를 ''으로 바꾸기 ('부'를 지우기)
FROM DEPARTMENT_T;

-- 7. 채우기 ----------------------------------------------------------------------------
 --LPAD(EXPR1, N, [EXPR2]) : 왼쪽 채우기, 왼쪽에 EXPR2를 채운다. (생략하면 공백 채움)
 --RPAD(EXPR1, N, [EXPR2]) : 오른쪽 채우기, 오른쪽에 EXPR2를 채운다. (생략하면 공백 채움)
--EXPR1에 숫자는 불가능
SELECT LPAD(NAME, 10, '*')  --10자리(한글은 5자리)의 NAME 반환, 왼쪽에 '*' 채움 
     , RPAD(NAME, 10, '*')  --10자리(한글은 5자리)의 NAME 반환, 오른쪽에 '*' 채움
FROM employee_t;

-- 8. 공백 제거-------------------------------------------------------------------------
 --LTRIM(EXPR) : 왼쪽 공백 제거 
 --RTRIM(EXPR) : 오른 공백 공백 제거
 --TRIM(EXPR)  : 양쪽 제거
 SELECT LTRIM('   HELLO   WORLD   ')
      , RTRIM('   HELLO   WORLD   ')
      ,  TRIM('   HELLO   WORLD   ')
FROM DUAL;





