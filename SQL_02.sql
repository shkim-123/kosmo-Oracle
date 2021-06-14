-- DEPT ���̺� ����
CREATE TABLE dept(
    dep_no      NUMBER(3)
    ,dep_name   VARCHAR2(20)    NOT NULL UNIQUE
    ,loc        VARCHAR2(20)    NOT NULL

    ,PRIMARY KEY(dep_no)    -- PK / FK �� �ؿ� ���� ����.
);

-- DEPT ���̺��� ��� �÷� �˻�
SELECT * FROM dept;

-- ���̺� ��ü ����
DROP TABLE dept;

-- ������ �Է�
-- INSERT INTO ���̺��(�÷���1, �÷���2, ~ �÷���n) VALUES(�Է� ������, �Է� ������, ~ �Է� ������)
INSERT INTO dept(dep_no, dep_name, loc) VALUES(10, '�ѹ���', '����');
INSERT INTO dept(dep_no, dep_name, loc) VALUES(20, '������', '�λ�');
INSERT INTO dept(dep_no, dep_name, loc) VALUES(30, '�����', '����');
INSERT INTO dept VALUES(40, '�����', '����');  -- �÷� ������ �ԷµǸ� ���� ����

-- INSERT ����
COMMIT;

-- EMPLOYEE ���̺� ����
CREATE TABLE employee(
    emp_no      NUMBER(3)
    ,emp_name   VARCHAR2(20)    NOT NULL
    ,dep_no     NUMBER(3)
    ,jikup      VARCHAR2(20)    NOT NULL
    ,salary     NUMBER(9)       DEFAULT 0
    ,hire_date  DATE            DEFAULT SYSDATE   -- SYSDATE : ���� �ð�
    ,jumun_num  CHAR(13)        NOT NULL UNIQUE
    ,phone      VARCHAR2(20)    NOT NULL
    ,mgr_emp_no NUMBER(2)

    ,PRIMARY KEY(emp_no)
    ,FOREIGN KEY(dep_no) REFERENCES dept(dep_no)
    ,CONSTRAINT employee_mgr_emp_no_fk FOREIGN KEY(mgr_emp_no) REFERENCES employee(emp_no)
      -- CONSTRAINT : ���� ���� �̸� ���, ���� ���� ����ȭ ��Ű�� ���Ͽ�
);

SELECT * FROM employee;

-- ����Ŭ ��¥ ����: ��-������-�⵵
-- ��¥ �����ʹ� '��-��-��'�� �Է� �����ϰ� �ϱ�
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- FK �������� ����
ALTER TABLE employee DISABLE CONSTRAINT employee_mgr_emp_no_fk;

-- TO_DATE ��ȯ�Լ� ����Ͽ� ��¥ �Է�
INSERT INTO employee VALUES( 1, 'ȫ�浿', 10, '����', 5000, to_date('1980-01-01','YYYY-MM-DD'), '7211271109410', '01099699515', NULL);

INSERT INTO employee VALUES( 1, 'ȫ�浿', 10, '����', 5000, '1980-01-01', '7211271109410', '01099699515', NULL);
INSERT INTO employee VALUES( 2, '�ѱ���', 20, '����', 3000, '1988-11-01', '6002061841224', '01024948424', 1);
INSERT INTO employee VALUES( 3, '�̼���', 20, '����', 3500, '1989-03-01', '6209172010520', '01026352672', 2);
INSERT INTO employee VALUES( 4, '�̶̹�', 30, '�븮', 2503, '1983-04-01', '8409282070226', '01094215694', 17 );
INSERT INTO employee VALUES( 5, '�̼���', 20, '���', 1200, '1990-05-01', '8401041483626', '01028585900', 3 );
INSERT INTO employee VALUES( 6, '���θ�', 30, '����', 4003, '1995-05-01', '8402121563616', '01191338328', 17 );
INSERT INTO employee VALUES( 7, '��⸸', 20, '����', 2300, '1996-06-01', '8011221713914', '01029463523', 2 );
INSERT INTO employee VALUES( 8, 'ä��ȭ', 30, '�븮', 1703, '1992-06-01', '8105271014112', '01047111052', 17 );
INSERT INTO employee VALUES( 9, '����ȭ', 10, '���', 1100, '1984-08-01', '8303291319116', '01025672300', 12 );
INSERT INTO employee VALUES( 10, '������', 30, '���', 1303, '1988-11-01', '8410031281312', '01027073174', 4 );
INSERT INTO employee VALUES( 11, '������', 20, '����', 1600, '1989-12-01', '8409181463545', '01071628290', 2 );
INSERT INTO employee VALUES( 12, '������', 10, '�븮', 1800, '1990-10-01', '8207211661117', '01042072622', 20 );
INSERT INTO employee VALUES( 13, '����ȭ', 10, '����', 3000, '1996-11-01', '8603231183011', '01098110955', 1 );
INSERT INTO employee VALUES( 14, 'ä�ö�', 20, '���', 3400, '1993-10-01', '8001172065410', '01044452437', 3 );
INSERT INTO employee VALUES( 15, '������', 10, '���', 2000, '1991-04-01', '8303101932611', '01027491145', 12 );
INSERT INTO employee VALUES( 16, '������', 30, '���', 4000, '1981-04-01', '7912031009014', '01098218448', 4 );
INSERT INTO employee VALUES( 17, '�̼���', 30, '����', 2803, '1984-05-01', '8102261713921', '0165358075', 1 );
INSERT INTO employee VALUES( 18, '������', 30, '���', 1003, '1986-07-01', '8203121977315', '01033583130', 4 );
INSERT INTO employee VALUES( 19, '�Ӳ���', 20, '���', 2200, '1988-04-01', '8701301040111', '01086253078', 7 );
INSERT INTO employee VALUES( 20, '������', 10, '����', 4500, '1990-05-01', '8811232452719', '01090084876', 13 );


-- EMPLOYEE ���̺� ������ ����
DELETE FROM employee;

-- FK �������� �ѱ�
ALTER TABLE employee DISABLE CONSTRAINT employee_mgr_emp_no_fk;

-- customer(��) ���̺� ����
CREATE TABLE customer(
    cus_no      NUMBER(2)
    ,cus_name   VARCHAR2(20)    NOT NULL
    ,tel_num    VARCHAR2(20)    NOT NULL
    ,jumin_num  CHAR(13)        NOT NULL UNIQUE
    ,emp_no     NUMBER(3)

    ,PRIMARY KEY(cus_no)
    ,FOREIGN KEY(emp_no) REFERENCES employee(emp_no)
);

-- customer ���̺� �˻�
SELECT * FROM customer;

-- salary_grade ���̺� ����
CREATE TABLE salary_grade (
    sal_grade_no    NUMBER(2)
    ,min_salary     NUMBER(9)   NOT NULL
    ,max_salary     NUMBER(9)   NOT NULL

    ,PRIMARY KEY(sal_grade_no)
);

-- salary_grade ���̺� �˻�
SELECT * FROM salary_grade;