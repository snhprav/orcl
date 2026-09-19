CREATE TABLE hr.jobs (
  job_id VARCHAR2(10 BYTE) NOT NULL,
  job_title VARCHAR2(35 BYTE) CONSTRAINT job_title_nn NOT NULL,
  min_salary NUMBER(6),
  max_salary NUMBER(6),
  CONSTRAINT job_id_pk PRIMARY KEY (job_id)
);
COMMENT ON TABLE hr.jobs IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';
COMMENT ON COLUMN hr.jobs.job_id IS 'Primary key of jobs table.';
COMMENT ON COLUMN hr.jobs.job_title IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';
COMMENT ON COLUMN hr.jobs.min_salary IS 'Minimum salary for a job title.';
COMMENT ON COLUMN hr.jobs.max_salary IS 'Maximum salary for a job title';