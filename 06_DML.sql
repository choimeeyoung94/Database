/*
    DML
    ===== INSERT (데이터 삽입하기)
    자동으로 입력되는 값들은 제외하고 INSERT 한다
    1. 모드 칼럼에 값을 입력하는 경우 (*칼럼 리스트 생략) 
    INSERT INTO 테이블 VALUES(값1, 값2, ... 값N);
    2. 일부 칼럼에 값을 입력하는 경우
    INSERT INTO 테이블(칼럼1, 칼럼2,...칼럼N) VALUES(값1, 값2, ... 값N);
    3. 여러 행을 한 번에 입력하는 경우
    INSERT INTO 테이블(칼럼1, 칼럼2,...칼럼N)
    VALUES (값1, 값2, ... 값N),
           (값1, 값2, ... 값N),
           (값1, 값2, ... 값N);
    4. 다른 테이블의 행을 복사해서 입력하는 경우 (*VALUES 없음 주의)
    INSERT INTO 테이블(칼럼1, 칼럼2, ... 칼럼N)
    SELECT 칼럼1, 칼럼2, ...칼럼N FROM 다른 테이블;
    
    ===== UPDATE (데이터 수정하기)
    1. 모든 행을 수정하는 경우
    UPDATE 테이블
    SET 칼럼1 = 값1, 칼럼2 = 값2,...,칼럼N = 값N;
    2. 조건을 만족하는 행을 수정하는 경우
    UPDATE 테이블
    SET 칼럼1 =(대입연산) 값1, 칼럼2 = 값2,...,칼럼N = 값N
    WHERE 조건칼럼 (비교연산 = , >= , <=, >, <) 값;
    
    ===== DELETE (데이터 삭제하기)
    1. 모든 행을 삭제하는 경우
    DELETE 
    FROM 테이블;
    2. 조건을 만족하는 행을 삭제하는 경우
    DELETE
    FROM 테이블
    WHERE 조건칼럼 = 값;
*/

CREATE DATABASE IF NOT EXISTS db_company;

# 데이터베이스 사용하기 (어떤 데이터베이스에 데이터를 저장할 것인지 명시해줘야 한다)
USE db_company;


CREATE TABLE tbl_department (
    dept_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(30) NOT NULL,
    dept_location VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tbl_employee (
    emp_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dept_id INT NOT NULL,
    emp_name VARCHAR(15) NOT NULL,
    position VARCHAR(10) NOT NULL,
    gender CHAR(1) NOT NULL,
    hire_date DATE  NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES tbl_department(dept_id)
) ENGINE=InnoDB;

ALTER TABLE tbl_employee AUTO_INCREMENT 1001;

# tbl_department 데이터 삽입
INSERT INTO tbl_department (dept_name, dept_location) 
VALUES('영업부', '대구');

INSERT INTO tbl_department (dept_name, dept_location)
VALUES('인사부', '서울');

INSERT INTO tbl_department
VALUES(NULL, '총무부','대구');

INSERT INTO tbl_department
VALUES(NULL, '기획부', '서울');

# tbl_employee
INSERT INTO tbl_employee (dept_id, emp_name, position, gender, hire_date, salary)
VALUES(1, '구창민', '과장', 'M', '1995-05-01', 5000000 ),
        (1, '김민서', '사원', 'M', '2017-09-01', 2500000),
        (2, '이은영', '부장', 'F', '1990-09-01', 5500000),
        (1, '한성일', '과장', 'M', '1993-04-01', 5000000);

# 테스트 데이터 입력
INSERT INTO tbl_department (dept_name, dept_location)
VALUES('개발부','서울');

# 테스트 데이터 수정하기 (지역을 부산으로 수정)
UPDATE tbl_department 
SET dept_location = '부산'
WHERE dept_id = 4;

# 테스트 데이터 삭제하기 (dept_id가 5인 부서 삭제하기)
DELETE
FROM tbl_department
WHERE dept_id = 4;

/*
    TCL (Transaction Control Language)
    1. 작업(트랜잭션) 저장
        COMMIT;
    2. 작업(트랜잭션) 취소 (이전 작업 저장 시점으로 되돌아 감)
        ROLLBACK;
    
    트랜잭션 Transaction
    1. 하나의 작업을 의미한다
    2. 하나 이상의 쿼리문(DML)으로 구성된다

    커밋 이전 상황
    1. 메모리(휘발성 기억장치)에 정보를 저장한다
    2. undo log에 임시로 정보가 저장된다
    3. 롤백이 가능한다
    
    커밋 이후 상황
    1. 디스크(비휘발성 기억장치)에 영구적으로 정보를 저장한다
    2. 롤백이 불가능하다
*/
# autocommit 여부를 확인하는 쿼리문 (0이면 autocommit 아님, 1이면 autocommit 상태)
select @@autocommit;

# autocommit 상태를 바꾸는 쿼리문
set autocommit = 0;

# 트랜잭션의 범위를 설정하는 방법
# START TRANSACTION;
# 쿼리문1;
# 쿼리문2;
# ...
# COMMIT;

# autocommit 테스트 (아래 쿼리문을 실행한 뒤 접속을 끊고 재접속하면 실행 결과가 남아있지 않습니다)
INSERT INTO tbl_department (dept_name, dept_location)
VALUES('개발부', '인천');

COMMIT;








        
DROP TABLE tbl_employee;