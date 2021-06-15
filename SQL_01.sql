-- king 계정 생성
CREATE USER king IDENTIFIED BY k123;

-- king 계정에 system 과 비슷한 권한 부여
GRANT CONNECT, RESOURCE,DBA TO king;