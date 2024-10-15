use it7g2020
go

if object_id('Projekat.Uplata_po_sudskom_resenju') is not null
drop table Projekat.Uplata_po_sudskom_resenju
if object_id('Projekat.Pravosnazna_sudska_presuda') is not null
drop table Projekat.Pravosnazna_sudska_presuda
if object_id('Projekat.Uplata_po_fakturi') is not null
drop table Projekat.Uplata_po_fakturi
if object_id('Projekat.Spis') is not null
drop table Projekat.Spis 
if object_id('Projekat.Klijent') is not null
drop table Projekat.Klijent
if object_id('Projekat.Stranka') is not null
drop table Projekat.Stranka
if object_id('Projekat.Faktura') is not null
drop table Projekat.Faktura
if object_id('Projekat.Racun') is not null
drop table Projekat.Racun
if object_id('Projekat.Uplata') is not null
drop table Projekat.Uplata
if object_id('Projekat.Racunovodja') is not null
drop table Projekat.Racunovodja
if object_id('Projekat.Zaposleni') is not null
drop table Projekat.Zaposleni
if object_id('Projekat.Banka') is not null
drop table Projekat.Banka
if object_id('Projekat.Institucije') is not null
drop table Projekat.Institucije
if object_id('Projekat.Fizicko_lice') is not null
drop table Projekat.Fizicko_lice
if object_id('Projekat.Pravno_lice') is not null
drop table Projekat.Pravno_lice
if object_id('Projekat.Predmet') is not null
drop table Projekat.Predmet
if object_id('Projekat.ZaposleniSekvenca') is not null
drop sequence Projekat.ZaposleniSekvenca
go
if object_id('Projekat.SekvencaFaktura') is not null
drop sequence Projekat.SekvencaFaktura
go

if SCHEMA_ID('Projekat') is not null
drop schema Projekat
go

create schema Projekat
go


create sequence Projekat.ZaposleniSekvenca as numeric
start with 1
minvalue 1
increment by 1
no cycle

create sequence Projekat.SekvencaFaktura as numeric
start with 1
minvalue 1
increment by 1
no cycle


create table Projekat.Zaposleni
(
	ID_ZAPOSLENOG numeric(2) not null,
	JMBG_ZAP varchar(13) constraint UC_JMBG unique (JMBG_ZAP) not null,
	IME_ZAP VARCHAR(20) NOT NULL,
	PREZIME_ZAP VARCHAR(20) NOT NULL,
	POL_ZAP VARCHAR(1) constraint CHK_POL_ZAPOSLENOG check (POL_ZAP IN ('M','Z')),
	DAT_RODJ_ZAP DATE NOT NULL,
	ADRESA_ZAP VARCHAR(50) NOT NULL,
	GRAD_ZAP VARCHAR(20) NOT NULL,
	DRZAVA_ZAP VARCHAR(20) NOT NULL,
	TEL_ZAP VARCHAR(20) NOT NULL,
	EMAIL_ZAP VARCHAR(30) NOT NULL,
	DAT_ZAP_ZAP DATE NOT NULL,
	PLATA_ZAP numeric(20) NOT NULL,
	CONSTRAINT PK_ID_ZAP PRIMARY KEY (ID_ZAPOSLENOG)
);

create table Projekat.Racunovodja
(
	ID_ZAPOSLENOG_R NUMERIC(2) NOT NULL,
	CONSTRAINT PK_ID_ZAP_RAC PRIMARY KEY (ID_ZAPOSLENOG_R),
	CONSTRAINT FK_ZAPOSLENI_RAC FOREIGN KEY (ID_ZAPOSLENOG_R)
		REFERENCES Projekat.Zaposleni (ID_ZAPOSLENOG)
);

create table Projekat.Uplata
(
	ID_UP VARCHAR(10) NOT NULL,
	IZVR_UP VARCHAR(50) NOT NULL,
	IZN_UP NUMERIC(10) CONSTRAINT CHK_IZN_UPL CHECK (IZN_UP > 0) NOT NULL,
	DAT_UP DATE CONSTRAINT CHK_DAT_UPL CHECK (DAT_UP<=GETDATE()) NOT NULL,
	ID_ZAPOSLENOG_R NUMERIC(2) NOT NULL,
	CONSTRAINT PK_ID_UPLATE PRIMARY KEY (ID_UP),
	CONSTRAINT FK_RAC_UPLATA FOREIGN KEY (ID_ZAPOSLENOG_R)
		REFERENCES Projekat.Racunovodja (ID_ZAPOSLENOG_R)
);

