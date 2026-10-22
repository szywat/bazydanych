-- Etap 1
-- 1. klucze główne:
--      klienci - id
--      pozycje_zamowien - id
--      produkty - id
--      zamowienia - id
--    klucze obce:
--      zamowienia - klienci_id
--      pozycje_zamowien - zamowienia_id, produkty_id
-- 
--  Wyjaśnienie łączenie zamówień z produktmai przez tabele pozycje_zamowien:
--      Tabela zamowienia i produkty są połączone relacją 0 lub wiele do wielu poprzez tabelę pozycje_zamowien,
--          która przyjmuje ich klucze główne jako klucze obce, tj. zamowienia_id i produkty_id.
--      Dzięki temu jesteśmy w stanie przypisać konkretny produkt do wielu zamówień (o ile stan magazynowy nam na to pozwala) oraz sprawdzić jakie zamówienie ma jakie produkty.

-- 2.
SELECT nazwa, cena, stan_magazynowy FROM produkty WHERE cena > 100.00 ORDER BY cena DESC, id ASC;

-- 3.
SELECT imie, nazwisko, miasto FROM klienci WHERE miasto IN ('Gdańsk', 'Gdynia');

-- 4.
SELECT * FROM produkty WHERE stan_magazynowy=0;