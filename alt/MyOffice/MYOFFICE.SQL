CREATE DATABASE `MYOFFICE`
USE `MYOFFICE`;

#
# Table structure for table ADRESSEN
#

CREATE TABLE `adressen` (
  `Nr` int(11) NOT NULL auto_increment,
  `Kategorie` varchar(25) default NULL,
  `Nachname` varchar(50) default NULL,
  `Vorname` varchar(50) default NULL,
  `Titel` varchar(50) default NULL,
  `Firma` varchar(50) default NULL,
  `Tel_Firma` varchar(25) default NULL,
  `Tel_Privat` varchar(25) default NULL,
  `Tel_Fax` varchar(25) default NULL,
  `Tel_Andere` varchar(25) default NULL,
  `E_Mail` varchar(50) default NULL,
  `Strasse_Nr` varchar(50) default NULL,
  `PLZ` varchar(25) default NULL,
  `Ort` varchar(50) default NULL,
  `Land` varchar(50) default NULL,
  `Notiz` text,
  `Adresse` text,
  `Frei1` varchar(50) default NULL,
  `Frei2` varchar(50) default NULL,
  `Frei3` varchar(50) default NULL,
  `Frei4` varchar(50) default NULL,
  `Rabatt` double default '0',
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Kategorie` (`Kategorie`),
  KEY `Nachname` (`Nachname`),
  KEY `Vorname` (`Vorname`),
  KEY `Titel` (`Titel`),
  KEY `Firma` (`Firma`)
) TYPE=MyISAM;


#
# Dumping data for table ADRESSEN
#

INSERT INTO `ADRESSEN` VALUES (0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0);

#
# Table structure for table ARTIKEL
#

CREATE TABLE `artikel` (
  `Nr` int(11) NOT NULL auto_increment,
  `Artikelgruppe` varchar(25) default NULL,
  `Artikel` varchar(25) default NULL,
  `EK_Preis` double default NULL,
  `Einheit_EK` varchar(13) default NULL,
  `Aufschlag` double default '0',
  `Gewicht` double default NULL,
  `Zahl1` double default '0',
  `Zahl2` double default '0',
  `Zahl3` double default '0',
  `Name1` varchar(25) default NULL,
  `Name2` varchar(25) default NULL,
  `Name3` varchar(100) default NULL,
  `Lieferant` varchar(50) default NULL,
  `LieferantArtikelNr` varchar(25) default '0',
  `Pos_Text` text,
  `EinheitMenge` varchar(13) default NULL,
  `BerechnungsArt` varchar(50) default NULL,
  `Kostenart` char(1) default NULL,
  `Bestand` double default '0',
  `Min_Bestand` double default '0',
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Artikelgruppe` (`Artikelgruppe`),
  KEY `Artikel` (`Artikel`)
) TYPE=MyISAM;


#
# Dumping data for table ARTIKEL
#


#
# Table structure for table EINHEIT
#

CREATE TABLE `einheit` (
  `Nr` int(11) NOT NULL auto_increment,
  `Einheit` varchar(13) default NULL,
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  UNIQUE KEY `Einheit` (`Einheit`)
) TYPE=MyISAM;


#
# Dumping data for table EINHEIT
#

INSERT INTO `EINHEIT` VALUES (1,'Meter',0);
INSERT INTO `einheit` VALUES (2,'Stunden',0);
INSERT INTO `einheit` VALUES (3,'Stück',0);
INSERT INTO `einheit` VALUES (4,'Sortiment',0);

#
# Table structure for table MODULE
#

CREATE TABLE `module` (
  `Nr` int(11) NOT NULL auto_increment,
  `Bezeichnung` varchar(50) default NULL,
  `Projekt_Nr` int(11) default '0',
  `Adress_Nr` int(11) default '0',
  `Modul_Nr` int(11) default '0',
  `Modulart` varchar(25) default NULL,
  `Erfassungsdatum` date default NULL,
  `LetzteBearbeitung` date default NULL,
  `Bearbeiter` varchar(50) default NULL,
  `Gruppierung` varchar(50) default NULL,
  `Projektname` varchar(50) default NULL,
  `Adressname` varchar(50) default NULL,
  `Notiz` text,
  `Kopftext` text,
  `Fusstext` text,
  `Adresse` text,
  `IhrZeichen` varchar(25) default NULL,
  `Modulart_Nr` int(11) default '0',
  `BMPLogo` blob,
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Bezeichnung` (`Bezeichnung`),
  KEY `Projekt_Nr` (`Projekt_Nr`),
  KEY `Adress_Nr` (`Adress_Nr`),
  KEY `Modul_Nr` (`Modul_Nr`),
  KEY `Modulart` (`Modulart`),
  KEY `Erfassungsdatum` (`Erfassungsdatum`),
  KEY `LetzteBearbeitung` (`LetzteBearbeitung`),
  KEY `Bearbeiter` (`Bearbeiter`),
  KEY `Gruppierung` (`Gruppierung`)
) TYPE=MyISAM;


#
# Dumping data for table MODULE
#


#
# Table structure for table NUMMER
#

CREATE TABLE `nummer` (
  `Nr` int(11) NOT NULL auto_increment,
  `HauptModulNr` int(11) default '0',
  `HauptModulName` varchar(25) default NULL,
  `NebenModulNr` int(11) default '0',
  `NebenModulName` varchar(25) default NULL,
  `ModulartNr` int(11) default '0',
  `ReadOnly` smallint(6) default NULL,
  PRIMARY KEY  (`Nr`)
) TYPE=MyISAM;


#
# Dumping data for table NUMMER
#


#
# Table structure for table artikelgruppe
#

CREATE TABLE `artikelgruppe` (
  `Nr` int(11) NOT NULL auto_increment,
  `Artikelgruppe` varchar(25) default NULL,
  `BerechnungsArt` varchar(50) default NULL,
  `Aufschlag` double default '0',
  `Kostenart` char(1) default NULL,
  `S_EinheitMenge` smallint(6) default '0',
  `S_Gewicht` smallint(6) default '0',
  `S_Zahl1` smallint(6) default '0',
  `S_Zahl2` smallint(6) default '0',
  `S_Zahl3` smallint(6) default '0',
  `S_Postext` smallint(6) default '0',
  `S_Name1` smallint(6) default '0',
  `S_Name2` smallint(6) default '0',
  `S_Name3` smallint(6) default '0',
  `V_Artikel` varchar(25) default NULL,
  `V_EK_Preis` double default '0',
  `V_Aufschlag` double default '0',
  `V_Einheit_Menge` varchar(13) default NULL,
  `V_Einheit_EKPreis` varchar(13) default NULL,
  `V_Lieferant` varchar(50) default NULL,
  `S_Lieferant` smallint(6) default '0',
  `S_Bestand` smallint(6) default '0',
  `S_Min_Bestand` smallint(6) default '0',
  `S_LieferantArtikelNr` smallint(6) default '0',
  `EinheitMengeSichtbar` smallint(6) default '0',
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  UNIQUE KEY `Artikelgruppe` (`Artikelgruppe`)
) TYPE=MyISAM;


#
# Dumping data for table artikelgruppe
#


#
# Table structure for table artikelliste
#

CREATE TABLE `artikelliste` (
  `Nr` int(11) NOT NULL auto_increment,
  `Pos_Nr` smallint(6) default '0',
  `Artikelgruppe` varchar(25) default NULL,
  `Artikel` varchar(25) default NULL,
  `Gruppierung` varchar(25) default NULL,
  `Modul_Nr` int(11) default '0',
  `Artikel_Nr` int(11) default '0',
  `EK_Preis` double default '0',
  `Einheit_EK` varchar(13) default NULL,
  `Menge` double default '0',
  `EinheitMenge` varchar(13) default NULL,
  `Aufschlag` double default '0',
  `Pos_Text` text,
  `VK_Preis` double default NULL,
  `Materialleistung` double default '0',
  `MatAufschlag` double default '0',
  `Dienstleistung` double default '0',
  `DieAufschlag` double default '0',
  `Fremdleistung` double default '0',
  `FreAufschlag` double default '0',
  `Sonstigeleistung` double default '0',
  `SonAufschlag` double default '0',
  `Gewicht` double default '0',
  `Zahl1` double default '0',
  `Zahl2` double default '0',
  `Zahl3` double default '0',
  `Name1` varchar(25) default NULL,
  `Name2` varchar(25) default NULL,
  `Name3` varchar(100) default NULL,
  `Lieferant` varchar(50) default NULL,
  `LieferantArtikelNr` varchar(25) default NULL,
  `BerechnungsArt` varchar(50) default NULL,
  `Menge2` double default '0',
  `Rabatt` double default '0',
  `Erledigt1` smallint(6) default '0',
  `Erledigt2` smallint(6) default '0',
  `Erledigt3` smallint(6) default '0',
  `Erledigt4` smallint(6) default '0',
  `Erledigt5` smallint(6) default '0',
  `ArtikelArt` varchar(25) default NULL,
  `Bearbeiter` varchar(25) default NULL,
  `Geaendert` smallint(6) default '0',
  `Kostenart` char(1) default NULL,
  `ReadOnly` smallint(6) default '0',
  `Berechnen1` double default '0',
  `Berechnen2` double default '0',
  `Berechnen3` double default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Modul_Nr` (`Modul_Nr`),
  KEY `Pos_Nr` (`Pos_Nr`),
  KEY `Artikel_Nr` (`Artikel_Nr`)
) TYPE=MyISAM;


