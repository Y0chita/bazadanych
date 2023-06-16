CREATE TABLE sala_koncertowa (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL,
    adres VARCHAR(200) NOT NULL,
    pojemnosc INT NOT NULL,
    osoba_kontaktowa VARCHAR(100) NOT NULL,
    email_kontaktowy VARCHAR(150) NOT NULL
);

CREATE TABLE miejsce_na_koncercie(
   id SERIAL PRIMARY KEY,
   miejsce VARCHAR(50) NOT NULL,
   cena_miejsca NUMERIC(10, 2),
   sala_koncertowa_id INT NOT NULL,
   CONSTRAINT miejsce_na_koncercie_sala_koncertowa_id_fk FOREIGN KEY (sala_koncertowa_id) 
                                        REFERENCES sala_koncertowa(id)
);

CREATE TABLE instrument (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(100)
);

CREATE TABLE zespol (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL
);

CREATE TABLE artysta (
    id SERIAL PRIMARY KEY,
    imie VARCHAR(100) NOT NULL,
    instrument_id INT,
    zespol_id INT NOT NULL,
    CONSTRAINT artysta_instrument_fk FOREIGN KEY (instrument_id) 
                                        REFERENCES instrument(id),
    CONSTRAINT artysta_zespol_fk FOREIGN KEY (zespol_id) 
                                        REFERENCES zespol(id)
);

CREATE TABLE wydarzenie (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL,
    data TIMESTAMP NOT NULL,
    miejsce_id INT NOT NULL,
    zespol_id INT NOT NULL,
    cena_biletu NUMERIC(10, 2),
    sprzedane_bilety INT NOT NULL DEFAULT 0,
    CONSTRAINT wydarzenie_miejsce_na_koncercie_fk FOREIGN KEY (miejsce_id) 
                                        REFERENCES sala_koncertowa(id),
    CONSTRAINT wydarzenie_zespol_fk FOREIGN KEY (zespol_id) 
                                        REFERENCES zespol(id)
);

CREATE TABLE przygotowany_zapasowy_instrument (
    id SERIAL PRIMARY KEY,
    instrument_id INT,
    wydarzenie_id INT,
    CONSTRAINT przygotowany_zapasowy_instrument_instrument_id_fk FOREIGN KEY (instrument_id)
        REFERENCES instrument(id),
    CONSTRAINT przygotowany_zapasowy_instrument_wydarzenie_id_fk FOREIGN KEY (wydarzenie_id)
        REFERENCES wydarzenie(id),
    CONSTRAINT przygotowany_zapasowy_instrument_unique_key UNIQUE (instrument_id, wydarzenie_id)
);

CREATE TABLE klient (
   id SERIAL PRIMARY KEY,
   imie VARCHAR(50) NOT NULL,
   nazwisko VARCHAR(50) NOT NULL,
   email VARCHAR(150) NOT NULL
);

CREATE TABLE bilet (
    id SERIAL PRIMARY KEY,
    wydarzenie_id INT NOT NULL,
    data_zakupu TIMESTAMP NOT NULL,
    klient_id INT NOT NULL,
    miejsce_id INT NOT NULL,
    CONSTRAINT bilet_wydarzenie_id_fk FOREIGN KEY (wydarzenie_id) 
                                        REFERENCES wydarzenie(id),
    CONSTRAINT bilet_klient_id_fk FOREIGN KEY (klient_id)
					REFERENCES klient(id),
    CONSTRAINT bilet_miejsce_na_koncercie_fk FOREIGN KEY (miejsce_id)
					REFERENCES miejsce_na_koncercie(id)
);

CREATE OR REPLACE VIEW miejsce_sala_koncertowa AS  
SELECT s.id, s.nazwa, s.adres, s.pojemnosc, m.miejsce, m.cena_miejsca 
FROM sala_koncertowa s  
LEFT JOIN miejsce_na_koncercie m ON s.id = m.sala_koncertowa_id; 

CREATE OR REPLACE VIEW bilet_klient AS  
SELECT b.id, b.wydarzenie_id, b.data_zakupu, k.imie, k.nazwisko 
FROM bilet b 
JOIN klient k ON b.klient_id = k.id; 