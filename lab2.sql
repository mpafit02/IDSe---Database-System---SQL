DROP TABLE book_author;
DROP TABLE author;
DROP TABLE book;
DROP TABLE category;

CREATE TABLE category (
	category_id NUMBER(8) PRIMARY KEY,
	category_name VARCHAR2(32) NOT NULL
);
CREATE TABLE book (
	isbn NUMBER(13) PRIMARY KEY,
	title VARCHAR2(128) NOT NULL,
	category_id REFERENCES category(category_id)
);
CREATE TABLE author (
	id NUMBER(8) PRIMARY KEY,
	family_name VARCHAR2(32) NOT NULL,
	given_names VARCHAR2(32),
	born DATE
);
CREATE TABLE book_author (
	book_isbn REFERENCES book(isbn),
	author_id REFERENCES author(id),
	PRIMARY KEY (book_isbn, author_id)
);
INSERT INTO author VALUES (1, 'Windham', 'John', DATE '1903-06-10');
INSERT INTO author VALUES (2, 'Steinbeck', 'John', DATE '1902-02-27');
INSERT INTO author VALUES (3, 'Kerouac', 'Jack', DATE '1922-03-12');

insert into book values(12345,'Handbook of the C language', NULL);
update book set title = 'Handbook of the C language' where isbn = 12345;

SELECT title, isbn FROM book WHERE title LIKE 'Handbook of %';

SELECT given_names FROM author;
--Remove dublicate values
SELECT DISTINCT given_names FROM author;

--Ascending order
SELECT family_name, given_names FROM author
ORDER BY family_name ASC, given_names ASC;

--Descending order
SELECT family_name, given_names FROM author
ORDER BY family_name DESC, given_names ASC;

SELECT family_name, given_names FROM author
ORDER BY family_name DESC, given_names DESC;

-- ORacle
SELECT * FROM (
SELECT DISTINCT family_name FROM author ORDER BY family_name DESC)
WHERE ROWNUM <= 2;
 
-- MySCL
-- SELECT DISTINCT family_name FROM author ORDER BY family_name DESC
-- LIMIT 2;

SELECT given_names, count(*) AS number_of_authors 
FROM author GROUP BY given_names;

-- Epipleon elegxos
SELECT given_names, count(*) AS number_of_authors 
FROM author GROUP BY given_names
HAVING count(*) >= 2
ORDER BY number_of_auhors DESC;

INSERT INTO category VALUES (1,'Fiction');
INSERT INTO category VALUES (2,'Fantacy');
INSERT INTO category VALUES (3,'Document');
UPDATE book SET category_id = 1 WHERE isbn=12345;

-- ME TO INNER I XORIS EINAI TO IDIO
--SELECT isbn, title, category_name FROM book NATURAL JOIN category;
--SELECT isbn, title, category_name FROM book NATURAL INNER JOIN category;
--SELECT isbn, title, category_name FROM book NATURAL RIGHT OUTER JOIN category;
--SELECT isbn, title, category_name FROM book INNER JOIN category USING (category_id);
--SELECT isbn, title, category_name FROM book JOIN category ON (book.category_id = category.category_id);
--Cartesian Product Both are the same
SELECT isbn, title, category_name FROM book CROSS JOIN category WHERE book.category_id = category.category_id;
SELECT isbn, title, category_name FROM book, category WHERE book.category_id = category.category_id;

SELECT given_names, family_name FROM author a1 WHERE NOT EXISTS (
	SELECT 1 FROM author a2 WHERE a2.family_name > a1.family_name
);