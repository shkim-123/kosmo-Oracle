-- 36. �ּ� ����, �ִ� ����, ��� ����, ��������, ���ο���
SELECT
        MIN(salary)    AS "�ּҿ���"  -- salary �÷����� �ּҰ� ����
        ,MAX(salary)   AS "�ִ뿬��"  -- salary �÷����� �ִ밪 ����
        ,AVG(salary)   AS "��տ���"  -- salary �÷����� ��հ� ����
                -- ����!! NULL ������ ���Ҷ� ������, ������ ���������� ������.
        ,SUM(salary)   AS "��������"  -- salary �÷����� ������ ����
        ,COUNT(*)      AS "���ο���"  -- COUNT(*)�� ������ ����
                -- NULL ���� ���� �÷��� ����.
FROM
        employee;

-- 37. ��������� �ִ� ���� ���
SELECT COUNT(emp_no) FROM customer;

-- 38. ���� ����ϴ� ������ ���
SELECT COUNT(DISTINCT emp_no) FROM customer;

-- 39. ���� ����� �ִ� ������ ���
SELECT COUNT(mgr_emp_no) FROM employee;

-- 40. ������ȣ, ������, ���Ͽ�-������ �˻�
SELECT
        emp_no      "������ȣ"
        , emp_name  "������"
        , SUBSTR(jumin_num, 3, 2)||'-'||SUBSTR(jumin_num, 5, 2)  "���Ͽ���"
        -- SUBSTR(�÷���, ���ۼ���, ����) : ���ۼ������� ������ �߶� ��ȯ
FROM
        employee;

SELECT * FROM customer;

-- 41. ��� �÷�, ��� ���� �˻�, �ֹι�ȣ�� 901225-2****** ����
SELECT
        cus_no
        , cus_name
        , tel_num
        , SUBSTR(jumin_num, 1, 6)||'-'||SUBSTR(jumin_num, 7, 1)||'******' AS "�ֹι�ȣ"
        , emp_no
FROM
        customer;
-- 42. ����ȣ, ����, ���������ȣ�� ����ϸ�?
-- ��, ���������ȣ�� ������ NULL ������� ���� '����' ǥ��
SELECT
        cus_no
        , cus_name
        , NVL(emp_no||'', '����')
        -- NVL(�÷���, NULL�� ��ü�� ������) : NULL �� ó�� �Լ�
        -- NULL ���� ��� ���ϴ� ���·� �����Ͽ� ���
        -- ||'' : ����ϴ� �����͸� ���� -> ���ڷ� ����
FROM
        customer;

-- 43. ����ȣ, ����, ����������翩�θ� ����ϸ�?
-- ��, ������ȣ�� ������ "����", ������ "����"���� ǥ��
SELECT
        cus_no
        , cus_name
        , NVL2(emp_no||'', '����', '����')
        -- NVL2(�÷���, NULL���� �ƴ� ��� ��ü�� ������, NULL�� ��ü�� ������)
        -- NULL ���� �ƴ� ���� NULL ���� ��� ���ϴ� ���·� �����Ͽ� ���
FROM
        customer;

-- 44. ������ȣ, ������, ����, ������ ����ϸ�?
SELECT
        emp_no
        , emp_name
        , jikup
        , CASE
                SUBSTR(jumin_num, 7, 1)
                WHEN '1' THEN '��'
                WHEN '3' THEN '��'
                WHEN '2' THEN '��'
                WHEN '4' THEN '��'
          END
        -- CASE �÷� WHEN �� ������ THEN ���ϰ� ... END
        -- 1, 3 -> �� / 2, 4 -> ��
FROM
        employee;

-- 44-1 ELSE �� �� ���
SELECT
        emp_no
        , emp_name
        , jikup
        , CASE
                SUBSTR(jumin_num, 7, 1)
                WHEN '1' THEN '��'
                WHEN '3' THEN '��'
                ELSE '��'
          END
        -- 1, 3 -> �� / �� �ܴ� ��� '��' �� ó��
