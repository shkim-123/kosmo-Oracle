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
    --   , 'D') = '4';    -- D -> ������ ���ڷ� ��µȴ�. ������ : 4
    --   , 'DY' ) = 'WED';

-- 58. employee ���̺��� 70���� ���� ������ �˻��϶�
SELECT *
  FROM employee
 WHERE SUBSTR(jumin_num, 1, 1) = '7'
       AND SUBSTR(jumin_num, 7, 1) = '1' ;

 -- 59. 1960���, 1970��� ����� �� ���ڸ� �˻��϶�
SELECT *
  FROM employee
 WHERE SUBSTR(jumin_num, 1, 1) IN('6', '7')
       AND SUBSTR(jumin_num, 7, 1) = '1' ;

-- 60. ���� �ٹ��� ������ ���� ������ �˻��ϸ�?
SELECT *
FROM employee
ORDER BY hire_date;

SELECT *
FROM employee
ORDER BY SYSDATE - hire_date DESC;

-- 61. ������ȣ, ������, �ٹ��ϼ�, �ٹ�������
-- , �Ի��� 5���� �� ��¥(��-��-��), �Ի��� ���� ������ ��¥(��-��-��)
-- , �Ի��� ��¥ ���� ���ƿ��� �Ͽ��ϳ�¥(��-��-��)�� �˻��ϸ�?
-- ��, �ٹ��ϼ��� �Ҽ� 2�ڸ����� �ݿø�
SELECT
        emp_no         ������ȣ
        , emp_name     ������
        , ROUND(SYSDATE - hire_date, 1)   �ٹ��ϼ�
        , TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date),1)  �ٹ�������
        , TO_CHAR(ADD_MONTHS(hire_date, 5),'YYYY-MM-DD')    �Ի���5�����ĳ�¥
        , TO_CHAR(LAST_DAY(hire_date), 'YYYY-MM-DD')   �Ի��Ѵ��Ǹ�������¥
        , TO_CHAR(NEXT_DAY(hire_date, 1), 'YYYY-MM-DD') �Ի絹�ƿ����Ͽ���
FROM
        employee;

-- MONTHS_BETWEEN(��¥1, ��¥2) -> ��¥1 - ��¥2 �� �������� �����ϱ�
-- ADD_MONTHS(��¥, ���� ��) -> ��¥�� ���� ���� ���� ��¥�� �����ϱ�
-- LAST_DAY(��¥) -> ��¥�� ���� ���� ������ ��¥�� �����ϱ�
-- NEXT_DAY(��¥, ��������) -> ��¥ �������� ���ƿ��� ������ ��¥�� �����ϱ�
                    --  -> ���� ������ 1 ~ 7(�� ~ ��)
-- ��¥1 - ��¥2 -> ��¥1�� ��¥2�� ���̸� �ϼ��� �����ϱ�
-- ��¥ + ����   -> ��¥���� ������ŭ�� �ϼ��� ���� ��ŭ�� ���� ��¥�� �����ϱ�
-- ��¥ - ����   -> ��¥���� ������ŭ�� �ϼ��� �� ��ŭ�� ���� ��¥�� �����ϱ�

-- 62. ������ ������ ������ �˻��ϸ�?
SELECT * FROM employee WHERE jikup = '����';

-- 63. ������ ������ �ƴ� ������ �˻��ϸ�?
SELECT * FROM employee WHERE jikup != '����';
SELECT * FROM employee WHERE jikup <> '����';

-- 64. �μ���ȣ�� 10���̰� ������ ������ ������ �˻��ϸ�?
SELECT * FROM employee WHERE dep_no = 10 AND jikup = '����';

-- 65. ������ ���� �Ǵ� ������ ������ �˻��ϸ�?
SELECT * FROM employee WHERE jikup = '����' OR jikup = '����';
SELECT * FROM employee WHERE jikup IN('����', '����');
SELECT * FROM employee WHERE jikup = ANY('����', '����');

-- 66. 10��, 20�� �μ� �߿� ������ ������ ������ �˻��ϸ�?
SELECT * FROM employee WHERE (dep_no = 10 OR dep_no = 20) AND jikup = '����';
SELECT * FROM employee WHERE dep_no IN(10, 20) AND jikup = '����';
-- IN() �Լ��� AND�� �־ IN()�� �ִ� �����Ͱ� ���� ���ȴ�.

-- 67. customer ���̺��� ��������� ���� ���� �˻��ϸ�?
SELECT * FROM customer WHERE emp_no IS NULL;

-- 68. customer ���̺��� ��������� �ִ� ���� �˻��ϸ�?
SELECT * FROM customer WHERE emp_no IS NOT NULL;

-- 69. customer ���̺��� ������� ��ȣ�� 9���� �ƴ� ���� �˻��ϸ�?
SELECT * FROM customer WHERE emp_no != 9 OR emp_no IS NULL;
SELECT * FROM customer WHERE NVL(emp_no, 0) != 9;
-- emp_no IS NULL ���ǵ� ���̴� ������ emp_no�� NULL �� ���
-- emp_no != 9 ���ǿ� ���Ե��� �ʱ� �����̴�.
-- �� NULL �� IS NULL �Ǵ� IN NOT NULL �����ڿ� ���ؼ��� �˻��ȴ�.

-- 70. employee ���̺��� ������ 3000 ���� ~ 4000���� ������ ������ �˻��ϸ�?
SELECT * FROM employee WHERE salary >= 3000 AND salary <= 4000;
SELECT * FROM employee WHERE salary BETWEEN 3000 AND 4000;

