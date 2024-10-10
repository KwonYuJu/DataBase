-- 공통 : 테이블 조회, 삭제, 구조 확인
SELECT * FROM articles;

SELECT * FROM users;

DROP TABLE articles;

DROP TABLE users;

PRAGMA table_info('articles');

-- 1. articles 테이블, users 테이블 생성(관계형 테이블 구조)
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT, -- 자동으로 증가하는 pk
  name VARCHAR(50) NOT NULL -- 사용자 이름, 최대 50자, 필수 입력
);

CREATE TABLE articles(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title VARCHAR(50) NOT NULL,
  content VARCHAR(100) NOT NULL,
  userId INTEGER NOT NULL, -- 작성자 id
  FOREIGN KEY (userId) -- 외래키 설정
    REFERENCES users(id) -- users테이블의 id(pk)를 참조
)

INSERT INTO
  users (name)
VALUES
  ('하석주'),
  ('송윤미'),
  ('유하선');

INSERT INTO
  articles (title, content, UserId)
VALUES
  ('제목1', '내용1', 1),
  ('제목2', '내용2', 2),
  ('제목3', '내용3', 1),
  ('제목4', '내용4', 4), -- 주의 : userId 4는 users테이블에 없음!
  ('제목5', '내용5', 1);

-- INNER JOIN : 두 테이블의 일치하는 데이터만 결합
SELECT * FROM articles
INNER JOIN users
  ON users.id = articles.userId;

-- MISSION : INNER JOIN 후 특정 사용자(user.id = 1)인 글의 제목과 이름 조회
SELECT articles.title, users.name
FROM articles
INNER JOIN users
  ON users.id = articles.userId
WHERE users.id = 1;

-- LEFT JOIN : 왼쪽 테이블(articles) 모든 데이터와, 오른쪽 테이블(users)
-- 일치하는 데이터를 결합(만약에 userId가 4인 경우는 NULL 값으로)
SELECT * FROM articles
LEFT JOIN users
  ON users.id = articles.'userId';
-- 큰따옴표나 작은따옴표 넣는경우 2가지
-- 1. 문자열 값 표현할때 WHERE name = "John"
-- 2. 테이블 명(또는 필드명)이 공백이있거나 특수문자가 있는 경우 "articles table"

-- MISSION : 글이 없는 사용자 찾기
SELECT * FROM articles
LEFT JOIN users
  ON users.id = articles.userId;
WHERE articles.userId IS NULL;

-- mission : 게시글을 작성한 이력이 없는 회원정보 조회
SELECT users.name
FROM users
LEFT JOIN articles
  ON articles.userId = users.id
WHERE articles.userId IS NULL;
