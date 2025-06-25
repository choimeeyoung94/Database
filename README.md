# Database

## SQL 종류
1. ddl (Data Definition Language)
    1) 데이터 정의어
    2) 데이터베이스 객체(데이터베이스, 테이블, 사용자 등)의 정보를 다루는 언어
2. DML (Data Manipulation Language)
    1) 데이터 조작어
    2) 실제 데이터를 다루는 언어
    3) 종류
       (1) INSERT: 삽입
       (2) UPDATE: 갱신
       (3) DELETE: 삭제
3. DQL (Data Query Language)
    1) 데이터 질의어
    2) 데이터를 검색할 때 사용하는 언어
    3) 종류: SELECT
4. DCL (Data Control Language)
    1) 데이터 제어어
    2) 데이터를 제어할 때 사용하는 언어
    3) 종류
        1) GRANT: 승인
        2) REVOKE: 승인해제
5. TCL (Transaction Control Language)
    1) 트랜잭션 제어어
    2) 트랜잭션을 처리할 때 사용하는 언어
    3) 종류
       (1) COMMIT: 트랜잭션 성공 (작업 내용 저장)
       (2) ROLLBACK: 트랜잭션 실패 (작업 내용 취소)

## 사용자 관련 쿼리문
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

## 데이터베이스 스키마 관련 쿼리문
1. 데이터베이스 생성
  create database [if not exists] 데이터베이스;
2. 데이터베이스 삭제
  drop database [if exists] 데이터베이스;