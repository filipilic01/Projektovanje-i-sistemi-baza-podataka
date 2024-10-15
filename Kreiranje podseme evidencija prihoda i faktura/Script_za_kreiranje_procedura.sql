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
1. Procedura koja na osnovu prosledjenog ID-ja klijenta izlistava sve njegove uplate po fakturi. Takodje, u ispisu se i nalazi i broj fakture na osnovu koje je izvrsena uplata kao i 
datum fakturisanja. Takodje ispisuje se i broj racuna i ime banke na koju je izvrsena uplata. Na kraju ispisati ukupan broj uplata klijenta sa prosledjenim ID-jem,
kao i ukupan iznos svih njegovih uplata.
*/

if object_id ('Projekat.Procedura1', 'P') is not null
drop proc Projekat.Procedura1
go
create procedure Projekat.Procedura1
	@id as numeric(3)
as 
begin
	declare @idKlij as numeric(3)
	declare @ime as varchar(20)
	declare @prz as varchar(25)
	declare @naziv as varchar(25)
	declare @idUp as varchar(10)
	declare @iznos as numeric(10)
	declare @datUp as date
	declare @idFak as numeric(3)
	declare @datFak as date
	declare @brRac as varchar(16)
	declare @banka as varchar(30)
	declare @counter as int
	declare @sum as numeric(10) = 0
	set @idKlij = (select distinct ID_STRANKE_K from Projekat.Uplata_po_fakturi where ID_STRANKE_K = @id)
	if (@id not in (select ID_STRANKE_K from Projekat.Klijent))
	begin
		print 'Klijent sa ID-jem ' + convert(varchar, @id) + ' ne postoji.'
	end
	else
	begin
		if(@idKlij is null)
		begin
			print 'Klijent sa ID-jem ' + convert(varchar,@id) + ' nije izvrsio nijednu uplatu.'
		end
		else
		begin
			declare @fl as int = (select distinct s.ID_FL from Projekat.Stranka s join Projekat.Klijent K on s.ID_STRANKE=K.ID_STRANKE_K join 
							Projekat.Uplata_po_fakturi upf on k.ID_STRANKE_K=upf.ID_STRANKE_K
							where upf.ID_STRANKE_K=@id)
			declare @pl as int= (select distinct s.ID_PL from Projekat.Stranka s join Projekat.Klijent K on s.ID_STRANKE=K.ID_STRANKE_K join 
							Projekat.Uplata_po_fakturi upf on k.ID_STRANKE_K=upf.ID_STRANKE_K
							where upf.ID_STRANKE_K=@id)
			if(@fl is null and @pl is not null)
				begin
					set @naziv = (select pl.NAZIV_PL from Projekat.Pravno_lice pl join Projekat.Stranka s on pl.ID_PL=s.ID_PL where s.ID_PL= @pl)
					print 'Klijent ' + @naziv + ' sa ID-jem ' + convert(varchar,@id) + ' je izvrsio sledece uplate:'  
				end
			else
				begin
					set @ime = (select f.IME_FL from Projekat.Fizicko_lice f join Projekat.Stranka s on f.ID_FL=s.ID_FL where s.ID_FL= @fl)
					set @prz = (select f.PRZ_FL from Projekat.Fizicko_lice f join Projekat.Stranka s on f.ID_FL=s.ID_FL where s.ID_FL= @fl)
					print 'Klijent ' + @ime + ' ' +@prz + ' sa ID-jem ' + convert(varchar,@id) + ' je izvrsio sledece uplate:'  
				end
			set @counter=0
			
			declare procedura_cursor CURSOR fast_forward for
					select u.ID_UP, u.IZN_UP, U.DAT_UP, f.ID_F, f.DAT_f, r.BR_RAC, b.NAZIV_B 
					from Projekat.Uplata u 
					join Projekat.Uplata_po_fakturi upf on u.ID_UP=upf.ID_UPF
					join Projekat.Faktura f on upf.ID_F=f.ID_F
					join Projekat.Racun r on f.BR_RAC=r.BR_RAC
					join Projekat.Banka b on r.ID_BANKA=b.ID_BANKA
					where upf.ID_STRANKE_K=@id
			open procedura_cursor
					set @counter=1
			fetch next from procedura_cursor into @idUp, @iznos, @datUp, @idFak, @datFak, @brRac, @banka
			while @@fetch_status = 0
				begin
					print convert(varchar, @counter) + '. ID uplate: ' + convert(varchar, @idUp) + ', iznos: ' + convert(varchar, @iznos) + ', datum uplate: ' + convert(varchar, @datUp) 
					+ ', ID fakture: ' + convert(varchar, @idFak) + ', datum fakturisanja: ' + convert(varchar, @datFak) + ', broj racuna: ' + @brRac + ', banka: ' + @banka
					set @sum=@sum+@iznos
					fetch next from procedura_cursor into @idUp, @iznos, @datUp, @idFak, @datFak, @brRac, @banka
					set @counter=@counter+1
				end
			close procedura_cursor
			deallocate procedura_cursor

			print 'Ukupno uplata: ' + convert(varchar,@counter-1)
			print 'Ukupan iznos svih uplata: ' + convert(varchar,@sum)
				
		end
	end
