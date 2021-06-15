-- SELECT��: SELECT �÷��� FROM ���̺��;
SELECT
        emp_no
        , emp_name
        , dep_no
        , jikup
        , salary
        , hire_date
        , jumin_num
        , phone
        , mgr_emp_no
FROM
        employee;

-- * ��� �÷� �˻�, ������ CREATE ������ ���
SELECT * FROM employee;

-- ���� ���� �÷��� ���� ���� ���
SELECT
        emp_no
        , emp_name
        , jikup
        , salary
        , hire_date
FROM
        employee;


-- ALIAS(��Ī) ���, "(���� ��Ʈ) ���ڡ�
SELECT
        emp_no            AS "�����ȣ"
        , emp_name           "������"   -- AS ���� ����
        , jikup           AS "����"
        , salary||'����'  AS "����"     -- ||'' �̱� ���� �����͸� �ٿ��� ���
                                        -- ����! + ��� �Ұ�, '(�̱� ����) ��� <- ���� �������̱� ������
        , hire_date           �Ի���    -- AS, ���� ���� ��� "(���� ����) ���� ����
FROM
        employee;

-- ������ ������ 12% �� ���
SELECT
        emp_name                AS "������"
        , jikup                 AS "����"
        , salary                AS "����"
        , salary*0.12||'����'   AS "����"   -- �÷��� �ڷ����� NUMBER�� ��� ������ �����ϴ�.
        , salary*0.88||'����'   AS "�Ǽ��ɾ�"
FROM
        employee;

-- ���� �ߺ� ����
SELECT DISTINCT jikup FROM employee;   -- DISTINCT �ߺ� ����
SELECT DISTINCT(jikup) FROM employee;  -- DISTINCT()
SELECT UNIQUE jikup FROM employee;     -- UNIQUE
SELECT UNIQUE(jikup) FROM employee;    -- UNIQUE()

-- �μ���ȣ, ������ �ߺ� ���� �˻�
SELECT DISTINCT dep_no, jikup FROM employee;  -- DISTINCT �÷���, �÷��� .. �ߺ� ���� �˻��ȴ�
-- SELECT DISTINCT(dep_no, jikup) FROM employee;   -- ����
SELECT UNIQUE dep_no, jikup FROM employee;

-- ������ 3000 �̻��� ���� �˻�
-- ������ ���
SELECT * FROM employee WHERE salary >= 3000;   -- WHERE���� ���� �Է�
                                               -- ���� �ɷ����� Ű����

-- ���� �������� �˻�
SELECT * FROM employee ORDER BY salary ASC; -- ORDER BY������ ����
SELECT * FROM employee ORDER BY salary;     -- ASC : ��������(�⺻��), DESC : ��������
                                            -- ���� ������ �ٲܶ� ���� Ű����
SELECT * FROM employee ORDER BY 5;          -- SELECT�� �÷����� ��ġ ��ȣ�� ���� ���

-- ���� �������� �˻�
SELECT * FROM employee ORDER BY salary DESC;
SELECT * FROM employee ORDER BY 5 DESC;

-- �μ���ȣ ��������, ���� ��������
SELECT * FROM employee ORDER BY dep_no ASC, salary DESC;  -- ���� ����
SELECT * FROM employee ORDER BY dep_no, salary DESC;      -- ASC ���� ����!!

-- ������ ���� ���� ����
SELECT * FROM employee ORDER BY jikup ASC;
SELECT * FROM employee ORDER BY jikup DESC;
-- �� ���� ��� �߸��Ȱ���
-- ���� ������ �ΰ��� �����ϴ� �������� ����Ŭ�� �ܼ��� ���İ������ϰ�� �ٸ���.
-- ���� ���ǹ��� �Ἥ ������ ������ �ٲپ�߸� �ȴ�.

-- ���� ���� ��, ������ ���� ���� ���� ����
SELECT *
FROM employee
ORDER BY DECODE(jikup, '����', 1, '����', 2, '����', 3, '�븮', 4, '���', 5), salary DESC;
-- DESC�� �����ϸ� ���� ���� ������ ��µȴ�.

-- ���常 �˻�
SELECT * FROM employee WHERE jikup = '����';  -- ����Ŭ���� �� �����ڴ� =

-- 20�� �μ��� ���常 �˻�
SELECT * FROM employee WHERE dep_no = 20 AND jikup = '����';  -- ����Ŭ and ������

-- 20�� �μ� �̰ų� ������ �˻�
SELECT * FROM employee WHERE dep_no = 20 OR jikup = '����';   -- ����Ŭ OR ������

-- ���� �߿� ���� 3400 �̻��� �˻�
SELECT * FROM employee WHERE jikup = '����' AND salary >= 3400;

-- �Ǽ��ɾ� 4000���� �̻� �޴� ����, ���� 12%
SELECT * FROM employee WHERE salary*0.88 >= 4000;

-- ���� ���� ���� ���� ���� ����, �μ���ȣ ��������, ������ �ƴ� ���� �˻�
SELECT * FROM employee WHERE jikup != '����' ORDER BY salary*0.12 DESC, dep_no DESC;

-- 20�� �μ� �߿� ���� 2000 ~ 3000 ���� �˻�
SELECT * FROM employee WHERE dep_no = 20 AND 2000 <= salary AND salary <= 3000;
SELECT * FROM employee WHERE dep_no = 20 AND salary BETWEEN 2000 AND 3000;
-- �÷��� BETWEEN ��1 AND ��2 : ��1 �̻� ��2 ���� �˻� ����, �̸��� �˻� �Ұ�

-- ���� ����� ���� ���� �˻�
SELECT * FROM employee WHERE mgr_emp_no IS NULL;     -- NULL �� �˻� IS NULL
-- NULL �� �����Ͱ� �ƴ϶� = �� �˻��� �� ����.
-- = �� NULL �� �ƴ� ���� �����͸� �˻��� �� �ִ�.

-- ���� ����� �ִ� ���� �˻�
SELECT * FROM employee WHERE mgr_emp_no IS NOT NULL;
-- NULL �� �ƴ� ��� �˻� IS NOT NULL