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
--

-- 37. ��������� �ִ� ���� ���
SELECT COUNT(emp_no) FROM customer;

-- 38. ���� ����ϴ� ������ ���
SELECT COUNT(DISTINCT emp_no) FROM customer;

-- 39. ���� ����� �ִ� ������ ���
SELECT COUNT(mgr_emp_no) FROM employee;

-- 39-1 ���������� �ִ� ������ ���
SELECT COUNT(DISTINCT mgr_emp_no) FROM employee;

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

-- DECODE() ���
SELECT *
FROM employee
ORDER BY
        DECODE(
                jikup
                ,'����', 1
                ,'����', 2
                ,'����', 3
                ,'�븮', 4
                ,'����', 5
                , 6
        ) ASC;


-- 49. ������ȣ, ������, �Ի���(��-��-��(����) �б� �ú���)
SELECT
        emp_no
        , emp_name
        , TO_CHAR(hire_date,'YYYY-MM-DD(DY) Q AM HH:MI:SS', 'NLS_DATE_LANGUAGE = Korean')
FROM
        employee;

-- AM �߰� : ����, ���ķ� ǥ��
-- HH24 : 0 ~ 23�÷� ǥ��
-- ���� ǥ�� : DAY (���� Ǯ����) / DY (���� ����)
-- �� ��° �ɼǿ� 'NLS_DATE_LANGUAGE = Korean' �߰�, DAY (�ѱ� Ǯ����) / DY (�ѱ� ����)
-- Q : 1 ~ 4 �б� ���

-- 49 - 1 ������ȣ, ������, �Ի���(x��-x��-x��(����) x�б� x��x��x��)
SELECT
        emp_no
        , emp_name
        , TO_CHAR(hire_date, 'YYYY') || '��-'  || TO_CHAR(hire_date, 'MM')  || '��-'
        || TO_CHAR(hire_date, 'DD')  || '��'   || TO_CHAR(hire_date, '(DY)', 'NLS_DATE_LANGUAGE = Korean')
        || TO_CHAR(hire_date, ' Q')  || '�б�' || TO_CHAR(hire_date, ' HH') || '��'
        || TO_CHAR(hire_date, 'MI')  || '��'   || TO_CHAR(hire_date, 'SS')  || '��'
FROM
        employee;

-- 2��° ���̽�
SELECT
        emp_no
        , emp_name
        , TO_CHAR(hire_date,'YYYY"��"-MM"��"-DD"��"(DY) Q"�б�" HH"��"MI"��"SS"��"', 'NLS_DATE_LANGUAGE = Korean')
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
                END || SUBSTR(jumin_num, 1, 6), 'YYYYMMDD'
            ) + 100
          , 'YYYY-MM-DD(DY)', 'NLS_DATE_LANGUAGE = Korean') "100����ġ��¥"
FROM
        employee;
-- ����Ŭ�� ��¥�� ������ ���ϰų� ���� ����� ��¥�� ���´�

-- 53-1. �������� 2021�� 5�� 12���̰� �������� 2021�� 11�� 10�� �̴�.
-- ��ĥ ���� �п� ��Ȱ�� �ϳ�?
SELECT
        TO_DATE('20211110', 'YYYYMMDD')
        - TO_DATE('20210512', 'YYYYMMDD') "�ϼ�"
FROM
        dual;

-- 54. ������ȣ, ������, ���糪��, �Ի��� ��� ����
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

-- ����⵵ - ����⵵ + 1 -> ���糪��
-- �Ի�⵵ - ����⵵ + 1 -> �Ի��� ��� ����

-- 55. ������ȣ, ������, �ֹι�ȣ, �ٰ��û��ϳ�(��-��-��), ���ϱ��� �����ϼ��� �˻�
SELECT
        emp_no
        , emp_name
        , jumin_num
        , TO_CHAR(
            TO_DATE(
             CASE
                  WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'MMDD'))
                         - TO_NUMBER(SUBSTR(jumin_num, 3, 4)) < 0
                        THEN '2021'
                  ELSE '2022'
              END || SUBSTR(jumin_num, 3, 4), 'YYYYMMDD')
             , 'YYYY-MM-DD')
           "�ٰ��û��ϳ�"
        , TO_DATE(
            CASE
                WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'MMDD'))
                      - TO_NUMBER(SUBSTR(jumin_num, 3, 4)) < 0
                    THEN '2021'
                ELSE '2022'
            END || SUBSTR(jumin_num, 3, 4), 'YYYYMMDD' )
          - TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'), 'YYYYMMDD') || '��'
          "���ϱ��� ���� �ϼ�"
FROM
        employee;

-- ���ػ��ϳ�¥ - ���糯¥  -> ����� ���� ������(����), ������ ���� ����(����)
-- ���ϱ��� ���� �ϼ� ��� ���
-- ���� ���ػ��ϳ�¥ - ���ݳ�¥ ���� ����� ������ ���������Ƿ� ���ػ��ϳ�¥ - ���ݳ�¥ �� �ȴ�.
-- ���� ���ػ��ϳ�¥ - ���ݳ�¥ ���� ������ ������ �������Ƿ� ������ϳ�¥ - ���ݳ�¥ �� �ȴ�.
SELECT
        emp_no
        , emp_name
        , jumin_num
        , TO_CHAR(TO_DATE(CASE WHEN
                    TO_DATE(
                        TO_CHAR(SYSDATE, 'YYYY') || SUBSTR(jumin_num, 3, 4)
                        , 'YYYYMMDD'
                  ) - SYSDATE >= 0
               THEN TO_CHAR(SYSDATE, 'YYYY')
               ELSE TO_CHAR(SYSDATE + 365, 'YYYY')
           END || SUBSTR(jumin_num, 3, 4), 'YYYYMMDD'), 'YYYY-MM-DD') "�ٰ��û��ϳ�"
        , TO_DATE(CASE WHEN
                    TO_DATE(
                        TO_CHAR(SYSDATE, 'YYYY') || SUBSTR(jumin_num, 3, 4)
                        , 'YYYYMMDD'
                  ) - SYSDATE >= 0
               THEN TO_CHAR(SYSDATE, 'YYYY')
               ELSE TO_CHAR(SYSDATE + 365, 'YYYY')
           END || SUBSTR(jumin_num, 3, 4), 'YYYYMMDD')
           - TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD'), 'YYYYMMDD') "���ϱ��� ���� �ϼ�"
FROM
        employee
ORDER BY
        5 ASC;   -- SELECT �÷� ���� ��ȣ�� ORDER BY�� �����ϴ�.
    -- "���ϱ��� ���� �ϼ�" ASC;  -- SELECT �÷��� �˸��ƽ��� ORDER BY�� �����ϴ�.

-- FLOOR() : -4
SELECT FLOOR(-3.1) FROM DUAL;

-- FLOOR() : -3
SELECT CEIL(-3.1) FROM DUAL;

