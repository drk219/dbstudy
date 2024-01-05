-- 데이터타입 변환 함수

/*
    DUAL 테이블
    1. 테이블이 필요없는 경우에 사용하는 테이블이다.
    2. 테이블이 필요없는 조회(DQL)의 경우에도 FROM절까지 작성해야 하는데 이 때 사용한다.
    3. 1개의 열(COLUM)과 1개의 행(ROW)로 구성되어 있다.
    4. DUMMY 칼럼 
       X     값
*/

/*
    1. 문자열을 숫자열로 변환
        TO_NUMBER(문자)
        TO_NUMBER('숫자')
*/
SELECT '100', TO_NUMBER('100')
FROM DUAL;
-- 문자는 왼쪽 정렬 , 숫자는 오른쪽 정렬

SELECT *
FROM department_t 
WHERE dept_no = '1';      --1도 '1'도 조회 가능

-- 오라클에서는 이렇게 바뀐 뒤에 실행된다.
SELECT *
FROM department_t 
WHERE dept_no = TO_NUMBER('1');



/*
    2. 숫자열을 문자열로 변환
        TO_CHAR(숫자, [형식])
*/
SELECT TO_CHAR(SALARY)
, TO_CHAR(SALARY, '99999999')     --'99999999' => 8자리 문자열로 변환, 빈자리는 공백으로 채움 ( 5000000)
, TO_CHAR(SALARY, '00000000')     --'00000000' => 8자리 문자열로 변환, 빈자리는 0으로 채움 (05000000)
, TO_CHAR(SALARY, '9,999,999')    --'9,999,999' => 7자리 문자열로 변환, 쉼표 표기(5,000,000)
, TO_CHAR(SALARY, '999,999')      --'999,999'  =>6자리 문자열로 변환, 자리수가 모자르면 정상 변환 불가(#######)
FROM employee_t;


/*
    3. 문자열을 날짜로 변환
        TO_DATE(문자, [형식])  --디폴트는 yy/mm/dd
        
        * 날짜/시간 형식
        - YY   : 년도 2자리
        - YYYY : 년도 4자리
        - MM   : 월
        - DD   : 일
        - AM   : 오전/오후
        - HH   : 12시간(01~12)
        - HH24 : 24시간(00~24)
        - MI   : 분
        - SS   : 초
        - FF3  : 밀리초 3자리 (천 분의 1초)
*/
SELECT TO_DATE(HIRE_DATE)
, TO_DATE(HIRE_DATE, 'YY/MM/DD')  --입력된 값을 년/월/일로 해석 
, TO_DATE(HIRE_DATE, 'YY/DD/MM')  --입력된 값을 년/일/월로 해석 (올바른 순서 아님)
, TO_DATE(HIRE_DATE, 'HH/MI/SS')  --입력된 값을 시/분/초로 해석 (오류 발생)
FROM employee_t;


/*
    4. 날짜를 문자열로 변환
        TO_CHAR(날짜,[형식])

        * 현재 날짜/시간 함수 
            1) SYSDATE      : 년,월,일,시,분,초
            2) SYSTIMESTAMP : 년,월,일,시,분,초,밀리초
*/
SELECT SYSDATE
, SYSTIMESTAMP
, TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS')
, TO_CHAR(SYSDATE, 'YYYY.MM.DD AM HH:MI:SS')
, TO_CHAR(SYSTIMESTAMP, 'YYYY.MM.DD AM HH:MI:SS.FF3')
FROM DUAL;








