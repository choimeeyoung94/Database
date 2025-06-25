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

## DML

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
## DQL
DQL
    
    1. 기본 구조
    SELECT 칼럼1, 칼럼2, ...
    FROM 테이블
    WHERE 조건칼럼 = 값
    GROUP BY 그룹화칼럼1, 그룹화칼럼2 ...
    HAVING 그룹조건칼럼 = 값
    ORDER BY 정렬칼럼 (ASC|DESC), 정렬칼럼2 (ASC|DESC),...
    LIMIT 시작, 개수;

    2. 각 절의 실행 순서
        1) FROM
        데이터를 조회할 테이블을 선택
        2) WHERE
        FROM 절에서 가져온 데이터 중 조건에 맞는 행만 선택
        3) GROUP BY 절
        WHERE 절을 통과한 데이터를 지정한 칼럼 기준으로 그룹화
        4) HAVING 절
        GROUP BY 절에 의해서 그룹화된 결과 중에서 조건에 맞는 행만 선택한다
        5) SELECT 절
        지금까지 과정을 거친 행(데이터)을 조회할 때 조회할 칼럼을 작성
        6) ORDER BY 절
        SELECT 절에서 선택한 결과 집합을 지정한 칼럼 기준으로 정렬한다
        7) LIMIT 절
        지금까지 과정을 거친 행(데이터)을 조회할 때 개수나 범위를 제한
        
    3. 기타 특징
        1) SELECT 절을 제외하면 모두 생략할 수 있다
        2) SELECT 절에서 조회할 칼럼에 별칭(ALIAS)을 부여할 수 있는데, 이 별칭은 ORDER BY 절에서 사용할 수 있다
            (다른 절에서는 조회할 칼럼에 지정한 별칭을 사용할 수 없다)
        3) GROUP BY 절 없이도 HAVING 절을 사용할 수 있다
           (전체 데이터를 하나의 그룹으로 간주하고 처리한다)
        4) ORDER BY 절에서 사용하는 정렬 키워드는 다음 의미를 가진다
            1) ASC : 오름차순 정렬, 생략 가능
            2) DESC : 내림차순 정렬, 생략 불가능
        5) LIMIT 절의 시작 값은 생략 할 수 있다. 이 경우 데이터의 처음부터 가져온다 
           (첫 행의 시작 값은 0이다)