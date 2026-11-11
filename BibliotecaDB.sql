-- ESERCITAZIONE 1 - Gestione di una biblioteca
-- Database: MySQL (eseguito con DBeaver)


-- =========================
-- 1. CREAZIONE DATABASE
-- =========================

CREATE DATABASE BibliotecaDB;
USE BibliotecaDB;


-- =========================
-- 2. CREAZIONE TABELLE
-- =========================

CREATE TABLE AUTORI (
    id_autore INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    nazionalita VARCHAR(50)
);

CREATE TABLE LIBRI (
    id_libro INT PRIMARY KEY AUTO_INCREMENT,
    titolo VARCHAR(100) NOT NULL,
    genere VARCHAR(50),
    anno_pubblicazione INT,
    id_autore INT NOT NULL,
    FOREIGN KEY (id_autore) REFERENCES AUTORI(id_autore)
);

CREATE TABLE UTENTI (
    id_utente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cognome VARCHAR(50) NOT NULL,
    data_iscrizione DATE
);

CREATE TABLE PRESTITI (
    id_prestito INT PRIMARY KEY AUTO_INCREMENT,
    id_libro INT NOT NULL,
    id_utente INT NOT NULL,
    data_prestito DATE NOT NULL,
    data_restituzione DATE,
    FOREIGN KEY (id_libro) REFERENCES LIBRI(id_libro),
    FOREIGN KEY (id_utente) REFERENCES UTENTI(id_utente)
);


-- =========================
-- 3. INSERIMENTO DATI
-- =========================

INSERT INTO AUTORI (nome, cognome, nazionalita) VALUES
('Umberto', 'Eco', 'Italiana'),
('Italo', 'Calvino', 'Italiana'),
('Elena', 'Ferrante', 'Italiana'),
('J.K.', 'Rowling', 'Britannica'),
('J.R.R.', 'Tolkien', 'Britannica'),
('George R.R.', 'Martin', 'Statunitense'),
('Stephen', 'King', 'Statunitense'),
('Isabel', 'Allende', 'Cilena');

INSERT INTO LIBRI (titolo, genere, anno_pubblicazione, id_autore) VALUES
('Il nome della rosa', 'Giallo', 1980, 1),
('Il pendolo di Foucault', 'Romanzo', 1988, 1),
('Numero zero', 'Romanzo', 2015, 1),
('Il barone rampante', 'Romanzo', 1957, 2),
('Le citta invisibili', 'Romanzo', 1972, 2),
('L''amica geniale', 'Romanzo', 2011, 3),
('La vita bugiarda degli adulti', 'Romanzo', 2019, 3),
('Harry Potter e la pietra filosofale', 'Fantasy', 1997, 4),
('Harry Potter e il calice di fuoco', 'Fantasy', 2000, 4),
('Il Signore degli Anelli', 'Fantasy', 1954, 5),
('Lo Hobbit', 'Fantasy', 1937, 5),
('Il trono di spade', 'Fantasy', 1996, 6),
('Fuoco e sangue', 'Fantasy', 2018, 6),
('Billy Summers', 'Thriller', 2021, 7),
('Holly', 'Thriller', 2023, 7);

INSERT INTO UTENTI (nome, cognome, data_iscrizione) VALUES
('Marco', 'Rossi', '2022-03-15'),
('Giulia', 'Bianchi', '2022-09-01'),
('Luca', 'Verdi', '2023-01-20'),
('Sara', 'Esposito', '2023-06-10'),
('Andrea', 'Russo', '2023-11-05'),
('Chiara', 'Romano', '2024-02-14'),
('Davide', 'Colombo', '2024-05-30'),
('Francesca', 'Ricci', '2024-10-12'),
('Matteo', 'Gallo', '2025-03-03'),
('Elisa', 'Conti', '2025-09-18');

