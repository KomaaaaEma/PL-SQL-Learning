SET SERVEROUTPUT ON
SET verify off

--��������. ������� 1
CREATE FUNCTION summator
    (num1 IN NUMBER,
    num2 in NUMBER)
    RETURN NUMBER
IS
    result NUMBER;
BEGIN
    result := num1 + num2;
    RETURN result;
END;


--����� ����� � �������. ������� 2
--������� �������� ��� ������� � ��������� ������, ����� � ���� ����� ���� ���������� � � �������
CREATE PACKAGE arr_number_p AS
    type number_array IS VARRAY(50) OF PLS_INTEGER;
END;
--��������������� ���� �������
CREATE FUNCTION array_total
    (num_array IN arr_number_p.number_array)
    RETURN NUMBER
IS
    arr_total NUMBER := 0;
BEGIN
    for i in 1 .. num_array.count
    LOOP
        arr_total := arr_total + num_array(i);
    END LOOP;
    RETURN arr_total;
END array_total;


--������� ����. ������� 3
CREATE FUNCTION right_now
    RETURN varchar2
IS
    current_moment VARCHAR2(50);
BEGIN
    select to_char(current_date, 'dd.mm.yyyy hh24:mi') INTO current_moment FROM dual;
    return current_moment;
END right_now;


--��� �����. ������� 4
CREATE FUNCTION without_digits
    (str1 VARCHAR2,
    str2 VARCHAR2)
    RETURN VARCHAR2
IS
    l_str1 VARCHAR2(250) := str1;
    l_str2 l_str1%TYPE := str2;
    result_string VARCHAR2(500);
BEGIN
    FOR counter IN 0 .. 9
    LOOP
        l_str1 := REPLACE(l_str1, TO_CHAR(counter));
        l_str2 := REPLACE(l_str2, TO_CHAR(counter));
    END LOOP;
    result_string := l_str1 || l_str2;
    return result_string;
END without_digits;


--������������ ������ �������
DECLARE
    num1 NUMBER := &num1;
    num2 num1%TYPE := &num2;
    str1 VARCHAR2(250) := '&str1';
    str2 VARCHAR2(250) := '&str2';
    num_array arr_number_p.number_array := arr_number_p.number_array();
BEGIN
    DBMS_OUTPUT.PUT_LINE('������������ ������� ��������. ���������� num1 = ' || num1 || ', ���������� num2 = ' || num2);
    DBMS_OUTPUT.PUT_LINE('�� ����� �����: ' || summator(num1, num2));
    
    DBMS_OUTPUT.PUT_LINE('����� ������:');
    DBMS_OUTPUT.PUT_LINE(right_now());
    
    DBMS_OUTPUT.PUT_LINE('����� ��������� �������');    
    DBMS_OUTPUT.PUT_LINE('�������� ������ �� 50 ����� ����� �� 0 �� 100');
    num_array.EXTEND(50);
    for i in 1 .. 50
    Loop        
        SELECT ROUND(DBMS_RANDOM.VALUE(0, 100)) INTO num_array(i) FROM DUAL;
        DBMS_OUTPUT.PUT(num_array(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('����� ��������� ������� �����: ');
    DBMS_OUTPUT.PUT_LINE(array_total(num_array));
    
    DBMS_OUTPUT.PUT_LINE('������������ �������� ����� �� ����� � ������������ ������');
    DBMS_OUTPUT.PUT_LINE(without_digits(str1, str2));
END;