#
# Dumping data for table artikelliste
#


#
# Table structure for table artikellistes
#

CREATE TABLE `artikellistes` (
  `Nr` int(11) NOT NULL auto_increment,
  `Pos` smallint(6) default '0',
  `Artikelgruppe` varchar(25) default NULL,
  `Artikel` varchar(25) default NULL,
  `Menge` double default NULL,
  `EinheitMenge` varchar(13) default NULL,
  `EK_Preis` double default NULL,
  `Einheit_EK` varchar(13) default NULL,
  `Aufschlag` double default NULL,
  `VK_Preis` double default NULL,
  `Artikel_Nr` int(11) default '0',
  `Gewicht` double default NULL,
  `Zahl1` double default NULL,
  `Zahl2` double default NULL,
  `Zahl3` double default NULL,
  `Name1` varchar(25) default NULL,
  `Name2` varchar(25) default NULL,
  `Name3` varchar(100) default NULL,
  `BerechnungsArt` varchar(50) default NULL,
  `ModulNr` int(11) default '0',
  `Stuecklisten_Nr` int(11) default NULL,
  `Lieferant` varchar(50) default NULL,
  `LieferantArtikelNr` varchar(25) default NULL,
  `Kostenart` char(1) default NULL,
  `Pos_Text` text,
  `Geaendert` smallint(6) default '0',
  `Erledigt1` smallint(6) default '0',
  `Erledigt2` smallint(6) default '0',
  `Erledigt3` smallint(6) default '0',
  `Erledigt4` smallint(6) default '0',
  `Erledigt5` smallint(6) default '0',
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Pos` (`Pos`),
  KEY `Stuecklisten_Nr` (`Stuecklisten_Nr`)
) TYPE=MyISAM;


#
# Dumping data for table artikellistes
#


#
# Table structure for table artikellistetemp
#

CREATE TABLE `artikellistetemp` (
  `Nr` int(11) NOT NULL auto_increment,
  `Pos_Nr` smallint(6) default '0',
  `Artikelgruppe` varchar(25) default NULL,
  `Artikel` varchar(25) default NULL,
  `Gruppierung` varchar(25) default NULL,
  `Modul_Nr` int(11) default '0',
  `Artikel_Nr` int(11) default '0',
  `EK_Preis` double default '0',
  `Einheit_EK` varchar(25) default NULL,
  `Menge` double default '0',
  `EinheitMenge` varchar(25) default NULL,
  `Aufschlag` double default '0',
  `Pos_Text` text,
  `VK_Preis` double default NULL,
  `Materialleistung` double default '0',
  `MatAufschlag` double default '0',
  `Dienstleistung` double default '0',
  `DieAufschlag` double default '0',
  `Fremdleistung` double default '0',
  `FreAufschlag` double default '0',
  `Sonstigeleistung` double default '0',
  `SonAufschlag` double default '0',
  `Gewicht` double default '0',
  `Zahl1` double default '0',
  `Zahl2` double default '0',
  `Zahl3` double default '0',
  `Name1` varchar(25) default NULL,
  `Name2` varchar(25) default NULL,
  `Name3` varchar(50) default NULL,
  `Lieferant` varchar(50) default NULL,
  `LieferantArtikelNr` varchar(25) default NULL,
  `BerechnungsArt` varchar(50) default NULL,
  `Menge2` double default '0',
  `Rabatt` double default '0',
  `Erledigt1` smallint(6) default '0',
  `Erledigt2` smallint(6) default '0',
  `Erledigt3` smallint(6) default '0',
  `Erledigt4` smallint(6) default '0',
  `Erledigt5` smallint(6) default '0',
  `ArtikelArt` varchar(25) default NULL,
  `Bearbeiter` varchar(25) default NULL,
  `Geaendert` smallint(6) default '0',
  `Kostenart` char(1) default NULL,
  `ReadOnly` smallint(6) default '0',
  `Berechnen1` double default '0',
  `Berechnen2` double default '0',
  `Berechnen3` double default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Modul_Nr` (`Modul_Nr`),
  KEY `Pos_Nr` (`Pos_Nr`),
  KEY `Artikel_Nr` (`Artikel_Nr`)
) TYPE=MyISAM;


#
# Dumping data for table artikellistetemp
#


#
# Table structure for table benutzer
#

CREATE TABLE `benutzer` (
  `Nr` int(11) NOT NULL auto_increment,
  `Benutzer` varchar(25) default NULL,
  `Passwort` varchar(25) default NULL,
  `Projektneu` smallint(6) default '0',
  `Projektaendern` smallint(6) default '0',
  `Projektloeschen` smallint(6) default '0',
  `Fensterdesign` varchar(25) default NULL,
  `FensterdesignNr` int(6) default '0',
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  UNIQUE KEY `Benutzer` (`Benutzer`)
) TYPE=MyISAM;


#
# Dumping data for table benutzer
#

INSERT INTO `benutzer` VALUES (1,'Standard','KlYf\\Yj\\',1,1,1,'Level 5',5,1);

#
# Table structure for table berechnungsart
#

CREATE TABLE `berechnungsart` (
  `Nr` int(11) NOT NULL auto_increment,
  `BerechnungsArt` varchar(250) default NULL,
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  UNIQUE KEY `BerechnungsArt` (`BerechnungsArt`)
) TYPE=MyISAM;


#
# Dumping data for table berechnungsart
#

INSERT INTO `berechnungsart` VALUES (1,'Menge*Gewicht*EK_Preis',1);
INSERT INTO `berechnungsart` VALUES (3,'Berechneter_EK*Menge',0);
INSERT INTO `berechnungsart` VALUES (2,'Menge*EK_Preis',1);
INSERT INTO `berechnungsart` VALUES (4,'Berechneter_EK/100*Aufschlag+Berechneter_EK',0);
INSERT INTO `berechnungsart` VALUES (5,'Berechneter_EK',0);

#
# Table structure for table einstellungdrucken
#

