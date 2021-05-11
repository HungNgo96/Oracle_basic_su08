--Link Cursor: https://www.oracletutorial.com/plsql-tutorial/plsql-cursor/

CREATE VIEW sales AS
SELECT customer_id,
       SUM(unit_price * quantity) total,
       ROUND(SUM(unit_price * quantity) * 0.05) credit
FROM order_items
INNER JOIN orders USING (order_id)
WHERE status = 'Shipped'
GROUP BY customer_id;
/
-- example 1
DECLARE
  l_budget NUMBER := 1000000;
   -- cursor
  CURSOR c_sales IS
  SELECT  *  FROM sales1  
  ORDER BY total DESC;
   -- record    
   r_sales c_sales%ROWTYPE;
BEGIN

  -- reset credit limit of all customers
  UPDATE customers SET credit_limit = 0;

  OPEN c_sales;

  LOOP
    FETCH  c_sales  INTO r_sales;
    EXIT WHEN c_sales%NOTFOUND;
    dbms_output.put_line('Creadit ' || r_sales.credit );
   -- dbms_output.put_line( c_sales%NOTFOUND );
    -- update credit for the current customer
    UPDATE 
        customers
    SET  
        credit_limit = 
            CASE WHEN l_budget > r_sales.credit 
                        THEN r_sales.credit 
                            ELSE l_budget
            END
    WHERE 
        customer_id = r_sales.customer_id;

    --  reduce the budget for credit limit
    l_budget := l_budget - r_sales.credit;

    DBMS_OUTPUT.PUT_LINE( 'Customer id: ' ||r_sales.customer_id || 
' Credit: ' || r_sales.credit || ' Remaining Budget: ' || l_budget );

    -- check the budget
    EXIT WHEN l_budget <= 0;
  END LOOP;

  CLOSE c_sales;
END;
/
--- CURSOR FOR LOOP Link: https://www.oracletutorial.com/plsql-tutorial/plsql-cursor-for-loop/
-- EXAMPLE 2
DECLARE
  CURSOR c_product
  IS
    SELECT 
        product_name, list_price
    FROM 
        products 
    ORDER BY 
        list_price DESC;
BEGIN
  FOR r_product IN c_product
  LOOP
    dbms_output.put_line( r_product.product_name || ': $' ||  r_product.list_price );
  END LOOP;
END;
/
-- EXAMPLE 3
BEGIN
  FOR r_product IN (
        SELECT 
            product_name, list_price 
        FROM 
            products
        ORDER BY list_price DESC
    )
  LOOP
     dbms_output.put_line( r_product.product_name ||
        ': $' || 
        r_product.list_price );
  END LOOP;
END;
/
-- EXAMPLE 4 CUROSR WITH PARAMETER

DECLARE
    r_product products%rowtype;
    CURSOR c_product (low_price NUMBER := 50, high_price NUMBER := 60)-- SET DEFAULT VALUE
    IS
        SELECT *
        FROM products
        WHERE list_price BETWEEN low_price AND high_price;
BEGIN
    -- show mass products
    dbms_output.put_line('Mass products: ');
    OPEN c_product(50,100);
    LOOP
        FETCH c_product INTO r_product;
        EXIT WHEN c_product%notfound;
        dbms_output.put_line(r_product.product_name || ': ' ||r_product.list_price);
    END LOOP;
    CLOSE c_product;

    -- show luxury products
    dbms_output.put_line('Luxury products: ');
    OPEN c_product(800,1000);
    LOOP
        FETCH c_product INTO r_product;
        EXIT WHEN c_product%notfound;
        dbms_output.put_line(r_product.product_name || ': ' ||r_product.list_price);
    END LOOP;
    CLOSE c_product;

END;
/