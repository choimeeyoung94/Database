/*
문제. 계좌 이체 처리하기

1. db_bank 데이터베이스와 은행, 고객, 계좌 테이블을 생성합니다.
  1) 관계 설정
    (1) 은행과 고객은 다대다 관계입니다.
    (2) 하나의 은행에는 여러 개의 계좌 정보가 존재합니다.
    (3) 하나의 고객은 여러 개의 계좌를 가질 수 있습니다.
  2) 칼럼 설정
    (1) 은행: 은행 아이디, 은행 이름
    (2) 고객: 고객 아이디, 고객 이름, 고객 연락처
    (3) 계좌: 계좌 아이디, 잔고 등
2. 계좌 이체 트랜잭션을 처리합니다.
  1) 각 테이블에 최소 2개의 샘플 데이터를 입력합니다.
  2) 1번 고객이 2번 고객으로 100,000만원을 계좌 이체하는 트랜잭션을 작성하고 실행합니다.
  3) 쿼리문 실행 중 발생하는 오류는 없다고 가정하고 ROLLBACK 처리는 하지 않습니다.
*/

CREATE DATABASE IF NOT EXISTS db_bank;

# 데이터베이스 사용하기 (어떤 데이터베이스에 데이터를 저장할 것인지 명시해줘야 한다)
USE db_bank;

# 은행 테이블
#  (2) 하나의 은행에는 여러 개의 계좌 정보가 존재합니다.
CREATE TABLE tbl_bank (
  bank_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  bank_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

# 고객 테이블
# (2) 고객: 고객 아이디, 고객 이름, 고객 연락처
#     (3) 하나의 고객은 여러 개의 계좌를 가질 수 있습니다.
CREATE TABLE tbl_customer (
  customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_name VARCHAR(50) NOT NULL,
  phone CHAR(11) NOT NULL
) ENGINE=InnoDB;

# 계좌 테이블
#  (3) 계좌: 계좌 아이디, 잔고 등
CREATE TABLE tbl_account (
  account_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  money INT NOT NULL,
  customer_id INT NOT NULL,
  bank_id INT NOT NULL,
  FOREIGN KEY(customer_id) REFERENCES tbl_customer(customer_id),
  FOREIGN KEY(bank_id) REFERENCES tbl_bank(bank_id)
) ENGINE=InnoDB;

INSERT INTO tbl_bank(bank_name) VALUES('하나은행');
INSERT INTO tbl_bank(bank_name) VALUES('국민은행');

INSERT INTO tbl_customer(customer_name, phone) VALUES('홍길동', 01011112222);
INSERT INTO tbl_customer(customer_name, phone) VALUES('김길동', 01033334444);

INSERT INTO tbl_account(money, customer_id, bank_id) VALUES(100000, 1, 1);
INSERT INTO tbl_account(money, customer_id, bank_id) VALUES(100000, 2, 2);


START TRANSACTION;

#  2) 1번 고객이 2번 고객으로 100,000만원을 계좌 이체하는 트랜잭션을 작성하고 실행합니다.
UPDATE tbl_account
SET money = money - 100000
WHERE account_id = 1;

UPDATE tbl_account
SET money = money + 100000
WHERE account_id = 2;

COMMIT;









DROP TABLE tbl_bank;
DROP TABLE tbl_customer;
DROP TABLE tbl_account;