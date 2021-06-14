-- 계정 생성
CREATE USER king IDENTIFIED BY k123;

-- 권한 부여 (SYSTEM과 비슷한 권한)
GRANT CONNECT, RESOURCE,DBA TO king;