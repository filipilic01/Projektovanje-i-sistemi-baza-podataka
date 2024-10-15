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

/*
1. Na osnovu prosledjenog ID-ja klijenta, ispisuje se ukupan broj njegovih uplata po fakturi i iznos njegove najvece uplate.
Ukoliko ne postoji klijent sa prosledjenim ID-jem, ispisati odgovarajucu poruku. Ukoliko klijent nije imao nijednu uplatu ispisati odgovarajucu poruku.
*/
if OBJECT_ID('Projekat.Funkcija1','FN') is not null
drop function Projekat.Funkcija1
go
create function Projekat.Funkcija1
(
	@id numeric(3)
)
returns varchar(500)
as
begin
	declare @brUplata as numeric(2)
	declare @iznos as numeric(10)
	declare @idKlij as numeric(3)
	declare @output as varchar(500)
	declare @ime as varchar(20)
	declare @prz as varchar(25)
	declare @fl as numeric(3)
	declare @pl as numeric(3)
	declare @naziv as varchar(40)

	set @idKlij =(select ID_STRANKE_K from Projekat.Klijent where ID_STRANKE_K=@id)
	
if(@idKlij is null)
begin
	set @output = 'Klijent sa ID-jem ' + convert(varchar, @id) + ' ne postoji.'
	return @output
end
else
begin
	set @fl= (select s.ID_FL from Projekat.Stranka s join Projekat.Klijent k on s.ID_STRANKE=k.ID_STRANKE_K where k.ID_STRANKE_K=@id)
	set @pl= (select s.ID_PL from Projekat.Stranka s join Projekat.Klijent k on s.ID_STRANKE=k.ID_STRANKE_K where k.ID_STRANKE_K=@id)
	set @brUplata= (select count(ID_STRANKE_K) from Projekat.Uplata_po_fakturi where ID_STRANKE_K=@id)
	if(@brUplata != 0)
	begin
		set @iznos=(select max(u.IZN_UP) from Projekat.Uplata u 
		join Projekat.Uplata_po_fakturi upf on u.ID_UP=upf.ID_UPF WHERE upf.ID_STRANKE_K=@id)
		if(@fl is not null)
		begin
			set @ime = (select f.IME_FL from Projekat.Fizicko_lice f join Projekat.Stranka s on f.ID_FL=s.ID_FL join Projekat.Klijent k on s.ID_STRANKE=K.ID_STRANKE_K where k.ID_STRANKE_K=@id)
			set @prz = (select f.PRZ_FL from Projekat.Fizicko_lice f join Projekat.Stranka s on f.ID_FL=s.ID_FL join Projekat.Klijent k on s.ID_STRANKE=K.ID_STRANKE_K where k.ID_STRANKE_K=@id)
			set @output= 'Klijent sa ID-jem ' + convert(varchar, @id) + ' ' + convert(varchar,@ime) + ' ' + convert(varchar,@prz) + ' ima ' 
			+ convert(varchar, @brUplata) + ' uplatu(e) po fakturi, a iznos njegove najvece uplate je '
			+ convert(varchar, @iznos) + '.'
			return @output
		end
		else if(@pl is not null)
		begin
			set @naziv = (select p.NAZIV_PL from Projekat.Pravno_lice p join Projekat.Stranka s on p.ID_PL=s.ID_PL join Projekat.Klijent k on s.ID_STRANKE=K.ID_STRANKE_K where k.ID_STRANKE_K=@id)
			set @output= 'Klijent sa ID-jem ' + convert(varchar, @id) + ' ' + @naziv + ' ima ' 
			+ convert(varchar, @brUplata) + ' uplatu(e) po fakturi, a iznos njegove najvece uplate je '
			+ convert(varchar, @iznos) + '.'
			return @output
		end
	end
	else
	begin
		if(@fl is not null)
		begin
			set @ime = (select f.IME_FL from Projekat.Fizicko_lice f join Projekat.Stranka s on f.ID_FL=s.ID_FL join Projekat.Klijent k on s.ID_STRANKE=K.ID_STRANKE_K where k.ID_STRANKE_K=@id)
			set @prz = (select f.PRZ_FL from Projekat.Fizicko_lice f join Projekat.Stranka s on f.ID_FL=s.ID_FL join Projekat.Klijent k on s.ID_STRANKE=K.ID_STRANKE_K where k.ID_STRANKE_K=@id)
			set @output='Klijent sa ID-jem ' + convert(varchar, @id) + ' ' + convert(varchar,@ime) + ' ' + convert(varchar,@prz) + ' nije izvrsio nijednu uplatu.'
			return @output
		end
		else if(@pl is not null)
		begin
			set @naziv = (select p.NAZIV_PL from Projekat.Pravno_lice p join Projekat.Stranka s on p.ID_PL=s.ID_PL join Projekat.Klijent k on s.ID_STRANKE=K.ID_STRANKE_K where k.ID_STRANKE_K=@id)
			set @output='Klijent sa ID-jem ' + convert(varchar, @id) + ' ' + @naziv + ' nije izvrsio nijednu uplatu.'
			return @output
		end
	end
