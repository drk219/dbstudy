--학생테이블
CREATE TABLE STUDENT_T (
    STUDENT_NO    NUMBER               NOT NULL PRIMARY KEY,
    STUDENT_NAME  VARCHAR2 (100 BYTE)  NOT NULL,
    STUDENT_GRADE NUMBER               NOT NULL,
    STUDENT_CLASS NUMBER               NOT NULL,
    CLASS_NO      NUMBER               NOT NULL
);

--과목테이블
CREATE TABLE SUBJECT_T (
    SUBJECT_NO    NUMBER               NOT NULL PRIMARY KEY,
    SUBJECT_NAME  VARCHAR2 (100 BYTE)  NOT NULL
);

--수강신청테이블
CREATE TABLE REGISTER_T (
    REGISTER_NO  NUMBER   NOT NULL PRIMARY KEY,
    STUDENT_NO   NUMBER   REFERENCES STUDENT_T(STUDENT_NO) ON DELETE CASCADE, -- 학생이 지워지면 수강신청도 삭제
    SUBJECT_NO   NUMBER   REFERENCES SUBJECT_T(SUBJECT_NO) ON DELETE SET NULL -- 과목이 지워지면 수강신청에서 과목 번호만 지운다. 학번은 그대로 둔다.
);

/*
    다대다 관계
    1. 2개의 테이블을 직접 관계 짓는 것응 불가능하다.
    2. 다대다 관계를 갖는 2개의 테이블과 연결된 중간 테이블이 필요하다.
    3. 일대다 관계를 2개 만들면 다대다 관계가 된다.
*/

DROP TABLE REGISTER_T;
DROP TABLE SUBJECT_T;
DROP TABLE STUDENT_T;