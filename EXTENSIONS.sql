SET SERVEROUTPUT ON SIZE UNLIMITED
--Первая обработка исключений
DECLARE
    num1 NUMBER;
BEGIN
    num1 := 'SABAKA';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = 06502 THEN
            DBMS_OUTPUT.PUT_LINE('ошибка преобразования символа в число ошибка числа или значения1');
        elsif SQLCODE = 06512 THEN
            DBMS_OUTPUT.PUT_LINE('ошибка преобразования символа в число ошибка числа или значения2');
        else
            DBMS_OUTPUT.PUT_LINE('Произошла ошибка SABAKA');
        END IF;
END;

--Обработка исключения связанного с номером. По сути дела, реалезована не верно
DECLARE
    num1 number := 0;
    too_much EXCEPTION;
    PRAGMA EXCEPTION_INIT(too_much, -1460);
BEGIN
    LOOP
        num1 := num1 + 1;
        DBMS_OUTPUT.PUT_LINE('INSIDE LOOP NUM1 = ' || num1);
        IF num1 >= 5 THEN
            RAISE too_much;
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1460 THEN
            DBMS_OUTPUT.PUT_LINE('ВЕЛИКАЯ ОШИБКА');
        END IF;
END;

--Исключение вызывается при помощи RAISE_APPLICATION_ERROR, которое позволяет добавить сообщение ошибке
DECLARE
    num1 number := 0;
    too_much EXCEPTION;
    PRAGMA EXCEPTION_INIT(too_much, -20144);
BEGIN
    LOOP
        num1 := num1 + 1;
        DBMS_OUTPUT.PUT_LINE('INSIDE LOOP NUM1 = ' || num1);
        IF num1 >= 5 THEN
            RAISE_APPLICATION_ERROR(-20144, 'SABAKA');
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -20144 THEN
            DBMS_OUTPUT.PUT_LINE('ВЕЛИКАЯ ОШИБКА ЧЕРЕЗ -20144');
            DBMS_OUTPUT.PUT_LINE(SQLCODE || ' ошибка, текст: ' || SQLERRM);
        END IF;
END;

--Попытка воспользоваться DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
DECLARE
    num1 number := 0;
    too_much EXCEPTION;
    PRAGMA EXCEPTION_INIT(too_much, -20144);
BEGIN
    LOOP
        num1 := num1 + 1;
        DBMS_OUTPUT.PUT_LINE('INSIDE LOOP NUM1 = ' || num1);
        IF num1 >= 5 THEN
            RAISE_APPLICATION_ERROR(-20144, 'SABAKA');
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -20144 THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
        END IF;
END;

