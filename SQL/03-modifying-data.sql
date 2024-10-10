-- 공통 : 테이블 전체 조회, 테이블 삭제, 테이블 구조 확인

-- 테이블 전체 조회
SELECT * FROM articles;
-- 테이블 삭제
DROP TABLE articles;
-- 테이블 구조 확인
PRAGMA table_info('articles')


-- 1. 테이블에 데이터 삽입
-- 새로운 테이블 articles 생성
CREATE TABLE articles (
  id INTEGER PRIMARY KEY AUTOINCREMENT, -- 자동으로 증가하는 pk
  title VARCHAR(100) NOT NULL, --- 제목 열, 최대 100자, 필수 입력
  content VARCHAR(200) NOT NULL, --- 내용 열, 최대 200자, 필수 입력
  createAt DATE NOT NULL -- 생성일 열, 날짜 형식, 필수 입력
);

-- 행 삽입과 열 추가 차이는 행 삽입은 여러 행을 한번에 삽입 가능
INSERT INTO
  articles (title, content, createAt)
VALUES
  ('hello', 'world', '2000-01-01'); -- 각 열에 해당하는 값 입력

INSERT INTO
  articles (title, content, createAt)
VALUES
  ('title1', 'content1', '1900-01-01'),
  ('title2', 'content2', '1800-01-01'),
  ('title3', 'content3', '1700-01-01');

-- 현재 날짜를 사용하여 행 삽입
INSERT INTO
  articles (title, content, createAt)
VALUES
  ('title4', 'content4', DATE()); --DATE() 함수는 현재 날짜를 반환


-- 2. 테이블의 데이터 수정(Update)
-- 단일 열 수정
UPDATE
  articles
SET
  title = 'update Title'
WHERE
  id = 1; -- id가 1인 행만 title열의 값을 update Title로 변경


-- 여러 열 수정
UPDATE
  articles
SET
  title = 'update Title',
  content = 'update Content' -- title, content값이 동시에 변경
WHERE
  id = 2; -- id가 2인 행만 수정

-- 3. 테이블에서 데이터 삭제(Delete)
-- 단일 행 삭제(행을 삭제할때는 DELETE로 삭제)
DELETE FROM
  articles
WHERE
  id = 1; -- id가 1인 행을 삭제


-- Mission : 생성일 기준으로 정렬하고 가장 오래된 2개의 행을 삭제
-- 1. 먼저 삭제할 ID 찾고, 2. 그다음에 찾은 ID 사용(IN)해서 삭제(DLETE)
-- 서브쿼리를 사용한 복합 삭제(1번 과정 삭제)
-- 서브쿼리 : SQL 쿼리 내부에 포함된 쿼리(중첩)

-- SELECT id
-- FROM articles
-- ORDER BY createAt
-- LIMIT 2;

DELETE FROM
  articles
WHERE id IN (
  SELECT id FROM articles
  ORDER BY createAt -- 생성일 기준으로 정렬
  LIMIT 2 -- 가장 오래된 2개의 행을 삭제
);