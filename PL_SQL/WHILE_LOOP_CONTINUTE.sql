-- Link: https://www.oracletutorial.com/plsql-tutorial/plsql-while-loop/
-- while loop
DECLARE
  n_counter NUMBER := 1;
BEGIN
  WHILE n_counter <= 5
  LOOP
    DBMS_OUTPUT.PUT_LINE( 'Counter : ' || n_counter );
    n_counter := n_counter + 1;
  END LOOP;
END;
/
-- while loop with exit when

DECLARE 
l_counter number := 1;
BEGIN

    WHILE l_counter <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE('Counter: '||l_counter);
        l_counter := l_counter + 1;
        EXIT WHEN l_counter = 3;
    END LOOP;
END;
/
-- CONTINUE link: https://www.oracletutorial.com/plsql-tutorial/plsql-continue/
BEGIN
  FOR n_index IN 1 .. 10
  LOOP
    -- skip odd numbers
    IF MOD( n_index, 2 ) = 1 THEN
      CONTINUE;
    END IF;
    DBMS_OUTPUT.PUT_LINE( n_index );
  END LOOP;
END;
