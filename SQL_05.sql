-- 56. 직원번호, 직원명, 직급, 연봉(xxx,xxx,xxx만원)을 검색하면?
SELECT emp_no
        ,emp_name
        , jikup
        ,TO_CHAR(salary, '999,999,999')||'만원' "연봉"
  FROM employee;
-- 999,999,999 -> 자리에 숫자가 없으면 숫자 표시 안함
-- 0 -> 자리에 숫자가 없으면 숫자 표시 (자릿수가 맞춰진다)

-- 57. employee 테이블에서 수요일에 태어난 직원을 검색하라
SELECT *
  FROM employee
 WHERE TO_CHAR(TO_DATE
       (
           CASE
               WHEN SUBSTR(jumin_num, 7, 1) IN('1', '2')
               THEN '19'
               ELSE '20'
           END || SUBSTR(jumin_num, 1, 6), 'YYYYMMDD'
       )
       , 'DY', 'NLS_DATE_LANGUAGE = Korean') = '수';

-- 58. employee 테이블에서 70년대생 남자 직원을 검색하라
SELECT *
  FROM employee
 WHERE SUBSTR(jumin_num, 1, 1) = '7'
       AND SUBSTR(jumin_num, 7, 1) IN ('1') ;