end
	return @output
end
go

SELECT Projekat.Funkcija1(9); --klijent nije izvrsio nijednu uplatu
SELECT Projekat.Funkcija1(2); --klijent jeste izvrsio uplate
SELECT Projekat.Funkcija1(26); --klijent sa tim ID-jem ne postoji



/*
2. Na osnovu prosledjenog broja fakture, proveriti da li je izvrsena uplata po toj fakturi, ukoliko nije ispisati odgovarajucu poruku. Ukoliko jeste izvrsena,
ispisati ko je izvrsilac uplate na osnovu fakture sa prosledjenim ID-jem i da li je on pravno ili fizicko lice ili je institucija. Ukoliko faktura sa tim ID-jem ne postoji,
ispisati odgovarajucu poruku
*/

if OBJECT_ID('Projekat.FunkcijaII', 'FN') is not null
drop function Projekat.FunkcijaII
GO
create function Projekat.FunkcijaII
(
	@id as numeric(3)
)
returns varchar(500)
as
begin
	declare @poruka as varchar(500)
	declare @idF as numeric(3)
	declare @status as bit
	declare @klij as numeric(3)
	declare @inst as numeric(3)
	declare @ime as varchar(20)
	declare @prz as varchar(25)
	declare @fl as numeric(3)
	declare @pl as numeric(3)
	declare @in as numeric(3)
	declare @nazivPL as varchar(40)
	declare @nazivIns as varchar(40)

	set @idF = (select ID_F from Projekat.Faktura where ID_F=@id)
	set @status = (select PLACENA from Projekat.Faktura where ID_F=@id)
	set @klij = (select ID_STRANKE_K from Projekat.Uplata_po_fakturi where ID_F=@id)
	set @inst = (select ID_IN from Projekat.Uplata_po_fakturi where ID_F=@id)


	if(@idF is null)
	begin
		set @poruka = 'Faktura sa ID-jem ' +convert(varchar, @id) + ' ne postoji.'
		return @poruka
	end
	else
	begin
		if(@status= 1)
		begin
			if(@klij is null and @inst is not null)
			begin
				set @nazivIns = (select distinct i.NAZIV_IN from Projekat.Institucije i join Projekat.Uplata_po_fakturi upf on i.ID_IN=upf.ID_IN where upf.ID_IN=@inst)
				set @poruka = 'ID fakture: ' + convert(varchar, @id) + ', Institucija: ' + @nazivIns+ '.'
				return @poruka
			end
			else
			begin
				set @fl = (select distinct s.ID_FL from Projekat.Stranka s join Projekat.Klijent K on s.ID_STRANKE=K.ID_STRANKE_K join Projekat.Uplata_po_fakturi upf on k.ID_STRANKE_K=upf.ID_STRANKE_K
							where upf.ID_STRANKE_K=@klij)
				set @pl = (select distinct s.ID_PL from Projekat.Stranka s join Projekat.Klijent K on s.ID_STRANKE=K.ID_STRANKE_K join Projekat.Uplata_po_fakturi upf on k.ID_STRANKE_K=upf.ID_STRANKE_K
							where upf.ID_STRANKE_K=@klij)

				if(@fl is null and @pl is not null)
				begin
					set @nazivPL = (select pl.NAZIV_PL from Projekat.Pravno_lice pl join Projekat.Stranka s on pl.ID_PL=s.ID_PL where s.ID_PL= @pl)
					set @poruka = 'ID fakture: ' + convert(varchar, @id) + ', Pravno lice: ' + @nazivPL + '.'
					return @poruka
				end
				else
				begin
					set @ime = (select f.IME_FL from Projekat.Fizicko_lice f join Projekat.Stranka s on f.ID_FL=s.ID_FL where s.ID_FL= @fl)
					set @prz = (select f.PRZ_FL from Projekat.Fizicko_lice f join Projekat.Stranka s on f.ID_FL=s.ID_FL where s.ID_FL= @fl)
					set @poruka = 'ID fakture: ' + convert(varchar, @id) + ', Fizicko lice: ' + @ime + ' ' + @prz + '.' 
					return @poruka
				end
			end
		end
		else
		begin
			set @poruka = 'Nije izvrsena nijedna uplata na osnovu fakture sa ID-jem ' + convert(varchar,@id) + '.' 
			return @poruka
		end
	end
return @poruka
end
go

select Projekat.FunkcijaII(1);--institucija
select Projekat.FunkcijaII(2);--pravno lice
select Projekat.FunkcijaII(3);--fizicko lice
select Projekat.FunkcijaII(23);--nije izvrsena nijedna uplata
select Projekat.FunkcijaII(33);--ne postoji ID fakture
