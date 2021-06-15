/*
-- ���̺� ���� ����
-- salary_grade�� �ƹ����� ����
-- customer > employee > dept�� FK�� �ɷ��־ �����ϴ� ������ �����ؾ� �Ѵ�. (���� ���ϴ� ���̺��� ���߿� ����)

-- salary_grade ���̺� ����
DROP TABLE salary_grade;
-- customer ���̺� ����
DROP TABLE customer;
-- employee ���̺� ����
DROP TABLE employee;
-- dept ���̺� ����
DROP TABLE dept;
-- emp_sq ������ ����
DROP SEQUENCE emp_sq;
-- cus_sq ������ ����
DROP SEQUENCE cus_sq;
*/

-- dept ���̺� ����
CREATE TABLE dept(
    dep_no      NUMBER(3)                        -- [�μ���ȣ] ���� �÷� ����. �ڷ����� ������
    ,dep_name   VARCHAR2(20)    NOT NULL UNIQUE  -- [�μ���] ���� �÷� ����. �ڷ����� ������. �������� �ʼ��Է�, �ߺ�����
    ,loc        VARCHAR2(20)    NOT NULL         -- [�μ���ġ] ���� �÷� ����. �ڷ����� ������. �������� �ʼ��Է�

    ,PRIMARY KEY(dep_no)            -- dep_np �÷��� primary key �����ϱ�. PK / FK �� �ؿ� ���� ����.
);

-- 4�� �� ������ �Է�
-- INSERT INTO ���̺��(�÷���1, �÷���2, ~ �÷���n) VALUES(�Է� ������, �Է� ������, ~ �Է� ������)
INSERT INTO dept(dep_no, dep_name, loc) VALUES(10, '�ѹ���', '����');
INSERT INTO dept(dep_no, dep_name, loc) VALUES(20, '������', '�λ�');
INSERT INTO dept(dep_no, dep_name, loc) VALUES(30, '�����', '����');
INSERT INTO dept VALUES(40, '�����', '����');  -- �÷� ������ �ԷµǸ� ���� ����
-- ���̺� �ԷµǴ� ��� ���� �����ʹ� '(�̱� ����) �� ���Ѵ�. "(���� ����) ��� �Ұ�!!!
-- INSERT INTO dept VALUES(50, "�����", "����");

-- dept ���̺��� ��� �÷��� ��� ���� �˻��ϱ�
SELECT * FROM dept;

-- dept ���̺��� dep_no�� 10�� ���� �˻��ϱ�
SELECT * FROM dept WHERE dep_no = 10;

-- employee ���̺��� PK ������ ����� �Ϸù�ȣ�� �����ϴ� ������ �����ϱ� (�Ϸ� ��ȣ �ڵ� ������)
-- ������ �̸� ��� ��Ģ: ���̺��_sq
CREATE SEQUENCE emp_sq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999;

-- employee ���̺� ����. ���� ������ ����Ǵ� ���̺��̴�.
CREATE TABLE employee(
    emp_no      NUMBER(3)                       -- [������ȣ]�� ����Ǵ� �÷� ����
    ,emp_name   VARCHAR2(20)    NOT NULL        -- [������]�� ����Ǵ� �÷� ����
    ,dep_no     NUMBER(3)                       -- [�ҼӺμ���ȣ]�� ����Ǵ� �÷� ����
    ,jikup      VARCHAR2(20)    NOT NULL        -- [����]�� ����Ǵ� �÷� ����. �������� �ʼ��Է�
    ,salary     NUMBER(9)       DEFAULT 0       -- [����]�� ����Ǵ� �÷� ����. �������� ���ָ� 0.
                                                -- DEFAULT �����ʹ� �ڷ���, �ڷ��� ũ�� ���� �ȿ� ����־�� �Ѵ�.
    ,hire_date  DATE            DEFAULT SYSDATE -- [�Ի���]�� ����Ǵ� �÷� ����. �������� ���ָ� ���� �ð�(SYSDATE)
    ,jumin_num  CHAR(13)        NOT NULL UNIQUE -- [�ֹι�ȣ]�� ����Ǵ� �÷� ����. �������� �����Է�, �ߺ��Ұ�
    ,phone      VARCHAR2(15)    NOT NULL        -- [��ȭ��ȣ]�� ����Ǵ� �÷� ����. �������� �ʼ��Է�
    ,mgr_emp_no NUMBER(3)                       -- [���ӻ��������ȣ]�� ����Ǵ� �÷� ����

    ,PRIMARY KEY(emp_no)                         -- [������ȣ] �÷��� PK �������� ����
    ,FOREIGN KEY(dep_no) REFERENCES dept(dep_no) -- [�ҼӺμ���ȣ] �÷��� FK �������� �ֱ�.
                                                 -- dept ���̺��� dep_no �÷� �����ϰ� �ϱ�
    ,CONSTRAINT employee_mgr_emp_no_fk FOREIGN KEY(mgr_emp_no) REFERENCES employee(emp_no)
      -- [���ӻ��������ȣ] �÷��� FK �������� �ֱ�. employee ���̺��� emp_no �÷� �����ϰ� �ϱ�
      -- CONSTRAINT : ���� ���� �̸� ���, ���� ���� ����ȭ ��Ű�� ���Ͽ�
);


