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

### TINYINT
- mysql에서 사용하는 정수형 데이터 타입
- 가장 작은 크기의 정수형 데이터 타입
- 저장 공간이 작기 때문에 메모리와 저장공간을 아끼고 싶을때 사용

### DATETIME vs TIMESTAMP
- 날짜와 시간을 저장하기 위한 데이터 타입
| 구분          | `DATETIME`                                         | `TIMESTAMP`                                        |
| ----------- | -------------------------------------------------- | -------------------------------------------------- |
| 📅 형식       | `YYYY-MM-DD HH:MM:SS`                              | `YYYY-MM-DD HH:MM:SS`                              |
| 🧠 내부 저장 방식 | **날짜와 시간 자체** 저장 (8바이트)                            | **UNIX 타임스탬프**로 저장 (4바이트)                          |
| ⏰ 타임존 영향    | **타임존 무관**                                         | **타임존 영향을 받음**                                     |
| 📆 범위       | `'1000-01-01 00:00:00'` \~ `'9999-12-31 23:59:59'` | `'1970-01-01 00:00:01'` \~ `'2038-01-19 03:14:07'` |
| 📦 저장 공간    | 8바이트                                               | 4바이트 (MySQL 5.5 이전은 4바이트)                          |
| 🕒 자동 시간 갱신 | 직접 설정 필요                                           | 기본적으로 `CURRENT_TIMESTAMP` 사용 가능                    |
| 🔄 시간 변환    | 저장된 대로 그대로 출력                                      | **타임존에 따라 변환되어 출력**                                |

## 서브쿼리
1. 쿼리 내부에 다른 쿼리를 포함하는 것을 의미
2. 쿼리가 포함되는 절에 따라 종류를 구분 한다
3. 종류
    1) WHERE 절: 중첩 서브쿼리 (단일 행 서브쿼리, 다중 행 서브쿼리)
    2) FROM 절: 인라인 뷰(테이블 형식의 결과 반환)
    3) SELECT 절: 스칼라 서브쿼리
    4) 스칼라 서브쿼리(하나의 값을 반환하는 서브쿼리)


