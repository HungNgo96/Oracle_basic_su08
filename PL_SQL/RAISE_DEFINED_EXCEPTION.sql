-- LINK: https://www.oracletutorial.com/plsql-tutorial/plsql-raise/
--syntax
/*
DECLARE
    exception_name EXCEPTION;
*/

-- syntax PRAGMA  
/*
DECLARE
    exception_name EXCEPTION;
    PRAGMA EXCEPTION_INIT (exception_name, error_number);
*/

-- example 1
DECLARE
    e_credit_too_high EXCEPTION;
    PRAGMA exception_init( e_credit_too_high, -20001 );-- define exceptions raise with pragma
    l_max_credit customers.credit_limit%TYPE;
    l_customer_id customers.customer_id%TYPE := &customer_id;
    l_credit customers.credit_limit%TYPE := &credit_limit;
BEGIN
    -- get the meax credit limit
    SELECT MAX(credit_limit) 
    INTO l_max_credit
    FROM customers;
    
    -- check if input credit is greater than the max credit
    IF l_credit > l_max_credit THEN 
        --RAISE e_credit_too_high;
        raise_application_error(-20001,'Credit is too high');--with message
    END IF;
    
    -- if not, update credit limit
    UPDATE customers 
    SET credit_limit = l_credit
    WHERE customer_id = l_customer_id;
    
    COMMIT;
END;
/

-- example 2 with custom exception
DECLARE
    e_credit_too_high EXCEPTION;
    PRAGMA exception_init( e_credit_too_high, -20001 );
    l_max_credit customers.credit_limit%TYPE;
    l_customer_id customers.customer_id%TYPE := &customer_id;
    l_credit customers.credit_limit%TYPE     := &credit_limit;
BEGIN
    BEGIN
        -- get the max credit limit
        SELECT MAX(credit_limit) 
        INTO l_max_credit
        FROM customers;
        
        -- check if input credit is greater than the max credit
        IF l_credit > l_max_credit THEN 
            RAISE e_credit_too_high;
        END IF;
        --exception 1
        EXCEPTION
            WHEN e_credit_too_high THEN
                dbms_output.put_line('The credit is too high' || l_credit);
                RAISE; -- reraise the exception
    END;
    --exception 2
        EXCEPTION
            WHEN e_credit_too_high THEN
                -- get average credit limit
                SELECT avg(credit_limit) 
                into l_credit
                from customers;
                
                -- adjust the credit limit to the average
                dbms_output.put_line('Adjusted credit to ' || l_credit);
            
                --  update credit limit
                UPDATE customers 
                SET credit_limit = l_credit
                WHERE customer_id = l_customer_id;
           
                COMMIT;
                    
END;
/

-- Exception Propagation link: https://www.oracletutorial.com/plsql-tutorial/plsql-exception-propagation/
-- example 3
DECLARE
    e1 EXCEPTION;
    PRAGMA exception_init (e1, -20001);
    e2 EXCEPTION;
    PRAGMA exception_init (e2, -20002);
    e3 EXCEPTION;
    PRAGMA exception_init (e2, -20003);
    l_input NUMBER := &input_number;
BEGIN
    -- inner block
    BEGIN
        IF l_input = 1 THEN
            raise_application_error(-20001,'Exception: the input number is 1');
        ELSIF l_input = 2 THEN
            raise_application_error(-20002,'Exception: the input number is 2');
        ELSE
            raise_application_error(-20003,'Exception: the input number is not 1 or 2');
        END IF;
    -- exception handling of the inner block
    EXCEPTION
        WHEN e1 THEN 
            dbms_output.put_line('Handle exception when the input number is 1');
    END;
    -- exception handling of the outer block
    EXCEPTION 
        WHEN e2 THEN
            dbms_output.put_line('Handle exception when the input number is 2');
END;
/

-- Handling Other Unhandled Exceptions link:https://www.oracletutorial.com/plsql-tutorial/oracle-sqlcode/

-- example 4
DECLARE
    l_code NUMBER;
    l_msg VARCHAR2(20000);
    r_customer customers%rowtype;
BEGIN
    SELECT * INTO r_customer FROM customers;
    
    EXCEPTION 
        WHEN OTHERS THEN
        l_code := SQLCODE;--return error code
        l_msg := SQLERRM;  -- return error message
        dbms_output.put_line('Error code:' || l_code ||' Error mess '|| l_msg);
END;
/
-- example 5
DECLARE
    l_first_name  contacts.first_name%TYPE := 'Flor';
    l_last_name   contacts.last_name%TYPE := 'Stone';
    l_email       contacts.email%TYPE := 'flor.stone@raytheon.com';
    l_phone       contacts.phone%TYPE := '+1 317 123 4105';
    l_customer_id contacts.customer_id%TYPE := -1;
BEGIN
    -- insert a new contact
    INSERT INTO contacts(first_name, last_name, email, phone, customer_id)
    VALUES(l_first_name, l_last_name, l_email, l_phone, l_customer_id);
    
    EXCEPTION 
        WHEN OTHERS THEN
            DECLARE
                l_error PLS_INTEGER := SQLCODE;
                l_msg VARCHAR2(255) := sqlerrm;
            BEGIN
                CASE l_error 
                WHEN -1 THEN
                    -- duplicate email
                    dbms_output.put_line('duplicate email found ' || l_email);
                    dbms_output.put_line(l_msg);
                    
                WHEN -2291 THEN
                    -- parent key not found
                    dbms_output.put_line('Invalid customer id ' || l_customer_id);
                    dbms_output.put_line(l_msg);
                END CASE;
                -- reraise the current exception
                RAISE;
            END;
            
END;
/