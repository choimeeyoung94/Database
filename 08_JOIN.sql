# db_company 데이터베이스 사용
USE db_company;

/*
    Cross Join
    1. 조인 조건이 생략되거나 잘못된 조인 조건을 사용한 경우이다
    2. 조인하는 테이블들의 모든 행들을 조합하여 조회한다
*/

# 부서아이디, 부서명, 사원번호, 직원명 Cross Join
SELECT d.dept_id, d.dept_name, e.emp_id, e.emp_name
FROM tbl_department d 
CROSS JOIN tbl_employee e;

/*
    Inner Join
    1. 조인 조건을 지정하는 조회 방식
    2. 조인하는 두 테이블에 모두 존재하는 데이터를 대상으로 조회한다
    
    Join Table 구분
    1. Drive Table (Driving Table)
       1) 조인을 주동하는 테이블 (조인할 때 먼저 읽는 테이블)
       2) 조인 조건에서 사용하는 칼럼 중 PK를 가진 테이블
       3) 일반적으로 행이 적은 테이블
    2. Driven Table
       1) Drive Table에 의해서 참조되는 테이블
       2) 조인 조건에서 사용하는 칼럼 중 FK를 가진 테이블
       3) 일반적으로 행이 많은 테이블
       
   Optimizer(옵티마이저)
   1. 어떤 테이블을 Drive Table로 사용할 것인지 선택한다
   2. 테이블 크기, 인덱스 유무, 조건절의 선택도(조건 필터링 결과가 적을 것으로 예상되는 테이블을 Drive Table로 선정) 등을 이용해서 Drive 테이블을 선택한다
   3. 과거 DB는 FROM 절에 작성한 테이블을 Drive Table로 인식하기도 했다
   
*/

# 모든 직원들의 부서아이디, 부서명, 직원아이디, 직원명을 조회하기
SELECT d.dept_id, d.dept_name, e.emp_id, e.emp_name
FROM tbl_department d
INNER JOIN tbl_employee e
ON d.dept_id = e.dept_id; -- 두 테이블의 참조 관계를 찾아서 이를 조인 조건으로 사용한다

# EXPLAIN 이용한 쿼리 실행 계획 확인하기
EXPLAIN SELECT d.dept_id, d.dept_name, e.emp_id, e.emp_name
FROM tbl_department d
INNER JOIN tbl_employee e
ON d.dept_id = e.dept_id;

/*
    Outer Join
    1. 조인 조건을 만족하지 않는 데이터를 결과에 포함시키는 조인방식
    2. 어느 한 쪽 테이블의 모든 데이터는 항상 결과에 포함된다
    3. 어느 쪽 테이블의 모든 데이터를 항상 포함할지에 따라 다음 세 가지로 나뉜다
        1) LEFT OUTER JOIN: JOIN 절 왼쪽에 있는 테이블의 모든 데이터는 항상 조회된다
        2) RIGHT OUTER JOIN: JOIN 절 오른쪽에 있는 테이블의 모든 데이터는 항상 조회된다
        3) FULL OUTER JOIN: JOIN 절 기준 양쪽에 있는 테이블의 모든 데이터는 항상 조회된다
*/

# 모든 직원들의 부서아이디, 부서명, 직원아이디, 직원명을 조회하기 단, 직원이 근무하지 않는 부서 정보도 조회 하기
SELECT d.dept_id, d.dept_name, e.emp_id, e.emp_name
FROM tbl_department d  
LEFT OUTER JOIN tbl_employee e
ON d.dept_id = e.dept_id;

# 모든 직원들의 부서아이디, 부서명, 직원아이디, 직원명을 조회하기
# 단, 부서가 없는 직원 정보도 조회하기
SELECT d.dept_id, d.dept_name, e.emp_id, e.emp_name
FROM tbl_department d  
RIGHT OUTER JOIN tbl_employee e
ON d.dept_id = e.dept_id;

#####################################################################################

# 1. '서울'에 근무하는 직원 정보 조회하기
SELECT *
FROM tbl_department d
JOIN tbl_employee e 
ON d.dept_id = e.dept_id AND d.dept_location = '서울';

# 2. 급여를 5,00,0000 이상 받는 직원이 있는 부서 정보 조회하기
select d.dept_name, e.emp_name, e.salary
FROM tbl_department d
JOIN tbl_employee e
ON d.dept_id = e.dept_id AND e.salary >= 5000000;

# 3. 각 지역별로 근무하는 직원 수 조회하기 (근무중인 직원이 없으면 조회할 필요 없음)
SELECT COUNT(emp_id), -- 직원 수를 구하기 위해서 모든 직원이 값을 가지고 있는 emp_id(PK)를 COUNT 함수에 전달 
        d.dept_location
FROM tbl_department d
JOIN tbl_employee e
ON d.dept_id = e.dept_id
GROUP BY d.dept_location;

# 4. 각 부서별 직원 수 조회하기 (근무 중인 직원이 없으면 0으로 표시하기)
SELECT COUNT(e.emp_id), d.dept_name
FROM tbl_department d
LEFT OUTER JOIN tbl_employee e
ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;
