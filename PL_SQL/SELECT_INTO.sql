-- LINK: https://www.oracletutorial.com/plsql-tutorial/plsql-select-into/
-- SELECT INTO level1

SET SERVEROUT ON;
DECLARE
  l_customer_name customers.name%TYPE;-- %TYPE get column in row
BEGIN
  -- get name of the customer 100 and assign it to l_customer_name
  SELECT name INTO l_customer_name
  FROM customers
  WHERE customer_id = 111100;
  -- show the customer name
  dbms_output.put_line( l_customer_name );
  
  EXCEPTION
        WHEN no_data_found THEN
          dbms_output.put_line('NOT FOUND THIS CUSTOMER');
END;
/
-- SELECT INTO level 2

DECLARE
  r_customer customers%ROWTYPE;--%ROWYPE get row
BEGIN
  -- get the information of the customer 100
  SELECT * INTO r_customer
  FROM customers
  WHERE customer_id = 100;
  -- show the customer info
  dbms_output.put_line( r_customer.name || ', website: ' || r_customer.website );
END;
/
-- SELECT INTO level 3

DECLARE
  l_customer_name customers.name%TYPE;
  l_contact_first_name contacts.first_name%TYPE;
  l_contact_last_name contacts.last_name%TYPE;
BEGIN
  -- get customer and contact names
  SELECT
    name, 
    first_name, 
    last_name
  INTO
    l_customer_name, 
    l_contact_first_name, 
    l_contact_last_name
  FROM
    customers
  INNER JOIN contacts USING( customer_id )
  WHERE
    customer_id = 100;
  -- show the information  
  dbms_output.put_line( 
    l_customer_name || ', Contact Person: ' ||
    l_contact_first_name || ' ' || l_contact_last_name );
END;