set SERVEROUT ON;
DECLARE
  CURSOR c_member
  IS
    SELECT 
        *
    FROM 
        members 
    ORDER BY 
        MEMBER_ID DESC;
BEGIN
  FOR r_member IN c_member
  LOOP
    dbms_output.put_line( r_member.member_name || ': $' ||  r_member.project_id );
  END LOOP;
END;
/
SELECT *
FROM members