-- data_restituzione NULL = libro non ancora restituito
INSERT INTO PRESTITI (id_libro, id_utente, data_prestito, data_restituzione) VALUES
(8, 1, '2025-01-10', '2025-01-30'),
(10, 1, '2025-02-05', '2025-03-01'),
(12, 1, '2025-03-15', '2025-04-10'),
(1, 1, '2025-05-02', '2025-05-25'),
(13, 1, '2026-10-20', NULL),
(9, 2, '2025-01-12', '2025-02-02'),
(6, 2, '2025-02-20', '2025-03-15'),
(8, 2, '2025-04-01', '2025-04-22'),
(14, 2, '2026-10-25', NULL),
(10, 3, '2025-03-10', '2025-04-05'),
(2, 3, '2025-06-01', '2025-06-28'),
(7, 3, '2026-10-28', NULL),
(12, 4, '2025-05-10', '2025-06-02'),
(3, 4, '2025-07-01', '2025-07-20'),
(8, 5, '2025-06-15', '2025-07-05'),
(4, 5, '2025-09-01', '2025-09-25'),
(9, 6, '2025-08-10', '2025-08-30'),
(15, 6, '2025-10-01', '2025-10-20'),
(1, 7, '2025-11-03', '2025-11-28'),
(10, 8, '2026-09-15', NULL);


-- Verifica vincoli (devono dare errore, per questo sono commentate)

-- Libro con autore che non esiste
-- INSERT INTO LIBRI (titolo, genere, anno_pubblicazione, id_autore) VALUES ('Prova', 'Romanzo', 2020, 99);

-- Prestito con utente che non esiste
-- INSERT INTO PRESTITI (id_libro, id_utente, data_prestito) VALUES (1, 99, '2026-11-01');


-- =========================
-- 4. QUERY
-- =========================

-- LIVELLO 1

-- 1. Tutti i libri
SELECT * FROM LIBRI;

-- 2. Tutti gli utenti
SELECT * FROM UTENTI;

-- 3. Libri pubblicati dopo il 2015
SELECT * FROM LIBRI WHERE anno_pubblicazione > 2015;

-- 4. Libri Fantasy
SELECT * FROM LIBRI WHERE genere = 'Fantasy';

-- 5. Utenti iscritti dopo il 01/01/2024
SELECT * FROM UTENTI WHERE data_iscrizione > '2024-01-01';

-- 6. Libri in ordine alfabetico
SELECT * FROM LIBRI ORDER BY titolo;

-- 7. Autori italiani
SELECT * FROM AUTORI WHERE nazionalita = 'Italiana';


-- LIVELLO 2

-- 1. Numero di libri
SELECT COUNT(*) AS numero_libri FROM LIBRI;

-- 2. Numero di utenti
SELECT COUNT(*) AS numero_utenti FROM UTENTI;

-- 3. Libri scritti da ogni autore
SELECT AUTORI.nome, AUTORI.cognome, COUNT(LIBRI.id_libro) AS numero_libri
FROM AUTORI
JOIN LIBRI ON AUTORI.id_autore = LIBRI.id_autore
GROUP BY AUTORI.id_autore, AUTORI.nome, AUTORI.cognome;

-- 4. Autori con almeno due libri
SELECT AUTORI.nome, AUTORI.cognome, COUNT(LIBRI.id_libro) AS numero_libri
FROM AUTORI
JOIN LIBRI ON AUTORI.id_autore = LIBRI.id_autore
GROUP BY AUTORI.id_autore, AUTORI.nome, AUTORI.cognome
HAVING COUNT(LIBRI.id_libro) >= 2;

-- 5. Numero di prestiti per ogni utente
SELECT UTENTI.nome, UTENTI.cognome, COUNT(PRESTITI.id_prestito) AS numero_prestiti
FROM UTENTI
LEFT JOIN PRESTITI ON UTENTI.id_utente = PRESTITI.id_utente
GROUP BY UTENTI.id_utente, UTENTI.nome, UTENTI.cognome;

-- 6. Libri attualmente in prestito
SELECT LIBRI.titolo, PRESTITI.data_prestito
FROM LIBRI
JOIN PRESTITI ON LIBRI.id_libro = PRESTITI.id_libro
WHERE PRESTITI.data_restituzione IS NULL;

-- 7. Numero di prestiti non restituiti
SELECT COUNT(*) AS prestiti_non_restituiti
FROM PRESTITI
WHERE data_restituzione IS NULL;


-- LIVELLO 3

-- 1. Titolo del libro con nome e cognome dell'autore
SELECT LIBRI.titolo, AUTORI.nome, AUTORI.cognome
FROM LIBRI
JOIN AUTORI ON LIBRI.id_autore = AUTORI.id_autore;

