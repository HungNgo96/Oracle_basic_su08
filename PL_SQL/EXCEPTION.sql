--link: https://www.oracletutorial.com/plsql-tutorial/plsql-exception/

/*
- syntax
BEGIN
    -- executable section
    ...
    -- exception-handling section
    EXCEPTION 
        WHEN e1 THEN 
            -- exception_handler1
        WHEN e2 THEN 
            -- exception_handler1
        WHEN OTHERS THEN
            -- other_exception_handler
END;
*/


-- exception for NO_DATA_FOUND
DECLARE
    l_name customers.NAME%TYPE;
    l_customer_id customers.customer_id%TYPE := &customer_id; -- &customer_id TEST enter values 
BEGIN
    -- get the customer
    SELECT NAME INTO l_name
    FROM customers
    WHERE customer_id = l_customer_id;
    
    -- show the customer name   
    dbms_output.put_line('customer name is ' || l_name);

    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Customer ' || l_customer_id ||  ' does not exist');
END;
/
-- exception level 2 with two exception in PL/SQL
DECLARE
    l_name customers.NAME%TYPE;
    l_customer_id customers.customer_id%TYPE := &customer_id;
BEGIN
    -- get the customer
    SELECT NAME INTO l_name
    FROM customers
    WHERE customer_id > l_customer_id;
    
    -- show the customer name   
    dbms_output.put_line('Customer name is ' || l_name);
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Customer ' || l_customer_id ||  ' does not exist');
        WHEN TOO_MANY_ROWS THEN
            dbms_output.put_line('The database returns more than one customer');    
END;
/