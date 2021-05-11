SET SERVEROUT ON;
DECLARE
    l_credit_limit   customers.credit_limit%TYPE;
    l_average_credit l_credit_limit%TYPE;
    l_max_credit     l_credit_limit%TYPE;
    l_min_credit     l_credit_limit%TYPE;
BEGIN
    -- get credit limits
    SELECT 
        MIN(credit_limit), 
        MAX(credit_limit), 
        AVG(credit_limit)
    INTO 
        l_min_credit,
        l_max_credit, 
        l_average_credit
    FROM customers;
    
    
    SELECT 
        credit_limit
    INTO 
        l_credit_limit
    FROM 
        customers
    WHERE 
        customer_id = 100;

    -- show the credits     
    dbms_output.put_line('Min Credit: ' || l_min_credit);
    dbms_output.put_line('Max Credit: ' || l_max_credit);
    dbms_output.put_line('Avg Credit: ' || l_average_credit);

    -- show customer credit    
    dbms_output.put_line('Customer Credit: ' || l_credit_limit);
END;