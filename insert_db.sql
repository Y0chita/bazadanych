INSERT INTO sala_koncertowa (nazwa, adres, pojemnosc, osoba_kontaktowa, email_kontaktowy) VALUES
    ('Stadion Narodowy', 'Al. Ks. J. Poniatowskiego 1, 03-901 Warszawa', 60000, 'Anna Kowalska', 'anna.kowalska@stadionnarodowy.pl'),
    ('SSE Arena, Wembley', 'Arena Square, Engineers Way, Wembley HA9 0AA, United Kingdom', 12000, 'John Smith', 'john.smith@ssearena.co.uk');

INSERT INTO miejsce_na_koncercie (miejsce, cena_miejsca, sala_koncertowa_id) VALUES
    ('Standard', 50.00, 1),
    ('Early', 75.00, 1),
    ('VIP', 100.00, 1),
    ('Standard', 30.00, 2),
    ('VIP', 60.00, 2);

INSERT INTO instrument (nazwa) VALUES 
    ('Gitara'), ('Bass'), ('Perkusja'), ('Keyboard');

INSERT INTO zespol (nazwa) VALUES
    ('Slipknot'),
    ('Metallica'),
    ('System of a Down'),
    ('Avenged Sevenfold'),
    ('Sick Puppies');

INSERT INTO artysta (imie, instrument_id, zespol_id) VALUES
    ('Corey Taylor', NULL, 1),
    ('Jim Root', 1, 1),
    ('Mick Thomson', 1, 1),
    ('Clown', 3, 1),
    ('James Hetfield', 1, 2),
    ('Kirk Hammett', 1, 2),
    ('Robert Trujillo', 2, 2),
    ('Lars Ulrich', 3, 2),
    ('Daron Malakian', 1, 3),
    ('Shavo Odadjian', 2, 3),
    ('Serj Tankian', NULL, 3),
    ('M. Shadows', NULL, 4),
    ('Synyster Gates', 1, 4),
    ('Zacky Vengeance', 1, 4),
    ('Johnny Christ', 2, 4),
    ('Arin Ilejay', 3, 4),
    ('Shim Moore', NULL, 5),
    ('Emma Anzai', 2, 5),
    ('Mark Goodwin', 3, 5);

INSERT INTO wydarzenie (nazwa, data, miejsce_id, zespol_id, cena_biletu, sprzedane_bilety) VALUES
    ('Slipknot Live in Warsaw', '2023-07-01 19:00:00', 1, 1, 180.50, 0),
    ('Metallica Live in Warsaw', '2023-07-15 20:00:00', 1, 2, 199.99, 0),
    ('System of a Down Live in London', '2023-08-02 19:30:00', 2, 3, 160.00, 0),
    ('Avenged Sevenfold Live in London', '2023-08-15 20:00:00', 2, 4, 150.00, 0),
    ('Sick Puppies Live in Warsaw', '2023-09-01 19:00:00', 1, 5, 80.00, 0),
    ('Sick Puppies Live in London', '2023-09-02 19:00:00', 2, 5, 80.00, 0);

INSERT INTO przygotowany_zapasowy_instrument (instrument_id, wydarzenie_id) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 2),
	(2, 4),
	(3, 3),
	(3, 4),
	(3, 5),
	(4, 5);

INSERT INTO klient (imie, nazwisko, email) VALUES
    ('Jan', 'Kowalski', 'jan.kowalski@example.com'),
    ('Anna', 'Nowak', 'anna.nowak@example.com'),
    ('Piotr', 'Zieliński', 'piotr.zielinski@example.com'),
    ('Katarzyna', 'Wójcik', 'katarzyna.wojcik@example.com'),
    ('Adam', 'Mickiewicz', 'adam.mickiewicz@example.com'),
    ('Maria', 'Kowalczyk', 'maria.kowalczyk@example.com'),
    ('Tomasz', 'Nowakowski', 'tomasz.nowakowski@example.com'),
    ('Izabela', 'Kowalska', 'izabela.kowalska@example.com'),
    ('Janusz', 'Kowalski', 'janusz.kowalski@example.com'),
    ('Marta', 'Nowak', 'marta.nowak@example.com');

INSERT INTO bilet (wydarzenie_id, data_zakupu, klient_id, miejsce_id) VALUES
	(1, '2023-06-01 15:30:00', 1, 1),
	(1, '2023-06-02 10:15:00', 2, 2),
	(1, '2023-06-02 11:45:00', 3, 1),
	(2, '2023-06-10 14:00:00', 4, 1),
	(2, '2023-06-11 16:30:00', 5, 2),
	(3, '2023-06-20 09:45:00', 6, 4),
	(3, '2023-06-22 13:15:00', 7, 5),
	(4, '2023-07-05 18:00:00', 8, 4),
	(4, '2023-07-07 11:30:00', 9, 5),
	(5, '2023-08-01 17:30:00', 10, 1),
	(6, '2023-08-02 09:00:00', 1, 4),
	(6, '2023-08-03 12:45:00', 2, 4);