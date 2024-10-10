
SELECT * FROM examples;
-- 테이블 구조 확인하는 명령어
PRAGMA table_info('examples')

-- 1. 새로운 테이블 생성
CREATE TABLE examples (
  ExamId INTEGER PRIMARY KEY AUTOINCREMENT,  -- 자동으로 증가하는 pk
  LastName VARCHAR(50) NOT NULL,-- LastName(필드명), 최대 50자, 필수로 입력
  FirstName VARCHAR(50) NOT NULL -- FirstName(필드명), 최대 50자, 필수로 입력
);
-- 2. 테이블 필드 수정
-- 2.1 열(필드) 추가
ALTER TABLE
  examples
ADD COLUMN
  Country VARCHAR(100) NOT NULL DEFAULT 'default value';
  -- Country 열 추가, 기본값 설정

-- Sqlite는 한번에 여러열을 추가할 수 없다. 그래서 각각 추가해야 한다.
ALTER TABLE examples
ADD COLUMN Age INTEGER NOT NULL DEFAULT 0;
-- 필드명, 데이터타입, 필수 입력, 기본값 0 


ALTER TABLE examples
ADD COLUMN Address VARCHAR(100) NOT NULL DEFAULT 'default value';
-- Address 열 추가, 필수 입력, 기본값 설정

-- 2.2 열 이름 변경
ALTER TABLE examples
RENAME COLUMN Address TO PostCode;
-- Address 열을 PostCode로 이름 변경

-- 2.3 열 삭제
ALTER TABLE examples
DROP COLUMN PostCode;
-- PostCode 열 삭제

-- 2.4 테이블 이름 변경
ALTER TABLE examples
RENAME TO new_examples;
-- examples 테이블을 new_examples로 테이블 이름 변경

-- 3. 테이블 삭제
DROP TABLE new_examples;

DROP TABLE examples;



-- sqlite는 컬럼 수정 불가
-- 대신 테이블의 이름을 바꾸고, 새 테이블을 만들고 데이터를 새 테이블에 복사하는 방식을 사용
