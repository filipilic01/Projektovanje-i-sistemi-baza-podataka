--ZAPOSLENI
insert into Projekat.Zaposleni
values(next value for Projekat.ZaposleniSekvenca,'2205959853842', 'Milan', 'Peric', 'M', '1959-05-22', 'Jirecekova 2', 'Novi Sad', 'Srbija', '065/4458985', 'milanperic@gmail.com', '2000-09-19', '95000')
insert into Projekat.Zaposleni
values(next value for Projekat.ZaposleniSekvenca,'0202966745514', 'Dragan', 'Simic', 'M', '1966-02-02', 'Vojvodjanskih brigada 14', 'Novi Sad', 'Srbija', '062/5875454', 'dragansimic@gmail.com', '2005-11-22', '95000')
insert into Projekat.Zaposleni
values(next value for Projekat.ZaposleniSekvenca,'1211977124577', 'Natasa', 'Radovanovic', 'Z', '1977-11-12', 'Tolstojeva 3', 'Novi Sad', 'Srbija', '061/755044', 'natasaradovanovic@gmail.com', '2015-12-14', '75000')
insert into Projekat.Zaposleni
values(next value for Projekat.ZaposleniSekvenca,'2501971889945', 'Slavko', 'Milivojevic', 'M', '1971-01-25', 'Sekspirova 2', 'Novi Sad', 'Srbija', '063/6546545', 'slavkomilivojevic@gmail.com', '2010-04-01', '85000')
insert into Projekat.Zaposleni
values(next value for Projekat.ZaposleniSekvenca,'1712969744859', 'Nada', 'Simonovic', 'Z', '1969-12-17', 'Narodnog fronta 25', 'Novi Sad', 'Srbija', '062/5557774', 'nadasimonovic@gmail.com', '2017-02-20', '55000')
select * from Projekat.Zaposleni
--RACUNOVODJA
insert intO Projekat.Racunovodja
values ('5')
select * from Projekat.Racunovodja
--BANKA
insert into Projekat.Banka
values ('1', 'UniCredit banka', null)
insert into Projekat.Banka
values ('2', 'OTP banka', '065/558952')
insert into Projekat.Banka
values ('3', 'Erste banka', null)
insert into Projekat.Banka
values ('4', 'Komercijalna banka', '062/7895648')
select * from Projekat.Banka						
--INSTITUCIJE
insert into Projekat.Institucije
values ('1', 'Osnovni sud u Novom Sadu', 'Sutjeska 3', 'Novi Sad')
insert into Projekat.Institucije
values ('2', 'Prekrsajni sud u Novom Sadu', 'Bulevar oslobodjenja 58', 'Novi Sad')
insert into Projekat.Institucije
values ('3', 'Gradska poreska uprava', 'Vojvodjanskih brigada 24', 'Novi Sad')
insert into Projekat.Institucije
values ('4', 'Centar za socijalni rad grada Novog Sada', 'Zmaj Ognjena Vuka 13-17', 'Novi Sad')
select * from Projekat.Institucije
--FIZICKO LICE
insert into Projekat.Fizicko_lice
values ('1', '2502984175448','Milos', 'Milosevic', '062/454655', null, null)
insert into Projekat.Fizicko_lice
values ('2', null,'Milica', 'Savic', null, null, null)
insert into Projekat.Fizicko_lice
values ('3', null,'Srdjan', 'Kovac', '064/7685445', null, null)
insert into Projekat.Fizicko_lice
values ('4', '2403977456522','Milija', 'Rosic', '064/7774445', 'milija123@gmail.com', 'Puskinova 22, Novi Sad')
insert into Projekat.Fizicko_lice
values ('5', '0608990586459','Darko', 'Lazic', '064/4465587', 'darkolazic@gmail.com', 'Lasla Gala 10, Novi Sad')
insert into Projekat.Fizicko_lice
values ('6', '2709952768998','Sava', 'Markovic', '064/5555554', null , 'Fruskogorska 11, Novi Sad')
insert into Projekat.Fizicko_lice
values ('7', '0110985765666','Aleksandar', 'Savkovic', '061/899854', 'savkovic123@gmail.com', 'Doza Djerdja 3, Novi Sad')
insert into Projekat.Fizicko_lice
values ('8', '1201970854689','Jovan', 'Stevic', '060/7645584', 'stevicjovan@gmail.com', 'Pavla Papa 15, Novi Sad')
insert into Projekat.Fizicko_lice
values ('9', '2811968565512','Milena', 'Stojicevic', '064/8778475', 'milenast@gmail.com', 'Kopernikova 16, Novi Sad')
insert into Projekat.Fizicko_lice
values ('10', '1712978768921','Filip', 'Bogdanovic', '069/784574', 'filipbogdan@gmail.com', 'Sopocanska 22, Novi Sad')
select * from Projekat.Fizicko_lice
--PRAVNO LICE
insert into Projekat.Pravno_lice
values ('1', '45684', 'DOO Agrocentar', '021/864856484', 'agrocentar@gmail.com', 'Bulevar Oslobodjenja 142, Novi Sad')
insert into Projekat.Pravno_lice
values ('2', '112425', 'JKP Novi Sad', '021/564686816', 'jkpnovisad123@gmail.com', 'Bulevar Oslobodjenja 111, Novi Sad')
insert into Projekat.Pravno_lice
values ('3', '777454', 'Diskont pica Novi Sad', null, null, null)
insert into Projekat.Pravno_lice
values ('4', '45686', 'Eksport-import', '062/7854448', 'eksportimport@gmail.com', 'Strazilovska 14, Novi Sad')
insert into Projekat.Pravno_lice
values ('5', '015457', 'Mesara Savanovic', '021/468468548', 'mesarasavanovic@gmail.com', 'Jesenjinova 10, Novi Sad')
insert into Projekat.Pravno_lice
values ('6', '897654', 'Inzenjering-Mirkovic', '021/455474124', 'inzmirkovic@gmail.com', 'Balzakova 23, Novi Sad')
insert into Projekat.Pravno_lice
values ('7', '49986', 'Higijena NS', '021/654458789', 'higijenans@gmail.com', 'Veternicka 14, Novi Sad')
select * from Projekat.Pravno_lice
--STRANKA
insert into Projekat.Stranka
values ('1', '4', null)
insert into Projekat.Stranka
values ('2', '5', null)
insert into Projekat.Stranka
values ('3', '6', null)
insert into Projekat.Stranka
values ('4', null , '1')
insert into Projekat.Stranka
values ('5', null, '3')
insert into Projekat.Stranka
values ('6', '7', null)
insert into Projekat.Stranka
values ('7', '1', null)
insert into Projekat.Stranka
values ('8', null, '4')
insert into Projekat.Stranka
values ('9', null, '5')
insert into Projekat.Stranka
values ('10', null, '6')
insert into Projekat.Stranka
values ('11', null, '7')
insert into Projekat.Stranka
values ('12', '8', null)
insert into Projekat.Stranka
values ('13', '9', null)
insert into Projekat.Stranka
values ('14', '10', null)
SELECT * FROM Projekat.Stranka
--KLIJENT
insert into Projekat.Klijent
values ('1')
insert into Projekat.Klijent
values ('2')
insert into Projekat.Klijent
values ('3')
insert into Projekat.Klijent
values ('5')
insert into Projekat.Klijent
values ('6')
insert into Projekat.Klijent
values ('8')
insert into Projekat.Klijent
values ('9')
insert into Projekat.Klijent
values ('10')
insert into Projekat.Klijent
values ('11')
insert into Projekat.Klijent
values ('12')
insert into Projekat.Klijent
values ('13')
insert into Projekat.Klijent
values ('14')
SELECT * FROM Projekat.Klijent
--RACUN
insert into Projekat.Racun
values('1707457896554178', '1')
insert into Projekat.Racun
values('3254563257845944', '2')
insert into Projekat.Racun
values('3401145879856858', '3')
insert into Projekat.Racun
values('2051475848965844', '4')
select * from Projekat.Racun
--PREDMET
insert into Projekat.Predmet
values('KP78994','2022-01-29', '2023-02-28', '1', '7500000', '1')
insert into Projekat.Predmet
values('SP84568','2022-11-08', '2023-04-12', '1', NULL, '1')
insert into Projekat.Predmet
values('SP54869','2018-02-09', '2020-03-09', '1', NULL, '2')
insert into Projekat.Predmet
values('PP11258','2023-04-10', NULL, '0', NULL, '1')
insert into Projekat.Predmet
values('KP89749','2022-10-15', '2023-01-05', '1', '550000', '2')
insert into Projekat.Predmet
values('PP71494','2022-04-08', '2022-09-30', '1', NULL, '3')
insert into Projekat.Predmet
values('KP32155','2023-03-31', NULL, '0', '110000', '2')
select * from Projekat.Predmet
--FAKTURA
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Osnovni sud u Novom Sadu', '2022-12-21', '45000', '5', '1707457896554178', 1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Eksport-import', '2022-02-18', '10000', '5', '1707457896554178',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Milija Rosic', '2022-10-22', '5000', '5', '2051475848965844', 1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Milija Rosic', '2023-01-03', '7500', '5', '2051475848965844',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Prekrsajni sud u Novom Sadu', '2022-11-21', '120000', '5', '1707457896554178',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Prekrsajni sud u Novom Sadu', '2022-12-01', '40000', '5', '1707457896554178',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Centar za socijalni rad grada Novog Sada', '2022-05-25', '15000', '5', '3401145879856858',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Aleksandar Savkovic', '2022-08-02', '20000', '5', '2051475848965844',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Sava Markovic', '2023-04-05', '7500', '5', '2051475848965844', 1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Darko Lazic', '2022-04-22', '1200', '5', '2051475848965844',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Osnovni sud u Novom Sadu', '2022-05-14', '32000', '5', '1707457896554178',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Aleksandar Savkovic', '2022-02-03', '4000', '5', '2051475848965844',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Aleksandar Savkovic', '2022-10-10', '16000', '5', '2051475848965844',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Milija Rosic', '2023-04-20', '1500', '5', '2051475848965844',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Sava Markovic', '2023-04-21', '4000', '5', '2051475848965844',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Jovan Stevic', '2022-09-26', '25000', '5', '1707457896554178',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Higijena NS', '2023-02-26', '14000', '5', '1707457896554178',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Inzenjering-Mirkovic', '2022-12-22', '55000', '5', '3401145879856858',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Filip Bogdanovic', '2023-03-22', '6000', '5', '1707457896554178',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Milena Stojicevic', '2022-09-26', '15500', '5', '1707457896554178',1)
insert into Projekat.Faktura
values(next value for Projekat.SekvencaFaktura, 'Milena Stojicevic', '2022-11-26', '10300', '5', '1707457896554178',1)
insert into Projekat.Faktura
values (next value for Projekat.SekvencaFaktura, 'Darko Lazic', '2023-05-04', '10000', '5', '1707457896554178',0)
insert into Projekat.Faktura
values (next value for Projekat.SekvencaFaktura, 'Filip Bogdanovic', '2023-03-03', '8500', '5', '1707457896554178',0)

