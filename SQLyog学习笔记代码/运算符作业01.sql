USE atguigudb;
#1
SELECT last_name,salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;

#2
SELECT last_name, department_id 
FROM employees 
WHERE department_id IN(20, 50);

#3
SELECT last_name,job_id,manager_id
FROM employees
WHERE manager_id <=>NULL;

#4
SELECT last_name,salary,commission_pct
FROM employees
WHERE NOT commission_pct <=>NULL;

SELECT last_name,salary,commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

SELECT last_name,salary,commission_pct
FROM employees
WHERE NOT ISNULL (commission_pct);

#5
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

#6
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%k%' OR last_name LIKE '%K%a%' ;



SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' AND last_name LIKE '%k%';

#7
SELECT first_name
FROM employees
WHERE first_name LIKE '%e';

#8
SELECT last_name,job_id
FROM employees
WHERE department_id BETWEEN 80 AND 100;

#9
SELECT last_name, salary, manager_id
FROM employees
WHERE manager_id IN(100,101,110);


