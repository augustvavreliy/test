1. Вывести список сотрудников, получающих максимальную заработную плату в своем отделе.

SELECT * FROM EMPLOYEE AS emp WHERE emp.SALARY = (SELECT MAX(salary) FROM EMPLOYEE as emp2 WHERE emp2.DEPARTMENT_ID = emp.DEPARTMENT_ID);

2. Вывести список ID отделов, количество сотрудников в которых не превышает 3 человек

SELECT DEPARTMENT_ID FROM EMPLOYEE GROUP BY DEPARTMENT_ID HAVING COUNT(*) <= 3;

3. Найти список ID отделов с максимальной суммарной зарплатой сотрудников

WITH department_salary AS 
	(SELECT DEPARTMENT_ID, SUM(SALARY) AS salary
	FROM EMPLOYEE 
	GROUP BY DEPARTMENT_ID)
SELECT DEPARTMENT_ID
FROM department_salary
WHERE department_salary.salary = (SELECT MAX(salary) FROM department_salary);

4. Добавить в БД новый отдел

INSERT INTO DEPARTMENT
VALUES (4, 'Security');

5. Добавить в новый отдел троих новых сотрудников и одного руководителя (с учетом заполнения всех полей)

INSERT INTO EMPLOYEE
VALUES (8, 4, 4, 'Vasya', 1500);
INSERT INTO EMPLOYEE
VALUES (9, 4, 4, 'Andrew', 2000);
INSERT INTO EMPLOYEE
VALUES (10, 4, 4, 'Jhon', 2000);
INSERT INTO EMPLOYEE
VALUES (11, 4, null, 'Alexandr', 5000);

6. Удалить отдел и всех сотрудников, привязанных к этому отделу

DELETE FROM EMPLOYEE WHERE DEPARTMENT_ID = 4;
DELETE FROM DEPARTMENT WHERE ID = 4;

7. Обновить ID любого отдела так, чтобы “не потерять” работающих в нем сотрудников

ALTER TABLE EMPLOYEE 
ADD CONSTRAINT dep_ID
FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENT(ID)
ON UPDATE CASCADE;
UPDATE DEPARTMENT
SET ID = 5 WHERE ID = 1;
SELECT * FROM EMPLOYEE;