-- employee_mgr_emp_no_fk ��� �̸��� FK �������� ����. ��, ���� ���� �ӽ� ����ȭ
-- ��ü�� ��������(����) �����̶� ALTER ���
ALTER TABLE employee DISABLE CONSTRAINT employee_mgr_emp_no_fk;

-- ����Ŭ ��¥ ����: ��-������-�⵵
-- ���� ���� �α����� ������ ��¥ �����ʹ� '��-��-��'�� ����ϰ� �ϱ�
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- employee ���̺� 20�� �� �Է��ϱ�
-- TO_DATE ��ȯ�Լ� ����Ͽ� ��¥ �Է�
-- INSERT INTO employee VALUES( 1, 'ȫ�浿', 10, '����', 5000, to_date('1980-01-01','YYYY-MM-DD'), '7211271109410', '01099699515', NULL);
-- ��� �ԷµǴ� �����ʹ� �������� ����Ѵ�.
-- ��, ���� ���� �� �Է� �� ������ �߻��� ��� ������ �ѹ��� ������ ���¶�, �Ϸù�ȣ�� �� ��찡 �ִ�.
INSERT INTO employee VALUES( emp_sq.nextval, 'ȫ�浿', 10, '����', 5000, '1980-01-01', '7211271109410', '01099699515', NULL);
INSERT INTO employee VALUES( emp_sq.nextval, '�ѱ���', 20, '����', 3000, '1988-11-01', '6002061841224', '01024948424', 1);
INSERT INTO employee VALUES( emp_sq.nextval, '�̼���', 20, '����', 3500, '1989-03-01', '6209172010520', '01026352672', 2);
INSERT INTO employee VALUES( emp_sq.nextval, '�̶̹�', 30, '�븮', 2503, '1983-04-01', '8409282070226', '01094215694', 17 );
INSERT INTO employee VALUES( emp_sq.nextval, '�̼���', 20, '���', 1200, '1990-05-01', '8401041483626', '01028585900', 3 );
INSERT INTO employee VALUES( emp_sq.nextval, '���θ�', 30, '����', 4003, '1995-05-01', '8402121563616', '01191338328', 17 );
INSERT INTO employee VALUES( emp_sq.nextval, '��⸸', 20, '����', 2300, '1996-06-01', '8011221713914', '01029463523', 2 );
INSERT INTO employee VALUES( emp_sq.nextval, 'ä��ȭ', 30, '�븮', 1703, '1992-06-01', '8105271014112', '01047111052', 17 );
INSERT INTO employee VALUES( emp_sq.nextval, '����ȭ', 10, '���', 1100, '1984-08-01', '8303291319116', '01025672300', 12 );
INSERT INTO employee VALUES( emp_sq.nextval, '������', 30, '���', 1303, '1988-11-01', '8410031281312', '01027073174', 4 );
INSERT INTO employee VALUES( emp_sq.nextval, '������', 20, '����', 1600, '1989-12-01', '8409181463545', '01071628290', 2 );
INSERT INTO employee VALUES( emp_sq.nextval, '������', 10, '�븮', 1800, '1990-10-01', '8207211661117', '01042072622', 20 );
INSERT INTO employee VALUES( emp_sq.nextval, '����ȭ', 10, '����', 3000, '1996-11-01', '8603231183011', '01098110955', 1 );
INSERT INTO employee VALUES( emp_sq.nextval, 'ä�ö�', 20, '���', 3400, '1993-10-01', '8001172065410', '01044452437', 3 );
INSERT INTO employee VALUES( emp_sq.nextval, '������', 10, '���', 2000, '1991-04-01', '8303101932611', '01027491145', 12 );
INSERT INTO employee VALUES( emp_sq.nextval, '������', 30, '���', 4000, '1981-04-01', '7912031009014', '01098218448', 4 );
INSERT INTO employee VALUES( emp_sq.nextval, '�̼���', 30, '����', 2803, '1984-05-01', '8102261713921', '0165358075', 1 );
INSERT INTO employee VALUES( emp_sq.nextval, '������', 30, '���', 1003, '1986-07-01', '8203121977315', '01033583130', 4 );
INSERT INTO employee VALUES( emp_sq.nextval, '�Ӳ���', 20, '���', 2200, '1988-04-01', '8701301040111', '01086253078', 7 );
INSERT INTO employee VALUES( emp_sq.nextval, '������', 10, '����', 4500, '1990-05-01', '8811232452719', '01090084876', 13 );

-- employee ���̺� ������ ����
-- DELETE FROM employee;

