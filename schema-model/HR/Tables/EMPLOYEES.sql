CREATE TABLE hr.employees (
  employee_id NUMBER(6) NOT NULL,
  first_name VARCHAR2(20 BYTE),
  last_name VARCHAR2(25 BYTE) CONSTRAINT emp_last_name_nn NOT NULL,
  email VARCHAR2(25 BYTE) CONSTRAINT emp_email_nn NOT NULL,
  phone_number VARCHAR2(20 BYTE),
  hire_date DATE CONSTRAINT emp_hire_date_nn NOT NULL,
  job_id VARCHAR2(10 BYTE) CONSTRAINT emp_job_nn NOT NULL,
  salary NUMBER(8,2) CONSTRAINT emp_salary_min CHECK (salary > 0),
  commission_pct NUMBER(2,2),
  manager_id NUMBER(6),
  department_id NUMBER(4),
  CONSTRAINT emp_emp_id_pk PRIMARY KEY (employee_id),
  CONSTRAINT emp_email_uk UNIQUE (email),
  CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES hr.departments (department_id),
  CONSTRAINT emp_job_fk FOREIGN KEY (job_id) REFERENCES hr.jobs (job_id),
  CONSTRAINT emp_manager_fk FOREIGN KEY (manager_id) REFERENCES hr.employees (employee_id)
);
COMMENT ON TABLE hr.employees IS 'employees table. Contains 107 rows. References with departments,
jobs, job_history tables. Contains a self reference.';
COMMENT ON COLUMN hr.employees.employee_id IS 'Primary key of employees table.';
COMMENT ON COLUMN hr.employees.first_name IS 'First name of the employee. A not null column.';
COMMENT ON COLUMN hr.employees.last_name IS 'Last name of the employee. A not null column.';
COMMENT ON COLUMN hr.employees.email IS 'Email id of the employee';
COMMENT ON COLUMN hr.employees.phone_number IS 'Phone number of the employee; includes country code and area code';
COMMENT ON COLUMN hr.employees.hire_date IS 'Date when the employee started on this job. A not null column.';
COMMENT ON COLUMN hr.employees.job_id IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.';
COMMENT ON COLUMN hr.employees.salary IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)';
COMMENT ON COLUMN hr.employees.commission_pct IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage';
COMMENT ON COLUMN hr.employees.manager_id IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';
COMMENT ON COLUMN hr.employees.department_id IS 'Department id where employee works; foreign key to department_id
column of the departments table';