-- Etap 4
-- 13.
SELECT * FROM klienci;
BEGIN TRANSACTION;
INSERT INTO klienci (imie, nazwisko, email, miasto)
VALUES ('Janusz', 'Kowalski', 'example@example.com', 'Gdańsk');
UPDATE klienci
SET miasto= 'Sopot'
WHERE klienci.email = 'example@example.com';
ROLLBACK TRANSACTION; 

-- 14.
SELECT * FROM produkty;
BEGIN TRANSACTION;
INSERT INTO produkty (nazwa, kategoria, cena, stan_magazynowy)
VALUES ('produkt testowy', 'test', 99.00, 1);
UPDATE produkty
SET cena=49.00
WHERE produkty.nazwa = 'produkt testowy';

DELETE FROM produkty WHERE produkty.nazwa = 'produkt testowy';
ROLLBACK TRANSACTION; 

-- 15.
SELECT * FROM klienci;
BEGIN TRANSACTION;
INSERT INTO klienci (imie, nazwisko, email, miasto)
VALUES ('Janusz', 'Kowalski', 'klient01@example.com', 'Gdańsk') -- duplicate key value violates unique constraint "uq_klienci_email"

ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
UPDATE produkty
SET stan_magazynowy= -1
WHERE produkty.id = 1; -- new row for relation "produkty" violates check constraint "ck_produkty_stan"
ROLLBACK TRANSACTION;

BEGIN TRANSACTION;
INSERT INTO zamowienia (klienci_id, data_zamowienia, status)
VALUES (100, (SELECT CURRENT_DATE), 'nowe'); -- insert or update on table "zamowienia" violates foreign key constraint "fk_zamowienia_klient"
ROLLBACK TRANSACTION;