-- 71. employee ���̺��� ������ 3000���� �̻� ~ 4000���� �̸� ������ ������ �˻��ϸ�?
SELECT * FROM employee WHERE 3000 <= salary AND salary > 4000;
SELECT * FROM employee WHERE (salary BETWEEN 3000 AND 4000) AND salary != 4000;

-- 72. employee ���̺��� ������ 5% �λ�ƴٰ� �����ϰ� 3000�̻��� ������ �˻��ϸ�?
SELECT * FROM employee WHERE salary*1.05 >= 3000;

-- 73. employee ���̺��� �Ի��� �� '1995-1-1' �̻��� ������ �˻��ϸ�?
SELECT * FROM employee WHERE hire_date >= TO_DATE('1995-1-1', 'YYYY-MM-DD');

-- 74. employee ���̺��� �Ի����� 1990�� ~ 1999�� ������ ������ �˻��ϸ�?
SELECT * FROM employee
WHERE hire_date BETWEEN TO_DATE('19900101', 'YYYYMMDD')
                AND TO_DATE('19991231', 'YYYYMMDD');

SELECT * FROM employee
WHERE TO_DATE('19900101', 'YYYYMMDD') <= hire_date
        AND hire_date < TO_DATE('20000101', 'YYYYMMDD');

-- 75. employee ���̺��� �μ���ȣ�� 10�� �Ǵ� 30���� ���� �߿�
-- ������ 3000 �̸��̰� �Ի����� '1996-01-01' �̸� ������ �˻��ϸ�?
SELECT * FROM employee
WHERE dep_no IN(10, 30)
        AND salary < 3000
        AND hire_date < TO_DATE('1996-01-01', 'YYYY-MM-DD');

-- 76. employ ���̺��� ���� �达�� ������ �˻��ϸ�?
SELECT * FROM employee WHERE SUBSTR(emp_name, 1, 1) = '��';
SELECT * FROM employee WHERE emp_name LIKE '��%';
-- WHERE �÷��� LIKE '���Ϲ��ڿ�'
-- -> �÷��� ���� �����Ͱ� ���Ϲ��ڿ��� ���� ������ �� ���� �˻��϶�
-- emp_name LIKE '��%'
-- -> ���� ù���ڰ� �ι�°�� ������ �͵� ���� ���̿� ���Ѿ��� ���������� ����
-- -> �������� ���� % �� ������ �͵� ���� ���̿� ���Ѿ����� �ǹ��̴�.

-- 77. employ ���̺��� ���� Ȳ���� ������ �˻��ϸ�?
SELECT * FROM employee
WHERE SUBSTR(emp_name, 1, 1) = 'Ȳ' AND SUBSTR(emp_name, 1, 2) <> 'Ȳ��';

SELECT * FROM employee
WHERE emp_name LIKE 'Ȳ%' AND emp_name NOT LIKE 'Ȳ��%';

-- 78. employee ���̺��� �̸��� 2���� ������ �˻��ϸ�?
SELECT * FROM employee WHERE LENGTH(emp_name) = 2;
-- LENGTH(�÷���) -> �÷��� ���� ���ڵ������� ���̸� 0�̻��� ������ �������ִ� �Լ�

-- 79. employee ���̺��� �̸��� ������ ������ ������ �˻��ϸ�?
SELECT * FROM employee WHERE emp_name LIKE '%��';
SELECT * FROM employee WHERE SUBSTR(emp_name, LENGTH(emp_name), 1) = '��';

-- 80. employee ���̺��� ���� �达�̰� 3������ ������ �˻��ϸ�?
SELECT * FROM employee WHERE emp_name LIKE '��%' AND LENGTH(emp_name) = 3;
SELECT * FROM employee WHERE emp_name LIKE '��__';

-- 81. employee ���̺��� �̸��� ���̶� ���ڸ� ���� ������ �˻��ϸ�?
SELECT * FROM employee WHERE emp_name LIKE '%��%';

-- 82. employee ���̺��� ���� �达�� �ƴ� ������ �˻��ϸ�?
SELECT * FROM employee WHERE emp_name NOT LIKE '��%';

-- 83. employee ���̺��� �̸� �߰����� ���� �� ������ �˻��ϸ�?
SELECT * FROM employee
WHERE emp_name LIKE '%��%'
        AND emp_name NOT LIKE '��%' AND emp_name NOT LIKE '%��';

-- 84. employee ���̺��� ���� ������ �˻��϶�
SELECT * FROM employee
WHERE SUBSTR(jumin_num, 7, 1) IN ('2', '4');

SELECT * FROM employee
WHERE jumin_num LIKE '______2%' OR jumin_num LIKE '______4%';

-- ���� �ֹι�ȣ �߰��� - �� �ִٸ� �Ʒ� ó�� �ص� �ȴ�.
SELECT * FROM employee
WHERE jumin_num LIKE '%-2%' OR jumin_num LIKE '%-4%';

-- 85. employee ���̺��� 1960���, 1970��� ������� ���ڸ� �˻��϶�
SELECT * FROM employee
WHERE SUBSTR(jumin_num, 1, 1) IN('6', '7') AND SUBSTR(jumin_num, 7, 1) = '1';

SELECT * FROM employee
WHERE jumin_num LIKE '6_____1%' OR jumin_num LIKE '7_____1%';

-- 86. ������ȣ, ������, �ҼӺμ��� �˻�?
SELECT
        e.emp_no
        , e.emp_name
        , d.dep_name
FROM
        employee e, dept d
WHERE
        e.dep_no = d.dep_no

-- 87. ����ȣ, ����, ����������̸� �˻�?
SELECT
        c.cus_no ����ȣ
        , c.cus_name ����
        , e.emp_name ����������̸�
FROM
        customer c, employee e
WHERE
        c.emp_no = e.emp_no