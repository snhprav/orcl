create or replace package p1
is
  procedure greet;
end p1;

/

create or replace package body p1
is
 procedure greet
    is
    begin
  dbms_output.put_line('Hello from package ');
    end greet;
end p1; 
/