-- 15. SELECT��: SELECT �÷��� FROM ���̺��;
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

-- * ��� �÷� �˻�, CREATE ������ ���
SELECT * FROM employee;
-- ��� �÷��� ������� ���µ� CREAT�� ������ ����.


-- 16. ���� ���� �÷��� ���� ���� ���
SELECT
        emp_no
        , emp_name
        , jikup
        , salary
        , hire_date
FROM
        employee;


-- 17. ALIAS(��Ī) ���, "(���� ����) ���ڡ�
SELECT
        emp_no            AS "�����ȣ"
        , emp_name           "������"   -- AS ���� ����
        , jikup           AS "����"
        , salary||'����'  AS "����"     -- ||'' �̱� ���� �����͸� �ٿ��� ���
                                        -- ����! + ��� �Ұ�, '(�̱� ����) ��� <- ���� �������̱� ������
        , hire_date           �Ի���    -- AS, ���� ���� ��� "(���� ����) ���� ����
FROM
        employee;


-- 18. ������ ������ 12% �� ���
SELECT
        emp_name                AS "������"
        , jikup                 AS "����"
        , salary                AS "����"
        , salary*0.12||'����'   AS "����"   -- �÷��� �ڷ����� NUMBER�� ��� ������ �����ϴ�.
        , salary*0.88||'����'   AS "�Ǽ��ɾ�"
FROM
        employee;
-- ���� ���̺��� *�� ������� �ʴ´�. �������� �����Ͽ� �����ش�.


-- 19. ���� �ߺ� ����
SELECT DISTINCT jikup FROM employee;   -- DISTINCT �ߺ� ����
SELECT DISTINCT(jikup) FROM employee;  -- DISTINCT()
SELECT UNIQUE jikup FROM employee;     -- UNIQUE
SELECT UNIQUE(jikup) FROM employee;    -- UNIQUE()


-- 20. �μ���ȣ, ������ �ߺ� ���� �˻�
SELECT DISTINCT dep_no, jikup FROM employee;  -- DISTINCT �÷���, �÷��� .. �ߺ� ���� �˻��ȴ�
-- SELECT DISTINCT(dep_no, jikup) FROM employee;   -- ����
SELECT UNIQUE dep_no, jikup FROM employee;


-- 21. ������ 3000 �̻��� ���� �˻�
-- ������ ���
SELECT * FROM employee WHERE salary >= 3000;   -- WHERE���� ���� �Է�
                                               -- ���� �ɷ����� Ű����

-- 22. ���� �������� �˻�
SELECT * FROM employee ORDER BY salary ASC; -- ORDER BY������ ����
SELECT * FROM employee ORDER BY salary;     -- ASC : ��������(�⺻��), DESC : ��������
                                            -- ���� ������ �ٲܶ� ���� Ű����
SELECT * FROM employee ORDER BY 5;          -- SELECT�� �÷����� ��ġ ��ȣ�� ���� ���


-- 23. ���� �������� �˻�
SELECT * FROM employee ORDER BY salary DESC;
SELECT * FROM employee ORDER BY 5 DESC;


-- 24. �μ���ȣ ��������, ���� ��������
SELECT * FROM employee ORDER BY dep_no ASC, salary DESC;  -- ���� ����
SELECT * FROM employee ORDER BY dep_no, salary DESC;      -- ASC ���� ����!!


-- 25. ������ ���� ���� ����
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


-- 26. ���常 �˻�
SELECT * FROM employee WHERE jikup = '����';  -- ����Ŭ���� �� �����ڴ� =


-- 27. 20�� �μ��� ���常 �˻�
SELECT * FROM employee WHERE dep_no = 20 AND jikup = '����';  -- ����Ŭ and ������


-- 28. 20�� �μ� �̰ų� ������ �˻�
SELECT * FROM employee WHERE dep_no = 20 OR jikup = '����';   -- ����Ŭ OR ������


-- 29. ���� �߿� ���� 3400 �̻��� �˻�
SELECT * FROM employee WHERE jikup = '����' AND salary >= 3400;


-- 30. �Ǽ��ɾ� 4000���� �̻� �޴� ����, ���� 12%
SELECT * FROM employee WHERE salary*0.88 >= 4000;


-- 31. ���� ���� ���� ���� ���� ����, �μ���ȣ ��������, ������ �ƴ� ���� �˻�
SELECT * FROM employee WHERE jikup != '����' ORDER BY salary*0.12 DESC, dep_no DESC;


-- 32. 20�� �μ� �߿� ���� 2000 ~ 3000 ���� �˻�
SELECT * FROM employee WHERE dep_no = 20 AND 2000 <= salary AND salary <= 3000;
SELECT * FROM employee WHERE dep_no = 20 AND salary BETWEEN 2000 AND 3000;
-- �÷��� BETWEEN ��1 AND ��2 : ��1 �̻� ��2 ���� �˻� ����, �̸��� �˻� �Ұ�


-- 33. ���� ����� ���� ���� �˻�
SELECT * FROM employee WHERE mgr_emp_no IS NULL;     -- NULL �� �˻� IS NULL
-- NULL �� �����Ͱ� �ƴ϶� = �� �˻��� �� ����.
-- = �� NULL �� �ƴ� ���� �����͸� �˻��� �� �ִ�.


-- 34. ���� ����� �ִ� ���� �˻�
SELECT * FROM employee WHERE mgr_emp_no IS NOT NULL;
-- NULL �� �ƴ� ��� �˻� IS NOT NULL