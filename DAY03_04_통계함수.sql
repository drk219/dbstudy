/*
    통계함수(집계함수)
    1. 합계   : SUM(EXPR)
    2. 평균   : AVG(EXPR)
    3. 최대값 : MAX(EXPR)
    4. 최소값 : MIN(EXPR)
    5. 갯수   : COUNT(EXPR)
*/

--EMPLOYEE_T TABLE

--1. 전체 사원의 기본급 합계
SELECT SUM(SALARY)
FROM employee_t;

--2. 전체 사원의 기본급 평균
SELECT AVG(SALARY)
FROM employee_t;

--3. 전체 사원의 기본급 최대
SELECT MAX(SALARY)
FROM employee_t;

--4. 전체 사원의 기본급 최소
SELECT MIN(SALARY)
FROM employee_t;

--5. 전체 사원 수
SELECT COUNT(EMP_NO)  --사원 번호의 갯수
FROM employee_t;

SELECT COUNT(NAME) --사원 이름의 갯수
FROM employee_t;

SELECT COUNT(*) --모든 칼럼을 참조해서 개수(사원 수 구하는 용도로 추천)
FROM employee_t;



--SAMPLE_T

--국어 점수 합계
SELECT SUM(KOR)  --NULL값은 제외하고 처리한다.
FROM sample_t;

--국어점수 평균  
SELECT AVG(KOR)  --NULL값은 제외하고 처리한다.
FROM sample_t;

--국어점수 최대값
SELECT MAX(KOR)  --NULL값은 제외하고 처리한다.
FROM sample_t;

--국어점수 최소값
SELECT MIN(KOR)  --NULL값은 제외하고 처리한다.
FROM sample_t;

--전체 학생 수
SELECT COUNT(*)
FROM sample_t;


--HR 계정으로 접속

-- 전체 연봉 합
SELECT SUM(SALARY)
FROM employees;


--커미션을 받는 사원들의 연봉 평균-------------------------------------------------------------------
SELECT COMMISSION_PCT * SALARY  --NULL과 커미션 조합
FROM employees;

SELECT AVG(COMMISSION_PCT * SALARY) -- NULL과 커미션 조합의 평균 (NULL은 무시)
FROM employees;


--전체 사원들의 연봉 평균
SELECT NVL(COMMISSION_PCT, 0) * SALARY  --0과 커미션 조합
FROM employees;

SELECT AVG(NVL(COMMISSION_PCT, 0) * SALARY)  --0과 커미션 조합의 평균 (0은 평균 연산에 포함됨)
FROM employees;
-----------------------------------------------------------------------------------------------------



--가장 먼저 입사한 사원이 입사한 날짜
SELECT MIN(HIRE_DATE)
FROM employees;

--가장 늦게 입사한 사원이 입사한 날짜
SELECT MAX(HIRE_DATE)
FROM employees;

--사원들이 근무하고 있는 부서의 갯수
SELECT COUNT(DISTINCT department_id) --중복 제거할 칼럼명 앞에 DISTINCT 입력하기
FROM employees;




