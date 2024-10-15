select * from Projekat.Zaposleni
select * from Projekat.Faktura
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

/*1. Kreirati triger koji ce se aktivirati nakon inserta u 
tabelu Uplata po fakturi i proveravati da li je iznos uplate jednak iznosu fakture, takodje u tabeli faktura ce obelezje PLACENA biti promenjeno na 1 sto 
znaci da je faktura placena.Ukoliko su iznosi jednaki, upisati torku i promeniti status fakture na placena (odnosno na 1)
Ukoliko nije ispisati gresku u konzoli.*/
if object_id('Projekat.Triger1') is not null
 drop trigger Projekat.Triger1
 go
 create trigger Projekat.Triger1
 on Projekat.Uplata_po_fakturi
 after insert
 as
 begin
	if @@ROWCOUNT=0
		return;

	declare @ID_UPF as VARCHAR(10)=(select ID_UPF from inserted)
	declare @ID_STRANKE_K as VARCHAR(5)=(select ID_STRANKE_K from inserted)
	declare @ID_F as  NUMERIC(3)=(select ID_F from inserted)
	declare @ID_IN as NUMERIC(2)=(select ID_IN from inserted)
	
	declare @iznUplate as numeric(8) = (select IZN_UP from Projekat.Uplata where ID_UP=@ID_UPF)
	declare @iznFakture as numeric(8) = (select f.UI_F from Projekat.Faktura f join Projekat.Uplata_po_fakturi upf on f.ID_F=upf.ID_F where upf.ID_UPF=@ID_UPF)


	if (@iznFakture!=@iznUplate)
	begin
		declare @msg2 as varchar(200)
		set @msg2=formatmessage('Iznos uplate '+ convert(varchar,@iznUplate)+ ' se razlikuje od iznosa fakture '+convert(varchar,@iznFakture)+
		'. Ne moze unos.')
		raiserror(@msg2,16,0)
	
		delete from Projekat.Uplata_po_fakturi
		where ID_UPF=@ID_UPF
		delete from Projekat.Uplata
		where ID_UP=@ID_UPF
	end
	else
	begin
		print 'Iznos fakture jednak je iznosu uplate. Promena statusa fakture.'

		update Projekat.Faktura
		set PLACENA= 1
		where ID_F=@ID_F

	end
 end
go

--izaziva gresku (losi iznosi)

insert into Projekat.Uplata(ID_UP,IZVR_UP,IZN_UP,DAT_UP,ID_ZAPOSLENOG_R)
values ('84648', 'Darko Lazic', '15000', '2023-05-07', '5')

insert into Projekat.Uplata_po_fakturi(ID_UPF,ID_STRANKE_K,ID_F,ID_IN)
values('84648', '2', 22, null)

SELECT * FROM Projekat.Faktura
select * from Projekat.Uplata
SELECT * FROM Projekat.Uplata_po_fakturi

--prolazi

insert into Projekat.Uplata(ID_UP,IZVR_UP,IZN_UP,DAT_UP,ID_ZAPOSLENOG_R)
values ('14500', 'Filip Bogdanovic', '8500', '2023-03-08', '5')

insert into Projekat.Uplata_po_fakturi(ID_UPF,ID_STRANKE_K,ID_F,ID_IN)
values('14500', '14', 23, null)

delete from Projekat.Uplata_po_fakturi
where ID_UPF=14500

delete from Projekat.Uplata
where ID_UP=14500

update Projekat.Faktura
set PLACENA= 0
where ID_F=23

select * from Projekat.Faktura

select * from Projekat.Uplata

select * from Projekat.Uplata_po_fakturi

/*
2. Triger se aktivira prilikom inserta nove torke u tabelu uplata po sudskom resenju i proverava da li je datum uplate manji od datuma pokretanja predmeta na osnovu 
cije pravosnazne sudske presude je izvrsena uplata po sudskom resenju. Ukoliko je datum validan uspesno izvrsiti unos, a ukoliko nije onda ispisati poruku o gresci
*/
if object_id('Projekat.Triger2') is not null
 drop trigger Projekat.Triger2
 go
 create trigger Projekat.Triger2
 on Projekat.Uplata_po_sudskom_resenju
 instead of insert
 as
 begin
	if @@ROWCOUNT=0
		return;
	declare @ID_UPS as VARCHAR(10)=(select ID_UPS from inserted)
	declare @brPredmeta varchar(10) = (select BR_PREDMETA_PSP from inserted)
	declare @rbrSpisa as numeric(2) = (select RBR_SPI_PSP from inserted)
	declare @datumUplate as date=(select DAT_UP from Projekat.Uplata where ID_UP=@ID_UPS)
	declare @datumPokretanja as date =(select p.DAT_PP from Projekat.Predmet p WHERE p.BR_PREDMETA=@brPredmeta)

	if(@datumUplate<@datumPokretanja)
	begin
		declare @msg as varchar(150) = 'Uplata ne sme biti izvrsena pre pokretanja predmeta na osnovu cije pravosnazne sudske presude je izvrsena uplata! Greska!'
		raiserror(@msg,16,0)

		delete from Projekat.Uplata
		where ID_UP=@ID_UPS
	end
	else
	begin
		insert into Projekat.Uplata_po_sudskom_resenju
		values(@ID_UPS,@brPredmeta,@rbrSpisa, (select ID_IN from inserted))
		print 'Uspesno izvrsen unos u tabelu uplata po sudskom resenju.'
	end
 end
 go

 select * from Projekat.Uplata
 select * from Projekat.Uplata_po_sudskom_resenju
 SELECT * FROM Projekat.Pravosnazna_sudska_presuda
 select * from Projekat.Predmet
 select * from Projekat.Spis
 select * from Projekat.Institucije
 
 --uspesan unos
 insert into Projekat.Uplata
 values('12000', 'Prekrsajni sud u Novom Sadu', 100000, '2023-05-12',5)

 insert into Projekat.Uplata_po_sudskom_resenju
 values('12000', 'KP32155', 1,2)

 delete from Projekat.Uplata_po_sudskom_resenju
		where ID_UPS='12000'

 delete from Projekat.Uplata
		where ID_UP='12000'
 --neuspesan unos

  insert into Projekat.Uplata
 values('12000', 'Prekrsajni sud u Novom Sadu', 100000, '2023-01-12',5)

 insert into Projekat.Uplata_po_sudskom_resenju
 values('12000', 'KP32155', 1,2)