CREATE TABLE `einstellungdrucken` (
  `Nr` int(11) NOT NULL auto_increment,
  `Modulart` varchar(25) default NULL,
  `Benutzer` varchar(25) default NULL,
  `Beschreibung` varchar(100) default NULL,
  `Feld1` varchar(150) default '',
  `Feld2` varchar(150) default '',
  `Feld3` varchar(150) default '',
  `Feld4` varchar(150) default '',
  `Feld5` varchar(150) default '',
  `Feld6` varchar(150) default '',
  `Feld7` varchar(150) default '',
  `Feld8` varchar(150) default '',
  `Feld9` varchar(150) default '',
  `Feld10` varchar(150) default '',
  `Feld11` varchar(150) default '',
  `Feld12` varchar(150) default '',
  `Feld13` varchar(150) default '',
  `Feld14` varchar(150) default '',
  `Feld15` varchar(150) default '',
  `Feld16` varchar(150) default '',
  `Feld17` varchar(150) default '',
  `Feld18` varchar(150) default '',
  `Feld19` varchar(150) default '',
  `Feld20` varchar(150) default '',
  `Abstand_Links` smallint(6) default '0',
  `Abstand_Oben` smallint(6) default '0',
  `Abstand_Unten` smallint(6) default '0',
  `Abstand_Rechts` smallint(6) default '0',
  `Kopfzeile` varchar(250) default '',
  `Absender` varchar(150) default '',
  `Summenzeile1` varchar(250) default '',
  `Summenzeile2` varchar(250) default '',
  `Summenzeile3` varchar(250) default '',
  `Summenzeile4` varchar(250) default '',
  `FussZeile` varchar(100) default '',
  `MemoFuss` varchar(100) default '',
  `LabelProjekt` varchar(250) default '',
  `Projekt` varchar(100) default '',
  `LabelBezeichnung` varchar(250) default '',
  `Bezeichnung` varchar(100) default '',
  `LabelGruppe` varchar(250) default '',
  `Gruppe` varchar(100) default '',
  `LabelAdresseKurzname` varchar(250) default '',
  `AdresseKurzname` varchar(100) default '',
  `Notiz` varchar(100) default '',
  `Adresse` varchar(100) default '',
  `LabelModulartklein` varchar(250) default '',
  `Modulartklein` varchar(100) default NULL,
  `LabelBearbeiter` varchar(250) default '',
  `Bearbeiter` varchar(100) default '',
  `LabelDatum` varchar(250) default '',
  `Datum` varchar(100) default '',
  `LabelTransaktionsNr` varchar(250) default NULL,
  `TransaktionsNr` varchar(100) default NULL,
  `LabelIhrZeichen` varchar(250) default '',
  `IhrZeichen` varchar(250) default '',
  `Titel` varchar(250) default '',
  `MemoKopf` varchar(100) default '',
  `Rahmen1` varchar(150) default NULL,
  `Rahmen2` varchar(150) default NULL,
  `FormatLogo` varchar(150) default NULL,
  `BmpLogo` mediumblob,
  `PanelLogoEnde` smallint(6) default '0',
  `Text1` varchar(250) default NULL,
  `Text2` varchar(250) default NULL,
  `Text3` varchar(250) default NULL,
  `FDrucker` varchar(20) default NULL,
  `Druckermaske` varchar(250) default NULL,
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Modulart` (`Modulart`),
  KEY `Benutzer` (`Benutzer`)
) TYPE=MyISAM;


#
# Dumping data for table einstellungdrucken
#

INSERT INTO `einstellungdrucken` VALUES (67,'Standard','Standard','Standard','1;Pos_Nr;0;0;29;1;Arial;clBlack;8;0;0;0;0;','1;Artikelgruppe;33;0;152;0;Arial;clBlack;8;0;0;0;0;','1;Artikel;186;0;149;0;Arial;clBlack;8;0;0;0;0;','1;Menge;336;0;45;1;Arial;clBlack;8;0;0;0;0;','1;EinheitMenge;382;0;67;0;Arial;clBlack;8;0;0;0;0;','1;Rabatt;450;0;39;1;Arial;clBlack;8;0;0;0;0;','1;VK_Preis;570;0;90;1;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;464;368;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;528;368;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;592;368;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;16;408;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;80;408;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;144;408;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;208;408;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;272;408;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;336;408;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;400;408;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;464;408;51;0;Arial;clBlack;8;0;0;0;0;','0;Pos_Nr;528;408;51;0;Arial;clBlack;8;0;0;0;0;','1;Pos_Text;33;21;370;0;Arial;clBlack;8;0;0;0;0;',70,20,50,5,'1;Pos   Artikelgruppe                         Artikel                                        Menge Einheit           Rabatt                                        VK_Preis;2;18;660;0;Arial;clWindowText;8;1;0;0;20;','1;Abs.........;2;11;250;0;Arial;clWindowText;8;0;0;0;18;','1;Gesamt: [VK] €;2;313;660;1;Arial;clWindowText;8;0;0;0;20;','1;+ [MwSt] % Mwst [MwStBetrag] €;2;339;660;1;Arial;clWindowText;8;0;0;0;20;','1;Gesamtbetrag = [VKPlusMwSt] €;2;365;660;1;Arial;clWindowText;8;0;0;0;20;','1;;2;391;660;1;Arial;clWindowText;8;0;0;0;20;','1;Seite  - [Page#] -;2;504;660;2;Arial;clWindowText;9;2;0;0;20;','1;Beispieltext;2;439;660;0;Times New Roman;clWindowText;10;0;0;0;40;','0;Projekt:;354;243;100;0;Arial;clNavy;8;1;0;0;18;','0;Beispieltext;457;243;200;0;Times New Roman;clWindowText;8;0;0;0;18;','1;Bezeichnung:;354;43;100;0;Arial;clNavy;8;1;0;0;18;','1;Beispieltext;461;44;200;0;Times New Roman;clWindowText;8;0;0;0;18;','0;Gruppe:;354;292;100;0;Arial;clNavy;8;1;0;0;18;','0;Beispieltext;457;291;200;0;Times New Roman;clWindowText;8;0;0;0;18;','0;Adr.-Kurzname:;354;315;100;0;Arial;clNavy;8;1;0;0;18;','0;Beispieltext;456;315;200;0;Times New Roman;clWindowText;8;0;0;0;18;','0;Notiz;2;357;660;0;Times New Roman;clWindowText;8;2;0;0;20;','1;Beispieltext;2;30;250;0;Arial;clWindowText;10;1;0;0;100;','1;ModulartKlein;354;18;100;0;Arial;clNavy;8;1;0;0;18;','1;Beispieltext;519;18;142;0;Times New Roman;clWindowText;8;0;0;0;18;','1;Bearbeiter:;353;69;100;0;Arial;clNavy;8;1;0;0;18;','1;Beispieltext;461;69;200;0;Times New Roman;clWindowText;8;0;0;0;18;','1;Datum:;352;94;100;0;Arial;clNavy;8;1;0;0;18;','1;Beispieltext;461;95;200;0;Times New Roman;clWindowText;8;0;0;0;18;','0;TransaktionsNr:;353;267;100;0;Arial;clNavy;8;1;0;0;18;','0;Beispieltext;456;267;200;0;Times New Roman;clWindowText;8;0;0;0;18;','1;IhrZeichen;353;119;100;0;Arial;clNavy;8;1;0;0;18;','1;Beispieltext;461;120;200;0;Times New Roman;clWindowText;8;0;0;0;18;','1;#;2;394;660;2;Arial;clWindowText;16;1;0;0;39;','1;Beispieltext;2;447;660;0;Times New Roman;clWindowText;10;0;0;0;40;','1;Rahmen1;348;8;317;2;MS Sans Serif;clWindowText;8;0;0;0;165;','0;Rahmen2;584;200;73;2;MS Sans Serif;clWindowText;8;0;0;0;33;','0;Logo;444;7;220;0;;clWindowText;8;0;0;0;130;',NULL,144,'1;Nr.:;461;18;33;0;Arial;clNavy;8;1;0;0;17;','1;USt-Id Nr.:;353;143;308;0;Arial;clNavy;8;1;0;0;18;','0;Text3;354;216;73;0;Arial;clNavy;8;1;0;0;17;','Preview',NULL,0);

#
# Table structure for table einstellungenallgemein
#

CREATE TABLE `einstellungenallgemein` (
  `Nr` int(11) unsigned NOT NULL auto_increment,
  `MWSt` double default '0',
  `FirmaNr` bigint(20) default '0',
  `Einheitgewicht` varchar(13) default NULL,
  `NameZahl1` varchar(25) default NULL,
  `NameZahl2` varchar(25) default NULL,
  `NameZahl3` varchar(25) default NULL,
  `EinheitZahl1` varchar(13) default NULL,
  `EinheitZahl2` varchar(13) default NULL,
  `EinheitZahl3` varchar(13) default NULL,
  `LandNr` int(6) default '0',
  `Name1` varchar(25) default NULL,
  `Name2` varchar(25) default NULL,
  `Name3` varchar(25) default NULL,
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`)
) TYPE=MyISAM;


