-- Creating table for PH-EmployeeDB

CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)

);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
	
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)

);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  	PRIMARY KEY (emp_no)
	
);

CREATE TABLE dept_emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR(4) NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (emp_no) REFERENCES salaries (emp_no)
	
);

CREATE TABLE titles (
  emp_no INT NOT NULL,
  title VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES salaries (emp_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)

);

--Retirement eligibility 1952 to 1955
SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';


--Retirement eligibility 1952

SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


--Retirement eligibility 1952 to 1955 and hired between 1985 and 1988

SELECT first_name, last_name

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


--Count of Retirement eligibility 1952 to 1955 and hired between 1985 and 1988

SELECT COUNT(first_name)

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


--Preparing to export retirement eligibility

SELECT first_name, last_name

INTO retirement_info

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Viewing retirement_info

SELECT * FROM retirement_info;

-- Create new table for retiring employees

SELECT emp_no, first_name, last_name

INTO retirement_info

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table

SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date

FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables

SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

Select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Retiring employee count by department number in order

SELECT COUNT(ce.emp_no), de.dept_no
INTO retire_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- double checking info from salaries
SELECT * FROM salaries
ORDER BY to_date DESC;

-- creating new table emp_info with emp_no, first_name, last_name, gender, to_date and salary

SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
     AND (de.to_date = '9999-01-01');

-- List of managers per department creating a new table that includes manager's employee number, first name, last name, and their starting and ending employment dates

SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager as dm
    INNER JOIN departments as d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp as ce
        ON (dm.emp_no = ce.emp_no);
		
-- Department Retirees creating new table dept_info

SELECT 	ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no);

-- 7.3.6 Skill Drill 1 returning info to Sales department

SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
	de.dept_no,
    d.dept_name
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON ri.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no
WHERE (d.dept_name = 'Sales')
	AND de.to_date = '9999-01-01';

-- Retiring employee count by Sales and Development departments 2nd try

SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
	de.dept_no,
    d.dept_name
FROM retirement_info as ri
INNER JOIN dept_emp as de
ON ri.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development')
	AND de.to_date = '9999-01-01';

-- Module 7 Delverable 1 Employee Database Challenge retrieving emp_no, first_name, last_name, title, from_date, to_date

SELECT e.emp_no,
    e.first_name,
	e.last_name,
	t.title,
	t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (t.to_date = '9999-01-01')
ORDER BY to_date DESC;

-- Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
--INTO unique_titles
FROM retirement_titles as rt
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Creating retiring_titles table

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

-- Deliverable 2 building a mentoring eligibility table

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- mentorship by title
SELECT COUNT(me.title), me.title
FROM mentorship_eligibilty as me
GROUP BY me.title
ORDER BY me.count DESC;


-- Deliverable 2 2nd query
SELECT DISTINCT ON (me.emp_no) me.emp_no,
	d.dept_name,
	me.first_name,
	me.last_name,
	me.birth_date,
	me.from_date,
	me.to_date,
	me.title
INTO mentorship_departments
FROM mentorship_eligibilty as me
INNER JOIN dept_emp as de
ON (me.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (me.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY me.emp_no;

-- mentorship by department
SELECT COUNT(md.dept_name), md.dept_name
FROM mentorship_departments as md
GROUP BY md.dept_name
ORDER BY md.count DESC;

