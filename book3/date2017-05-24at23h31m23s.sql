--函数调用1
SELECT e.ename,e.sal,sal_tax(e.sal) tax FROM emp e;
--函数调用2
SELECT empno,ename,sal-sal*sal_tax(sal) 实发工资 FROM emp;

SELECT func(100) FROM dual;
SELECT func(101) FROM dual;
