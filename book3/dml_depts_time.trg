CREATE OR REPLACE TRIGGER dml_depts_time
  BEFORE 
  INSERT OR UPDATE OR DELETE 
  ON dept
BEGIN
  IF TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00' OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
  RAISE_APPLICATION_ERROR (-20205,'You may only make changes during normal office hours');
  END IF;
END dml_depts_time;       
/