#
# Dumping data for table einstellungenallgemein
#

INSERT INTO `einstellungenallgemein` VALUES (1,16,'1','Kg','Zah1','Zahl2','Zahl3','EinheitZahl1','EinheitZahl2','EinheitZahl3',49,'Name1','Name2','Name3',0);

#
# Table structure for table einstellungform1
#

CREATE TABLE `einstellungform1` (
  `Nr` int(6) unsigned NOT NULL auto_increment,
  `Modulart` varchar(25) default NULL,
  `Benutzer` varchar(25) default NULL,
  `FensterNr` smallint(6) default '0',
  `Beschreibung` varchar(100) default NULL,
  `FormularName` varchar(50) default NULL,
  `SQLFrom` varchar(50) default NULL,
  `SQLSelect` varchar(100) default NULL,
  `SQLWhere` varchar(100) default NULL,
  `SQLOrder` varchar(50) default NULL,
  `SQLWhereZusatz` varchar(100) default NULL,
  `Caption` varchar(50) default NULL,
  `NeuAn` smallint(6) default '0',
  `AusgabeAn` smallint(6) default '0',
  `KopierenAn` smallint(6) default '0',
  `AendernAn` smallint(6) default '0',
  `LoeschenAn` smallint(6) default '0',
  `ErsteSpalteBreite` smallint(6) default '0',
  `FensterTop` smallint(6) default '0',
  `FensterLeft` smallint(6) default '0',
  `FensterWidth` smallint(6) default '0',
  `FensterHoehe` smallint(6) default '0',
  `Rückgabespalte1` smallint(6) default '0',
  `Rückgabespalte2` smallint(6) default '0',
  `FelderWennNeu` varchar(50) default NULL,
  `FelderWennNeuValue` varchar(50) default NULL,
  `DBC` smallint(6) default '0',
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Modulart` (`Modulart`),
  KEY `Benutzer` (`Benutzer`),
  KEY `FensterNr` (`FensterNr`)
) TYPE=MyISAM;


#
# Dumping data for table einstellungform1
#

INSERT INTO `einstellungform1` VALUES (2,'Standard','Standard',41,'EinstellungenForm1','EinstellungenForm1','EinstellungForm1','*','Aus','FensterNr',NULL,'EinstellungForm1',1,2,1,1,1,30,26,9,991,540,0,0,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (3,'Standard','Standard',4,'Bearbeiter aussuchen','FormAdresse','Adressen','Nr,Nachname,Vorname,Kategorie,Readonly','Aus','Nachname','Kategorie =\"Mitarbeiter\" and','Bearbeiter aussuchen',1,2,2,1,1,2,30,13,450,510,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (4,'Standard','Standard',5,'Gruppierung aussuchen','FormAdresse','Gruppierung','*','Aus','Gruppierung',NULL,'Gruppierung aussuchen',2,2,2,2,2,2,30,13,450,510,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (5,'Standard','Standard',3,'Modul Projekt','ProjektName','Module','Nr,Projektname,Readonly','Modulart = \"Projekt\"','ProjektName',NULL,'Projekt aussuchen',2,2,2,2,2,2,189,230,332,529,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (6,'Standard','Standard',31,'Stammdaten Einheit','FormMaskeEinheit','Einheit','*','Aus','Einheit',NULL,'Einheit aussuchen',1,2,0,1,1,2,26,9,130,612,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (7,'Standard','Standard',1,'Module Bezeichnung','DammiForm','Module','*','Aus','Bezeichnung',NULL,'Name aussuchen',0,1,0,0,0,2,118,233,354,476,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (8,'Standard','Standard',2,'Module Firma','FormAdresse','Adressen','Nr,Firma,Nachname,Vorname,Kategorie,Readonly','Aus','Firma',NULL,'Firma aussuchen',1,2,1,1,1,2,144,231,388,563,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (14,'Standard','Standard',7,'Module Bezeichnung','DammiForm','Module','*','Aus','Bezeichnung',NULL,'Name aussuchen',2,2,2,2,2,2,30,13,200,510,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (15,'Standard','Standard',11,'Projekt Kunde','FormAdresse','Adressen','Nr,Firma,Nachname,Vorname,Kategorie,Readonly','Aus','Firma','Kategorie = \"Kunde\" and','Kunde aussuchen',1,2,1,1,1,2,78,27,389,651,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (16,'Standard','Standard',12,'Projekt Leiter','FormAdresse','Adressen','Nr,Nachname,Vorname,Kategorie,Readonly','Aus','Nachname','Kategorie = \"Mitarbeiter\" and','Projektleiter aussuchen',1,2,1,1,1,2,52,18,356,416,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (17,'Standard','Standard',13,'Projekt Bearbeiter','FormAdresse','Adressen','Nr,Nachname,Vorname,Kategorie,Readonly','Aus','Nachname','Kategorie = \"Mitarbeiter\" and','Projektbearbeiter aussuchen',1,2,1,1,1,2,52,18,355,425,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (19,'Standard','Standard',21,'Adressen Kategorie','FormKategorie','Kategorie','Nr,Kategorie,Readonly','Aus','Kategorie',NULL,'Kategorie aussuchen',1,2,1,1,1,2,103,238,350,587,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (20,'Standard','Standard',32,'Module Stammdaten Artikel',NULL,'Artikel','*','Aus','Artikelgruppe',NULL,'Artikelliste',1,2,1,1,1,2,45,13,618,487,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (21,'Standard','Standard',33,'Module Stammdaten Artikelgruppe',NULL,'Artikelgruppe','*','Aus','Artikelgruppe',NULL,'Artikelgruppenliste',1,2,1,1,1,2,33,15,556,500,0,1,'Berechnungsart,Kostenart','\"Menge*EK_Preis\",\"M\"',0,1);
INSERT INTO `einstellungform1` VALUES (22,'Standard','Standard',72,'Artikel Einheit',NULL,'Einheit','*','Aus','Einheit',NULL,'Einheit aussuchen',2,2,2,2,2,2,98,535,116,531,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (23,'Standard','Standard',73,'Artikel EinheitGewicht',NULL,'Einheit','*','Aus','Einheit',NULL,'Einheit für Gewicht aussuchen',2,2,2,2,2,2,78,27,198,561,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (24,'Standard','Standard',74,'Artikel Lieferant',NULL,'Adressen','Nr,Firma,Nachname,Vorname,Kategorie,Readonly','Aus','Firma','Kategorie =\"Lieferant\" and','Lieferant aussuchen',1,2,1,1,1,2,150,402,382,501,0,1,'Kategorie','\"Lieferant\"',0,1);
INSERT INTO `einstellungform1` VALUES (26,'Standard','Standard',42,'Module Stammdaten EinstellungModulart',NULL,'EinstellungModulart','*','Aus','Modulart',NULL,'EinstellungModulart',1,2,1,1,1,2,26,9,792,630,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (28,'Standard','Standard',71,'Artikel Artikelgruppe',NULL,'Artikelgruppe','*','Aus','Artikelgruppe',NULL,'Artikelgruppe aussuchen',1,2,1,1,1,2,0,0,444,481,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (29,'Standard','Standard',61,'Artikelgruppe BerechnungsArt',NULL,'Berechnungsart','*','Aus','Berechnungsart',NULL,'Berechnungsart aussuchen',2,2,2,2,2,2,78,27,350,328,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (30,'Standard','Standard',37,'Stammdaten Adressen',NULL,'Adressen','Nr,Firma,Nachname,Vorname,Readonly','Aus','Firma',NULL,'Stammdaten Adressen',1,2,1,1,1,2,27,10,572,464,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (31,'Standard','Standard',34,'Stammdaten Module',NULL,'Module','*','Aus','Nr',NULL,'Modul-Liste',0,2,0,0,0,0,26,9,721,587,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (32,'Standard','Standard',100,'Artikelsammlung',NULL,'Module','*','Aus','Bezeichnung','Modulart =\"Projekt\" and','Projekt aussuchen',1,2,1,1,1,2,26,9,334,699,0,1,'Modulart','\"Projekt\"',0,1);
INSERT INTO `einstellungform1` VALUES (33,'Standard','Standard',101,'ArtikelSammlung Adresse',NULL,'Adressen','Nr,Firma,Nachname,Vorname,Kategorie,Readonly','Aus','Firma','Kategorie =\"Kunde\" and','Kunde aussuchen',1,2,1,1,1,NULL,0,0,442,630,0,1,'Kategorie','\"Kunde\"',0,1);
INSERT INTO `einstellungform1` VALUES (34,'Standard','Standard',102,'Artikelsammlung Gruppierung',NULL,'Gruppierung','*','Aus','Gruppierung',NULL,'Gruppierung aussuchen',2,2,2,2,2,2,52,18,352,611,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (35,'Standard','Standard',103,'Artikelsammlung Bearbeiter',NULL,'Adressen','Nr,Nachname,Vorname,Kategorie,Readonly','Aus','Nachname','Kategorie =\"Mitarbeiter\" and','Bearbeiter aussuchen',2,2,2,2,2,2,164,692,307,511,0,1,'Kategorie','\"Mitarbeiter\"',0,1);
INSERT INTO `einstellungform1` VALUES (36,'Standard','Standard',35,'Stammdaten Projekte',NULL,'Module','*','Modulart=\"Projekt\"','Nr',NULL,'Stammdaten Projekte',0,2,0,0,1,2,26,9,991,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (37,'Standard','Standard',81,'Stammdaten Textbausteine',NULL,'Textbaustein','*','Aus','Modulart',NULL,'Textbausteine',0,2,0,0,0,2,52,18,442,630,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (38,'Standard','Standard',121,'Textbausteine Modulart',NULL,'EinstellungModulart','Nr,Modulart,Readonly','Aus','Modulart',NULL,'Modulart aussuchen',2,2,2,2,2,2,82,26,442,630,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (39,'Standard','Standard',122,'Textbaustein Benutzer',NULL,'Benutzer','Nr,Benutzer,Readonly','Aus','Benutzer',NULL,'Benutzer aussuchen',2,2,2,2,2,2,78,27,442,630,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (41,'Standard','Standard',104,'Artikelsammlung Memo Kopf',NULL,'Textbaustein','Nr,Beschreibung,Modulart,Benutzer,Textart,Readonly','Aus','Beschreibung','Textart =\"Kopftext\" and','Textblock für den Kopftext aussuchen',1,2,1,1,1,2,56,191,389,577,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (42,'Standard','Standard',105,'Artikelsammlung Memo Fuss',NULL,'Textbaustein','Nr,Beschreibung,Modulart,Benutzer,Textart,Readonly','Aus','Beschreibung','Textart =\"Fusstext\" and','Textblock für den Fusstext aussuchen',1,2,1,1,1,2,0,0,409,410,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (43,'Standard','Standard',82,'Stammdaten Benutzer',NULL,'Benutzer','Nr,Benutzer,Passwort,Readonly','Aus','Benutzer',NULL,'Stammdaten Benutzer',1,2,0,1,1,2,124,209,185,364,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (44,'Standard','Standard',106,'Artikelsammlung Artikelgruppe',NULL,'Artikelgruppe','*','Aus','Artikelgruppe',NULL,'Artikelgruppe aussuchen',2,2,2,2,2,2,52,18,442,630,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (45,'Standard','Standard',107,'Artikelsammlung Artikel',NULL,'Artikel','*','Aus','Artikel',NULL,'Artikel aussuchen',2,2,2,2,2,2,52,18,1004,589,0,2,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (46,'Standard','Standard',108,'Artikelsammlung Einheit Menge',NULL,'Einheit','*','Aus','Einheit',NULL,'Einheit aussuchen',2,2,2,2,2,2,52,18,442,630,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (47,'Standard','Standard',109,'Artikelsammlung Einheit EK',NULL,'Einheit','*','Aus','Einheit',NULL,'Einheit aussuchen',2,2,2,2,2,2,52,18,442,630,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (48,'Standard','Standard',62,'Artikelgruppe Einheit Menge  für vorgabe',NULL,'Einheit','*','Aus','Einheit',NULL,'Einheit aussuchen',2,2,2,2,2,2,101,36,442,500,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (49,'Standard','Standard',75,'Artikel Einheit Menge',NULL,'Einheit','*','Aus','Einheit',NULL,'Einheit für die Menge Aussuchen',2,2,2,2,2,2,0,0,149,527,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (50,'Standard','Standard',83,'Stammdaten Stücklisten',NULL,'StueckListe','*','Aus','Artikelgruppe',NULL,'Stücklisten',1,2,1,1,1,2,45,14,496,400,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (51,'Standard','Standard',84,'Stammdaten Stücklistengruppe',NULL,'Stuecklistengruppe','*','Aus','Stuecklistengruppe',NULL,'Stücklistengruppen',1,2,1,1,1,2,26,9,307,519,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (52,'Standard','Standard',131,'Stammdaten Stuckliste Stuecklistengruppe aussuchen',NULL,'Stuecklistengruppe','*','Aus','Stuecklistengruppe',NULL,'Stücklistengruppe aussuchen',2,2,2,2,2,2,99,38,226,417,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (53,'Standard','Standard',132,'Stammdaten Stückliste >Bearbeiter',NULL,'Adressen','Nr,Nachname,Vorname,Kategorie,Readonly','Aus','Nachname','Kategorie =\"Mitarbeiter\" or  Kategorie =\"Teilnehmer\" and','Bearbeiter aussuchen',2,2,2,2,2,2,100,664,326,512,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (54,'Standard','Standard',36,'Stammdaten Kunden',NULL,'Adressen','*','Kategorie=\"Kunde\"','Nr',NULL,'Stammdaten Kunden',1,2,1,1,1,2,26,9,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (55,'Standard','Standard',85,'Stammdaten Stücklistenartikel',NULL,'Stuecklistenartikel','*','Aus','Nr',NULL,'Stücklistenartikel',0,2,0,0,0,2,26,9,541,490,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (56,'Standard','Standard',133,'Stückliste EinheitMenge Kopfbereich',NULL,'Einheit','*','Aus','Einheit',NULL,'Einheit aussuchen',1,2,1,1,1,2,99,460,150,530,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (57,'Standard','Standard',134,'Stückliste Artikel',NULL,'Artikel','*','Aus','Artikel',NULL,'Artikel aussuchen',2,2,2,2,2,2,78,27,362,584,0,2,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (58,'Standard','Standard',136,'Stückliste Einheit_EK',NULL,'Einheit','*','Aus','Einheit',NULL,'Einheit aussuchen',1,2,1,1,1,2,0,0,127,582,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (59,'Standard','Standard',135,'Stückliste EinheitMenge',NULL,'Einheit','*','Aus','Einheit',NULL,'Einheit aussuchen',1,2,1,1,1,2,78,27,194,436,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (60,'Standard','Standard',63,'Artikelgruppe Einheit EKPreis für Vorgabe',NULL,'Einheit','*','Aus','Einheit',NULL,'Einheit aussuchen',2,2,2,2,2,2,78,27,201,521,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (62,'Standard','Standard',137,'Stückliste Artikelgruppe',NULL,'Artikelgruppe','*','Aus','Artikelgruppe',NULL,'Artikelgruppe aussuchen',2,2,2,2,2,2,56,30,442,437,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (63,'Standard','Standard',39,'Stammdaten Mitarbeiter',NULL,'Adressen','*','Kategorie = \"Mitarbeiter\"','Nr',NULL,'Stammdaten Mitarbeiter',1,2,1,1,1,2,26,9,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (64,'Standard','Standard',38,'Stammdaten Lieferant',NULL,'Adressen','*','Kategorie = \"Lieferant\"','Nr',NULL,'Stammdaten Lieferant',1,2,1,1,1,2,26,9,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (67,'Standard','Standard',40,'Stammdaten Adressen-Kategorie',NULL,'Kategorie','*','Aus','Nr',NULL,'Stammdaten Adressen-Kategorie',1,2,1,1,1,2,26,9,206,477,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (68,'Standard','Standard',86,'Artikel aus den Bewegungsdaten',NULL,'ArtikelListe','*','Aus','Nr',NULL,'Artikel aus den Bewegungsdaten',0,2,0,0,0,2,26,9,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (76,'Standard','Standard',64,'Stammdaten Lieferant',NULL,'Adressen','Nr,Firma,Nachname,Vorname,Readonly','Kategorie = \"Lieferant\"','Nr',NULL,'Stammdaten Lieferant',2,2,2,2,2,2,0,0,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (78,'Standard','Standard',43,'Einstellungsliste für die Druckermasken',NULL,'EinstellungDrucken','*','Aus','Nr',NULL,'Druckermasken-Liste',1,0,1,1,1,2,0,0,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (79,'Standard','Standard',181,'Einstellung Module Druckermaske',NULL,'EinstellungDrucken','Nr,Beschreibung,Modulart,Benutzer,Readonly','Aus','Nr',NULL,'Druckermaske aussuchen:',1,0,1,1,1,2,0,0,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (83,'Bestellung','Standard',101,'Artikelsammlung Adressen',NULL,'Adressen','Nr,Firma,Nachname,Vorname,Kategorie,Readonly','Aus','Firma','Kategorie =\"Lieferant\" and','Lieferant aussuchen',1,0,1,1,1,2,0,0,691,540,0,1,'Kategorie','\"Lieferant\"',0,1);
INSERT INTO `einstellungform1` VALUES (81,'Standard','Standard',44,'Einstellungen Benutzer',NULL,'Benutzer','*','Aus','Nr',NULL,'Einstellungen Benutzer',0,0,0,1,0,2,0,0,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (82,'Standard','Standard',182,'Berechnungsart',NULL,'BerechnungsArt','*','Aus','Nr',NULL,'Berechnungsart',1,0,1,1,1,2,78,27,358,500,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (84,'Standard','Standard',88,'Übersicht der Nummernvergabe',NULL,'Nummer','*','Aus','Nr',NULL,'Übersicht der Nummernvergabe',0,0,0,0,0,2,0,0,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (85,'Standard','Standard',87,'Artkel der Stücklisten in Module',NULL,'ArtikelListeS','*','Aus','Nr',NULL,'Artkel der Stücklisten in Module',0,0,0,0,1,2,0,0,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (93,'Standard','Standard',213,'Lagerbestand >0',NULL,'Artikel','Nr,artikelgruppe,Artikel,Bestand,Min_Bestand','Artikelgruppe = \"Flacheisen\"','artikelgruppe','Bestand < Min_Bestand and','Flacheisen Bestand < Min_Bestand',1,0,1,1,1,2,0,0,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (86,'Standard','Standard',89,'stammdaten Gruppierung',NULL,'Gruppierung','*','Aus','Nr',NULL,'Stammdaten Gruppierung',1,0,1,1,1,2,26,9,329,626,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (87,'Standard','Standard',90,'Listen-Wartung  Artkellistetemp',NULL,'Artikellistetemp','*','Aus','Nr',NULL,'Artikellistetemp',0,0,0,0,1,2,52,18,442,630,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (88,'Standard','Standard',191,'EK Preis ändern',NULL,'Artikel','*','Aus','Nr',NULL,'EK Preis ändern',1,0,1,1,1,2,26,9,508,710,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (89,'Standard','Standard',192,'Aufschlag ändern',NULL,'Artikel','*','Aus','Nr',NULL,'Aufschlag ändern',1,0,1,1,1,2,0,0,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (90,'Standard','Standard',211,'Adressen mit der Kategorie',NULL,'Adressen','Nr,Firma,Nachname,Tel_Firma,Tel_Privat','Kategorie = \"Kunde\"','Nr',NULL,'Telefonnummern von Kunden',1,0,0,0,0,2,26,9,966,623,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (91,'Standard','Standard',212,'Telefonnummern von Lieferanden',NULL,'Adressen','Nr,Firma,Nachname,Tel_Firma,Tel_Privat','Kategorie = \"Lieferant\"','Nr',NULL,'Telefonnummern von Lieferanten',0,0,0,0,0,2,26,9,966,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (92,'Standard','Standard',208,'mit F6 die sortierte Spalte ändern',NULL,'Artikel','*','Aus','Nr',NULL,'mit F6 die sortierte Spalte ändern',1,0,1,1,1,2,0,0,691,540,0,1,NULL,NULL,0,1);
INSERT INTO `einstellungform1` VALUES (100,'Standard','Standard',46,'Fensterdesign verwalten',NULL,'Fensterdesign','*','Aus','Nr',NULL,'Fensterdesign verwalten',1,0,1,1,1,2,0,0,691,540,0,1,NULL,NULL,1,0);
INSERT INTO `einstellungform1` VALUES (97,'Standard','Standard',231,'Fenstereinstellung des Benutzers aussuchen',NULL,'Fensterdesign','*','Aus','Name',NULL,'Fenstereinstellung des Benutzers aussuchen',1,0,1,1,1,2,266,302,204,403,0,1,NULL,NULL,0,0);

#
# Table structure for table einstellungmodulart
#

CREATE TABLE `einstellungmodulart` (
  `Nr` int(11) NOT NULL auto_increment,
  `Modulart` varchar(25) default NULL,
  `Benutzer` varchar(25) default NULL,
  `Beschreibung` varchar(100) default NULL,
  `FensterTop` smallint(6) default '0',
  `FensterHoehe` smallint(6) default '0',
  `FensterLeft` smallint(6) default '0',
  `FensterWidth` smallint(6) default '0',
  `FelderWennNeu` varchar(250) default NULL,
  `FelderWennNeuValue` varchar(250) default NULL,
  `FensterInternAn` smallint(6) default '0',
  `FensterKopfAn` smallint(6) default '0',
  `FensterSummeAn` smallint(6) default '0',
  `FensterFussAn` smallint(6) default '0',
  `FensterButtonAn` smallint(6) default '0',
  `FensterBreiteBewegenAn` smallint(6) default '0',
  `FensterHoeheMin` smallint(6) default '0',
  `FensterBreiteMin` smallint(6) default '0',
  `FensterBreiteMax` smallint(6) default '0',
  `DatensatzNeu` smallint(6) default '0',
  `DatensatzAusgabe` smallint(6) default '0',
  `Datensatzsuchen` smallint(6) default '0',
  `DatensatzKopieren` smallint(6) default '0',
  `DatensatzAendern` smallint(6) default '0',
  `Datensatzloeschen` smallint(6) default '0',
  `DatensatzSpeichern` smallint(6) default '0',
  `PosTextZeilen` smallint(6) default '0',
  `InternProjekt` smallint(6) default '0',
  `InternAdresse` smallint(6) default '0',
  `InternBezeichnung` smallint(6) default '0',
  `InternGruppierung` smallint(6) default '0',
  `InternNotiz` smallint(6) default '0',
  `KopfAdressfeld` smallint(6) default '0',
  `KopfModulNr` smallint(6) default '0',
  `KopfDatum` smallint(6) default '0',
  `KopfBearbeiter` smallint(6) default '0',
  `KopfTranzaktionsNr` smallint(6) default '0',
  `KopfIhrZeichenText` varchar(25) default '',
  `KopfIhrZeichen` smallint(6) default '0',
  `Kopftext` smallint(6) default '0',
  `Fusstext` smallint(6) default '0',
  `InternEn` smallint(6) default '0',
  `KopfEn` smallint(6) default '0',
  `SummeEn` smallint(6) default '0',
  `FussEn` smallint(6) default '0',
  `ArtikelueberschriftEn` smallint(6) default '0',
  `Artikelueberschrift` varchar(250) default '',
  `KopfModultext` smallint(6) default '0',
  `Beziehungs_Nr` int(11) default '0',
  `Beziehungs_Name` varchar(25) default '',
  `HauptModulNr` int(11) default '0',
  `HauptModulName` varchar(25) default NULL,
  `AAWidth` smallint(6) default '0',
  `AADBGridGruppeLeft` smallint(6) default '0',
  `AAGruppeSpaltenbreite1` smallint(6) default '0',
  `AAGruppeSpaltenbreite2` smallint(6) default '0',
  `AAArtikelSpaltenbreite1` smallint(6) default '0',
  `AAArtikelSpaltenbreite2` smallint(6) default '0',
  `AARahmenbeite` smallint(6) default '0',
  `AADBGridGruppeBreite` smallint(6) default '0',
  `AAButtonNr` smallint(6) default '0',
  `AACaption1` varchar(150) default '',
  `AACaption2` varchar(150) default '',
  `AACaption3` varchar(150) default '',
  `AACaption4` varchar(150) default '',
  `AACaption5` varchar(150) default '',
  `AACaption6` varchar(150) default '',
  `AACaption7` varchar(150) default '',
  `AACaption8` varchar(150) default '',
  `AAEnaF2` smallint(6) default '0',
  `AAEnaF3` smallint(6) default '0',
  `AAEnaF4` smallint(6) default '0',
  `AAEnaF5` smallint(6) default '0',
  `AAEnaF6` smallint(6) default '0',
  `AAEnaF7` smallint(6) default '0',
  `AAEnaF8` smallint(6) default '0',
  `AAEnaF9` smallint(6) default '0',
  `AAEnaButton1` smallint(6) default '0',
  `AAEnaButton2` smallint(6) default '0',
  `AAEnaButton3` smallint(6) default '0',
  `AAEnaButton4` smallint(6) default '0',
  `AAEnaButton5` smallint(6) default '0',
  `AAEnaButton6` smallint(6) default '0',
  `AAEnaButton7` smallint(6) default '0',
  `AAEnaButton8` smallint(6) default '0',
  `AASQLFilterArtikel1` varchar(250) default '',
  `AASQLFilterArtikel2` varchar(250) default '',
  `AASQLFilterArtikel3` varchar(250) default '',
  `AASQLFilterArtikel4` varchar(250) default '',
  `AASQLFilterArtikel5` varchar(250) default '',
  `AASQLFilterArtikel6` varchar(250) default '',
  `AASQLFilterArtikel7` varchar(250) default '',
  `AASQLFilterArtikel8` varchar(250) default '',
  `AASQLFilterGruppe1` varchar(250) default '',
  `AASQLFilterGruppe2` varchar(250) default '',
  `AASQLFilterGruppe3` varchar(250) default '',
  `AASQLFilterGruppe4` varchar(250) default '',
  `AASQLFilterGruppe5` varchar(250) default '',
  `AASQLFilterGruppe6` varchar(250) default '',
  `AASQLFilterGruppe7` varchar(250) default '',
  `AASQLFilterGruppe8` varchar(250) default '',
  `AAMarkiernZeigenAn` smallint(6) default '0',
  `AAErledigtArtikelAn` smallint(6) default '0',
  `AAErledigtArtikelAusSchal` smallint(6) default '0',
  `ErledigtNr` smallint(6) default '0',
  `FarbenwechselFarbe1` varchar(50) default NULL,
  `FarbenwechselFarbe2` varchar(50) default NULL,
  `Farbenwechsel` smallint(6) default '0',
  `FarbenwechselFarbeSelect` varchar(50) default NULL,
  `monitormaske1` varchar(250) default NULL,
  `monitormaske2` varchar(250) default NULL,
  `monitormaske3` varchar(250) default NULL,
  `monitormaske4` varchar(250) default NULL,
  `monitormaske5` varchar(250) default NULL,
  `monitormaske6` varchar(250) default NULL,
  `monitormaske7` varchar(250) default NULL,
  `monitormaske8` varchar(250) default NULL,
  `monitormaske9` varchar(250) default NULL,
  `monitormaske10` varchar(250) default NULL,
  `monitormaske11` varchar(250) default NULL,
  `monitormaske12` varchar(250) default NULL,
  `monitormaske13` varchar(250) default NULL,
  `monitormaske14` varchar(250) default NULL,
  `monitormaske15` varchar(250) default NULL,
  `monitormaske16` varchar(250) default NULL,
  `monitormaske17` varchar(250) default NULL,
  `monitormaske18` varchar(250) default NULL,
  `monitormaske19` varchar(250) default NULL,
  `monitormaske20` varchar(250) default NULL,
  `AATop` smallint(6) default '0',
  `AALeft` smallint(6) default '0',
  `Lagerverwaltung` tinyint(1) default '0',
  `druckermaske1` varchar(25) default NULL,
  `druckermaske2` varchar(25) default NULL,
  `druckermaske3` varchar(25) default NULL,
  `druckermaske4` varchar(25) default NULL,
  `druckermaske5` varchar(25) default NULL,
  `druckermaske6` varchar(25) default NULL,
  `druckermaskeNr1` varchar(10) default NULL,
  `druckermaskeNr2` varchar(10) default NULL,
  `druckermaskeNr3` varchar(10) default NULL,
  `druckermaskeNr4` varchar(10) default NULL,
  `druckermaskeNr5` varchar(10) default NULL,
  `druckermaskeNr6` varchar(10) default NULL,
  `Modulloeschen` smallint(6) default '0',
  `Modulkopieren` smallint(6) default '0',
  `Modulaendern` smallint(6) default '0',
  `Modulneu` smallint(6) default '0',
  `ReadOnly` smallint(6) default '0',
  `MwSt` double default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Modulart` (`Modulart`),
  KEY `Benutzer` (`Benutzer`)
) TYPE=MyISAM;