create table Projekat.Banka
(
	ID_BANKA NUMERIC(2) NOT NULL,
	NAZIV_B VARCHAR(20) NOT NULL,
	KONTAKT_B VARCHAR(20),
	CONSTRAINT PK_BANKA PRIMARY KEY (ID_BANKA)

);

create table Projekat.Racun
(
	BR_RAC VARCHAR(16) NOT NULL,
	ID_BANKA NUMERIC(2) NOT NULL,
	CONSTRAINT PK_RACUN PRIMARY KEY (BR_RAC),
	CONSTRAINT FK_BANKA_RACUN FOREIGN KEY (ID_BANKA)
		REFERENCES Projekat.Banka (ID_BANKA)
);



create table Projekat.Faktura
(
	ID_F NUMERIC(3) NOT NULL,
	PR_F VARCHAR(50) NOT NULL,
	DAT_F DATE CONSTRAINT CHK_DAT_FAKT CHECK (DAT_F<=GETDATE()) NOT NULL,
	UI_F NUMERIC(10) CONSTRAINT CHK_IZNOS_FAKT CHECK (UI_F>0) NOT NULL,
	ID_ZAPOSLENOG_R NUMERIC(2) NOT NULL,
	BR_RAC VARCHAR(16) NOT NULL,
	PLACENA BIT CONSTRAINT DFT_PLAC DEFAULT(0),
	CONSTRAINT PK_FAKTURA PRIMARY KEY (ID_F),
	CONSTRAINT FK_FAK_RACUN FOREIGN KEY (BR_RAC)
		REFERENCES Projekat.Racun (BR_RAC),
	CONSTRAINT FK_FAK_ZAPOSL FOREIGN KEY (ID_ZAPOSLENOG_R)
		REFERENCES Projekat.Racunovodja (ID_ZAPOSLENOG_R)
);

create table Projekat.Institucije
(
	ID_IN NUMERIC(2) NOT NULL,
	NAZIV_IN VARCHAR(40) NOT NULL,
	ADRESA_IN VARCHAR(50) NOT NULL,
	MESTO_IN VARCHAR(30) NOT NULL,
	CONSTRAINT PK_INSTITUCIJA PRIMARY KEY (ID_IN)
);

create table Projekat.Fizicko_lice
(
	ID_FL NUMERIC(5) NOT NULL,
	MBR_FL NUMERIC(13),
	IME_FL VARCHAR(20) NOT NULL,
	PRZ_FL VARCHAR(20) NOT NULL,
	TEL_FL VARCHAR(20),
	EMAIL_FL VARCHAR(60),
	ADRESA_FL VARCHAR(50),
	CONSTRAINT PK_FIZ_LICE PRIMARY KEY (ID_FL)
);

create table Projekat.Pravno_lice
(
	ID_PL NUMERIC(3) NOT NULL,
	PIB_PL NUMERIC(20) CONSTRAINT UC_PIB_PL UNIQUE (PIB_PL) NOT NULL,
	NAZIV_PL VARCHAR(30) NOT NULL,
	TEL_PL VARCHAR(20),
	EMAIL_PL VARCHAR(60),
	ADRESA_PL VARCHAR(50),
	CONSTRAINT PK_PRAVNO_LICE PRIMARY KEY (ID_PL)
);

create table Projekat.Stranka 
(
	ID_STRANKE VARCHAR(5) NOT NULL,
	ID_FL NUMERIC(5),
	ID_PL NUMERIC(3),
	CONSTRAINT PK_STRANKA PRIMARY KEY (ID_STRANKE),
	CONSTRAINT FK_STRANKA_FIZ FOREIGN KEY (ID_FL)
		REFERENCES Projekat.Fizicko_lice (ID_FL),
	CONSTRAINT FK_STRANKA_PRAV FOREIGN KEY (ID_PL)
		REFERENCES Projekat.Pravno_lice (ID_PL),
	CONSTRAINT CHK_FIZ_PRAV CHECK ((ID_FL IS NULL AND ID_PL IS NOT NULL) OR (ID_FL IS NOT NULL AND ID_PL IS NULL))
);

create table Projekat.Klijent 
(
	ID_STRANKE_K VARCHAR(5) NOT NULL,
	CONSTRAINT PK_KLIJENT PRIMARY KEY (ID_STRANKE_K),
	CONSTRAINT FK_KLIJENT_SER FOREIGN KEY (ID_STRANKE_K)
		REFERENCES Projekat.Stranka (ID_STRANKE)
);

