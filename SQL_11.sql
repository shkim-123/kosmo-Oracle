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
SELECT ROWNUM, zxc.* FROM (
  SELECT CASE WHEN print_level > 0 THEN LPAD('��', print_level+LENGTH(subject), ' ')
            END||subject "SUBJECT"
            , writer
            , TO_CHAR(reg_date, 'YYYY-MM-DD') "REG_DATE"
            , readcount
  FROM board
  ORDER BY group_no, print_no DESC
) zxc ORDER BY ROWNUM DESC


SELECT ROWNUM, zxc.* FROM (
SELECT * FROM employee ORDER BY emp_no DESC
) zxc ORDER BY ROWNUM DESC