#
# Dumping data for table einstellungmodulart
#

INSERT INTO `einstellungmodulart` VALUES (22,'Angebot','Standard','Angebot',50,660,50,793,NULL,NULL,0,0,0,0,1,1,360,515,793,1,1,1,1,1,1,1,3,1,1,1,0,1,1,1,1,1,0,'Ihr Zeichen:',1,1,1,1,1,1,1,1,'Pos Artikelgruppe                   Artikel                              Menge Einheit            EK_Preis/Pro             Aufs.% Rabatt%     VK_Preis',1,0,'',0,NULL,540,130,2,0,2,2,2,187,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,0,1,1,1,1,1,1,1,0,1,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,0,'$00DEDFDE','$00EFEFEF',1,'$0084F5FF','1;Pos_Nr;3;3;29;1;MS Sans Serif;clNavy;8;0;0;0;0;;','1;Artikelgruppe;33;3;152;0;MS Sans Serif;clNavy;8;0;0;0;1;;','1;Artikel;186;3;149;0;MS Sans Serif;clNavy;8;0;0;0;2;;','1;Menge;336;0;45;1;MS Sans Serif;clNavy;8;0;1;1;3;;','1;EinheitMenge;382;3;67;0;MS Sans Serif;clNavy;8;0;0;0;4;;','1;EK_Preis;450;0;74;1;MS Sans Serif;clNavy;8;0;1;1;5;;','1;Einheit_EK;525;3;67;0;MS Sans Serif;clNavy;8;0;0;0;6;Berechneter_EK;','1;Aufschlag;593;0;39;1;MS Sans Serif;clNavy;8;0;1;1;7;;','1;Rabatt;636;0;39;1;MS Sans Serif;clNavy;8;0;1;1;8;Berechneter_EK;','1;VK_Preis;683;1;81;1;MS Sans Serif;clNavy;8;0;0;0;9;;','1;Pos_Text;33;23;370;0;Verdana;clWindowText;8;2;0;1;10;;','1;Berechnen1;447;27;74;1;MS Sans Serif;clNavy;8;0;0;0;11;Berechneter_EK;','0;DBEditPos_Nr;144;408;57;0;MS Sans Serif;clNavy;8;0;0;0;10;;','0;DBEditPos_Nr;208;408;57;0;MS Sans Serif;clNavy;8;0;0;0;13;;','0;DBEditPos_Nr;272;408;57;0;MS Sans Serif;clNavy;8;0;0;0;14;;','0;DBEditPos_Nr;336;408;57;0;MS Sans Serif;clNavy;8;0;0;0;15;;','0;DBEditPos_Nr;400;408;57;0;MS Sans Serif;clNavy;8;0;0;0;16;;','0;DBEditPos_Nr;464;408;57;0;MS Sans Serif;clNavy;8;0;0;0;17;;','0;DBEditPos_Nr;528;408;57;0;MS Sans Serif;clNavy;8;0;0;0;18;;','0;DBEditPos_Nr;592;408;57;0;MS Sans Serif;clNavy;8;0;0;0;19;;',0,0,0,'Standard Maske Standard',NULL,NULL,NULL,NULL,NULL,'69',NULL,NULL,NULL,NULL,NULL,1,1,1,1,0,0);

