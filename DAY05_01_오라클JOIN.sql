/*내부 조인*/ --오라클 조인 (INNER JOIN -> , / ON -> WHERE)

-- 1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오.
SELECT E.EMP_NO, E.NAME, E.DEPART, D.DEPT_NAME
FROM DEPARTMENT_T D, EMPLOYEE_T E   --순서 교환가능(결과에 영향 없) 하지만 암묵적으로 지키는 순서는 있음.
WHERE D.DEPT_NO = E.DEPART;  --좌측(DRIVING TABLE)이 우측(DRIVEN TABLE)의 검색 칼럼


-- 2. 부서별 평균연봉을 조회하시오. 부서명과 평균연봉을 조회하시오.
SELECT D.DEPT_NAME, AVG(E.SALARY)
FROM DEPARTMENT_T D, EMPLOYEE_T E
WHERE D.DEPT_NO = E.DEPART
GROUP BY D.DEPT_NAME;




/*외부 조인(OUTER JOIN)*/ --ORACLE JOIN

-- 1. 모든 사원들의 사원번호, 사원명, 부서명을 조회하시오.
SELECT E.EMP_NO, E.NAME, D.DEPT_NAME
FROM DEPARTMENT_T D, EMPLOYEE_T E
WHERE d.dept_no(+) = e.depart;  -- 오른쪽 조인은 왼쪽에 (+) 추가하기


-- 2. 부서별 사원수 조회하시오. 사원이 없으면 0으로 조회하시오.
SELECT D.DEPT_NAME, e.emp_no, e.name, e.depart, e.position, e.gender
FROM DEPARTMENT_T D, EMPLOYEE_T E
WHERE d.dept_no = e.depart(+);  --왼쪽 조인은 오른쪽에 (+) 추가하기

SELECT D.DEPT_NAME, COUNT(e.emp_no)
FROM DEPARTMENT_T D, EMPLOYEE_T E
WHERE d.dept_no = e.depart(+)
GROUP BY D.DEPT_NAME; --왼쪽 조인은 오른쪽에 (+) 추가하기




--HR 접속

--<<내부 조인>>
-- 1. 사원번호, 사원명, 부서명을 조회하시오.
SELECT E.EMPLOYEE_id, E.LAST_NAME, d.department_name
FROM DEPARTMENTS D, EMPLOYEES E
WHERE d.department_id = e.department_id
;

-- 2. 부서번호, 부서명, 지역명을 조회하시오.
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, l.street_address
FROM LOCATIONS L, DEPARTMENTS D
WHERE L.LOCATION_ID = d.location_id;


-- 3. 사원번호, 사원명, 직업, 직업별 최대연봉, 연봉을 조회하시오.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.JOB_ID, J.MAX_SALARY, E.SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID;


-- <<외부조인>>
-- 4. 사원번호, 사원명, 부서명을 조회하시오. 부서가 없으면 '부서없음'으로 표시하시오.
SELECT E.EMPLOYEE_id, E.LAST_NAME, NVL(D.DEPARTMENT_NAME, '부서없음')
FROM DEPARTMENTS D, EMPLOYEES E  --왼쪽 테이블은 일치하는 값만 포함하고, 오른쪽 테이블은 모두 포함
WHERE d.department_id(+) = e.department_id;

-- 5. 부서별 평균 급여를 조회하시오. 근무중인 사원이 없으면 평균급여를 0으로 조회하시오.
SELECT D.DEPARTMENT_NAME, NVL(AVG(E.SALARY), 0)
FROM departments D, EMPLOYEES E
WHERE d.department_id(+) = e.department_id
GROUP BY d.department_id, d.department_name;


-- <<3개 이상 테이블 조인하기>> --ORACLE JOIN (,로 모든 테이블 연결/ WHERE,AND 사용)
-- 6. 사원번호, 사원명, 부서번호, 부서명, 지역번호, 지역명
SELECT E.EMPLOYEE_ID, E.LAST_NAME, d.department_id, d.department_name, l.location_id, l.street_address
FROM DEPARTMENTS D, EMPLOYEES E, LOCATIONS L
WHERE d.department_id = e.department_id
AND d.location_id = l.location_id;

SELECT E.EMPLOYEE_ID, E.LAST_NAME, d.department_id, d.department_name, l.location_id, l.street_address
FROM locations L, departments D, employees E
WHERE l.location_id = d.location_id
AND d.department_id = e.department_id;


-- 7. 국가명, 도시명, 부서명을 조회하시오.
SELECT C.COUNTRY_NAME AS 국가명, l.city AS 도시명, d.department_name AS 부서명
FROM COUNTRIES C, LOCATIONS L, departments D
WHERE C.country_id = l.country_id
AND l.location_id = d.location_id;


-- <<셀프 조인>> 하나의 테이블에 일대다 관계를 가지는 칼럼들이 존재하는 경우) --ORACLE JOIN

-- 8. 사원번호, 사원명, 매니저번호, 매니저명을 조회하시오.
--            <관계>
-- 1명의 매니저가 N명의 사원을 관리한다.
-- 매니저테이블 :  사원테이블
--       1      :       M
-- EMPLOYEES M  :  EMPLOYEES E
--      PK      :       FK

SELECT E.EMPLOYEE_ID AS 사원번호, E.LAST_NAME AS 사원명, E.MANAGER_ID AS 매니저번호, M.LAST_NAME AS 매니저명
FROM EMPLOYEES M, EMPLOYEES E
WHERE M.employee_id = e.MANAGER_id;


-- 9. 같은 부서내에서 나보다 급여를 더 많이 받는 사원 조회하시오.
-- 관계
-- 나는 여러사원ㄴ과 관계를 맺는다.
-- 나                    너
-- EMPLOYEES ME          EMPLOYEES YOU
-- 같은 부서의 사원만 조인하기 위해서 부서 번호로 조인조건을 생성
SELECT ME.EMPLOYEE_ID AS 사원번호
, ME.LAST_NAME AS 사원명
, ME.SALARY AS 급여
, you.employee_id AS 너사원번호
, YOU.LAST_NAME AS 너사원명
, YOU.SALARY AS 너급여
FROM EMPLOYEES ME, EMPLOYEES YOU 
WHERE ME.DEPARTMENT_ID = YOU.DEPARTMENT_ID
AND ME.SALARY < YOU.SALARY;

