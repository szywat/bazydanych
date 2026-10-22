-- Etap 5
-- 16.

SELECT * FROM klienci WHERE id = 1;
SELECT * FROM produkty WHERE id = 3;

-- Scenariusz 1: ROLLBACK
BEGIN TRANSACTION;

INSERT INTO zamowienia (klienci_id, data_zamowienia, status)
VALUES (1, CURRENT_DATE, 'nowe');
-- currval zwraca id, które zamówienie dostało przed chwilą w tej sesji
INSERT INTO pozycje_zamowien (zamowienia_id, produkty_id, ilosc, cena_jednostkowa)
VALUES (currval('zamowienia_id_seq'), 3, 2, (SELECT cena FROM produkty WHERE id = 3));

UPDATE produkty
SET stan_magazynowy = stan_magazynowy - 2
WHERE id = 3 AND stan_magazynowy >= 2;

ROLLBACK TRANSACTION;

-- Sprawdzenie: zamówienie i pozycja zniknęły, stan wrócił do 5
SELECT * FROM zamowienia WHERE id > 180;
SELECT * FROM pozycje_zamowien WHERE zamowienia_id > 180;
SELECT stan_magazynowy FROM produkty WHERE id = 3;

-- Scenariusz 2: COMMIT
BEGIN TRANSACTION;

INSERT INTO zamowienia (klienci_id, data_zamowienia, status)
VALUES (1, CURRENT_DATE, 'nowe');

INSERT INTO pozycje_zamowien (zamowienia_id, produkty_id, ilosc, cena_jednostkowa)
VALUES (currval('zamowienia_id_seq'), 3, 2, (SELECT cena FROM produkty WHERE id = 3));

UPDATE produkty
SET stan_magazynowy = stan_magazynowy - 2
WHERE id = 3 AND stan_magazynowy >= 2;

COMMIT TRANSACTION;

-- Sprawdzenie: zamówienie i pozycja zapisane, stan zmniejszony do 3
SELECT * FROM zamowienia WHERE id > 180;
SELECT * FROM pozycje_zamowien WHERE zamowienia_id > 180;
SELECT stan_magazynowy FROM produkty WHERE id = 3;

-- Dlaczego jedna transakcja:
-- Utworzenie zamówienia, dodanie pozycji i zmniejszenie stanu magazynowego
-- to jedna operacja sprzedaży. Muszą się wykonać wszystkie albo żadna (atomowość).
-- Gdyby wykonywać je osobno, błąd w trakcie (np. brak towaru) zostawiłby
-- w bazie zamówienie bez pozycji albo pozycję bez zmniejszonego stanu.
-- Transakcja pozwala wtedy wycofać wszystkie zmiany naraz.