SELECT 
   tablespace_name, 
   file_name, 
   bytes / 1024/ 1024  MB
FROM
   dba_data_files;

/
CREATE TABLE t1(
   id INT GENERATED ALWAYS AS IDENTITY, 
   c1 VARCHAR2(32)
) TABLESPACE tbs1;
/
BEGIN
   FOR counter IN 1..10000 loop
      INSERT INTO t1(c1)
      VALUES(sys_guid());
   END loop;
END;

/
SELECT 
   tablespace_name, 
   bytes / 1024 / 1024 MB
FROM 
   dba_free_space
WHERE 
   tablespace_name = 'TBS1';
   
/

   CREATE TABLESPACE tbs2
   DATAFILE 'D:\HUNGNGO\ORACLE\ORADATA\ORCL\DEMOTBP102.DBF'

   size 10M autoextend on;
  
/

 select tablespace_name, file_name, bytes/1048576 File_Size_MB, autoextensible, increment_by from dba_data_files order by file_id;