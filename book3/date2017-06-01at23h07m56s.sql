CREATE USER forward IDENTIFIED BY forward;
GRANT CREATE SESSION,CREATE TABLE,CREATE VIEW,CREATE SEQUENCE TO forward;
create role developer;

--系统管理员
grant create table,create view,create sequence,create procedure to developer;
grant developer to forward;

--用hr用户访问数据库，授予forward操作employees表的结构
grant select,insert
on employees
to forward;
--进入forward访问hr管理的数据库
select * from hr.employees;

--同义词
create synonym emps for hr.employees;
select * from emps;

--进入hr用户身份操作
revoke insert on employees from forward;
revoke create sequence from forward;

CREATE OR REPLACE PROCEDURE raise_salary
(p_id IN employees.employee_id%TYPE)
IS
BEGIN
  IF p_id >200 THEN
    --BEGIN
     UPDATE employees
     SET salary = salary * 1.15
     WHERE employee_id = p_id;
    --END;
  END IF;
  IF p_id <200 THEN
     --BEGIN
       UPDATE employees
       SET salary = salary * 1.10
       WHERE employee_id = p_id;
     --END;
  END IF;
END raise_salary;

/*BEGIN
EXECUTE raise_salary(207);
END;*/

CREATE OR REPLACE PROCEDURE hello
IS
BEGIN
  raise_salary(206);
END hello;

CREATE OR REPLACE FUNCTION get_manager_id
(p_id IN employees.employee_id%TYPE)
RETURN NUMBER
IS
v_manager_id employees.manager_id%TYPE:=0;
BEGIN
    SELECT manager_id INTO v_manager_id
    FROM employees WHERE employee_id = p_id;
    RETURN v_manager_id;         
END get_manager_id;

SELECT manager_id 
    FROM employees WHERE employee_id = 206;

SELECT get_manager_id(206) FROM dual;

CREATE OR REPLACE TRIGGER dml_depts_time
BEFORE
INSERT OR UPDATE OR DELETE
ON departments
BEGIN
  IF to_char(SYSDATE,'HH24:MI') NOT BETWEEN '08:00' AND '18:00' OR 
    to_char(SYSDATE,'DY')IN('SAT','SUN') THEN
    raise_application_error(-20205,'You may only make changes during normal office hours');
  END IF;
END dml_depts_time;

UPDATE departments
SET department_name='IT GROUP'
WHERE department_id=60;

CREATE OR REPLACE TRIGGER update_job_history
       AFTER
       UPDATE OF job_id,department_id
       ON employees
       FOR EACH ROW
BEGIN
      INSERT INTO job_history(employee_id,start_date,end_date,job_id,department_id)
      VALUES(:old.employee_id,:old.hire_date,SYSDATE,:old.job_id,:old.department_id);
END;

UPDATE employees
SET department_id=90
WHERE employee_id IN(106,107);

SELECT * FROM job_history;
