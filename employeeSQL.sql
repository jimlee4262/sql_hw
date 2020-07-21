--Drop Table
Drop TABLE departments, employees, dept_emp, dept_manager, salaries, titles;

--Create Table

CREATE TABLE departments
	(
	dept_no varchar(30) not null,
 	dept_name varchar(30) not null);
	
--See Table
Select * From departments

--Add Primary Key to dept_no
ALTER TABLE departments
ADD PRIMARY KEY (dept_no);

--See Primary Key on Department Table
Select * from departments;


--Add employees table
CREATE TABLE employees
	(
	emp_no VARCHAR(30) not null,
 	emp_title_id VARCHAR(30) not null,
	birth_date VARCHAR(30),
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(30),
	hire_date VARCHAR(30));
	
--Add Primary Key to dept_no
ALTER TABLE employees
ADD PRIMARY KEY (emp_no);

--See employee table
Select * from employees;

--Create department_employee table
CREATE TABLE dept_emp
	(
	emp_no VARCHAR(30),
	dept_no VARCHAR(30),
	foreign key (dept_no) references departments(dept_no)
	);

--See depart_emp table
select * From dept_emp;

--Create dept_manager table
CREATE TABLE dept_manager
	(
	dept_no VARCHAR(30),
	emp_no VARCHAR(30),
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no)
	);
	
--See dept_manager table
select * From dept_manager;

--Create Salaries Table
CREATE TABLE salaries
	(
	emp_no VARCHAR(30),
	salary VARCHAR(30),
	foreign key (emp_no) references employees(emp_no)
	);

--See salaries table
Select * FROM salaries;

--Create titles table
CREATE TABLE titles
	(
	emp_title_id VARCHAR(30),
	title VARCHAR(30),
	PRIMARY KEY (emp_title_id)
	);

--See Title table
Select * FROM titles;

ALTER TABLE titles
RENAME COLUMN emp_title_id TO emp_no ;

--Add foreign key to employee_title_ID
ALTER TABLE employees
ADD FOREIGN KEY (emp_title_id) REFERENCES titles(emp_title_id);

--Data Analysis 1 Detail of each employee: employee number, last name, first name, sex, and salary

Select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e
left join salaries as s
on e.emp_no = s.emp_no;

--Data Analysis 2 First name, last name, and hire date hired in 1986
Select first_name, last_name, hire_date
from employees
where hire_date like '%1986';

--Data Analysis 3 manager of each department, department number, department name, manager's employee number, 
--last name, first name

Select d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name
from departments as d
join dept_manager as m on d.dept_no = m.dept_no
join employees as e on m.emp_no = e.emp_no;

--Select d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
--from employees as e
--right join dept_manager as dm on e.emp_no = dm.emp_no
--left join departments as d on dm.dept_no = d.

--Data Analysis 4 Department of each employee: employee number, last name, first name, and department name
select e.emp_no, e.last_name, e.first_name, f.dept_name
from employees as e
full outer join dept_emp as d on e.emp_no = d.emp_no
full outer join departments as f on d.dept_no=f.dept_no;

--Data Analysis 5 First Name, Last Name, sex, name is 'Hercules' and Last name begins with B
Select first_name, last_name, sex
from employees
where first_name = 'Hercules' AND
last_name like 'B%';

--Data Analysis 6 Sales Department, emp #, last name, first name, and department name
Select e.emp_no, e.last_name, e.first_name, f.dept_name
from employees as e
join dept_emp as d on e.emp_no = d.emp_no
join departments as f on d.dept_no = f.dept_no
where f.dept_name = 'Sales';

--Data Analysis 7 Sales and Development departments, emp no, last name, first name, and department name
Select e.emp_no, e.last_name, e.first_name, f.dept_name
from employees as e
join dept_emp as d on e.emp_no = d.emp_no
join departments as f on d.dept_no = f.dept_no
where f.dept_name = 'Sales' OR f.dept_name = 'Development';

--Data Analysis 8 Descending order; frequency count of employee last names, 
Select last_name, Count(last_name) as ct_last_name
from employees
group by last_name 
order by ct_last_name desc;



