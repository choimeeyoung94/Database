# 제품 테이블과   카테고리 테이블 
# M      :        1(1개의 카테고리에 M개의 제품이 연결된다) (1:다 관계)
# FK              PK
# 자식(child)     부모(parent)
#                 먼저 생성
# 먼저 삭제

# 제품의 이미지를 등록하고자 합니다
# 이미지 아이디, 제품 아이디, 이미지 url 주소, 메인 이미지 여부, 최초 등록 일시를 저장할 수 있도록 이미지 테이블 만들기 (tbl_product_image)



# db_model
#       (SCHEMA) 
CREATE DATABASE IF NOT EXISTS db_model;

# db_model 데이터베이스 사용
USE db_model;

# 카테고리 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_category  (
    category_id       INT NOT NULL  AUTO_INCREMENT PRIMARY KEY,
    category_name     VARCHAR(100) NOT NULL,
    category_describe TEXT NOT NULL,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP # CURRENT_TIMESTAMP: 현재 날짜와 시간을 의미하는 내장함수
) ENGINE=InnoDB;

# 제품 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_product(
 product_id   INT AUTO_INCREMENT PRIMARY KEY,
 category_id  INT NOT NULL, # 카테고리 테이블과 관계를 맺는 칼럼 
 product_name VARCHAR(50) NOT NULL, 
 price        DECIMAL(10,2) NOT NULL,
 discount     DECIMAL(10,2) NULL,
 created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updtated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP  ON UPDATE CURRENT_TIMESTAMP, # 입력안하면 CURRENT_TIMESTAMP, 업데이트 하면 CURRENT_TIMESTAMP
 FOREIGN KEY(category_id) REFERENCES tbl_category(category_id) # 외래키 설정: 현재 테이블의 category_id(외래키)는 카테고리 테이블의 category_id 칼럼이 가진 값만 가질 수 있다 (참조 무결성)
    ON UPDATE CASCADE # 부모 테이블의 PK가 수정되면 자식 테이블의 FK가 함께 수정된다 (참조하는 부모 테이블의 값이 변경될 경우 자식 테이블의 관련 값도 자동으로 함께 변경)
    ON DELETE CASCADE # 부모 테이블의 PK가 삭제되면 자식 테이블의 FK가 함께 삭제된다
) ENGINE=InnoDB;

# 이미지 아이디, 제품 아이디, 이미지 url 주소, 메인 이미지 여부, 최초 등록 일시를 저장할 수 있도록 이미지 테이블 만들기 (tbl_product_image)
# 이미지 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_product_image(
   image_id INT AUTO_INCREMENT PRIMARY KEY,
   product_id INT NULL, # 안적으면 NULL 
   image_url VARCHAR(255) NOT NULL,
   is_main BOOLEAN DEFAULT FALSE,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY(product_id) REFERENCES tbl_product(product_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL # 부모 테이블의 PK가 삭제 되면 자식 테이블의 FK가 NULL이 된다
) ENGINE=InnoDB;

# 제품 이미지 테이블 삭제
DROP TABLE IF EXISTS tbl_product_image;

# 제품 테이블 삭제
DROP TABLE IF EXISTS tbl_product;

# 카테고리 테이블 삭제
DROP TABLE IF EXISTS tbl_category;

# db_model 데이터베이스 삭제
DROP DATABASE IF EXISTS db_model;
















