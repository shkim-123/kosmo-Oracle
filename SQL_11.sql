CREATE TABLE board(
        b_no           number(9)                         -- �Խ��� �� ������ȣ

        , subject      varchar2(50)   NOT NULL           -- �� ����
        , writer       varchar2(30)   NOT NULL           -- �۾��� �̸�
        , content      varchar2(2000) NOT NULL           -- �� ����
        , pwd          varchar2(12)   NOT NULL           -- ��ȣ
        , email        varchar2(30)                      -- �̸���

        , reg_date     date           DEFAULT SYSDATE    -- �����
        , readcount    number(5)      DEFAULT 0          -- ��ȸ��

        , group_no     number(9)      NOT NULL           -- �Խ��� ���� �Ҽ� �׷��ȣ
        , print_no     number(9)      NOT NULL           -- ���� �׷��ȣ ������ ȭ�� ��� ���� ��ȣ
        , print_level  number(9)      NOT NULL           -- ���� �׷��ȣ ������ ��� �鿩���� ���� �ܰ� ��ȣ

        , PRIMARY KEY(b_no)        -- �Խ��� �� ������ȣ PK
);

SELECT * FROM board;

-- 166
INSERT INTO board(b_no, subject, writer, content, pwd, email, group_no, print_no, print_level)
VALUES((SELECT NVL(MAX(b_no), 0)+1 FROM board)
    , '11�� ��� ����սô�.', '���', '��¼�� ��¼��', '1234', 'hwon@naver.com'
    , (SELECT NVL(MAX(b_no), 0)+1 FROM board)
    , 0
    , 0
)

-- 167
-- �θ���� ��ȸ���� 1 ������Ʈ�ϱ�
UPDATE board SET readcount = readcount + 1 WHERE b_no = 1;

-- ������ ������ ���� ��¼�����ȣ�� 1 ������Ʈ �ϱ�
UPDATE board SET print_no = print_no + 1
    WHERE group_no = (SELECT group_no FROM board WHERE b_no = 1)
        AND print_no > (SELECT print_no FROM board WHERE b_no = 1);
    -- group_no = b_no �� 1���� ���� �׷��ȣ
    -- print_no > b_no �� 1���� ���� ��¼�����ȣ


-- ��� �Է��ϱ�
INSERT INTO board(b_no, subject, writer, content, pwd, email, group_no, print_no, print_level)
VALUES((SELECT NVL(MAX(b_no), 0)+1 FROM board)
    , '�½��ϴ�. �����սô�', '����', '��¼�� ��¼��', '2345', 'min@naver.com'
    , (SELECT group_no FROM board WHERE b_no = 1)       -- b_no�� 1���� ���� �׷��ȣ
    , (SELECT print_no+1 FROM board WHERE b_no = 1)     -- b_no�� 1���� ���� ��¼�����ȣ�� 1 ���Ѱ�
    , (SELECT print_level+1 FROM board WHERE b_no = 1)  -- b_no�� 1���� ���� �鿩�����ȣ�� 1 ���Ѱ�
)

-- 168. �Խ����� ��� ���� ����ϸ�?
-- ��µǴ� �����ʹ� �ܼ�������ȣ, ����, �۾���, �ۼ���(��-��-��), ��ȸ�� �̴�.
-- ���� ������ �׷��ȣ ��������, ��¼�����ȣ �������� �̴�.
-- �鿩����� print_level �÷� ���� �����͸� ������ �鿩���⸦ ǥ���Ͻʽÿ�.

-- ó�� �ۼ��� ����
SELECT ROWNUM, zxc.* FROM (
    SELECT CASE WHEN print_level > 0 THEN LPAD('��', print_level*6, ' ')
              END||subject "SUBJECT"
              , writer
              , TO_CHAR(reg_date, 'YYYY-MM-DD') "REG_DATE"
              , readcount
    FROM board
    ORDER BY group_no, print_no DESC
) zxc ORDER BY ROWNUM DESC


-- �ζ��κ信 CNT �߰��� ����
SELECT x.cnt - ROWNUM + 1  "��ȣ"
        , CASE WHEN print_level > 0 THEN LPAD('��', print_level*6, ' ')
        END||subject     "����"
        , writer         "�۾���"
        , TO_CHAR(reg_date, 'YYYY-MM-DD') "�ۼ���"
        , readcount      "��ȸ��"
FROM board, (SELECT COUNT(*) "CNT" FROM board) x
ORDER BY group_no DESC, print_no


-- ����
SELECT x.cnt - ROWNUM + 1  "��ȣ", b.*
FROM (
    SELECT
            LPAD(' ', print_level*5, ' ')||DECODE(print_no, 0, '', '��')||subject "������"
            , writer         "�۾���"
            , TO_CHAR(reg_date, 'YYYY-MM-DD') "�ۼ���"
            , readcount      "��ȸ��"
    FROM board
    ORDER BY group_no DESC, print_no
) b, (SELECT COUNT(*) CNT FROM board) x


commit


-- ���� ��ȣ ó��
-- 1
SELECT (SELECT COUNT(*) FROM employee) - ROWNUM + 1 "������ȣ"
        , ROWNUM  "������ȣ"
        , e.*
FROM employee e
-- �� ���� - ������ȣ + 1 -> ������ȣ
-- ��, ���������� �ݺ������� �۵��Ǵ� SQL���̶� ���ϰ� ���� �ɸ���.

-- 2
SELECT x.cnt - ROWNUM + 1 "������ȣ"
        , ROWNUM  "������ȣ"
        , e.*
FROM employee e, (SELECT COUNT(*) "CNT" FROM employee) x
-- �ζ��κ�� ó��