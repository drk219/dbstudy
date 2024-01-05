/*
    서브쿼리(SUB QUERY)
    
    1. 메인 쿼리에 포함되는 하위 쿼리를 서브 쿼리하고 한다.
    2. 실행순서
        서브 쿼리 -> 메인 쿼리
    3. 종류
        1) SELECT 절 : 스칼라 서브 쿼리
        2)   FROM 절 : 인라인 뷰 (INLINE VIEW)
        3)  WHERE 절 : 서브 쿼리
              (1) 단일 행 서브 쿼리 - 결과 행이 1행
              (2) 다중 행 서브 쿼리 - 결과 행이 N행
*/

-- WHERE 절-------------------------------------------------------------------------------------
/*
    단일행 서브 쿼리
    1. 서브쿼리에 실행결과가 1행이다.
    2. 단일행 서브 쿼리인 경우
        1) 함수결과를 반환하는 서브쿼리
        2) PK 또는 UNIQUE 칼럼의 동등비교 조건을 사용한 서브 쿼리
    3. 단일행 서브쿼리 연산자
        =, !=, >, >=, <, <=
*/

-- 1. 사원번호가 1004인 사원의 직책을 가진 사원 조회하기 ('사원번호가 1004인 사원의 직책'가 서브쿼리)
/*
SELECT *
FROM employee_t
WHERE POSITION = '과장';
*/

SELECT *
FROM employee_t
WHERE POSITION = (SELECT POSITION 
                    FROM EMPLOYEE_T 
                   WHERE EMP_NO = 1004);
-- (SELECT POSITION FROM EMPLOYEE_T WHERE EMP_NO = 1004) 가 서브 쿼리

-- 2. 급여평균보다 더 큰 급여를 받는 사원 조회하기
SELECT *
FROM employee_t
WHERE SALARY > (SELECT AVG(SALARY) 
                  FROM employee_t);  -- 급여평균보다 더 큰 급여
                  

/*
    다중행 서브 쿼리
    1. 서브 쿼리 실행결과가 N행이다.
    2. 다중 행 서브 쿼리 연산자
        IN, ANY(=또는), ALL 등
*/
-- 1. 부서가 '영업부'인 사원을 조회하시오.
SELECT *
FROM EMPLOYEE_T
WHERE depart = (SELECT DEPT_NO FROM DEPARTMENT_T WHERE DEPT_NAME = '영업부');
--(SELECT DEPT_NO FROM DEPARTMENT_T WHERE DEPT_NAME = '영업부') 단일행처럼 보이는 다중행 서브 쿼리

SELECT *
FROM EMPLOYEE_T
WHERE depart IN(SELECT DEPT_NO FROM DEPARTMENT_T WHERE DEPT_NAME = '영업부');
            -- IN 사용

-- 2. 근무지역이 '서울'인 사원을 조회하시오.
SELECT *
FROM employee_t
WHERE depart IN(SELECT DEPT_NO FROM DEPARTMENT_T WHERE LOCATION = '서울');

-- FROM 절---------------------------------------------------------------------------------------
/*
    인라인 뷰 --가장 먼저 실행된다.
    1. FROM절에 포함되는 서브 쿼리이다.
    2. 서브 쿼리의 실행 결과를 임시 테이블의 형식으로 FROM절에 두고 사용한다.
    3. SELECT문의 실행 순서를 조정할 때 사용할 수 있다.
*/

-- HR 접속

-- 1. 2번째로 입사한 사원을 조회하시오.
--1) HIRE_DATE 오름차순 정렬 (입사순 정렬) - 별명 A
--2) 오름차순 결과에 행 번호(ROWNUM)를 붙임 - 별명 B
--3) 행 번호가 2인 데이터 조회
SELECT B.*                                 
FROM (SELECT ROWNUM AS RN, A.*             --2
       FROM (SELECT *                      
               FROM employees              
           ORDER BY HIRE_DATE ASC) A) B    --1
WHERE B.RN = 2;                            --3
    
/*
SELECT ROWNUM, *
        FROM employees
    ORDER BY HIRE_DATE ASC; 
*/  -- 실행 순서가 안맞음

-- 2. 연봉 탑 10을 조회하시오.
--1) 연봉 내림차순 정렬한 A  2)A에 행번호 붙인 B  3)1-10행까지 데이터 조회
SELECT B.*
FROM(SELECT ROWNUM AS RN, A.*
     FROM (SELECT *
           FROM employees
           ORDER BY SALARY DESC) A) B
WHERE B.RN BETWEEN 1 AND 10;

