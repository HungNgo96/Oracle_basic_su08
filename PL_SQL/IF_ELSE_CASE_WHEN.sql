--link https://www.oracletutorial.com/plsql-tutorial/plsql-if/
-- if else level 1
SET SERVEROUT ON;
DECLARE l_number number := 20000;
BEGIN
    IF l_number > 1000 THEN
         DBMS_OUTPUT.PUT_LINE('NUMBER IS GREATER THAN 1K');
    END IF;
END;

-- if else level 2

DECLARE 
l_number1 number := 1000;
l_number2 number := 2000;
BEGIN
    IF l_number1 > l_number2 THEN
    DBMS_OUTPUT.PUT_LINE('Number1 is greater than number2');
    
    ELSE
        DBMS_OUTPUT.PUT_LINE('Number1 is less than number2');
    END IF;
END;
/
-- link https://www.oracletutorial.com/plsql-tutorial/plsql-case-statement/
-- case when level 1
DECLARE
  c_grade CHAR( 1 );
  c_rank  VARCHAR2( 20 );
BEGIN
  c_grade := 'B';
  CASE c_grade
  WHEN 'A' THEN
    c_rank := 'Excellent' ;
  WHEN 'B' THEN
    c_rank := 'Very Good' ;
  WHEN 'C' THEN
    c_rank := 'Good' ;
  WHEN 'D' THEN
    c_rank := 'Fair' ;
  WHEN 'F' THEN
    c_rank := 'Poor' ;
  ELSE
    c_rank := 'No such grade' ;
  END CASE;
  DBMS_OUTPUT.PUT_LINE( c_rank );
END;

--case when level 2
DECLARE
  n_sales      NUMBER;
  n_commission NUMBER;
BEGIN
  n_sales := 150000;
  CASE
  WHEN n_sales    > 200000 THEN
    n_commission := 0.2;
  WHEN n_sales   >= 100000 AND n_sales < 200000 THEN
    n_commission := 0.15;
  WHEN n_sales   >= 50000 AND n_sales < 100000 THEN
    n_commission := 0.1;
  WHEN n_sales    > 30000 THEN
    n_commission := 0.05;
  ELSE
    n_commission := 0;
  END CASE;

  DBMS_OUTPUT.PUT_LINE( 'Commission is ' || n_commission * 100 || '%'
  );
END;

