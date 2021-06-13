SET SERVEROUTPUT ON

DECLARE
    num1 NUMBER := 5;
    num2 NUMBER;
BEGIN
    dbms_output.put_line('Простая команда CASE');
  CASE num1
    WHEN 5 THEN DBMS_OUTPUT.PUT_LINE('five');
    WHEN 0 THEN DBMS_OUTPUT.PUT_LINE('zero');
    ELSE DBMS_OUTPUT.PUT_LINE('Nothing');
    END CASE;

    dbms_output.put_line('Поисковая команда CASE');
    case 
        when num1 = 5 then dbms_output.put_line('five');
        when num1 = 0 then dbms_output.put_line('zero');
        else dbms_output.put_line('nothing');
    end case;
    
    dbms_output.put_line('Попытка использования case-выражения');
    num2 := case
        when num1 > 4 then 2
        when num1 = 0 then 1
        else 3
        end;
    DBMS_OUTPUT.PUT_LINE(num2);
END;