-- Active: 1695101968780@@127.0.0.1@3306@final

CREATE DATABASE IF NOT EXISTS Final;

USE Final;

CREATE TABLE IF NOT EXISTS Student (
    Stu_ID VARCHAR(10) PRIMARY KEY,
    Stu_Name VARCHAR(20),
    Age VARCHAR(2),
    Course VARCHAR(10),
    Academic_level VARCHAR(10)
);

ALTER TABLE student
MODIFY COLUMN Course VARCHAR(30);

CREATE TABLE IF NOT EXISTS Teacher (
    Teacher_ID VARCHAR(10) PRIMARY KEY,
    Teacher_Name VARCHAR(20),
    Teacher_Desig VARCHAR(20)
);

-- DROP TABLE student;
-- DROP TABLE department;

CREATE TABLE IF NOT EXISTS Department (
    Dept_ID VARCHAR(10),
    Dept_Name VARCHAR(20),
    Tech_ID VARCHAR(10),
    FOREIGN KEY (Tech_ID)
        REFERENCES Teacher (Teacher_ID)
        ON DELETE CASCADE,
    StudID VARCHAR(10),
    FOREIGN KEY (StudID)
        REFERENCES Student (Stu_ID)
        ON DELETE CASCADE
);

INSERT INTO student
VALUES("Arch-02","Shahreen",24,"Architect","BSc"),
("CSE-01","Shawon",28,"Programming","MSc"),
("CSE-03","Shapnil",23,"Data Analytics","BSc"),
("CSE-05","Robin",28,"Data Analytics","BSc"),
("CSE-06","Nadim",27,"Programming","BSc"),
("CIV-07","Imran",29,"Civil","BSc"),
("Mark-08","Faysal",22,"Marketing","Hons"),
("Mark-09","Sharif",21,"Marketing","Hons"),
("BBA-04","Real",28,"Business Administration","BBA"),
("BBA-10","Shakil",20,"Administration","Hons");

UPDATE student
SET
    `Course` = 'Architecture'
WHERE
    `Stu_ID` = 'Arch-02';

INSERT INTO teacher
VALUES("TArch-01","Farhan","Professor"),
("TBAd-02","Tamzid","Lecturer"),
("TCiv-03","Shahid","Assistant Lecturer"),
("TCSE-04","Zuckerburg","Assistant Lecturer"),
("TDA-05","Alex","Lecturer"),
("TMark-06","Raihan","Assistant Professor");

SELECT
    *
FROM
    department;

INSERT INTO department
VALUES("D-01","Architecture","TArch-01","Arch-02"),
("D-02","CSE","TCSE-04","CSE-01"),
("D-02","CSE","TCSE-04","CSE-06"),
("D-02","Data Analytics","TDA-05","CSE-03"),
("D-02","Data Analytics","TDA-05","CSE-05"),
("D-03","Civil","TCiv-03","CIV-07"),
("D-04","Marketing","TMark-06","Mark-08"),
("D-04","Marketing","TMark-06","Mark-09"),
("D-05","Business Admin","TBAd-02","BBA-04"),
("D-05","Business Admin","TBAd-02","BBA-10");


SELECT
    `Age`
FROM
    student
ORDER BY `Age` DESC;

-- !!Queries
-- 1. Write the query to return all student that age more than 22.
SELECT
    `Age`, `Stu_Name`
FROM
    student
WHERE
    `Age` > 22
ORDER BY `Age` ASC;

-- 2.Write the query to return the teacher’s ID, designation that teacher’s designation are maximum in the database.
SELECT `Teacher_ID`, `Teacher_Desig`
FROM teacher
WHERE `Teacher_Desig` = (
    SELECT MAX(`Teacher_Desig`)
    FROM teacher
);

SELECT * FROM department;
-- 3.Write the query to return the teacher’s designation that teacher’s name second character is ‘T’.
SELECT
    `Teacher_Desig`
FROM
    teacher
WHERE
    SUBSTRING(`Teacher_Name`, 2, 1) = 'a';


-- 4.Write the query to return the DepartmentName,student Age where average age of student more than or equal 22 in descending order.
SELECT
    D.`Dept_Name`, AVG(S.`Age`) AS AVG_Age
FROM
    student S
        INNER JOIN
    department D ON S.`Stu_ID` = D.`StudID`
GROUP BY D.`Dept_Name`
HAVING AVG(S.`Age`) >= 22
ORDER BY AVG_Age DESC;

-- 5.Find the Second Highest Student age of all department.
SELECT
    MAX(S.`Age`) AS SecondHighestAge
FROM
    student S
        INNER JOIN
    department D ON S.`Stu_ID` = D.`StudID`
WHERE
    S.`Age` < (SELECT
            MAX(`Age`)
        FROM
            student
        WHERE
            `Dept_ID` IN (SELECT
                    `Dept_ID`
                FROM
                    department));