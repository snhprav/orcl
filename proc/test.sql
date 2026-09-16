create or replace function show(id number)
return number
is
vsal number;
begin
select salary into vsal from employees where employee_id=id;
return vsal;
end show;
