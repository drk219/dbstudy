/*
    테이블(table)
    1. 관계형 DB에서 데이터를 저장하는 객체이다.
    2. 표 형식을 가진다.
    3. 행 row과 열 column의 집합 형식이다.
*/
/*
    테이블 만들기
    1. 열을 만드는 과정이다.
    2. 테이블 만드는 쿼리문
        CREATE TABLE 테이블 이름 (
            칼럼이름1 데이터타입 제약조건,
            칼럼이름2 데이터타입 제약조건,
            ....
        );
*/
/*
    데이터타입
    1. NUMBER(p,s) : p는 정밀도, s는 스케일
        1) 정밀도 p : 전체 유효 숫자 (123은 3, 0123은 3, 1.2는 2)
        2) 스케일 s : 소수부의 유효 숫자 (1.2는 1, 2.34는 2)
        예) 1.2 -> p:2, s:1 -> NUMBER(2,1) / 0.xx -> NUMBER(2,2)
            number(3) -> 0~999
        3) 스케일만 생략하면 정수로 표시하는 숫자
        4) 정밀도와 스케일을 생략하면 정수, 실수 모두 표시할 수 있는 숫자
    2. CHAR(size) : 글자수가 최대 size인 고정 문자
        1) 고정 문자 : 글자수의 변동이 적은 문자 (예: 휴대전화번호, 주민번호 등)
        2) 최대 size : 2000 byte
    3. VARCHAR2(size) : 글자수가 최대 size인 가변 문자
        1) 가변 문자 : 글자수의 변동이 큰 문자(예: 이름, 주소 등)
        2) 최대 size : 4000 byte
    4. CLOB : VARCHAR2(size)로 처리할 수 없는 큰 문자
    5. DATE : 날짜/시간(년,월,일,시,분,초)
    6. TIMESTAMP : 날짜/시간(년,월,일,시,분,초,마이크로초(백만분의 1초))
*/
/*
    제약조건 5가지
    1. NOT NULL : 필수 입력
    2. UNIQUE : 중복 불가
    3. PRIMARY KEY : 기본키(식별키, 찾아올 때 쓰는 값 (예:학번, 주민번호, 제품번호, 군번 등))
        'NOTNULL + UNIQUE' 비슷 
    4. FOREIGN KEY : 외래키
    5. CHECK : 작성한 조건으로 값의 제한
    
    **기본키(parent key)에 없는 외래키(child key)가 입력되면 나는 오류메시지
      : parent key not found
      : 무결성 제약조건(GD.SYS_C007327)이 위배되었습니다- 부모 키가 없습니다
*/

--블로그 구현을 위한 블로그 테이블
CREATE TABLE BLOG_T (
    BLOG_NO  NUMBER              NOT NULL PRIMARY KEY,
    TITLE    VARCHAR2(100 byte)  NOT NULL,
    EDITER   VARCHAR2(100 byte)  NOT NULL,
    CONTENTS CLOB                NULL, --null은 생략가능
    CREATED  DATE                NOT NULL
);

-- 블로그 테이블 삭제하기
DROP TABLE BLOG_T;