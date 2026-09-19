SET DEFINE OFF

CREATE SEQUENCE sample123.locations_seq INCREMENT BY 100 MAXVALUE 9900 NOCACHE;

CREATE SEQUENCE sample123.employees_seq NOCACHE;

CREATE SEQUENCE sample123.departments_seq INCREMENT BY 10 MAXVALUE 9990 NOCACHE;

CREATE SEQUENCE sample123.hibernate_sequence;

CREATE SEQUENCE sample123.s1 INCREMENT BY 2 MAXVALUE 10;

CREATE TABLE sample123.regions (
  region_id NUMBER CONSTRAINT region_id_nn NOT NULL,
  region_name VARCHAR2(25 BYTE)
);

ALTER TABLE sample123.regions ADD CONSTRAINT reg_id_pk PRIMARY KEY (region_id) USING INDEX sample123.reg_id_pk;

CREATE TABLE sample123.countries (
  country_id CHAR(2 BYTE) CONSTRAINT country_id_nn NOT NULL,
  country_name VARCHAR2(40 BYTE),
  region_id NUMBER,
  CONSTRAINT country_c_id_pk PRIMARY KEY (country_id)
)
ORGANIZATION INDEX;

COMMENT ON TABLE sample123.countries IS 'country table. References with locations table.';

COMMENT ON COLUMN sample123.countries.country_id IS 'Primary key of countries table.';

COMMENT ON COLUMN sample123.countries.country_name IS 'Country name';

COMMENT ON COLUMN sample123.countries.region_id IS 'Region ID for the country. Foreign key to region_id column in the departments table.';

CREATE TABLE sample123.locations (
  location_id NUMBER(4) NOT NULL,
  street_address VARCHAR2(40 BYTE),
  postal_code VARCHAR2(12 BYTE),
  city VARCHAR2(30 BYTE) CONSTRAINT loc_city_nn NOT NULL,
  state_province VARCHAR2(25 BYTE),
  country_id CHAR(2 BYTE)
);

COMMENT ON TABLE sample123.locations IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';

COMMENT ON COLUMN sample123.locations.location_id IS 'Primary key of locations table';

COMMENT ON COLUMN sample123.locations.street_address IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';

COMMENT ON COLUMN sample123.locations.postal_code IS 'Postal code of the location of an office, warehouse, or production site
of a company. ';

COMMENT ON COLUMN sample123.locations.city IS 'A not null column that shows city where an office, warehouse, or
production site of a company is located. ';

COMMENT ON COLUMN sample123.locations.state_province IS 'State or Province where an office, warehouse, or production site of a
company is located.';

COMMENT ON COLUMN sample123.locations.country_id IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';

ALTER TABLE sample123.locations ADD CONSTRAINT loc_id_pk PRIMARY KEY (location_id) USING INDEX sample123.loc_id_pk;

CREATE TABLE sample123.zzzzz (
  "ID" NUMBER,
  "NAME" VARCHAR2(20 BYTE)
);

CREATE TABLE sample123.departments (
  department_id NUMBER(4) NOT NULL,
  department_name VARCHAR2(30 BYTE) CONSTRAINT dept_name_nn NOT NULL,
  manager_id NUMBER(6),
  location_id NUMBER(4)
);

COMMENT ON TABLE sample123.departments IS 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.';

COMMENT ON COLUMN sample123.departments.department_id IS 'Primary key column of departments table.';

COMMENT ON COLUMN sample123.departments.department_name IS 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. ';

COMMENT ON COLUMN sample123.departments.manager_id IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';

COMMENT ON COLUMN sample123.departments.location_id IS 'Location id where a department is located. Foreign key to location_id column of locations table.';

ALTER TABLE sample123.departments ADD CONSTRAINT dept_id_pk PRIMARY KEY (department_id) USING INDEX sample123.dept_id_pk;

CREATE TABLE sample123.jobs (
  job_id VARCHAR2(10 BYTE) NOT NULL,
  job_title VARCHAR2(35 BYTE) CONSTRAINT job_title_nn NOT NULL,
  min_salary NUMBER(6),
  max_salary NUMBER(6)
);

COMMENT ON TABLE sample123.jobs IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';

COMMENT ON COLUMN sample123.jobs.job_id IS 'Primary key of jobs table.';

COMMENT ON COLUMN sample123.jobs.job_title IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';

COMMENT ON COLUMN sample123.jobs.min_salary IS 'Minimum salary for a job title.';

COMMENT ON COLUMN sample123.jobs.max_salary IS 'Maximum salary for a job title';

ALTER TABLE sample123.jobs ADD CONSTRAINT job_id_pk PRIMARY KEY (job_id) USING INDEX sample123.job_id_pk;

CREATE TABLE sample123.employees (
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
  department_id NUMBER(4)
);

COMMENT ON TABLE sample123.employees IS 'employees table. Contains 107 rows. References with departments,
jobs, job_history tables. Contains a self reference.';

COMMENT ON COLUMN sample123.employees.employee_id IS 'Primary key of employees table.';

COMMENT ON COLUMN sample123.employees.first_name IS 'First name of the employee. A not null column.';

COMMENT ON COLUMN sample123.employees.last_name IS 'Last name of the employee. A not null column.';

COMMENT ON COLUMN sample123.employees.email IS 'Email id of the employee';

COMMENT ON COLUMN sample123.employees.phone_number IS 'Phone number of the employee; includes country code and area code';

COMMENT ON COLUMN sample123.employees.hire_date IS 'Date when the employee started on this job. A not null column.';

COMMENT ON COLUMN sample123.employees.job_id IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.';

COMMENT ON COLUMN sample123.employees.salary IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)';