end
go

exec Projekat.Procedura1 6--fl
exec Projekat.Procedura1 10--pl
exec Projekat.Procedura1 50--nema ID-ja
exec Projekat.Procedura1 5--bez uplata

/*
2. Na osnovu prosledjenog id-ja klijenta, klijentu se kreira mejl koji ce biti koriscen u radu sa advokatskom kancelarijom. Mejl ce biti u formatu <naziv klijenta><id klijenta>@advokatiNS.com
(npr. filipilic1.@advokatiNS.com).
Sva slova u mejlu pre ekstenzije @advokatiNS.com moraju biti mala.
*/

if object_id('Projekat.Procedura2', 'P') is not null
drop proc Projekat.Procedura2
go
create procedure Projekat.Procedura2
	@id as numeric(3)
as
begin
	declare @ekstenzija as varchar(15)
	declare @email as varchar(60)
	set @ekstenzija = '@advokatiNS.com'
	if (@id not in (select ID_STRANKE_K from Projekat.Klijent))
	begin
		print 'Klijent sa ID-jem ' + convert(varchar, @id) + ' ne postoji.'
	end
	else
	begin
		declare @pl as numeric(3) = (select s.ID_PL from Projekat.Stranka s join Projekat.Klijent k on s.ID_STRANKE=k.ID_STRANKE_K where k.ID_STRANKE_K=@id)
		declare @fl as numeric(3) = (select s.ID_FL from Projekat.Stranka s join Projekat.Klijent k on s.ID_STRANKE=k.ID_STRANKE_K where k.ID_STRANKE_K=@id)
		if(@pl is null and @fl is not null)
		begin
			declare @ime as varchar(20) = (select f.IME_FL from Projekat.Fizicko_lice f join Projekat.Stranka s on f.ID_FL=s.ID_FL where s.ID_FL= @fl)
			declare @prz as varchar(25) = (select f.PRZ_FL from Projekat.Fizicko_lice f join Projekat.Stranka s on f.ID_FL=s.ID_FL where s.ID_FL= @fl)
			declare @imeLower as varchar(20) = (select lower(@ime))
			declare @przLower as varchar(25) = (select lower(@prz))
			declare @emailStari as varchar(60) = (select EMAIL_FL from Projekat.Fizicko_lice where ID_FL=@fl)
			set @email = @imeLower+@przLower+convert(varchar,@id)+@ekstenzija

			update Projekat.Fizicko_lice
			set EMAIL_FL= @email
			where ID_FL= @fl

			print 'Klijent ' + convert(varchar, @id) + ':'
			print 'Stari mejl je ' + @emailStari + '.'
			print 'Novi mejl je ' + @email + '.'
		end
		else
		begin
			declare @naziv as varchar(25) = (select p.NAZIV_PL from Projekat.Pravno_lice p join Projekat.Stranka s on p.ID_PL=s.ID_PL where s.ID_PL= @pl)
			declare @nazivLower as varchar(25) = (select lower(@naziv))
			declare @nazivReplace as varchar(25) = (select replace(@nazivLower, ' ', '_'))
			declare @mailStari as varchar(60) = (select EMAIL_PL from Projekat.Pravno_lice where ID_PL=@pl)
			set @email = @nazivReplace+convert(varchar,@id)+@ekstenzija

			update Projekat.Pravno_lice
			set EMAIL_PL = @email
			where ID_PL=@pl
			
			print 'Klijent ' + convert(varchar, @id) + ':'
			print 'Stari mejl je ' + @mailStari + '.'
			print 'Novi mejl je ' + @email + '.'
		end
		
		
	end
end
go

exec Projekat.Procedura2 1--fizicko lice
exec Projekat.Procedura2 10--pravno lice
exec Projekat.Procedura2 111-- ne postoji ID

select * from Projekat.Klijent
select * from Projekat.Fizicko_lice