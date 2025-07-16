CREATE TABLE laziki (
  nr_lazika INT,
  nazwa_lazika TEXT,
  rok_wyslania INT,
  wsp_ladowania TEXT
);
CREATE TABLE obszary (
  kod_obszaru TEXT,
  nazwa_obszaru TEXT
);
CREATE TABLE pomiary (
  nr_lazika INT,
  data_pomiaru DATE,
  kod_obszaru TEXT,
  wspolrzedne TEXT,
  glebokosc INT,
  ilosc INT
);