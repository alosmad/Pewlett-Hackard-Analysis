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
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO title_noduplicates
FROM retirement_titles as rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

-- Number of retiring employees by job title
SELECT COUNT(tn.title), tn.title
INTO retiring_titles
FROM title_noduplicates as tn
GROUP BY tn.title
ORDER BY count DESC;

-- Mentoship elegibility program

SELECT DISTINCT ON (e.emp_no)
e.emp_no,
e.first_name, 
e.last_name, 
e.birth_date,
de.from_date,
de.to_date,
t.title
INTO mentorship
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, t.from_date DESC;
