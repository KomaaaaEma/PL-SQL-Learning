SET SERVEROUTPUT ON

DECLARE 
    l_num INTEGER := 0;
    CURSOR employee_cur IS SELECT * FROM employees;
BEGIN
    DBMS_OUTPUT.PUT_LINE('������� ����');
    LOOP
        DBMS_OUTPUT.PUT_LINE('Inside loop:  l_num = ' || l_num);
        IF l_num > 5 THEN
            EXIT;
        END IF;
        l_num := l_num + 1;
    END LOOP;
    
    DBMS_OUTPUT.NEW_LINE();
    l_num := 0;
    
    DBMS_OUTPUT.PUT_LINE('������� ���� � EXIT WHEN');
    LOOP
        DBMS_OUTPUT.PUT_LINE('Inside loop:  l_num = ' || l_num);
        EXIT WHEN l_num > 5;
        l_num := l_num + 1;
    END LOOP; 
    
    l_num := 0;
    DBMS_Output.new_line;
    
    DBMS_OUTPUT.PUT_LINE('���� WHILE');
    WHILE l_num <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE('Inside loop:  l_num = ' || l_num);
        l_num := l_num + 1;
    END LOOP;
    
    DBMS_OUTPUT.NEW_LINE;
    dbms_output.put_line('���� FOR � �������� ���������');
    FOR counter IN 0 .. 6
    LOOP
        DBMS_OUTPUT.PUT_LINE('Inside loop: l_num = ' || l_num || ' Counter = ' || counter);
        l_num := l_num - 1;
    END LOOP;
    
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('������� ������� ���� ��� � ��������, ������� �� �������');
    FOR counter IN (SELECT * FROM employees)
    LOOP
        DBMS_OUTPUT.PUT_LINE(counter.first_name || ' ' || counter.last_name);
    END LOOP;
    
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('� ������ �� ��������� �������� ���� ��� � ���������� ����� ��������');
    FOR counter IN employee_cur
    LOOP
        DBMS_OUTPUT.PUT_LINE(counter.last_name || ' ' || counter.first_name);
    END LOOP;
END;