-- 2. Tutti i prestiti con titolo, utente e date
SELECT LIBRI.titolo, UTENTI.nome, UTENTI.cognome, PRESTITI.data_prestito, PRESTITI.data_restituzione
FROM PRESTITI
JOIN LIBRI ON PRESTITI.id_libro = LIBRI.id_libro
JOIN UTENTI ON PRESTITI.id_utente = UTENTI.id_utente;

-- 3. Utenti che hanno fatto almeno un prestito
SELECT DISTINCT UTENTI.nome, UTENTI.cognome
FROM UTENTI
JOIN PRESTITI ON UTENTI.id_utente = PRESTITI.id_utente;

-- 4. Utenti che non hanno mai fatto prestiti
SELECT UTENTI.nome, UTENTI.cognome
FROM UTENTI
LEFT JOIN PRESTITI ON UTENTI.id_utente = PRESTITI.id_utente
WHERE PRESTITI.id_prestito IS NULL;

-- 5. Libri mai presi in prestito
SELECT LIBRI.titolo
FROM LIBRI
LEFT JOIN PRESTITI ON LIBRI.id_libro = PRESTITI.id_libro
WHERE PRESTITI.id_prestito IS NULL;

-- 6. Prestiti ancora aperti con dati di utente e libro
SELECT *
FROM PRESTITI
JOIN UTENTI ON PRESTITI.id_utente = UTENTI.id_utente
JOIN LIBRI ON PRESTITI.id_libro = LIBRI.id_libro
WHERE PRESTITI.data_restituzione IS NULL;


-- LIVELLO 4

-- 1. Utente con piu prestiti
SELECT UTENTI.nome, UTENTI.cognome, COUNT(*) AS numero_prestiti
FROM UTENTI
JOIN PRESTITI ON UTENTI.id_utente = PRESTITI.id_utente
GROUP BY UTENTI.id_utente, UTENTI.nome, UTENTI.cognome
ORDER BY numero_prestiti DESC
LIMIT 1;

-- 2. Autore con piu libri
SELECT AUTORI.nome, AUTORI.cognome, COUNT(*) AS numero_libri
FROM AUTORI
JOIN LIBRI ON AUTORI.id_autore = LIBRI.id_autore
GROUP BY AUTORI.id_autore, AUTORI.nome, AUTORI.cognome
ORDER BY numero_libri DESC
LIMIT 1;

-- 3. Genere piu richiesto nei prestiti
SELECT LIBRI.genere, COUNT(*) AS numero_prestiti
FROM PRESTITI
JOIN LIBRI ON PRESTITI.id_libro = LIBRI.id_libro
GROUP BY LIBRI.genere
ORDER BY numero_prestiti DESC
LIMIT 1;

-- 4. Media dei prestiti per utente
SELECT COUNT(*) / (SELECT COUNT(*) FROM UTENTI) AS media_prestiti
FROM PRESTITI;

-- 5. Utenti con almeno tre prestiti
SELECT UTENTI.nome, UTENTI.cognome, COUNT(*) AS numero_prestiti
FROM UTENTI
JOIN PRESTITI ON UTENTI.id_utente = PRESTITI.id_utente
GROUP BY UTENTI.id_utente, UTENTI.nome, UTENTI.cognome
HAVING COUNT(*) >= 3;


-- =========================
-- 5. MODIFICHE E CANCELLAZIONI
-- =========================

-- 1. Modifico la nazionalita di un autore
UPDATE AUTORI SET nazionalita = 'Cilena-Statunitense' WHERE id_autore = 8;

-- 2. Modifico il genere di un libro
UPDATE LIBRI SET genere = 'Giallo storico' WHERE id_libro = 1;

-- 3. Registro la restituzione di un libro
UPDATE PRESTITI SET data_restituzione = '2026-11-06' WHERE id_prestito = 5;

-- 4. Cancello un utente che non ha mai fatto prestiti (Elisa Conti)
DELETE FROM UTENTI WHERE id_utente = 10;

-- 5. Provo a cancellare un autore che ha dei libri (deve dare errore)
-- DELETE FROM AUTORI WHERE id_autore = 1;
-- Errore 1451: non si puo cancellare perche ci sono libri collegati a questo autore
