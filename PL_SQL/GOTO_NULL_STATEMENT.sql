-- LINK https://www.oracletutorial.com/plsql-tutorial/plsql-goto/
-- GOTO 
BEGIN
  GOTO second_message;

  <<first_message>>
  DBMS_OUTPUT.PUT_LINE( 'Hello' );
  GOTO the_end;

  <<second_message>>
  DBMS_OUTPUT.PUT_LINE( 'PL/SQL GOTO Demo' );
  GOTO first_message;

  <<the_end>>
  DBMS_OUTPUT.PUT_LINE( 'and good bye...' );

END;

-- Link  https://www.oracletutorial.com/plsql-tutorial/plsql-null/
-- NULL STATEMENT
DECLARE
  n_credit_status VARCHAR2( 50 );
BEGIN
  n_credit_status := 'GOOD';

  CASE n_credit_status
  WHEN 'BLOCK' THEN
    request_for_aproval;
  WHEN 'WARNING' THEN
    send_email_to_accountant;
  ELSE
    NULL;
  END CASE;
END;