--1.Aktualizuje liczbe sprzedanych biletów po dodaniu nowego biletu
CREATE OR REPLACE FUNCTION aktualizuj_liczbe_sprzedanych_biletow()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE wydarzenie
    SET sprzedane_bilety = sprzedane_bilety + 1
    WHERE id = NEW.wydarzenie_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER po_wstawieniu_biletu
AFTER INSERT ON bilet
FOR EACH ROW
EXECUTE FUNCTION aktualizuj_liczbe_sprzedanych_biletow();

--2.Automatycznie dodaje dwa podstawowe miejsca Standard i VIP po dodaniu nowej sali koncertowej o podstawowych cenach kolejno 50.00 i 100.00
CREATE OR REPLACE FUNCTION dodaj_miejsca_po_dodaniu_sali_koncertowej()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO miejsce_na_koncercie (miejsce, cena_miejsca, sala_koncertowa_id)
    VALUES ('Standard', 50.00, NEW.id), ('VIP', 100.00, NEW.id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER dodaj_miejsca_trigger
AFTER INSERT ON sala_koncertowa
FOR EACH ROW
EXECUTE FUNCTION dodaj_miejsca_po_dodaniu_sali_koncertowej();