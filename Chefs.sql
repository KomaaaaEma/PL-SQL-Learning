SET SERVEROUTPUT ON

SET VERIFY OFF

--Задание 5. Создание таблицы шефов, в которой должны быть идентификаторы поваров, их имена и даты рождения
CREATE TABLE chefs (
    chef_id     INTEGER NOT NULL,
    full_name   VARCHAR2(80) NOT NULL,
    birth_date  DATE NOT NULL
);

--Задание 6. Процедура, которая будет принимать на вход ФИО повара, его дату рождения и добавлять данные в таблицу
--Создадим последовательность идентификаторов поваров
CREATE SEQUENCE chef_seq 
MINVALUE 1 
MAXVALUE 99999 
START WITH 1 
INCREMENT BY 1 
CACHE 20;

--DROP SEQUENCE chef_seq;

--Сама процедура
CREATE PROCEDURE add_chef (
    full_name_p  IN  VARCHAR2,
    birthday_p   IN  DATE
) IS
BEGIN
    INSERT INTO chefs (
        chef_id,
        full_name,
        birth_date
    ) VALUES (
        chef_seq.NEXTVAL,
        add_chef.full_name_p,
        add_chef.birthday_p
    );

END add_chef;
--Заполнение таблицы
DECLARE
    TYPE first_name IS
        VARRAY(10) OF VARCHAR2(30);
    TYPE last_name IS
        VARRAY(10) OF VARCHAR2(30);
    first_names_l    first_name := first_name( 'Александр', 'Павел', 'Илья', 'Энтони', 'Марио', 'Луиджи', 'Гай', 'Гордон', 'Пьер', 'Вольфганг' );
    last_names_l     last_name := last_name( 'Бурден', 'Фиери', 'Пак', 'Уайт', 'Рамзи', 'Рождественский', 'Оливер', 'Бонапарт', 'Робюшон', 'Поль' );
    chefs_count      INTEGER := &chefs_count;
    chef_first_name  VARCHAR2(30);
    chef_last_name   VARCHAR2(30);
    birthday_l       DATE;
BEGIN
    FOR i IN 1..chefs_count LOOP
        chef_first_name := first_names_l(dbms_random.value(1, 10));
        chef_last_name := last_names_l(dbms_random.value(1, 10));
        birthday_l := to_date(trunc(dbms_random.value(to_char(DATE '1970-01-01', 'J'), to_char(DATE '2003-01-01', 'J'))), 'J');
        add_chef(chef_first_name || ' ' || chef_last_name, birthday_l);
    END LOOP;
END;

--SELECT * FROM CHEFS;
--DELETE FROM chefs
--WHERE EXISTS (SELECT * FROM chefs);

/*Задание 7. Создать таблицу cooking_skills (умение повара), в таблице должен быть идентификатор умения 
и название умения. Например: Выпекание тортов, выпекание пирожных, утка по пекински */

CREATE TABLE cooking_skills
    (cook_skill_id INTEGER NOT NULL,
    cook_skill_name VARCHAR2(50) NOT NULL);

CREATE SEQUENCE cook_skill_seq
MINVALUE 1
MAXVALUE 9999
START WITH 1
INCREMENT BY 1
CACHE 20;
--DROP SEQUENCE cook_skill_seq;

INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, 'Выпекание тортов');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, 'Выпекание пирожных');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, 'Утка по пекински');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, 'Морепродукты');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, 'Пицца');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, 'Тайская кухня');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, 'Вьетнамская кухня');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, 'Шашлык-башлык');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, 'Кавказкая кухня');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, 'Суши');

DELETE FROM cooking_skills
WHERE EXISTS (SELECT * FROM cooking_skills);

/*Задание 8. Создать таблицу chef_skill_links , связь поваров и их умений, 
в таблице так же должна быть дата с которой повар овладел умением.*/

/*Задание 9.Написать запрос, который вернет ФИО и даты рождения всех поваров 
умеющих выпекать торты.*/

--Задание 10. Написать функцию, которая вернет день рождения самого молодого повара.
CREATE FUNCTION youngest_chef
    RETURN DATE
IS
    youngest_chef_birth DATE;
BEGIN
    SELECT MAX(birth_date) INTO youngest_chef_birth FROM chefs;
    RETURN youngest_chef_birth;
END youngest_chef;

/*Задание 11. Написать запрос, который вернет всех поваров старше 30 лет 
и перечень умений для каждого из них.*/

/*Задание 12. Написать запрос, который вернет всех поваров научившихся печь пирожные
в возрасте моложе 20 лет.*/

--Задание 13. Написать функцию, которая по идентификатору повара вернёт ФИО повара

CREATE FUNCTION chef_FIO(chef_id_f IN INTEGER)
    RETURN VARCHAR2
IS
    fio VARCHAR2(50);
BEGIN
    SELECT full_name into chef_FIO.fio from chefs WHERE chef_id = chef_FIO.chef_id_f;
    return fio;
END;

--Демонстрация заданий 10, 13
BEGIN
    DBMS_OUTPUT.PUT_LINE(youngest_chef());
    DBMS_OUTPUT.PUT_LINE(chef_FIO(TO_NUMBER('&Integer')));
END;

/*Задание 14.Написать запрос, который вернёт всех поваров у которых 
фамилия начинается на букву "П".*/
SELECT full_name FROM chefs
WHERE substr(full_name, INSTR(full_name, ' ')+1, 1) ='П';

/*Задание 15. Написать запрос, который вернёт количество поваров в возрастных группах: 10-20, 20-30, 
30-40, 40-50, 50-60, 60-70, 70-80, 80-90, 90-100, умеющих варить суп.*/

/*Задание 16. Предложите схему для разделения умений поваров на группы и категории.
Например:
группы - холодные закуски, гарниры, выпечка, десерты;
категории - сложные рецепты, легкие рецепты, рецепты требующие особых навыков.*/
