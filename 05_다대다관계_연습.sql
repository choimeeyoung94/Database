# 고객(Customer), 제품(Product), 주문(Purchase), 주문상세(PurchaseDetail) 테이블을 생성
# 한 고객은 여러 번 구매할 수 있습니다 (고객 - 주문)
# 여러 번의 구매에는 각각 여러 제품이 포함될 수 있습니다 (주문 - 주문상세 - 제품)
# 고객명, 고객연락처, 제품명, 제품가격, 재고, 구매일, 구매한제품객수 정보를 저장하세요

CREATE DATABASE IF NOT EXISTS db_model;

# db_model 데이터베이스 사용
USE db_model;

# 고객 테이블
CREATE TABLE IF NOT EXISTS tbl_customer(
  customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL,
  phone CHAR(11) NULL
) ENGINE=InnoDB;

# 구매 테이블
CREATE TABLE IF NOT EXISTS tbl_purchase(
  purchase_id INT NOT NULL PRIMARY KEY,
  customer_id INT NULL,
  purchase_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(customer_id) REFERENCES tbl_customer(customer_id) ON DELETE SET NULL
) ENGINE=InnoDB;

# 제품 테이블
CREATE TABLE IF NOT EXISTS tbl_product(
  product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL
  
) ENGINE=InnoDB;

# 구매상세 테이블
CREATE TABLE IF NOT EXISTS tbl_purchase_detail(
  purchase_detail_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  purchase_id        INT NOT NULL,
  product_id         INT NOT NULL,
  quantity           INT NOT NULL DEFAULT 1,
  FOREIGN KEY(purchase_id) REFERENCES tbl_purchase(purchase_id) ON DELETE CASCADE,
  FOREIGN KEY(product_id) REFERENCES tbl_product(product_id) ON DELETE CASCADE
) ENGINE=InnoDB;

# 구매상세 테이블 삭제
DROP TABLE IF EXISTS tbl_purchase_detail;

# 구매 테이블 삭제
DROP TABLE IF EXISTS tbl_purchase;

# 고객 테이블 삭제
DROP TABLE IF EXISTS tbl_customer;

# 제품 테이블 삭제
DROP TABLE IF EXISTS tbl_product;

CREATE DATABASE IF NOT EXISTS db_model;

# db_model 데이터베이스 사용
USE db_model;

# 문제1. 게시글(Post)에 댓글(Comment) 달기
# 한 게시글에 여러 댓글이 달릴 수 있습니다.
# 게시글 제목, 게시글내용, 게시글작성일, 댓글내용, 댓글작성일 정보를 저장합니다.
# 게시글 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_post (
    post_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title   VARCHAR(100) NOT NULL,
    content TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

# 댓글 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_comment (
    comment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(post_id) REFERENCES tbl_post(post_id) ON DELETE CASCADE
) ENGINE=InnoDB;

# 댓글 테이블 삭제
DROP TABLE IF EXISTS tbl_comment;

# 게시글 테이블 삭제
DROP TABLE IF EXISTS tbl_post;

# 문제2 부서에 속한 직원
# 한 부서에 여러 직원이 속할 수 있습니다
# 부서명, 부서위치, 부서장, 직원명, 입사일 정보를 저장합니다

# 부서 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_department (
  dept_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(100) NOT NULL,
  deop_location VARCHAR(100) NULL,
  manager_id INT NULL,
  FOREIGN KEY(manager_id) REFERENCES tbl_employee(emp_id) # 직원 테이블이 있어야만 부서 테이블 만들 수 있다
    ON DELETE SET NULL # 부서장이 삭제되면 manager_id를 NULL 처리한다
) ENGINE=InnoDB;

# 직원 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_employee (
    emp_id   INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dept_id  INT NULL,
    emp_name VARCHAR(100) NOT NULL,
    hired_at DATE NOT NULL,
    FOREIGN KEY(dept_id) REFERENCES tbl_department(dept_id) # 부서 테이블이 있어야만 사원 테이블을 만들 수 있다 
        ON DELETE SET NULL # 부서가 없어지면 dept_id를 null 처리한다
)ENGINE=InnoDB;

# 위와 같이 작업하면 테이블 생성 순서에 문제가 발생하여 작업을 수행할 수 없다
# 실제로는 외래키 제약조건을 나중에 추가한다
# alter 테이블로 나중에 테이블 제약조건을 수정한다


# 직원 테이블 생성 (외래키 없이 생성)
CREATE TABLE IF NOT EXISTS tbl_employee (
    emp_id   INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    hired_at DATE NOT NULL
)ENGINE=InnoDB;

# 부서 테이블 생성 (외래키 없이 생성)
CREATE TABLE IF NOT EXISTS tbl_department (
  dept_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(100) NOT NULL,
  deop_location VARCHAR(100) NULL,
  manager_id INT NULL
) ENGINE=InnoDB;

# 직원 테이블에 dept_id 칼럼 추가하고 외래키 제약조건 추가
ALTER TABLE tbl_employee add column dept_id INT NULL;
ALTER TABLE tbl_employee add constraint fk_employee_department
 FOREIGN KEY(dept_id) REFERENCES tbl_department(dept_id) ON DELETE SET NULL;
# 부서 테이블의 manager_id 칼럼 외래키 설정
alter table tbl_department add constraint fk_department_manager 
  FOREIGN KEY(manager_id) REFERENCES tbl_employee(emp_id);

# 직원, 부서 테이블 삭제 (외래키가 없으므로 순서에 상관이 없습니다.)
DROP TABLE IF EXISTS tbl_employee, tbl_department;
