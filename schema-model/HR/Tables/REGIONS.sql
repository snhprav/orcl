CREATE TABLE hr.regions (
  region_id NUMBER CONSTRAINT region_id_nn NOT NULL,
  region_name VARCHAR2(25 BYTE),
  CONSTRAINT reg_id_pk PRIMARY KEY (region_id)
);