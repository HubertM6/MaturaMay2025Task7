CREATE TABLE ages AS
SELECT
  kategoria_wiekowa,
  nazwa,
  COUNT(*) AS wystawionych_ocen
FROM
  (
    SELECT
      IF (
        wiek >= 50,
        "weterani",
        IF (wiek >= 20, "seniorzy", "juniorzy")
      ) AS kategoria_wiekowa,
      nazwa
    FROM
      Gracze
      INNER JOIN (
        oceny
        INNER JOIN gry ON oceny.id_gry = gry.id_gry
      ) ON gracze.id_gracza = oceny.id_gracza
  ) t1
GROUP BY
  kategoria_wiekowa,
  nazwa;
SELECT
  kategoria_wiekowa,
  nazwa,
  wystawionych_ocen
FROM
  ages k1
WHERE
  wystawionych_ocen = (
    SELECT
      MAX(wystawionych_ocen)
    FROM
      ages k2
    WHERE
      k1.kategoria_wiekowa = k2.kategoria_wiekowa
  );
