/*
    GROUP BY
    1. 같은 값을 가진 데이터들을 하나의 그룹으로 묶어서 처리
    2. 대부분 통계함수랑 함께 사용
    3. 자켜야 할 문법
        GROUP BY 절에 명시한 칼럼만 SELECT 절에서 조회할 수 있다. (GROUPBY가 전체집합 SELECT는 부분)
*/

-- 1. 사원 테이블에서 부서 번호를 기준으로 그룹화하여 조회하시오.
SELECT *
FROM EMPLOYEE_T
GROUP BY DEPART; -- 문법을 안지켜서 오류

SELECT DEPART
FROM employee_t
GROUP BY depart; 

-- 2. 사원 테이블에서 부서번호별 연봉의 평균을 조화하시오.
SELECT DEPART AS 부서번호
, AVG(SALARY) AS 연봉평균
FROM EMPLOYEE_t
GROUP BY DEPART;

SELECT DEPART
, SUM(SALARY) AS 연봉합
FROM employee_t
GROUP BY DEPART;

-- 3. 부서 테이블애서 지역별 부서 수를 조회하시오.
SELECT location AS 지역
, COUNT(*) AS 부서수
FROM department_t
GROUP BY location;

-- 4. 사원 테이블에서 직급과 성별을 ㅣ준으로 그룹화하여 평균 급여 조회하시오.
SELECT POSITION, GENDER
, AVG(SALARY) AS 평균급여
FROM EMPLOYEE_T
GROUP BY POSITION, GENDER;

-- 5. 사원 테이블에서 입사월별 입사자수를 조회하시오.
SELECT TO_CHAR(HIRE_DATE, 'MM') AS 입사월
, COUNT(*) AS 입사자수
FROM employee_t
GROUP BY TO_CHAR(hire_date, 'MM');

SELECT EXTRACT(MONTH FROM HIRE_DATE) AS 입사월
, COUNT(*) AS 입사자수
FROM employee_t
GROUP BY EXTRACT(MONTH FROM HIRE_DATE);


/*
    HAVING
    1. 주로 GROUP BY 절과 함께 사용한다.
    2. 통계 함수에 조건을 지정하는 경우 사용한다.
    3. 일반 조건은 WHERE 절에 작성한다. (WHERE랑 HAVING절 구분 잘하도록!)
*/

-- 1. 사원 테이블에서 성별에 따른 연봉의 평균을 조회하시오. 성별이 'M'인 사원만 조회하시오.
SELECT GENDER 
, FLOOR(AVG(SALARY)) AS 연봉평균
FROM employee_t
WHERE GENDER = 'M'
GROUP BY GENDER;

-- 2. 사원 테이블에서 성별에 따른 연봉의 평균을 조회하시오. 각 성별별 사원 수가 2명 이상인 사원만 조회하시오.
SELECT GENDER
, FLOOR(AVG(SALARY)) AS 연봉평균
FROM EMPLOYEE_T
GROUP BY GENDER
HAVING COUNT(*) >= 2;

SELECT GENDER
, FLOOR(AVG(SALARY)) AS 연봉평균
FROM EMPLOYEE_T
WHERE COUNT(*) >= 2
GROUP BY GENDER;  -- 오류남





-- HR 계정으로 접속

-- 1. 사원 테이블에서 동일한 부서번호를 가진 사원들을 그룹화하여 각 그룹별로 몇 명의 사원이 있는지 조회하시오.
SELECT DEPARTMENT_ID AS 부서번호
, COUNT(*) 
FROM employees
GROUP BY department_id;


-- 2. 사원 테이블에서 같은 직업을 가진 사원들을 그룹화하여 각 그룹별로 연봉의 평균이 얼마인지 조회하시오.
SELECT JOB_ID AS 직업
, FLOOR(AVG(SALARY)) AS 연봉평균
FROM employees
GROUP BY JOB_ID;


-- 3. 사원 테이블에서 전화번호 앞 3자리가 같은 사원들을 그룹화하여 각 그룹별로 연봉의 합계가 얼마인지 조회하시오.
SELECT SUBSTR(PHONE_NUMBER, 1, 3)
, SUM(SALARY)
FROM employees
GROUP BY SUBSTR(PHONE_NUMBER, 1, 3);


-- 4. 사원 테이블에서 각 부서별 사원수가 20명 이상인 부서를 조회하시오.
SELECT DEPARTMENT_ID
, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 20;


-- 5. 사원 테이블에서 각 부서별 사원수를 조회하시오. 단, 부서번호가 없는 사원은 제외하시오.
SELECT DEPARTMENT_ID AS 부서
, COUNT(*) 
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY department_id;

