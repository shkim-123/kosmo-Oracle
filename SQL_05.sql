-- 56. ������ȣ, ������, ����, ����(xxx,xxx,xxx����)�� �˻��ϸ�?
SELECT emp_no
        ,emp_name
        , jikup
        ,TO_CHAR(salary, '999,999,999')||'����' "����"
  FROM employee;
-- 999,999,999 -> �ڸ��� ���ڰ� ������ ���� ǥ�� ����
-- 0 -> �ڸ��� ���ڰ� ������ ���� ǥ�� (�ڸ����� ��������)

-- 57. employee ���̺��� �����Ͽ� �¾ ������ �˻��϶�
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
       , 'DY', 'NLS_DATE_LANGUAGE = Korean') = '��';

-- 58. employee ���̺��� 70���� ���� ������ �˻��϶�
SELECT *
  FROM employee
 WHERE SUBSTR(jumin_num, 1, 1) = '7'
       AND SUBSTR(jumin_num, 7, 1) IN ('1', '3') ;