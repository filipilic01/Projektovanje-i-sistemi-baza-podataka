select * from Projekat.Zaposleni
select * from Projekat.Uplata
SELECT * FROM Projekat.Uplata_po_fakturi
select * from Projekat.Uplata_po_sudskom_resenju
select * from Projekat.Faktura
SELECT * FROM Projekat.Klijent
select * from Projekat.Institucije
SELECT * FROM Projekat.Stranka
select * from Projekat.Pravno_lice
select * from Projekat.Fizicko_lice
select * from Projekat.Predmet
SELECT * FROM Projekat.Spis
SELECT * FROM Projekat.Pravosnazna_sudska_presuda
select * from Projekat.Banka
select * from Projekat.Racun


/*1. Izlistati za svakog klijenta koji je fizicko lice (ID, maticni broj, ime i prezime, broj telefona, email, adresu)i koji ima vise od jedne uplate po fakturi 
prosecan iznos njegovih uplata po fakturi kao i ukupan broj njegovih uplata
*/
select k.ID_STRANKE_K as 'ID klijenta', fl.MBR_FL as 'Maticni broj klijenta', fl.IME_FL + ' ' +fl.PRZ_FL as 'Ime i prezime klijenta', fl.TEL_FL as 'Broj telefona',
isnull(fl.EMAIL_FL, 'Email klijenta nije poznat') as 'Email klijenta', fl.ADRESA_FL as 'Adresa klijenta',
avg(u.IZN_UP) as 'Prosecan iznos uplata', count(upf.ID_STRANKE_K) as 'Ukupan broj svih uplata po fakturi'
from Projekat.Fizicko_lice fl join Projekat.Stranka s on fl.ID_FL=s.ID_FL
join Projekat.Klijent k on s.ID_STRANKE = k.ID_STRANKE_K
join Projekat.Uplata_po_fakturi upf on k.ID_STRANKE_K=upf.ID_STRANKE_K
join Projekat.Uplata u on upf.ID_UPF=u.ID_UP
group by k.ID_STRANKE_K, fl.MBR_FL, fl.IME_FL, fl.PRZ_FL, fl.TEL_FL, fl.EMAIL_FL, fl.ADRESA_FL
having count(upf.ID_STRANKE_K) > 1

/*2. Izlistati sve fakture (ID, primalac, ukupan iznos, datum) iz poslednjeg kvartala 2022. godine ciji je iznos veci od prosecnog iznosa svih faktura u tom periodu, pored toga 
u jednoj koloni napisati da li je primalac fakture klijent ili institucija
*/
select fak.ID_F as 'ID fakture', fak.PR_F as 'Primalac fakture', fak.UI_F as 'Ukupan iznos fakture', fak.DAT_F as 'Datum fakturisanja',
case 
when upf.ID_IN is not null then 'Institucija'
when upf.ID_STRANKE_K is not null then 'Klijent'
end as 'Vrsta primaoca'
from Projekat.Faktura fak join Projekat.Uplata_po_fakturi upf on fak.ID_F=upf.ID_F 
where DATEPART(year, fak.DAT_F) = 2022 and DATEPART(MONTH, fak.DAT_F) in (9,10,11,12) 
and fak.UI_F>(select AVG(UI_F) from PROJEKAT.Faktura fak where DATEPART(year, fak.DAT_F) = 2022 and DATEPART(MONTH, fak.DAT_F) in (9,10,11,12))

/*3. Izlistati sve klijente koji su fizicka lica (ID klijenta, maticni broj klijenta, ime i prezime, broj telefona, email i adresu) 
i ukupne iznose svih njihovih uplata po fakturi cija vrednost nije manja od 7000, sortirati rastuce po imenu, u jednoj koloni ispisati za svaku torku da li je ukupna vrednost
veca od 30 000, manja od 15 000 ili se nalazi izmedju
*/
select k.ID_STRANKE_K as 'ID klijenta', fl.MBR_FL as 'Maticni broj klijenta', fl.IME_FL + ' ' +fl.PRZ_FL as 'Ime i prezime klijenta', fl.TEL_FL as 'Broj telefona',
isnull(fl.EMAIL_FL, 'Email klijenta nije poznat') as 'Email klijenta', fl.ADRESA_FL as 'Adresa klijenta', sum(u.IZN_UP) as 'Ukupan iznos svih uplata po fakturi',
case
when sum(u.IZN_UP) >= 30000 then 'Ukupan iznos je veci od 30 000'
when sum(u.IZN_UP) <= 15000 then 'Ukupan iznos je manji od 15 000'
when sum(u.IZN_UP) < 30000 and sum(u.IZN_UP) > 15000 then 'Ukupan iznos je manji od 30 000, a veci od 15 000'
end as 'Odnos uplata'
from Projekat.Fizicko_lice fl join Projekat.Stranka s on fl.ID_FL=s.ID_FL
join Projekat.Klijent k on s.ID_STRANKE = k.ID_STRANKE_K
join Projekat.Uplata_po_fakturi upf on k.ID_STRANKE_K=upf.ID_STRANKE_K
join Projekat.Uplata u on upf.ID_UPF=u.ID_UP
group by k.ID_STRANKE_K, fl.MBR_FL, fl.IME_FL, fl.PRZ_FL, fl.TEL_FL, fl.EMAIL_FL, fl.ADRESA_FL
having sum(u.IZN_UP)>7000
order by fl.IME_FL asc