-- 3. 2번째로 입사한 사원을 조회하시오. (1번 보다 간단해진 방법)
-- 1) HIRE_DATE 오름차순 정렬하고 행 번호(R0W_NUMBER 함수)를 붙인다. - 별명 A
-- 2) 행 번호가 2인 데이터 조회
SELECT A.*
FROM (SELECT ROW_NUMBER() OVER (ORDER BY HIRE_DATE ASC) AS RN, EMPLOYEE_ID, HIRE_DATE
        FROM employees) A
WHERE A.RN = 2;


-- 4. 연봉 탑 10을 조회하시오. (2번에서 사용한 방법보다 간단)
-- 1) 연봉 내림차순 정렬한 A / 2)A에 행번호 붙인 B / 3)1-10행까지 데이터 조회
SELECT A.*
FROM (SELECT ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS RN, EMPLOYEE_ID, LAST_NAME, SALARY
        FROM EMPLOYEES) A
WHERE A.RN BETWEEN 1 AND 10;

--SELECT 절---------------------------------------------------------------------------------------
/*
    스칼라 서브 쿼리
    1. SELECT절에 포함된 서브쿼리이다.
    2. 메인 쿼리를 서브 쿼리에서 사용할 수 있다.
        1) 비상관 쿼리 : 서브 쿼리가 메인 쿼리를 사용하지 않는다.
        2) 상관 쿼리   : 서브 쿼리가 메인 쿼리를 사용한다.
*/ 

-- 1. 부서번호가 50인 부서에 근무하는 사원의 사원번호, 사원명, 부서명 조회하시오. (비상관 쿼리)
SELECT EMPLOYEE_ID 
     , LAST_NAME
     , (SELECT DEPARTMENT_NAME 
          FROM departments 
         WHERE DEPARTMENT_ID = 50) -- 단일행 서브 쿼리
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

-- 2. 부서번호가 50인 부서에 근무하는 사원의 사원번호, 사원명, 부서명 조회하시오. (상관 쿼리)
SELECT E.EMPLOYEE_ID
, E.LAST_NAME
, (SELECT D.DEPARTMENT_NAME 
   FROM DEPARTMENTS D
   WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
   AND D.DEPARTMENT_ID = 50)
FROM EMPLOYEES E;

-- 3. 부서번호, 부서명, 근무중인 사원수를 조회하시오.
SELECT D.DEPARTMENT_ID AS 부서번호
, D.DEPARTMENT_NAME AS 부서명
, (SELECT COUNT(*)
   FROM EMPLOYEES E
   WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS 사원수
FROM DEPARTMENTS D;

/*
    CREATE 문과 서브 쿼리
    1. 서브 쿼리 결과를 새로운 테이블로 만들 수 있다.
    2. 테이블을 복사하는 용도로 사용할 수 있다.
    3. 형식
        CREATE TABLE 테이블명 (칼럼1, 칼럼2, ...)
        AS (SELECT 칼럼1, 칼럼2, ...)
*/

-- GD계정
-- 1. 사원번호, 사원명, 급여, 부서번호를 조회하고 결과를 새 테이블로 생성하시오.
CREATE TABLE EMPLOYEE_T2 (EMP_NO, NAME, SALARY, DEPART)
AS (SELECT EMP_NO, NAME, SALARY, DEPART
FROM EMPLOYEE_T);

-- 2. 부서테이블의 구조만 복사하여 새 테이블을 생성하시오.
CREATE TABLE DEPARTMENT_T2 (DEPT_NO, DEPT_NAME, LOCATION)
AS (SELECT DEPT_NO, DEPT_NAME, LOCATION
    FROM DEPARTMENT_T
    WHERE 1 = 2);   --언제나 FALSE인 조건을 넣어서 빈 테이블로 작성

/*
    INSERT 문과 서브 쿼리
    1. 서브 쿼리 결과를 INSERT 할 수 있다.
    2. 한 번에 여러행을 INSERT 할 수도 있다.
    3. 형식
        INSERT INTO 테이블명 (칼럼1, 칼럼2, ...)
        (SELECT 칼럼1, 칼럼2, ...)
*/

-- 1. 지역이 '대구'인 부서 정보를 DEPARTMENT_T2 테이블에 삽입하시오.
INSERT INTO department_t2(DEPT_NO, dept_name, location)
(SELECT DEPT_NO, dept_name, location
FROM department_t
WHERE LOCATION = '대구');
COMMIT;

-- 2. 직급이 '과장'인 사원 정보를 '과장명단' 테이블로 생성하시오.
CREATE TABLE 과장명단 (EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY)
AS (SELECT EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY
      FROM employee_t
     WHERE 1 = 2);

INSERT INTO 과장명단 (EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY) 
(SELECT EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY
   FROM employee_t
  WHERE POSITION = '과장');
COMMIT;




