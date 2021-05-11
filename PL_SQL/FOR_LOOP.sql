-- link https://www.oracletutorial.com/plsql-tutorial/plsql-loop/
-- LOOP with exit;
SET SERVEROUT ON;
DECLARE 
l_count number := 0;
BEGIN
    LOOP
        l_count := l_count + 1;
        IF l_count > 10 THEN
            l_count := l_count - 1;
            EXIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Inside loop: ' || l_count); 
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('After loop: ' || l_count);
END;
/
-- LOOP with exit when

DECLARE 
l_count number := 0;
BEGIN

    LOOP
        l_count := l_count + 1;
        EXIT WHEN l_count > 5;
        DBMS_OUTPUT.PUT_LINE('Inside loop: ' || l_count);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('After loop: '|| l_count);
END;
/
-- LOOP with nested loops
DECLARE
l_i number := 0;
l_j number := 0;
BEGIN
    <<outer_loop>>
    LOOP
    l_i := l_i + 1;
    EXIT outer_loop WHEN l_i > 2;
     dbms_output.put_line('Outer counter ' || l_i);
     l_j := 0;
          <<inner_loop>> LOOP
          l_j := l_j + 1;
          EXIT inner_loop WHEN l_j > 3;
          dbms_output.put_line(' Inner counter ' || l_j);
        END LOOP inner_loop;
    END LOOP outer_loop;
    
END;
/
-- link https://www.oracletutorial.com/plsql-tutorial/plsql-for-loop/
-- for loop

BEGIN

    FOR l_counter in 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(l_counter);
    END LOOP;

END;
