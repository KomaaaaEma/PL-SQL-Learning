SET SERVEROUTPUT ON

SET VERIFY OFF

--������� 5. �������� ������� �����, � ������� ������ ���� �������������� �������, �� ����� � ���� ��������
CREATE TABLE chefs (
    chef_id     INTEGER NOT NULL,
    full_name   VARCHAR2(80) NOT NULL,
    birth_date  DATE NOT NULL
);

--������� 6. ���������, ������� ����� ��������� �� ���� ��� ������, ��� ���� �������� � ��������� ������ � �������
--�������� ������������������ ��������������� �������
CREATE SEQUENCE chef_seq 
MINVALUE 1 
MAXVALUE 99999 
START WITH 1 
INCREMENT BY 1 
CACHE 20;

--DROP SEQUENCE chef_seq;

--���� ���������
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
--���������� �������
DECLARE
    TYPE first_name IS
        VARRAY(10) OF VARCHAR2(30);
    TYPE last_name IS
        VARRAY(10) OF VARCHAR2(30);
    first_names_l    first_name := first_name( '���������', '�����', '����', '������', '�����', '������', '���', '������', '����', '���������' );
    last_names_l     last_name := last_name( '������', '�����', '���', '����', '�����', '��������������', '������', '��������', '�������', '����' );
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

/*������� 7. ������� ������� cooking_skills (������ ������), � ������� ������ ���� ������������� ������ 
� �������� ������. ��������: ��������� ������, ��������� ��������, ���� �� �������� */

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

INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, '��������� ������');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, '��������� ��������');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, '���� �� ��������');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, '������������');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, '�����');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, '������� �����');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, '����������� �����');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, '������-������');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, '��������� �����');
INSERT INTO cooking_skills(cook_skill_id, cook_skill_name) VALUES (cook_skill_seq.NEXTVAL, '����');

DELETE FROM cooking_skills
WHERE EXISTS (SELECT * FROM cooking_skills);

/*������� 8. ������� ������� chef_skill_links , ����� ������� � �� ������, 
� ������� ��� �� ������ ���� ���� � ������� ����� ������� �������.*/

/*������� 9.�������� ������, ������� ������ ��� � ���� �������� ���� ������� 
������� �������� �����.*/

--������� 10. �������� �������, ������� ������ ���� �������� ������ �������� ������.
CREATE FUNCTION youngest_chef
    RETURN DATE
IS
    youngest_chef_birth DATE;
BEGIN
    SELECT MAX(birth_date) INTO youngest_chef_birth FROM chefs;
    RETURN youngest_chef_birth;
END youngest_chef;

/*������� 11. �������� ������, ������� ������ ���� ������� ������ 30 ��� 
� �������� ������ ��� ������� �� ���.*/

/*������� 12. �������� ������, ������� ������ ���� ������� ����������� ���� ��������
� �������� ������ 20 ���.*/

--������� 13. �������� �������, ������� �� �������������� ������ ����� ��� ������

CREATE FUNCTION chef_FIO(chef_id_f IN INTEGER)
    RETURN VARCHAR2
IS
    fio VARCHAR2(50);
BEGIN
    SELECT full_name into chef_FIO.fio from chefs WHERE chef_id = chef_FIO.chef_id_f;
    return fio;
END;

--������������ ������� 10, 13
BEGIN
    DBMS_OUTPUT.PUT_LINE(youngest_chef());
    DBMS_OUTPUT.PUT_LINE(chef_FIO(TO_NUMBER('&Integer')));
END;

/*������� 14.�������� ������, ������� ����� ���� ������� � ������� 
������� ���������� �� ����� "�".*/
SELECT full_name FROM chefs
WHERE substr(full_name, INSTR(full_name, ' ')+1, 1) ='�';

/*������� 15. �������� ������, ������� ����� ���������� ������� � ���������� �������: 10-20, 20-30, 
30-40, 40-50, 50-60, 60-70, 70-80, 80-90, 90-100, ������� ������ ���.*/

/*������� 16. ���������� ����� ��� ���������� ������ ������� �� ������ � ���������.
��������:
������ - �������� �������, �������, �������, �������;
��������� - ������� �������, ������ �������, ������� ��������� ������ �������.*/
