--
--    Copyright © Red Gate Software Ltd 2010-2026-2026
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--         http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.
--
-- The content of the Oracle afterMigrate__fix_invalid_objects.sql file is a command that re-compiles any invalid database objects.
-- This is required because objects such as procedures, which are managed in repeatable migrations, can have dependencies
-- on other objects but Flyway runs all repeatable migrations in alphabetical order regardless of any dependencies.
-- Therefore some objects may not be properly compiled after flyway migrate completes.

BEGIN
<<objectloop>>
  FOR cur_rec IN (SELECT owner,
                         object_name,
                         object_type,
                         CASE object_type
                           WHEN 'PACKAGE' THEN 1
                           WHEN 'PACKAGE BODY' THEN 2
                           ELSE 3
                           END AS recompile_order
                  FROM sys.all_objects
                  WHERE status != 'VALID'
                    AND object_type != 'TYPE BODY'
                  ORDER BY recompile_order ASC)
  LOOP
BEGIN
      IF cur_rec.object_type = 'PACKAGE BODY' THEN
        EXECUTE IMMEDIATE 'ALTER PACKAGE "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE BODY';
ElSE
        EXECUTE IMMEDIATE 'ALTER ' || cur_rec.object_type || ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
END IF;
EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(cur_rec.object_type || ' : ' || cur_rec.owner || ' : ' || cur_rec.object_name || 'could not be compiled');
END;
END LOOP objectloop;
END;