FROM
        employee;

-- 44-2 �� �����͸� ���ǹ����� ó��
SELECT
        emp_no
        , emp_name
        , jikup
        , CASE
                WHEN SUBSTR(jumin_num, 7, 1) = '1' THEN '��'
                WHEN SUBSTR(jumin_num, 7, 1) = '3' THEN '��'
                ELSE '��'
          END
FROM
        employee;

-- 44-3 DECODE() ���
SELECT
        emp_no
        , emp_name
        , jikup
        , DECODE(
                SUBSTR(jumin_num, 7, 1)
                , '1', '��'
                , '3', '��'
                , '��'
        )
        -- DECODE(�÷���, �� ������, ���ϰ�, ..., �� �� ���� ���� ���ϰ�)
FROM
        employee;

-- 45. ������ȣ, ������, ����, ����⵵ ���
-- CASE�� ����� ���
SELECT
        emp_no
        , emp_name
        , jikup
        , CASE
                SUBSTR(jumin_num, 7, 1)
                WHEN '1' THEN '19'
                WHEN '2' THEN '19'
                ELSE '20'
          END || SUBSTR(jumin_num, 1, 2)
FROM
        employee;

-- DECODE() ����� ���
SELECT
        emp_no
        , emp_name
        , jikup
        , DECODE(
                SUBSTR(jumin_num, 7, 1)
                , '1', '19'
                , '2', '19'
                , '20'
        ) || SUBSTR(jumin_num, 1, 2)
FROM
        employee;

-- 46. ������ȣ, ������, ����, ������(4�ڸ�)
-- CASE�� ����� ���
SELECT
        emp_no
        , emp_name
        , jikup
        , CASE
                SUBSTR(jumin_num, 7, 1)
                WHEN '1' THEN '19'
                WHEN '2' THEN '19'
                ELSE '20'
          END || SUBSTR(jumin_num, 1, 1) || '0���'
FROM
        employee;

-- DECODE() ����� ���
SELECT
        emp_no
        , emp_name
        , jikup
        , DECODE(
                SUBSTR(jumin_num, 7, 1)
                , '1', '19'
                , '2', '19'
                , '20'
        ) || SUBSTR(jumin_num, 1, 1) || '0���'
FROM
        employee;

-- 47. ���̼����� ���
SELECT *
FROM employee
ORDER BY
        CASE
            WHEN SUBSTR(jumin_num, 7, 1) = '1' THEN '19'
            WHEN SUBSTR(jumin_num, 7, 1) = '2' THEN '19'
            ELSE '20'
        END || SUBSTR(jumin_num, 1, 6)
        ASC;
-- �Ʒ� ó�� �ϸ� �ȵȴ�. 2000�� ���� ���� ���´�. 2000�� ���� �ֹι�ȣ�� 00���� �����Ѵ�.
SELECT * FROM employee ORDER BY jumin_num asc;

-- 48. ���� ������� ����
SELECT *
FROM employee
ORDER BY
        CASE jikup
            WHEN '����' THEN 1
            WHEN '����' THEN 2
            WHEN '����' THEN 3
            WHEN '�븮' THEN 4
            WHEN '����' THEN 5
            ELSE 6
        END
        ASC;

-- 49. ������ȣ, ������, �Ի���(��-��-��)
SELECT
        emp_no
        , emp_name
        , TO_CHAR(hire_date,'YYYY-MM-DD')
FROM
        employee;

-- 50. ������ȣ, ������, ���� �˻�
SELECT
        emp_no
        , emp_name
        , TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
          - TO_NUMBER(
                CASE
                    SUBSTR(jumin_num, 7, 1)
                    WHEN '1' THEN '19'
                    WHEN '2' THEN '19'
                    ELSE '20'
                END || SUBSTR(jumin_num, 1, 2)
          ) + 1 || '��' AS "����"
