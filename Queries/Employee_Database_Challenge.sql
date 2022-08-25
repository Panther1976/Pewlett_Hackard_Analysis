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
INTO unique_titles
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
INTO mentorship_eligibility
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
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY me.count DESC;

-- Deliverable 2 new table mentorship_departments and a 2nd query

SELECT DISTINCT ON (me.emp_no) me.emp_no,
	d.dept_name,
	me.first_name,
	me.last_name,
	me.birth_date,
	me.from_date,
	me.to_date,
	me.title
INTO mentorship_departments
FROM mentorship_eligibility as me
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

