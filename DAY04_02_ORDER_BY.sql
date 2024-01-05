/*
    ORDER BY
    1. 조회 결과를 정렬할 때 이용
    2. 정렬 방법
        1) 오름차순 정렬 : ASC 또는 생략
        2) 내림차순 정렬 : DESC
    3. 2개 이상의 정렬기준을 추가할 수 있다.
    4. SELECT절에서 제일 마지막으로 실행됨
*/

-- 1. 연봉이 높은 순으로 사원을 조회하시오.
SELECT *
FROM EMPLOYEE_T
ORDER BY SALARY DESC;

-- 2. 입사순으로 조회하시오. 
SELECT *
FROM EMPLOYEE_T
ORDER BY HIRE_DATE ASC; -- ASC 생략가능

--3. 성별의 오름차순으로 정렬하시오. 동일한 성별 내에서는 이름의 내림차순으로 정렬하시오.
SELECT *
FROM EMPLOYEE_T
ORDER BY gender, NAME DESC;


