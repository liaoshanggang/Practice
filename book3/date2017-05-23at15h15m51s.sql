--les11
CREATE VIEW empvu80
AS SELECT employee_id,last_name,salary
FROM employees
WHERE department_id = 80;

CREATE VIEW salvu50
AS SELECT employee_id id_number,last_name NAME,
   salary*12 ann_salary
   FROM employees
   WHERE department_id = 50;
   
SELECT * FROM empvu80;   
--�޸���ͼ
CREATE OR REPLACE VIEW empvu80
(id_number,NAME,sal,department_id)
AS SELECT employee_id,first_name ||''||last_name,
salary,department_id
FROM employees
WHERE department_id = 80;

SELECT * FROM empvu80;  

--������ͼ
CREATE VIEW dept_sum_vu
(NAME,minsal,maxsal,avgsal)
AS SELECT d.department_name,MIN(e.salary),
MAX(e.salary),AVG(e.salary) 
FROM employees e,departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_name;
SELECT * FROM dept_sum_vu;


CREATE OR REPLACE VIEW empvu20
AS SELECT *
FROM employees
WHERE department_id = 20
WITH CHECK OPTION CONSTRAINT empvu20_ck;

CREATE OR REPLACE VIEW empvu10
(employee_number,employee_name,job_title)
AS SELECT employee_id,last_name,job_id
FROM employees
WHERE department_id = 10
WITH READ ONLY;

DROP VIEW empvu80;
DROP VIEW salvu50;
DROP VIEW dept_sum_vu;
DROP VIEW empvu20;

SELECT ROWNUM  AS RANK,last_name,salary
FROM (SELECT last_name,salary FROM employees
ORDER BY salary DESC)
WHERE ROWNUM<=3;

CREATE SEQUENCE dept_deptid_seq
INCREMENT BY 10
START WITH 120
MAXVALUE 9999
NOCACHE
NOCYCLE;

SELECT sequence_name,min_value,max_value,
increment_by,last_number
FROM user_sequences;

DROP SEQUENCE stu_id_seq;
CREATE SEQUENCE stu_id_seq
INCREMENT BY 10
START WITH 09
MAXVALUE 9999
NOCACHE
NOCYCLE;

SELECT * FROM student;
INSERT INTO student(s#,sname,sage,ssex)
VALUES (stu_id_seq.nextval,'Support',null,2500);
SELECT * FROM student;

SELECT stu_id_seq.currval
FROM dual;

ALTER SEQUENCE stu_id_seq
INCREMENT BY 20
MAXVALUE 999999
NOCACHE
NOCYCLE

CREATE INDEX student_s#_idx
ON student(s#);

SELECT ic.INDEX_NAME,ic.COLUMN_NAME,
ic.COLUMN_POSITION col_pos,ix.UNIQUENESS
FROM user_indexes ix,user_ind_columns ic
WHERE ic.index_name = ix.INDEX_NAME
AND ic.TABLE_NAME = 'STUDENT';

CREATE INDEX upper_dept_name_inx
ON departments(UPPER(department_name));

SELECT *
FROM departments
WHERE UPPER(department_name)='SALES';

DROP INDEX upper_dept_name_inx;

DROP INDEX student_s#_idx;

CREATE SYNONYM de_sum
FOR empvu80;

DROP SYNONYM de_sum;

--les07
SELECT employee_id,last_name,salary,department_id
FROM employees
WHERE employee_id = &employee_num;

SELECT last_name,department_id,salary*12
FROM employees
WHERE job_id = '&job_title';

SELECT employee_id,last_name,job_id,
&column_name
FROM employees
WHERE &condition
ORDER BY &order_column;

SELECT employee_id,last_name,salary,department_id
FROM employees
WHERE employee_id = &employee_num;

SELECT * FROM student;
INSERT INTO student
(s#,sname,sage,ssex)
VALUES('&s#','&sname',SYSDATE��'&ssex');
SAVEPOINT insert_done;
COMMIT;
SELECT * FROM student;
INSERT INTO student
(s#,sname,sage,ssex)
VALUES('&s#','&sname',SYSDATE��'&ssex');
COMMIT;

SELECT * FROM student;
ROLLBACK TO insert_done;
SELECT * FROM student;

SELECT employee_id, last_name, job_id, department_id
FROM employees outer
WHERE EXISTS ( SELECT 'X'
FROM employees
WHERE manager_id =
outer.employee_id);
