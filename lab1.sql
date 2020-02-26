SELECT employee_id, last_name, 
    salary * 12 AS "ANUAL SALARY"
FROM employees;

--ex3
DESC employees

--ex4
SELECT * FROM employees;

--ex5
SELECT employee_id, last_name, 
    first_name, job_id, hire_date 
FROM employees;
--asta este proiectie

--ex6
SELECT job_id FROM employees;
SELECT DISTINCT job_id FROM employees;
SELECT job_title, job_id FROM jobs;
--job_id cheie primara in jobs si cheie secundara in employees

--ex7
SELECT last_name || ',' || job_id "Angajat si titlu"
FROM employees;

--9
SELECT last_name, salary
FROM employees
WHERE salary>2850;

--10
SELECT last_name, department_id 
FROM employees
WHERE employee_id=104;

--11
SELECT first_name, last_name, salary
FROM employees
WHERE salary NOT BETWEEN 1500 AND 2850;

--12
SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '20-FEB-1987' AND '1-MAY-1989'
ORDER BY 3;

--13
SELECT last_name, department_id
FROM employees
WHERE department_id IN(10,30)
ORDER BY 1;

--14
SELECT last_name, salary
FROM employees
WHERE salary>3500 AND department_id IN(10,30);

--15
SELECT SYSDATE
FROM dual;

SELECT TO_CHAR(SYSDATE,'DDD/YEAR:SSSSS')
FROM dual;

--16
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE('%87%'); --sau LIKE '%87';

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(year FROM hire_date)=1987;

--17
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

--18
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;

--19
SELECT last_name, salary, commission_pct
FROM employees
ORDER BY salary DESC, commission_pct DESC;

--20
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

SELECT last_name
FROM employees
WHERE UPPER(last_name) LIKE '__A%';

--21
SELECT last_name
FROM employees
WHERE UPPER(last_name) LIKE '%L%L%' AND 
    department_id=30 OR manager_id=101;

--22
SELECT last_name, job_id, salary
FROM employees
WHERE (job_id LIKE '%clerk%' OR job_id LIKE '%rep%')
    AND salary NOT IN(1000, 2000, 3000);

--23
SELECT first_name, last_name, salary, comission_pct
FROM employees
WHERE salary > salary * comission_pct * 5;
