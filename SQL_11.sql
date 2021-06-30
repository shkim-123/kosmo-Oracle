CREATE TABLE board(
        b_no           number(9)                         -- 게시판 글 고유번호

        , subject      varchar2(50)   NOT NULL           -- 글 제목
        , writer       varchar2(30)   NOT NULL           -- 글쓴이 이름
        , content      varchar2(2000) NOT NULL           -- 글 내용
        , pwd          varchar2(12)   NOT NULL           -- 암호
        , email        varchar2(30)                      -- 이메일

        , reg_date     date           DEFAULT SYSDATE    -- 등록일
        , readcount    number(5)      DEFAULT 0          -- 조회수

        , group_no     number(9)      NOT NULL           -- 게시판 글의 소속 그룹번호
        , print_no     number(9)      NOT NULL           -- 같은 그룹번호 내에서 화면 출력 순서 번호
        , print_level  number(9)      NOT NULL           -- 같은 그룹번호 내에서 댓글 들여쓰기 레벨 단계 번호

        , PRIMARY KEY(b_no)        -- 게시판 글 고유번호 PK
);

SELECT * FROM board;

-- 166
INSERT INTO board(b_no, subject, writer, content, pwd, email, group_no, print_no, print_level)
VALUES((SELECT NVL(MAX(b_no), 0)+1 FROM board)
    , '11월 모두 취업합시다.', '희원', '어쩌구 저쩌구', '1234', 'hwon@naver.com'
    , (SELECT NVL(MAX(b_no), 0)+1 FROM board)
    , 0
    , 0
)

-- 167
-- 부모글의 조회수를 1 업데이트하기
UPDATE board SET readcount = readcount + 1 WHERE b_no = 1;

-- 밑으로 내리는 글의 출력순서번호를 1 업데이트 하기
UPDATE board SET print_no = print_no + 1
    WHERE group_no = (SELECT group_no FROM board WHERE b_no = 1)
        AND print_no > (SELECT print_no FROM board WHERE b_no = 1);
    -- group_no = b_no 가 1번인 글의 그룹번호
    -- print_no > b_no 가 1번인 글의 출력순서번호


-- 댓글 입력하기
INSERT INTO board(b_no, subject, writer, content, pwd, email, group_no, print_no, print_level)
VALUES((SELECT NVL(MAX(b_no), 0)+1 FROM board)
    , '맞습니다. 열공합시다', '영민', '어쩌구 저쩌구', '2345', 'min@naver.com'
    , (SELECT group_no FROM board WHERE b_no = 1)       -- b_no가 1번인 글의 그룹번호
    , (SELECT print_no+1 FROM board WHERE b_no = 1)     -- b_no가 1번인 글의 출력순서번호에 1 더한거
    , (SELECT print_level+1 FROM board WHERE b_no = 1)  -- b_no가 1번인 글의 들여쓰기번호에 1 더한거
)

-- 168. 게시판의 모든 글을 출력하면?
-- 출력되는 데이터는 단순역순번호, 제목, 글쓴이, 작성일(년-월-일), 조회수 이다.
-- 정렬 기준은 그룹번호 내림차순, 출력순서번호 오름차순 이다.
-- 들여쓰기는 print_level 컬럼 안의 데이터를 가지고 들여쓰기를 표현하십시오.

-- 처음 작성한 쿼리
SELECT ROWNUM, zxc.* FROM (
    SELECT CASE WHEN print_level > 0 THEN LPAD('ㄴ', print_level*6, ' ')
              END||subject "SUBJECT"
              , writer
              , TO_CHAR(reg_date, 'YYYY-MM-DD') "REG_DATE"
              , readcount
    FROM board
    ORDER BY group_no, print_no DESC
) zxc ORDER BY ROWNUM DESC


-- 인라인뷰에 CNT 추가한 쿼리
SELECT x.cnt - ROWNUM + 1  "번호"
        , CASE WHEN print_level > 0 THEN LPAD('ㄴ', print_level*6, ' ')
        END||subject     "제목"
        , writer         "글쓴이"
        , TO_CHAR(reg_date, 'YYYY-MM-DD') "작성일"
        , readcount      "조회수"
FROM board, (SELECT COUNT(*) "CNT" FROM board) x
ORDER BY group_no DESC, print_no


-- 정답
SELECT x.cnt - ROWNUM + 1  "번호", b.*
FROM (
    SELECT
            LPAD(' ', print_level*5, ' ')||DECODE(print_no, 0, '', 'ㄴ')||subject "글제목"
            , writer         "글쓴이"
            , TO_CHAR(reg_date, 'YYYY-MM-DD') "작성일"
            , readcount      "조회수"
    FROM board
    ORDER BY group_no DESC, print_no
) b, (SELECT COUNT(*) CNT FROM board) x


commit


-- 역순 번호 처리
-- 1
SELECT (SELECT COUNT(*) FROM employee) - ROWNUM + 1 "역순번호"
        , ROWNUM  "정순번호"
        , e.*
FROM employee e
-- 총 개수 - 정순번호 + 1 -> 역순번호
-- 단, 서브쿼리를 반복적으로 작동되는 SQL문이라서 부하가 많이 걸린다.

-- 2
SELECT x.cnt - ROWNUM + 1 "역순번호"
        , ROWNUM  "정순번호"
        , e.*
FROM employee e, (SELECT COUNT(*) "CNT" FROM employee) x
-- 인라인뷰로 처리