#
# Table structure for table fensterdesign
#

CREATE TABLE `fensterdesign` (
  `Nr` int(11) NOT NULL auto_increment,
  `Name` varchar(25) default NULL,
  `ButtonDateiNichtActive` varchar(50) default NULL,
  `ButtonDateiActive` varchar(50) default NULL,
  `ButtonFarbeNichtActive` varchar(25) default NULL,
  `ButtonFarbeActive` varchar(25) default NULL,
  `ButtonFeldActive` smallint(6) default '0',
  `ButtonFeldNichtActive` smallint(6) default '0',
  `ButtonFontColorActive` varchar(25) default NULL,
  `ButtonFontColorNichtActive` varchar(25) default NULL,
  `Cascad` smallint(6) default '0',
  `Animationsgeschwindigkeit` smallint(6) default '0',
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`)
) TYPE=MyISAM;


#
# Dumping data for table fensterdesign
#

INSERT INTO `fensterdesign` VALUES (3,'MAV','','C:\\Planlos\\MAV.BMP','$00DDFFFF','$00A8E8FF',1,2,'$004080FF','$00B0F0FF',1,240,0);
INSERT INTO `fensterdesign` VALUES (2,'Standard','','C:\\Planlos\\Madagaskar.bmp','$00F2E3B7','$00808040',2,2,'$00AEC8E0','$00F7EFD6',1,60,1);
INSERT INTO `fensterdesign` VALUES (4,'Feininger','','C:\\Planlos\\Feininger1.bmp','$00E8FFF4','$008BF6FE',1,2,'clTeal','clWhite',1,24,0);
INSERT INTO `fensterdesign` VALUES (5,'Level 5','','C:\\Planlos\\Tastaturblau1.bmp','$00848200','$00848200',1,2,'$00D6FEFC','$00848200',1,30,0);
INSERT INTO `fensterdesign` VALUES (7,'Madargaskar','','C:\\Planlos\\Madagaskar.bmp','$00F6ECCD','$00F7EDD1',1,2,'$00AEC8E0','$00F7EFD6',1,6,0);

#
# Table structure for table gruppierung
#

CREATE TABLE `gruppierung` (
  `Nr` int(11) NOT NULL auto_increment,
  `Gruppierung` varchar(50) default NULL,
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Gruppierung` (`Gruppierung`)
) TYPE=MyISAM;


