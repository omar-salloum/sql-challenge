--1) List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, 
(SELECT s.salary
FROM salaries as s
WHERE s.emp_no = e.emp_no)
FROM employees as e;


-- 2) List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM EMPLOYEES
WHERE DATE_PART('year', hire_date) = 1986; 

-- 3) List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT 
    (SELECT dm.dept_no 
     FROM dept_manager as dm 
     WHERE dm.emp_no = e.emp_no) as dept_no,
    (SELECT d.dept_name 
     FROM departments as d
     WHERE d.dept_no = (SELECT dm.dept_no 
                        FROM dept_manager as dm 
                        WHERE dm.emp_no = e.emp_no)) as dept_name,
    e.emp_no, 
    e.last_name, 
    e.first_name
FROM employees e
WHERE e.emp_no IN (SELECT dm.emp_no FROM dept_manager as dm)
ORDER BY emp_no;


-- 4) List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT 
    de.dept_no,
    (SELECT e.emp_no 
     FROM EMPLOYEES as e 
     WHERE e.emp_no = de.emp_no),
    (SELECT e.last_name 
     FROM EMPLOYEES as e 
     WHERE e.emp_no = de.emp_no),
    (SELECT e.first_name 
     FROM EMPLOYEES as e 
     WHERE e.emp_no = de.emp_no),
    (SELECT d.dept_name
     FROM DEPARTMENTS as d
     WHERE d.dept_no = de.dept_no)
FROM dept_emp as de;

-- 5) List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM EMPLOYEES
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';


-- 6) List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp_no, last_name, first_name
FROM EMPLOYEES
WHERE emp_no IN (	SELECT emp_no FROM dept_emp
					WHERE dept_no IN 	(	SELECT dept_no FROM DEPARTMENTS
					 						WHERE dept_name = 'Sales'));
											


-- 7) List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.																				
SELECT 
    e.emp_no, 
    e.last_name, 
    e.first_name,
    d.dept_name
FROM EMPLOYEES as e
JOIN dept_emp as de ON e.emp_no = de.emp_no
JOIN DEPARTMENTS as d ON de.dept_no = d.dept_no
WHERE de.dept_no IN (
    SELECT dept_no 
    FROM DEPARTMENTS 
    WHERE dept_name IN ('Sales', 'Development')
);


-- 8) List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) as "Last Name Frequency"
FROM EMPLOYEES
GROUP BY last_name
ORDER BY "Last Name Frequency" DESC;