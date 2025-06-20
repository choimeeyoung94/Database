# 데이터베이스 생성하기
CREATE DATABASE IF NOT EXISTS db_ddl;

# 데이터베이스 사용하기 (어떤 데이터베이스에 데이터를 저장할 것인지 명시해줘야 한다)
USE db_ddl;

# 테이블 생성 (데이터 저장을 위한 데이터베이스 객체)
# 행(Row), 열(Column)
# 기본 문법: 칼럼명 -> 데이터타입 -> 제약조건 순으로 작성
# CHAR는 고정길이 
CREATE TABLE IF NOT EXISTS tbl_product(
   product_id         INT PRIMARY KEY    NOT NULL AUTO_INCREMENT PRIMARY KEY, # 기본키 (데이터 식별자), Auto_INCREMENT는 1부터 시작한다
   product_name       VARCHAR(50)        NOT NULL,
   price              DECIMAL(10,2)      NOT NULL, # 소수점 이하 자리까지 합쳐서 10자리 (소수점 앞에 8자리.소수점 뒤에 2자리) , NOT NULL: 비어있으면 안된다
   discount           DECIMAL(10,2)      NULL, # 비어있어도 된다
   created_at         DATETIME           DEFAULT NOW() # 기본값 시스템이 자동으로 시간을 등록해준다
) ENGINE=InnoDB; 


# 스토리지 엔진
# InnoDB: 트랜잭션 지원(동시성 지원), 외래키 지원(무결성 지원), 은행 또는 쇼핑몰등 일반적인 사이트에서 사용
# MyISAM: 데이터를 저장하고 읽어들이기만 할때 쓴다. 풀텍스트 인덱스 지원(검색을 빠르게 하기 위해서 사용, 읽기 위주 작업에 특화). 일반적인 웹 개발에서는 InnoDB를 쓴다. 

# AUTO_INCREMENT 시작 값을 바꾸는 방법 (설정 안해주면 1부터 시작한다)
ALTER TABLE tbl_product AUTO_INCREMENT = 1000; 

# 테이블 삭제하기 (취소 불가능)
DROP TABLE IF EXISTS tbl_product;

# 데이터베이스 삭제
DROP DATABASE IF EXISTS db_ddl;