create table Projekat.Predmet
(
	BR_PREDMETA VARCHAR(10) NOT NULL,
	DAT_PP DATE CONSTRAINT CHK_DAT_PP CHECK (DAT_PP<=GETDATE()) NOT NULL,
	DAT_ZP DATE CONSTRAINT CHK_DAT_ZP CHECK (DAT_ZP<=GETDATE()),
	SUD_P BIT NOT NULL,
	VR_SPORA NUMERIC(8) CONSTRAINT CHK_SPOR CHECK (VR_SPORA>0),
	BR_POZ NUMERIC(1) CONSTRAINT CHK_BR_POZ CHECK (BR_POZ IN (1,2,3)),
	CONSTRAINT PK_PREDMET PRIMARY KEY (BR_PREDMETA),
	CONSTRAINT CHK_DATUMI_PREDMET CHECK (DAT_ZP>DAT_PP),
	
);

create table Projekat.Spis 
(
	BR_PREDMETA VARCHAR(10) NOT NULL,
	RBR_SPI VARCHAR(4) NOT NULL,
	STAT_SP BIT NOT NULL,
	DATUM_PRIJ_SP DATE,
	DATUM_PRED_SP DATE,
	PDF_S VARBINARY(8000),
	CONSTRAINT PK_SPIS PRIMARY KEY (BR_PREDMETA,RBR_SPI),
	CONSTRAINT FK_SPIS_PRED FOREIGN KEY (BR_PREDMETA)
		REFERENCES Projekat.Predmet (BR_PREDMETA),

);

create table Projekat.Pravosnazna_sudska_presuda
(
	BR_PREDMETA_PSP VARCHAR(10) NOT NULL,
	RBR_SPI_PSP VARCHAR(4) NOT NULL,
	BR_RAC VARCHAR(16) NOT NULL,
	CONSTRAINT PK_PRESUDA PRIMARY KEY (BR_PREDMETA_PSP,RBR_SPI_PSP),
	CONSTRAINT FK_PRESUDA_SPIS FOREIGN KEY (BR_PREDMETA_PSP,RBR_SPI_PSP)
		REFERENCES Projekat.Spis (BR_PREDMETA, RBR_SPI),
	CONSTRAINT FK_PRESUDA_RAC FOREIGN KEY (BR_RAC)
		REFERENCES Projekat.Racun (BR_RAC)
);

create table Projekat.Uplata_po_fakturi
(
	ID_UPF VARCHAR(10) NOT NULL,
	ID_STRANKE_K VARCHAR(5) ,
	ID_F NUMERIC(3) NOT NULL,
	ID_IN NUMERIC(2) ,
	CONSTRAINT PK_UPLATA_PO_FAKT PRIMARY KEY (ID_UPF),
	CONSTRAINT FK_UFAKT_UPLATA FOREIGN KEY (ID_UPF)
		REFERENCES Projekat.Uplata (ID_UP),
	CONSTRAINT FK_UFAKT_KLIJ FOREIGN KEY (ID_STRANKE_K)
		REFERENCES Projekat.Klijent (ID_STRANKE_K),
	CONSTRAINT FK_UFAKT_FAKT FOREIGN KEY (ID_F)
		REFERENCES Projekat.Faktura (ID_F),
	CONSTRAINT FK_UFAKT_INST FOREIGN KEY (ID_IN)
		REFERENCES Projekat.Institucije (ID_IN),
	CONSTRAINT CHK_UPLATA_PO_FAKT CHECK ((ID_IN IS NULL AND ID_STRANKE_K IS NOT NULL) OR (ID_IN IS NOT NULL AND ID_STRANKE_K IS NULL))
);

CREATE TABLE Projekat.Uplata_po_sudskom_resenju
(
	ID_UPS VARCHAR(10) NOT NULL,
	BR_PREDMETA_PSP VARCHAR(10) NOT NULL,
	RBR_SPI_PSP VARCHAR(4) NOT NULL,
	ID_IN NUMERIC(2) NOT NULL,
	CONSTRAINT PK_UPLATA_PO_RESENJU PRIMARY KEY (ID_UPS),
	CONSTRAINT FK_RES_UPLATA FOREIGN KEY (ID_UPS)
		REFERENCES Projekat.Uplata (ID_UP),
	CONSTRAINT FK_RES_PRESUDA FOREIGN KEY (BR_PREDMETA_PSP,RBR_SPI_PSP)
		REFERENCES Projekat.Pravosnazna_sudska_presuda (BR_PREDMETA_PSP,RBR_SPI_PSP),
	CONSTRAINT FK_SUD_INSTIT FOREIGN KEY (ID_IN)
		REFERENCES Projekat.Institucije (ID_IN)
);

	