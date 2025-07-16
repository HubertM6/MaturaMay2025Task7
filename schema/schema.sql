CREATE TABLE oceny (
  id_gry INT,
  id_gracza INT,
  stan TEXT,
  ocena INT
);
CREATE TABLE gracze (
  id_gracza INT,
  imie TEXT,
  nazwisko TEXT,
  wiek INT
);
CREATE TABLE gry (
  id_gry INT,
  nazwa TEXT,
  kategoria TEXT
);
