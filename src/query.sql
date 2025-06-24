select nazwa_obszaru from pomiary inner join obszary on pomiary.kod_obszaru = obszary.kod_obszaru where glebokosc <= 100 group by nazwa_obszaru order by sum(ilosc) desc limit 1
