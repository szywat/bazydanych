-- Etap 2
-- 5. 
SELECT zamowienia.id, zamowienia.data_zamowienia, zamowienia.status, klienci.imie, klienci.nazwisko 
FROM zamowienia 
LEFT JOIN klienci 
ON klienci.id=zamowienia.klienci_id;

-- 6.
SELECT produkty.nazwa, pozycje_zamowien.ilosc, produkty.cena, (produkty.cena * pozycje_zamowien.ilosc) AS wartosc
FROM pozycje_zamowien
LEFT JOIN produkty
ON produkty.id=pozycje_zamowien.produkty_id;

-- 7.
SELECT CONCAT(k.imie,' ', k.nazwisko) AS klient,
COUNT(z.id) AS ilosc_zamowien
FROM klienci k
LEFT JOIN zamowienia z
ON z.klienci_id=k.id
GROUP BY k.id, k.imie, k.nazwisko;