FROM
        employee;

-- 51. ������ȣ, ������, �ٹ�����
SELECT
        emp_no "������ȣ"
        , emp_name "������"
        , CEIL( (SYSDATE - hire_date) / 365)||'����' "�ٹ�����"
        -- ����Ŭ��  ��¥ - ��¥ �� ������� ��¥ ���̸�ŭ�� �ϼ� �ִ�.
        -- CEIL() : �Ҽ� ù° �ڸ����� ������ �ø��ϴ� ���� �Լ��� �����̴�.
        -- FLOOR() : �Ҽ� ù° �ڸ����� ������ �����ϴ� ���� �Լ��� �����̴�.
FROM
        employee;

-- 52. ������ȣ, ������, ���ɴ�
SELECT
        emp_no
        , emp_name
        , FLOOR(
            (TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
                - TO_NUMBER(
                    CASE SUBSTR(jumin_num, 7, 1)
                        WHEN '1' THEN '19'
                        WHEN '2' THEN '19'
                        ELSE '20'
                    END || SUBSTR(jumin_num, 1, 2)
                ) + 1)
            * 0.1) || '0��' "����"
FROM
        employee;

-- 53. ������ȣ, ������, 100����ġ��¥(��-��-��)
SELECT
        emp_no
        , emp_name
        , TO_CHAR(
            TO_DATE(
                CASE
                    WHEN SUBSTR(jumin_num, 7, 1) IN('1', '2') THEN '19'
                    ELSE '20'
                END || SUBSTR(jumin_num, 1, 6), 'YYYY-MM-DD')
            + 100
          , 'YYYY-MM-DD') "100����ġ��¥"
FROM
        employee;
-- ����Ŭ�� ��¥�� ������ ���ϰų� ���� ����� ��¥�� ���´�

-- 54. �������� 2021�� 5�� 12���̰� �������� 2021�� 11�� 10�� �̴�.
-- ��ĥ ���� �п� ��Ȱ�� �ϳ�?
SELECT
        TO_DATE('20211110', 'YYYYMMDD')
        - TO_DATE('20210512', 'YYYYMMDD') "�ϼ�"
FROM
        dual;

-- 55. ������ȣ, ������, ���糪��, �Ի��� ��� ����
SELECT
        emp_no
        , emp_name
        , TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
            - TO_NUMBER(
                CASE
                    WHEN SUBSTR(jumin_num, 7, 1) IN('1', '2') THEN '19'
                    ELSE '20'
                END || SUBSTR(jumin_num, 1, 2))
            + 1 "����"
        , TO_NUMBER(TO_CHAR(hire_date, 'YYYY'))
            - TO_NUMBER(
                CASE
                    WHEN SUBSTR(jumin_num, 7, 1) IN('1', '2') THEN '19'
                    ELSE '20'
                END || SUBSTR(jumin_num, 1, 2))
            + 1 "�Ի��ϴ�ó���"
FROM
        employee;

-- 56. ������ȣ, ������, �ٰ��û��ϳ�(��-��-��), ���ϱ��� �����ϼ��� �˻�
SELECT
        emp_no
        , emp_name
        , TO_CHAR(
            TO_DATE(
             CASE
                  WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'MMDD'))
                   - TO_NUMBER(SUBSTR(jumin_num, 3, 4)) < 0
                     THEN '2021'
                  ELSE '2022'
              END || SUBSTR(jumin_num, 3, 4) )
             , 'YYYY-MM-DD')
           "�ٰ��û��ϳ�"
        , TO_DATE(
            CASE
                WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'MMDD'))
                      - TO_NUMBER(SUBSTR(jumin_num, 3, 4)) < 0
                THEN '2021'
                ELSE '2022'
            END || SUBSTR(jumin_num, 3, 4))
          - TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'))||'��'
          "���ϱ��� ���� �ϼ�"
FROM
        employee;
