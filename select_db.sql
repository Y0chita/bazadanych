--1.Wyświetla imiona osób które są zapisane na dany koncert
SELECT imie, nazwisko, wydarzenie.nazwa
FROM bilet
INNER JOIN wydarzenie ON wydarzenie.id = bilet.wydarzenie_id
INNER JOIN klient ON klient.id = bilet.klient_id
ORDER BY wydarzenie.nazwa;

--2.Wyświetla ile osób jest kupiło bilet na dany koncert
SELECT nazwa, count(*) AS liczba_kupionych_biletow FROM wydarzenie
INNER JOIN bilet ON wydarzenie.id = bilet.wydarzenie_id
GROUP BY wydarzenie.nazwa;

--3.Wyświetla jaki artysta potrzebuje jakiego zapasowego instrumentu
SELECT a.id, a.imie, i.nazwa AS instrument
FROM artysta a, instrument i
WHERE a.instrument_id = i.id;

--4.Wyświetla jaki artysta potrzebuje jakiego zapasowego instrumentu tylko dla wybranego zespołu
SELECT imie, instrument.nazwa FROM (artysta
INNER JOIN instrument ON artysta.instrument_id = instrument.id)
INNER JOIN zespol ON zespol.id = artysta.zespol_id
WHERE zespol.nazwa = 'Slipknot'
ORDER BY nazwa;

--5.Wyświetla osobyu kupujące bilet których nazwisko zaczyna się na K
SELECT * FROM klient WHERE nazwisko LIKE 'K%';

--6.Wyświetla artystów na ktorych nie trzeba specjalnie przygotowywac zapasowych instrumentów
SELECT * FROM artysta WHERE instrument_id IS NULL;

--7.Wyświetla przerwe między koncertami danego zespołu
SELECT
	w1.nazwa AS nazwa_wydarzenia,
    w1.data AS data_wydarzenia,
    w2.nazwa AS nazwa_nastepnego_wydarzenia,
    w2.data AS data_nastepnego_wydarzenia,
    EXTRACT(DAY FROM (w2.data - w1.data)) AS przerwa_dni
FROM
    wydarzenie w1
JOIN
    wydarzenie w2 ON w1.zespol_id = w2.zespol_id
WHERE
    w1.zespol_id = 5 
    AND w2.data > w1.data
ORDER BY
    w1.data;

--8.Wyświetla nazwy zespołów i liczbę sprzedanych biletów dla każdego zespołu
SELECT zespol.nazwa, COUNT(*) AS liczba_sprzedanych_biletow
FROM zespol
INNER JOIN wydarzenie ON zespol.id = wydarzenie.zespol_id
INNER JOIN bilet ON wydarzenie.id = bilet.wydarzenie_id
GROUP BY zespol.nazwa;

--9.Pokazuje dla jakich wydarzen zostaly przygotowane jakie instrumenty jako zapas (wiele do wielu)
SELECT i.nazwa AS nazwa_instrumentu, w.nazwa AS nazwa_wydarzenia
FROM instrument i
JOIN przygotowany_zapasowy_instrument pzi ON i.id = pzi.instrument_id
JOIN wydarzenie w ON w.id = pzi.wydarzenie_id;

--10.Pokazuje klientów którzy nie kupili biletu na dane wydarzenie
SELECT k.id, k.imie, k.nazwisko
FROM klient k
WHERE NOT EXISTS (
    SELECT
    FROM bilet b
    WHERE b.klient_id = k.id
    AND b.wydarzenie_id = 1
);

--11.Pokazuje cene ostateczna po podliczeniu ceny strefy i wydarzenia
SELECT b.id, b.wydarzenie_id, b.data_zakupu, 
       (m.cena_miejsca + w.cena_biletu) AS cena_calkowita
FROM bilet b
JOIN miejsce_na_koncercie m ON b.miejsce_id = m.id
JOIN wydarzenie w ON b.wydarzenie_id = w.id;

--12.Uzycie perspektywy do pokazania sali koncertowych jak i miejsc
SELECT * FROM miejsce_sala_koncertowa;

--13.Użycie perspektywy do pokazania klientów i zakupionych biletów i także ich dat
SELECT * FROM bilet_klient;

--14.Wyświetla koncerty które odbędą się po obecnej dacie
SELECT nazwa, data FROM wydarzenie WHERE data > CURRENT_DATE;

--15.Usuwa artyste
DELETE FROM artysta WHERE imie = 'Shim Moore';

--16.Uzupełnia kolumne sprzedane_bilety w tabeli wydarzenie o aktualne bilety
UPDATE wydarzenie
SET sprzedane_bilety = (
    SELECT COUNT(*)
    FROM bilet
    WHERE bilet.wydarzenie_id = wydarzenie.id
);


