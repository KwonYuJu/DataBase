-- 1번. 단일 데이터 조회하기

-- employees 테이블에서 LastName 필드만 선택
SELECT
  LastName, FirstName
FROM
  employees;

-- employess 테이블에서 모든 필드를 다 조회하고 싶다.
SELECT
  *
FROM
  employees;

-- 별칭

SELECT
  FirstName AS '이름'
FROM
  employees;

-- 밀리초를 분으로 변환
SELECT
  Name,
  Milliseconds / 60000 AS '재생 시간(분)'
FROM
  tracks;

-- ORDER BY는 오름차순 정렬(python에서 sort()와 같다)
SELECT
  FirstName
FROM
  employees
ORDER BY
  FirstName;

-- 내림차순 정렬은 DESC(python에서 sort(reverse=True)와 같다)
SELECT
  FirstName
FROM
  employees
ORDER BY
  FirstName DESC;

-- Country는 내림차순 정렬, 같은 Country내에서는 City를 오름차순 정렬
SELECT
  Country, City
FROM
  customers
ORDER BY
  Country DESC,
  City;

-- 정렬을 계산된 값을 기준으로 정렬도 가능하다.
SELECT
  Name,
  Milliseconds / 60000 AS '재생 시간(분)'
FROM
  tracks
ORDER BY
  Milliseconds DESC;

-- NULL은 '값이 없음'을 의미 (python의 None과 같다)
SELECT
  postalCode
FROM
  customers
ORDER BY
  PostalCode;

-- DISTINCT :중복 제거
SELECT DISTINCT
  Country
FROM
  customers
ORDER BY
  Country;

-- WHERE은 조건을 지정(python에서 if문이나 리스트 컴프리헨션 조건부와 비슷)
-- City가 'Prague'인 고객만 선택
SELECT
  LastName, FirstName, City
FROM
  customers
WHERE
  city = 'Prague';

-- City가 'Prague'가 아닌 고객만 선택
SELECT
  LastName, FirstName, City
FROM
  customers
WHERE
  city != 'Prague';

-- AND는 두 조건을 모두 만족(python의 and 연산자와 비슷)
-- Company는 NULL값이고, Country는 'USA'
SELECT
  LastName, FirstName, Company, Country
FROM
  customers
WHERE
  Company IS NULL
  AND Country = 'USA';

-- OR는 두 조건중 하나만 만족(python의 or 연산자와 비슷)
-- Company가 NULL값이거나 Country는 'USA'
SELECT
  LastName, FirstName, Company, Country
FROM
  customers
WHERE
  Company IS NULL
  OR Country = 'USA';

-- BETWEEN은 범위지정 100000이상, 500000이하
SELECT
  Name, Bytes
FROM
  tracks
WHERE
  Bytes BETWEEN 100000 AND 500000;

-- 범위 내의 값을 선택하고 정렬
SELECT
  Name, Bytes
FROM
  tracks
WHERE
  Bytes BETWEEN 100000 AND 500000
ORDER BY
  Bytes;

-- IN은 여러값중에 하나와 일치하는지 확인(python 의 맴버쉽 연산자와 비슷)
SELECT
  LastName, FirstName, Country
FROM
  customers
WHERE
  Country IN ('Canada', 'Germany', 'France');

-- NOT IN은 여러값 과 일치하지 않는지 확인(python 의 맴버쉽 연산자와 비슷)
SELECT
  LastName, FirstName, Country
FROM
  customers
WHERE
  Country NOT IN ('Canada', 'Germany', 'France');

-- 패턴매칭 LIKE
-- ex) LastName이 son으로 끝나는 단어(%)
SELECT
  LastName, FirstName
FROM
  customers
WHERE
  LastName LIKE '%son'

-- '_'는 한글자를 의미
SELECT
  LastName, FirstName
FROM
  customers
WHERE
  FirstName LIKE '___a';

--LIMIT 결과의 개수 제한
SELECT
  TrackId, Name, Bytes
FROM
  tracks
ORDER BY Bytes DESC -- 내림차순 정렬
LIMIT 7; -- 큰 값 7개

-- LIMIT 두 개의 인자 줄때, 천 번째 인자 시작 위치, 두 번째 인자 개수
SELECT
  TrackId, Name, Bytes
FROM
  tracks
ORDER BY
  Bytes DESC
LIMIT 3, 4;

-- 국가별로 그룹화 한다(같은 Country를 가진 객체를 하나의 그룹으로 묶는다).
-- 그 다음에 COUNT(*) 각 그룹내의 객체의 개수를 센다.
SELECT
  Country, COUNT(*)
FROM
  customers
GROUP BY
  Country;

-- AVG()는 평균을 계산
SELECT
  Composer,
  AVG(Bytes) AS avgOfBytes
FROM
  tracks
GROUP BY
  Composer
ORDER BY
  AVG(Bytes) DESC;

-- 이 쿼리는 error ---> WHERE에서는 집계 함수 결과를 사용할수 없다.
SELECT
  Composer,
  AVG(Milliseconds / 60000) AS avgOfMinute
FROM
  tracks
WHERE
  avgOfMinute < 10
GROUP BY
  Composer;

-- HAVING
SELECT
  Composer,
  AVG(Milliseconds / 60000) AS avgOfMinute
FROM
  tracks
GROUP BY
  Composer
HAVING
  avgOfMinute < 10;

-- 과일가게가 있는데 손님이 "평균가격이 5000원 미만인 과일을 담아주세요"
-- 1단계 : 과일 종료별로 그룹지어야 한다(사과, 배, 파인애플 ....)
-- 2단계 : 각 그룹의 평균 가격을 계산
-- 3단계 : 마지막으로 평균가격이 5000원 미만인 그룹을 선택

-- WHERE을 쓴다? 그룹짓기 전에(1단계 전에) 아직 평균가격을 모르는 상태에서 필터링?
-- 안된다!! 에러가난다.
-- HAVING 2단계 후에 평균가격을 알고있는 상태에서 필티링
-- 만약 AVG같은 집계함수의 결과를 필터링 하고싶다 ---> 무조건 HAVING