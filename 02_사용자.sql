/*
    사용자 관련 쿼리문(SQL)
    1. 사용자 생성
        CREATE USER 사용자@호스트 IDENTIFIED BY 비밀번호;
        * 호스트 관련
        1) localhost : 로컬에서만 접근하는 사용자
        2) %         : 원격 접속 가능한 사용자
        3) 특정IP    : 해당 IP에서만 접근하는 사용자
    2. 사용자 제거
        DROP USER 사용자@호스트
        * @호스트 생략 가능
    3. 사용자에게 권한 부여
        GRANT 권한종류 PRIVILEGES ON 스키마.객체 TO 사용자@호스트
*/

/*
    데이터베이스(스키마) 관련 쿼리문
    
    1. 데이터베이스 생성
    create database [if not exists] 데이터베이스;
    2. 데이터베이스 삭제
    drop database [if exists] 데이터베이스;
*/

# 1. db_test 데이터베이스 만들기
CREATE DATABASE IF NOT EXISTS db_test;
SHOW DATABASES;

# 2. user_test 사용자 만들기
CREATE USER 'user_test'@'%' IDENTIFIED BY 'P@ssw0rd';
-- USE mysql; -- mysql 데이터베이스를 사용합니다.
SELECT * FROM mysql.user; -- 사용자 정보가 등록된 mysql 데이터베이스의 user 

# 3. user_test 사용자에게 권한 부여하기 (root같은 관리자 계정이 다른 사용자에게 권한을 줄 수 있다)
# *.* => 모든 스키마의 모든 객체
GRANT ALL PRIVILEGES ON db_test.* TO 'user_test'@'%'; # db_test 내부의 모든 것을 사용할 수 있는 권한이 생성된다.
SHOW GRANTS FOR 'user_test'@'%';

# 4. user_test 사용자 삭제하기
# @: 어디어디에 있는 , %: 모든 호스트
DROP USER 'user_test'@'%'; # DROP USER user_test

# 5. db_test 데이터베이스 삭제하기
DROP DATABASE IF EXISTS db_test;

# 수업에서 사용할 사요앚 만들고, 권한 부여하기
#       데이터베이스 객체의 종류가 들어간다
CREATE USER IF NOT EXISTS '_goodee'@'%' IDENTIFIED BY 'goodee';

#                        모든 데이터베이스 안에 모든 테이블                    
GRANT ALL PRIVILEGES ON *.* TO '_goodee'@'%';




 