select * from Projekat.Faktura
--UPLATA
insert into Projekat.Uplata
values ('12354', 'Prekrsajni sud u Novom Sadu', '10000', '2023-03-05', '5')
insert into Projekat.Uplata
values ('95966', 'Centar za socijalni rad grada Novog Sada', '15000', '2022-06-01', '5')
insert into Projekat.Uplata
values ('65482', 'Prekrsajni sud u Novom Sadu', '50000', '2022-01-10', '5')
insert into Projekat.Uplata
values ('65445', 'Osnovni sud u Novom Sadu', '112000', '2022-10-05', '5')
insert into Projekat.Uplata
values ('14254', 'Milija Rosic', '7500', '2023-01-17', '5')
insert into Projekat.Uplata
values ('89485', 'Osnovni sud u Novom Sadu', '25000', '2022-10-18', '5')
insert into Projekat.Uplata
values ('71177', 'Milija Rosic', '5000', '2022-10-25', '5')
insert into Projekat.Uplata
values ('12554', 'Eksport-import', '10000', '2022-02-26', '5')
insert into Projekat.Uplata
values ('12774', 'Aleksandar Savkovic', '20000', '2022-08-08', '5')
insert into Projekat.Uplata
values ('45687', 'Darko Lazic', '1200', '2022-04-29', '5')
insert into Projekat.Uplata
values ('99878', 'Sava Markovic', '7500', '2023-04-10', '5')
insert into Projekat.Uplata
values ('65455', 'Aleksandar Savkovic', '4000', '2022-02-08', '5')
insert into Projekat.Uplata
values ('15525', 'Osnovni sud u Novom Sadu', '65000', '2023-04-18', '5')
insert into Projekat.Uplata
values ('74565', 'Aleksandar Savkovic', '16000', '2022-10-16', '5')
insert into Projekat.Uplata
values ('11214', 'Milija Rosic', '1500', '2023-04-25', '5')
insert into Projekat.Uplata
values ('91578', 'Sava Markovic', '4000', '2023-04-23', '5')
insert into Projekat.Uplata
values ('44441', 'Jovan Stevic', '25000', '2022-09-30', '5')
insert into Projekat.Uplata
values ('32112', 'Filip Bogdanovic', '6000', '2023-03-30', '5')
insert into Projekat.Uplata
values ('11114', 'Milena Stojicevic', '15500', '2022-10-07', '5')
insert into Projekat.Uplata
values ('44578', 'Inzenjering-Mirkovic', '55000', '2022-12-30', '5')
insert into Projekat.Uplata
values ('88748', 'Milena Stojicevic', '10300', '2022-11-30', '5')
insert into Projekat.Uplata
values ('77994', 'Higijena NS', '14000', '2023-03-18', '5')
insert into Projekat.Uplata
values ('31545', 'Osnovni sud u Novom Sadu', '45000', '2022-12-31', '5')
insert into Projekat.Uplata
values ('70025', 'Prekrsajni sud u Novom Sadu', '120000', '2022-12-06', '5')
insert into Projekat.Uplata
values ('10245', 'Prekrsajni sud u Novom Sadu', '40000', '2022-12-06', '5')
insert into Projekat.Uplata
values ('95006', 'Osnovni sud u Novom Sadu', '32000', '2022-06-01', '5')
select * from Projekat.Uplata
--UPLATA PO FAKTURI
insert into Projekat.Uplata_po_fakturi
values('31545', null, '1', '1')
insert into Projekat.Uplata_po_fakturi
values('70025', null, '5', '2')
insert into Projekat.Uplata_po_fakturi
values('10245', null, '6', '2')
insert into Projekat.Uplata_po_fakturi
values('95966', null, '7', '4')
insert into Projekat.Uplata_po_fakturi
values('95006', null, '11', '1')
insert into Projekat.Uplata_po_fakturi
values('14254', '1', '3', null)
insert into Projekat.Uplata_po_fakturi
values('71177', '1', '4', null)
insert into Projekat.Uplata_po_fakturi
values('12774', '6', '8', null)
insert into Projekat.Uplata_po_fakturi
values('12554', '8', '2', null)
insert into Projekat.Uplata_po_fakturi
values('45687', '2', '10', null)
insert into Projekat.Uplata_po_fakturi
values('99878', '3', '9', null)
insert into Projekat.Uplata_po_fakturi
values('65455', '6', '12', null)
insert into Projekat.Uplata_po_fakturi
values('11214', '1', '14', null)
insert into Projekat.Uplata_po_fakturi
values('91578', '3', '15', null)
insert into Projekat.Uplata_po_fakturi
values('74565', '6', '13', null)
insert into Projekat.Uplata_po_fakturi
values('77994', '11', '17', null)
insert into Projekat.Uplata_po_fakturi
values('88748', '13', '21', null)
insert into Projekat.Uplata_po_fakturi
values('44578', '10', '18', null)
insert into Projekat.Uplata_po_fakturi
values('11114', '13', '20', null)
insert into Projekat.Uplata_po_fakturi
values('32112', '14', '19', null)
insert into Projekat.Uplata_po_fakturi
values('44441', '12', '16', null)
SELECT * FROM Projekat.Uplata_po_fakturi
--SPIS
insert into Projekat.Spis
values('KP78994', '1', '1', null, '2022-01-31', 4000)
insert into Projekat.Spis
values('KP78994', '2', '1', null,'2021-01-31', 7000)
insert into Projekat.Spis
values('KP78994', '3', '1', null, '2021-02-02', 8000)
insert into Projekat.Spis
values('KP89749', '1', '1', null, '2022-10-16', 4000)
insert into Projekat.Spis
values('KP89749', '2', '1', null, '2023-01-04', 6555)
insert into Projekat.Spis
values('KP32155', '1', '1', null, '2023-04-01', 7200)
insert into Projekat.Spis
values('PP71494', '1', '1', null, '2022-04-19', 6500)
insert into Projekat.Spis
values('SP84568', '1', '0', '2022-11-18', null, 4855)
insert into Projekat.Spis
values('SP84568', '2', '0', '2022-12-04', null, 6055)
SELECT * FROM Projekat.Spis
--PRAVOSNAZNA SUDSKA PRESUDA
insert into Projekat.Pravosnazna_sudska_presuda
values('SP84568', '2', '1707457896554178' )
insert into Projekat.Pravosnazna_sudska_presuda
values('KP78994', '3', '1707457896554178' )
insert into Projekat.Pravosnazna_sudska_presuda
values('KP89749', '2', '2051475848965844' )
insert into Projekat.Pravosnazna_sudska_presuda
values('PP71494', '1', '1707457896554178' )
 insert into Projekat.Pravosnazna_sudska_presuda
 values('KP32155', '1', '2051475848965844')
SELECT * FROM Projekat.Pravosnazna_sudska_presuda

--UPLATA PO SUDSKOM RESENJU
insert into Projekat.Uplata_po_sudskom_resenju
values('15525', 'SP84568', '2', '1')
insert into Projekat.Uplata_po_sudskom_resenju
values('12354', 'KP78994', '3', '2')
insert into Projekat.Uplata_po_sudskom_resenju
values('65482', 'KP89749', '2', '2')
insert into Projekat.Uplata_po_sudskom_resenju
values('65445', 'PP71494', '1', '1')
select * from Projekat.Uplata_po_sudskom_resenju
