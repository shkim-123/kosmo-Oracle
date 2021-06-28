-- 140. ���� ������� ������ �˻��ϵ� 1����� 10������� �˻��ϸ�?
-- 140-1
SELECT ROWNUM, e.*   -- * ������ ��Ī�� �� �� �ִ�.
FROM employee e

SELECT ROWNUM, dep_no, dep_name, loc
FROM dept

-- 140-2
SELECT ROWNUM, e.*
FROM employee e
WHERE ROWNUM <= 10
ORDER BY salary DESC

-- 140-3
SELECT ROWNUM, e.*
FROM (SELECT * FROM employee ORDER BY salary DESC) e
WHERE ROWNUM <= 10

-- 140-4
SELECT ROWNUM, e.*
FROM (SELECT * FROM employee ORDER BY salary DESC) e
WHERE 11 <= ROWNUM AND ROWNUM <= 20

-- 140-5
-- ��1
SELECT *
FROM (
        SELECT ROWNUM RNUM, e.*
        FROM (SELECT * FROM employee ORDER BY salary DESC) e
        WHERE ROWNUM <= 10
     )
WHERE RNUM >= 1
-- RNUM�� �ۿ� �ִ� SELECT�� ���忡���� �ܼ��� �÷��̴�.

-- ��2
SELECT *
FROM (
        SELECT ROWNUM RNUM, e.*
        FROM (SELECT * FROM employee ORDER BY salary DESC) e
     )
WHERE RNUM >= 1 AND RNUM <= 10

-- ����. ���� ���� 11����� 20�ฦ �˻��϶�
SELECT *
FROM (
        SELECT ROWNUM RNUM, e.*
        FROM (SELECT * FROM employee ORDER BY salary DESC) e
        WHERE ROWNUM <= 20
     )
WHERE RNUM >= 11

-- ����
SELECT * FROM ( SELECT ROWNUM RNUM, zxcvb.*  FROM (
        ���ϴ� ���� SELECT ��
) zxcvb WHERE ROWNUM <= ���������ȣ) WHERE RNUM >= �������ȣ

-- 140-6. �� ���� ������ 6����� 10����� �˻��ϸ�?
SELECT * FROM ( SELECT ROWNUM RNUM, zxcvb.*  FROM (
        SELECT * FROM customer
        ORDER BY
            DECODE(SUBSTR(jumin_num, 7, 1), '1', '19', '2', '19', '20')
                  ||SUBSTR(jumin_num, 1, 6)
) zxcvb WHERE ROWNUM <= 10) WHERE RNUM >= 6

-- 140-7. ���� ���� ���� �� 2����� 5����� �˻��ϸ�?
SELECT * FROM ( SELECT ROWNUM RNUM, zxcvb.*  FROM (
       SELECT * FROM employee
       ORDER BY DECODE(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, 5)
) zxcvb WHERE ROWNUM <= 5) WHERE RNUM >= 2

-- 127. �ζ��κ並 ����ϸ� ������ ���� ������ Ǯ �� �ִ�.
SELECT * FROM
(
SELECT
        dep_no                 DEP_NO
        , jikup                JIKUP
        , SUM(salary)          TOT_SALARY
        , ROUND(AVG(salary),1) AVG_SALARY
        , COUNT(*)       EMP_CNT
FROM
        employee
GROUP BY
        dep_no, jikup
)  WHERE EMP_CNT >= 3
-- �ζ��κ��� alias�� �ٱ��� SELECT�������� �÷����� ��޵ȴ�.

-- 135. ������ �Ի��, �ο����� �˻��ϸ�? �Ի�� �������� ����
-- <����> �Ի�� �������� ����
-- <����> �� ������� 2��, 9���� ��� ������. 2��, 9���� ���Խ�Ű�� �ο����� 0���� �����Ϸ���?
SELECT m.month||'��'    "�Ի��"
        , COUNT(e.emp_name) "�Ի��ο���"
FROM (
    SELECT '01' "MONTH" FROM DUAL UNION
    SELECT '02' FROM DUAL UNION SELECT '03' FROM DUAL UNION SELECT '04' FROM DUAL UNION
    SELECT '05' FROM DUAL UNION SELECT '06' FROM DUAL UNION SELECT '07' FROM DUAL UNION
    SELECT '08' FROM DUAL UNION SELECT '09' FROM DUAL UNION SELECT '10' FROM DUAL UNION
    SELECT '11' FROM DUAL UNION SELECT '12' FROM DUAL
) m, employee e
WHERE TO_CHAR(e.hire_date(+), 'MM') = m.month
GROUP BY m.month||'��'
ORDER BY "�Ի��";

-- ������� ���
SELECT m.month||'��'    "�Ի��"
        , (SELECT COUNT(e.emp_name) FROM employee e WHERE TO_CHAR(e.hire_date, 'MM') = m.month) "�Ի��ο���"
FROM (
    SELECT '01' "MONTH" FROM DUAL UNION
    SELECT '02' FROM DUAL UNION SELECT '03' FROM DUAL UNION SELECT '04' FROM DUAL UNION
    SELECT '05' FROM DUAL UNION SELECT '06' FROM DUAL UNION SELECT '07' FROM DUAL UNION
    SELECT '08' FROM DUAL UNION SELECT '09' FROM DUAL UNION SELECT '10' FROM DUAL UNION
    SELECT '11' FROM DUAL UNION SELECT '12' FROM DUAL
) m
ORDER BY "�Ի��";

-- 141. ���ú��� 10�� ���ı��� ��¥ �߿� �����, �Ͽ���, �������� ������ ���� ������ ���ϸ�?
SELECT COUNT(*) FROM (
    SELECT SYSDATE "XDAY" FROM DUAL UNION
    SELECT SYSDATE + 1 FROM DUAL UNION SELECT SYSDATE + 2 FROM DUAL UNION SELECT SYSDATE + 3 FROM DUAL UNION
    SELECT SYSDATE + 4 FROM DUAL UNION SELECT SYSDATE + 5 FROM DUAL UNION SELECT SYSDATE + 6 FROM DUAL UNION
    SELECT SYSDATE + 7 FROM DUAL UNION SELECT SYSDATE + 8 FROM DUAL UNION SELECT SYSDATE + 9 FROM DUAL UNION
    SELECT SYSDATE + 10 FROM DUAL
)
WHERE TO_CHAR(xday, 'DY', 'NLS_DATE_LANGUAGE = KOREAN') NOT IN('��', '��', '��')

-- 142. �̹��� �߿� �����, �Ͽ����� ������ ���� ������ ���ϸ�? = �̹��� ���� �� ���ϱ�
SELECT COUNT(*) FROM (

)
WHERE TO_CHAR( , 'DY', 'NLS_DATE_LANGUAGE = KOREAN') NOT IN('��', '��')

SELECT COUNT(*) FROM (
SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM')||'-01', 'YYYY-MM-DD')+RNUM-1 "XDAY"
FROM (SELECT ROWNUM RNUM FROM employee UNION SELECT ROWNUM + 20 FROM employee)
WHERE RNUM <= TO_NUMBER(TO_CHAR(LAST_DAY(SYSDATE), 'DD')
)
) d
WHERE TO_CHAR(d.XDAY, 'DY', 'NLS_DATE_LANGUAGE = KOREAN') NOT IN('��', '��')