-- Etap 3
-- 8. 
SELECT zamowienia.id, SUM(pozycje_zamowien.ilosc * pozycje_zamowien.cena_jednostkowa) AS wartosc_zamowienia 
FROM zamowienia
LEFT JOIN pozycje_zamowien
ON zamowienia.id=pozycje_zamowien.zamowienia_id
GROUP BY zamowienia.id;

-- 9.
SELECT CONCAT(k.imie, ' ', k.nazwisko) AS klient,
COALESCE(SUM(pz.ilosc * pz.cena_jednostkowa), 0) AS wartosc_zamowienia
FROM klienci k
LEFT JOIN zamowienia z
ON z.klienci_id=k.id
AND z.status IN ('oplacone', 'wyslane')
LEFT JOIN pozycje_zamowien pz
ON pz.zamowienia_id=z.id
GROUP BY k.id, k.imie, k.nazwisko;

-- 10.
SELECT CONCAT(k.imie, ' ', k.nazwisko) AS klient,
SUM(pz.ilosc * pz.cena_jednostkowa) AS wartosc_zamowienia
FROM klienci k
LEFT JOIN zamowienia z
ON z.klienci_id=k.id
LEFT JOIN pozycje_zamowien pz
ON pz.zamowienia_id=z.id
GROUP BY k.id, k.imie, k.nazwisko
HAVING SUM(pz.ilosc * pz.cena_jednostkowa) > 500;

-- 11.
SELECT * 
FROM produkty
WHERE produkty.cena > (SELECT AVG(produkty.cena) FROM produkty);

-- 12.
SELECT * 
FROM klienci k
WHERE NOT EXISTS (SELECT * FROM zamowienia z WHERE z.klienci_id = k.id);