COMMENT ON COLUMN sample123.employees.commission_pct IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage';

COMMENT ON COLUMN sample123.employees.manager_id IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';

COMMENT ON COLUMN sample123.employees.department_id IS 'Department id where employee works; foreign key to department_id
column of the departments table';

ALTER TABLE sample123.employees ADD CONSTRAINT emp_emp_id_pk PRIMARY KEY (employee_id) USING INDEX sample123.emp_emp_id_pk;

ALTER TABLE sample123.employees ADD CONSTRAINT emp_email_uk UNIQUE (email) USING INDEX sample123.emp_email_uk;

CREATE TABLE sample123.job_history (
  employee_id NUMBER(6) CONSTRAINT jhist_employee_nn NOT NULL,
  start_date DATE CONSTRAINT jhist_start_date_nn NOT NULL,
  end_date DATE CONSTRAINT jhist_end_date_nn NOT NULL,
  job_id VARCHAR2(10 BYTE) CONSTRAINT jhist_job_nn NOT NULL,
  department_id NUMBER(4),
  CONSTRAINT jhist_date_interval CHECK (end_date > start_date)
);

COMMENT ON TABLE sample123.job_history IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';

COMMENT ON COLUMN sample123.job_history.employee_id IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';

COMMENT ON COLUMN sample123.job_history.start_date IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';

COMMENT ON COLUMN sample123.job_history.end_date IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';

COMMENT ON COLUMN sample123.job_history.job_id IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';

COMMENT ON COLUMN sample123.job_history.department_id IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';

ALTER TABLE sample123.job_history ADD CONSTRAINT jhist_emp_id_st_date_pk PRIMARY KEY (employee_id,start_date) USING INDEX sample123.jhist_emp_id_st_date_pk;

CREATE OR REPLACE type sample123.vartype is varray(3) of number;

/

CREATE TABLE sample123.st (
  "ID" NUMBER,
  marks sample123.vartype
);

CREATE TABLE sample123.empl30 (
  "ID" NUMBER,
  deptno NUMBER
);

CREATE INDEX sample123.emp_name_ix ON sample123.employees(last_name,first_name);

CREATE INDEX sample123.jhist_employee_ix ON sample123.job_history(employee_id);

CREATE INDEX sample123.emp_department_ix ON sample123.employees(department_id);

CREATE INDEX sample123.emp_job_ix ON sample123.employees(job_id);

CREATE INDEX sample123.emp_manager_ix ON sample123.employees(manager_id);

CREATE INDEX sample123.jhist_job_ix ON sample123.job_history(job_id);

CREATE INDEX sample123.loc_city_ix ON sample123.locations(city);

CREATE INDEX sample123.jhist_department_ix ON sample123.job_history(department_id);

CREATE INDEX sample123.dept_location_ix ON sample123.departments(location_id);

CREATE INDEX sample123.loc_country_ix ON sample123.locations(country_id);

CREATE INDEX sample123.loc_state_province_ix ON sample123.locations(state_province);

CREATE OR REPLACE PROCEDURE sample123.add_job_history
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   , p_department_id   job_history.department_id%type
   )
IS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date,
                           job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;

/

CREATE OR REPLACE PROCEDURE sample123.secure_dml
IS
BEGIN
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
	RAISE_APPLICATION_ERROR (-20205,
		'You may only make changes during normal office hours');
  END IF;
END secure_dml;

/

CREATE OR REPLACE FORCE VIEW sample123.emp_details_view (employee_id,job_id,manager_id,department_id,location_id,country_id,first_name,last_name,salary,commission_pct,department_name,job_title,city,state_province,country_name,region_name) AS
SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id
WITH READ ONLY;

CREATE OR REPLACE TRIGGER sample123.secure_employees
  BEFORE INSERT OR UPDATE OR DELETE ON sample123.employees
DISABLE BEGIN
  secure_dml;
END secure_employees;

/

CREATE OR REPLACE TRIGGER sample123.update_job_history
  AFTER UPDATE OF job_id, department_id ON sample123.employees
  FOR EACH ROW
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate,
                  :old.job_id, :old.department_id);
END;

/

ALTER TABLE sample123.locations ADD CONSTRAINT loc_c_id_fk FOREIGN KEY (country_id) REFERENCES sample123.countries (country_id);

ALTER TABLE sample123.employees ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES sample123.departments (department_id);

ALTER TABLE sample123.employees ADD CONSTRAINT emp_job_fk FOREIGN KEY (job_id) REFERENCES sample123.jobs (job_id);

ALTER TABLE sample123.employees ADD CONSTRAINT emp_manager_fk FOREIGN KEY (manager_id) REFERENCES sample123.employees (employee_id);

ALTER TABLE sample123.job_history ADD CONSTRAINT jhist_dept_fk FOREIGN KEY (department_id) REFERENCES sample123.departments (department_id);

ALTER TABLE sample123.job_history ADD CONSTRAINT jhist_emp_fk FOREIGN KEY (employee_id) REFERENCES sample123.employees (employee_id);

ALTER TABLE sample123.job_history ADD CONSTRAINT jhist_job_fk FOREIGN KEY (job_id) REFERENCES sample123.jobs (job_id);

ALTER TABLE sample123.countries ADD CONSTRAINT countr_reg_fk FOREIGN KEY (region_id) REFERENCES sample123.regions (region_id);

ALTER TABLE sample123.departments ADD CONSTRAINT dept_loc_fk FOREIGN KEY (location_id) REFERENCES sample123.locations (location_id);

ALTER TABLE sample123.departments ADD CONSTRAINT dept_mgr_fk FOREIGN KEY (manager_id) REFERENCES sample123.employees (employee_id);

