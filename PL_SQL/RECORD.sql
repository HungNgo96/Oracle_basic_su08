-- LINK: https://www.oracletutorial.com/plsql-tutorial/plsql-record/
-- RECORD level 1

/*
syntax
DECLARE
   record_name table_name%ROWTYPE;
*/

/*
EXAMPLE 1:
DECLARE
   r_contact contacts%ROWTYPE;
*/

/*
EXAMPLE 2:
DECLARE
    record_name cursor_name%ROWTYPE;
*/
/*
DECLARE
    CURSOR c_contacts IS
        SELECT first_name, last_name, phone
        FROM contacts;
    r_contact c_contacts%ROWTYPE;
*/

/*
  TYPE record_type IS RECORD (
    field_name1 data_type1 [[NOT NULL] := | DEFAULT default_value],
    field_name2 data_type2 [[NOT NULL] := | DEFAULT default_value],
    ...
);*/
DECLARE
  -- define a record type
TYPE r_customer_contact_t
IS
  RECORD
  (
    customer_name customers.name%TYPE,
    first_name    contacts.first_name%TYPE,
    last_name     contacts.last_name%TYPE );
  -- declare a record
  r_customer_contacts r_customer_contact_t;
BEGIN
  NULL;
END;