#
# Dumping data for table gruppierung
#


#
# Table structure for table kategorie
#

CREATE TABLE `kategorie` (
  `Nr` int(11) NOT NULL auto_increment,
  `Kategorie` varchar(25) default NULL,
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  UNIQUE KEY `Kategorie` (`Kategorie`)
) TYPE=MyISAM;


#
# Dumping data for table kategorie
#

INSERT INTO `kategorie` VALUES (2,'Mitarbeiter',1);
INSERT INTO `kategorie` VALUES (1,'Kunde',1);
INSERT INTO `kategorie` VALUES (3,'Privat',0);
INSERT INTO `kategorie` VALUES (4,'Lieferant',1);

#
# Table structure for table stueckliste
#

CREATE TABLE `stueckliste` (
  `Nr` int(11) NOT NULL auto_increment,
  `Artikelgruppe` varchar(25) default NULL,
  `Artikel` varchar(25) default NULL,
  `Bearbeiter` varchar(25) default NULL,
  `EK_Preis` decimal(10,2) default NULL,
  `EinheitMenge` varchar(13) default NULL,
  `Aufschlag` double default '0',
  `Rabatt` double default '0',
  `VK_Preis` double default '0',
  `Materialleistung` double default '0',
  `MatAufschlag` double default '0',
  `Dienstleistung` double default '0',
  `DieAufschlag` double default '0',
  `Fremdleistung` double default '0',
  `FreAufschlag` double default '0',
  `Sonstigeleistung` double default '0',
  `SonAufschlag` double default '0',
  `Gewicht` double default '0',
  `Zahl1` double default '0',
  `Zahl2` double default '0',
  `Zahl3` double default '0',
  `Pos_Text` text,
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Bearbeiter` (`Bearbeiter`)
) TYPE=MyISAM;


#
# Dumping data for table stueckliste
#


#
# Table structure for table stuecklistenartikel
#

CREATE TABLE `stuecklistenartikel` (
  `Nr` int(11) NOT NULL auto_increment,
  `Pos` smallint(6) default '0',
  `Artikelgruppe` varchar(25) default NULL,
  `Artikel` varchar(25) default NULL,
  `Menge` double default '0',
  `EinheitMenge` varchar(13) default NULL,
  `EK_Preis` double default NULL,
  `Einheit_EK` varchar(13) default NULL,
  `Aufschlag` double default NULL,
  `VK_Preis` double default NULL,
  `Artikel_Nr` int(11) default '0',
  `Gewicht` double default '0',
  `Zahl1` double default '0',
  `Zahl2` double default '0',
  `Zahl3` double default '0',
  `Name1` varchar(25) default NULL,
  `Name2` varchar(25) default NULL,
  `Name3` varchar(100) default NULL,
  `Lieferant` varchar(50) default NULL,
  `LieferantArtikelNr` varchar(25) default NULL,
  `BerechnungsArt` varchar(50) default NULL,
  `Stuecklisten_Nr` int(11) default '0',
  `Kostenart` char(1) default NULL,
  `Pos_Text` text,
  `Geaendert` smallint(6) default '0',
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Pos` (`Pos`),
  KEY `StueckListen_Nr` (`Stuecklisten_Nr`)
) TYPE=MyISAM;


#
# Dumping data for table stuecklistenartikel
#


#
# Table structure for table stuecklistengruppe
#

CREATE TABLE `stuecklistengruppe` (
  `Nr` int(11) NOT NULL auto_increment,
  `StuecklistenGruppe` varchar(25) default NULL,
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  UNIQUE KEY `StuecklistenGruppe` (`StuecklistenGruppe`)
) TYPE=MyISAM;


#
# Dumping data for table stuecklistengruppe
#


#
# Table structure for table textbaustein
#

CREATE TABLE `textbaustein` (
  `Nr` int(11) NOT NULL auto_increment,
  `Modulart` varchar(25) default NULL,
  `Benutzer` varchar(25) default NULL,
  `Textart` varchar(10) default NULL,
  `Beschreibung` varchar(60) default NULL,
  `Textbaustein` text,
  `ReadOnly` smallint(6) default '0',
  PRIMARY KEY  (`Nr`),
  KEY `Modulart` (`Modulart`),
  KEY `Nr` (`Nr`),
  KEY `Textart` (`Textart`)
) TYPE=MyISAM;


#
# Dumping data for table textbaustein
#


