CREATE TABLE hr.job_history (
  employee_id NUMBER(6) CONSTRAINT jhist_employee_nn NOT NULL,
  start_date DATE CONSTRAINT jhist_start_date_nn NOT NULL,
  end_date DATE CONSTRAINT jhist_end_date_nn NOT NULL,
  job_id VARCHAR2(10 BYTE) CONSTRAINT jhist_job_nn NOT NULL,
  department_id NUMBER(4),
  CONSTRAINT jhist_date_interval CHECK (end_date > start_date),
  CONSTRAINT jhist_emp_id_st_date_pk PRIMARY KEY (employee_id,start_date),
  CONSTRAINT jhist_dept_fk FOREIGN KEY (department_id) REFERENCES hr.departments (department_id),
  CONSTRAINT jhist_emp_fk FOREIGN KEY (employee_id) REFERENCES hr.employees (employee_id),
  CONSTRAINT jhist_job_fk FOREIGN KEY (job_id) REFERENCES hr.jobs (job_id)
);
COMMENT ON TABLE hr.job_history IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';
COMMENT ON COLUMN hr.job_history.employee_id IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';
COMMENT ON COLUMN hr.job_history.start_date IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';
COMMENT ON COLUMN hr.job_history.end_date IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';
COMMENT ON COLUMN hr.job_history.job_id IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';
COMMENT ON COLUMN hr.job_history.department_id IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';