/*4. Za svakog klijenta (fizicka lica) koji je izvrsio neku uplatu, prikazati ID klijenta, njegovo ime i prezime, zatim ID uplate, datum i iznos njegove najvece uplate, pored toga
prikazati broj racuna i naziv banke u kojoj je izvrsena uplata. Sortirati rastuce po iznosu uplate
*/
select k.ID_STRANKE_K as 'ID klijenta', fl.IME_FL + ' ' +fl.PRZ_FL as 'Ime i prezime klijenta', up.ID_UP as 'ID uplate',
up.IZN_UP as 'Iznos uplate', try_convert(date, up.DAT_UP, 105) as 'Datum uplate', r.BR_RAC as 'Broj racuna', banka.NAZIV_B as 'Naziv banke'
from Projekat.Fizicko_lice fl join Projekat.Stranka s on fl.ID_FL=s.ID_FL
join Projekat.Klijent k on s.ID_STRANKE = k.ID_STRANKE_K
join Projekat.Uplata_po_fakturi upf on k.ID_STRANKE_K=upf.ID_STRANKE_K
join Projekat.Faktura f on upf.ID_F=f.ID_F 
join Projekat.Racun r on f.BR_RAC=r.BR_RAC
join Projekat.Banka banka on r.ID_BANKA=banka.ID_BANKA
join Projekat.Uplata up on upf.ID_UPF=up.ID_UP
join (select k.ID_STRANKE_K, max(up.IZN_UP) maks from Projekat.Klijent k join Projekat.Uplata_po_fakturi upf on k.ID_STRANKE_K=upf.ID_STRANKE_K
join Projekat.Uplata up on upf.ID_UPF=up.ID_UP group by k.ID_STRANKE_K) uplata 
on k.ID_STRANKE_K=uplata.ID_STRANKE_K
where up.IZN_UP=uplata.maks
group by k.ID_STRANKE_K, fl.IME_FL, fl.PRZ_FL, up.DAT_UP, up.ID_UP, up.IZN_UP, r.BR_RAC, banka.NAZIV_B
order by up.IZN_UP asc

/*
5. Izlistati dve uplate po fakturi (ID, izvrsilac uplate, datum, iznos) od kojih jedna predstavlja najvecu uplatu koju je izvrsio klijent koji je fizicko lice, 
dok druga predstavlja najvecu uplatu koju je izvrsio klijent koji je prvano lice. Jedna kolona treba da predstavlja vrstu klijenta u kojoj ce 
biti ispisano da li je klijent fizicko ili pravno lice
*/
select u.ID_UP as 'ID uplate', u.IZVR_UP as 'Izvrsilac uplate', u.DAT_UP as 'Datum uplate', u.IZN_UP as 'Iznos uplate', 
case
when s.ID_FL is null then 'Pravno lice'
when s.ID_PL is null then 'Fizicko lice'
end as 'Vrsta klijenta'
from Projekat.Uplata u
join Projekat.Uplata_po_fakturi upf on u.ID_UP=upf.ID_UPF 
join Projekat.Klijent k on upf.ID_STRANKE_K=k.ID_STRANKE_K
join Projekat.Stranka s on k.ID_STRANKE_K=s.ID_STRANKE
JOIN
((select top(1) k.ID_STRANKE_K, max(u.IZN_UP) maxizn from Projekat.Uplata u join Projekat.Uplata_po_fakturi upf on u.ID_UP=upf.ID_UPF
join Projekat.Klijent k on upf.ID_STRANKE_K=k.ID_STRANKE_K
join Projekat.Stranka s on k.ID_STRANKE_K=s.ID_STRANKE 
join Projekat.Fizicko_lice f on s.ID_FL=f.ID_FL 
group by k.ID_STRANKE_K
order by maxizn desc)
union
(
select top(1) k.ID_STRANKE_K, max(u.IZN_UP) maxizn from Projekat.Uplata u join Projekat.Uplata_po_fakturi upf on u.ID_UP=upf.ID_UPF
join Projekat.Klijent k on upf.ID_STRANKE_K=k.ID_STRANKE_K
join Projekat.Stranka s on k.ID_STRANKE_K=s.ID_STRANKE 
join Projekat.Pravno_lice p on s.ID_PL=p.ID_PL 
group by k.ID_STRANKE_K
order by maxizn desc
)) maxPlata on k.ID_STRANKE_K= maxPlata.ID_STRANKE_K
where u.IZN_UP=maxizn