-- employee ���̺��� ��� �÷��� ��� ���� �˻��ϱ�
SELECT * FROM employee;

-- employee_mgr_emp_no_fk ��� �̸��� FK �������� �ѱ�. ��, ���� ���� �ӽ� Ȱ��ȭ
ALTER TABLE employee ENABLE CONSTRAINT employee_mgr_emp_no_fk;

-- customer ���̺��� PK ������ ����� �Ϸù�ȣ�� �����ϴ� ������ �����ϱ� (�Ϸ� ��ȣ �ڵ� ������)
-- ������ �̸� ��� ��Ģ: ���̺��_sq
CREATE SEQUENCE cus_sq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 999;


-- customer ���̺� ����, �� ������ ����Ǵ� ���̺��̴�.
-- �̸� ��� : �ʹ� �߻����� ��쿡�� cus_no ������ ����Ѵ�.
CREATE TABLE customer(
    cus_no      NUMBER(3)                        -- [����ȣ]�� ����Ǵ� �÷� ����
    ,cus_name   VARCHAR2(20)    NOT NULL         -- [����]�� ����Ǵ� �÷� ����. �������� �ʼ� �Է�
    ,tel_num    VARCHAR2(20)                     -- [��ȭ��ȣ]�� ����Ǵ� �÷� ����. �������� �ʼ� �Է�
    ,jumin_num  CHAR(13)        NOT NULL UNIQUE  -- [�ֹι�ȣ]�� ����Ǵ� �÷� ����. �������� �ʼ� �Է�, �ߺ� �Ұ�
    ,emp_no     NUMBER(3)                        -- [���������ȣ]�� ����Ǵ� �÷� ����

    ,PRIMARY KEY(cus_no)                             -- [����ȣ] �÷��� PK �������� ����
    ,FOREIGN KEY(emp_no) REFERENCES employee(emp_no) -- [���������ȣ] �÷��� FK �������� ����.
                                                     -- employee ���̺��� emp_no �÷� �����ϰ� �ϱ�
);

-- customer ���̺� 10�� �� ������ �Է�
INSERT INTO customer VALUES(cus_sq.nextval, '������', '123-123', '7001131537915', 3);
INSERT INTO customer VALUES(cus_sq.nextval, '�̰���', '343-1454', '6902161627914', 2);
INSERT INTO customer VALUES(cus_sq.nextval, '�̿���', '144-1655', '7503202636215', NULL);
INSERT INTO customer VALUES(cus_sq.nextval, '��ö��', '673-1674', '7704301234567', 4);
INSERT INTO customer VALUES(cus_sq.nextval, '�ڷ���', '123-1674', '7205211123675', 3);
INSERT INTO customer VALUES(cus_sq.nextval, '��ĵ��', '673-1764', '6507252534566', NULL);
INSERT INTO customer VALUES(cus_sq.nextval, '�Ŷ���', '176-7677', '0006083648614', 7);
INSERT INTO customer VALUES(cus_sq.nextval, '���赹', '673-6774', '0008041346574', 9);
INSERT INTO customer VALUES(cus_sq.nextval, '��ȫ��', '767-1234', '7312251234689', 13);
INSERT INTO customer VALUES(cus_sq.nextval, '��ȳ�', '767-1677', '7510152432168', 4);

-- customer ���̺��� ��� �÷��� ��� ���� �˻��ϱ�
SELECT * FROM customer;

-- customer ���̺��� ��� �÷��� ��� �� �����ϱ�
-- DELETE FROM customer;

-- salary_grade ���̺� ����. ���� ����� �����ϴ� ���̺��̴�.
CREATE TABLE salary_grade (
    sal_grade_no    NUMBER(2)             -- [�������]�� ����Ǵ� �÷� ����
    ,min_salary     NUMBER(5)   NOT NULL  -- [��������]�� ����Ǵ� �÷� ����. �������� �ʼ� �Է�
    ,max_salary     NUMBER(5)   NOT NULL  -- [�ְ���]�� ����Ǵ� �÷� ����. �������� �ʼ� �Է�

    ,PRIMARY KEY(sal_grade_no)            -- [�������] �÷��� PK �������� ����
);

-- salary_grade ���̺� 5�� �� ������ �Է�
INSERT INTO salary_grade VALUES(1, 8000, 10000);
INSERT INTO salary_grade VALUES(2, 6000, 7999);
INSERT INTO salary_grade VALUES(3, 4000, 5999);
INSERT INTO salary_grade VALUES(4, 2000, 3999);
INSERT INTO salary_grade VALUES(5, 1000, 1999);

-- salary_grade ���̺��� ��� �÷��� ��� ���� �˻��ϱ�
SELECT * FROM salary_grade;

-- salary_grade ���̺� ��� �÷��� ��� �� �����ϱ�
-- DELETE FROM salary_grade;

-- INSERT ����
COMMIT;
