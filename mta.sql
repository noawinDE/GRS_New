-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 16, 2018 at 06:09 PM
-- Server version: 10.1.33-MariaDB
-- PHP Version: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mta`
--

-- --------------------------------------------------------

--
-- Table structure for table `achievementlist`
--

CREATE TABLE `achievementlist` (
  `ID` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `gainXP` int(11) NOT NULL,
  `gainMoney` int(11) NOT NULL,
  `socialStateID` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `achievements`
--

CREATE TABLE `achievements` (
  `ID` int(11) NOT NULL,
  `UID` int(11) NOT NULL,
  `achievmentID` int(11) NOT NULL,
  `data` varchar(111) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `achievments`
--

CREATE TABLE `achievments` (
  `UID` int(4) NOT NULL,
  `SchlaflosInSA` varchar(50) NOT NULL DEFAULT '0',
  `Waffenschieber` varchar(50) NOT NULL DEFAULT '0',
  `Angler` varchar(50) NOT NULL DEFAULT '0',
  `Lizensen` varchar(50) NOT NULL DEFAULT '0',
  `Fahrzeugwahn` varchar(50) NOT NULL DEFAULT '0',
  `EigeneFuesse` varchar(50) NOT NULL DEFAULT '0',
  `KingOfTheHill` varchar(50) NOT NULL DEFAULT '0',
  `ReallifeWTF` varchar(50) NOT NULL DEFAULT '0',
  `DerSammler` varchar(50) NOT NULL DEFAULT '0',
  `TheTruthIsOutThere` varchar(50) NOT NULL DEFAULT '0',
  `SilentAssasin` varchar(50) NOT NULL DEFAULT '0',
  `HighwayToHell` varchar(50) NOT NULL DEFAULT '0',
  `LookoutsA` varchar(20) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|',
  `Hufeisen` varchar(50) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|',
  `Revolverheld` int(1) NOT NULL DEFAULT '0',
  `ChickenDinner` int(1) NOT NULL DEFAULT '0',
  `NichtGehtMehr` int(1) NOT NULL DEFAULT '0',
  `highscore` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `advertisedplayers`
--

CREATE TABLE `advertisedplayers` (
  `werberUID` int(255) NOT NULL,
  `geworbenerUID` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ban`
--

CREATE TABLE `ban` (
  `ID` int(11) NOT NULL,
  `UID` int(4) NOT NULL,
  `AdminUID` int(4) NOT NULL,
  `Grund` varchar(50) NOT NULL,
  `Datum` varchar(50) NOT NULL,
  `IP` varchar(50) NOT NULL DEFAULT '0',
  `Serial` varchar(50) NOT NULL,
  `Eintragsdatum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `STime` int(11) NOT NULL DEFAULT '0',
  `Entbannt` int(255) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `biz`
--

CREATE TABLE `biz` (
  `ID` int(2) NOT NULL,
  `Biz` varchar(50) NOT NULL,
  `UID` int(4) NOT NULL,
  `Kasse` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Preis` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `blacklist`
--

CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL,
  `UID` int(4) NOT NULL,
  `EintraegerUID` int(4) NOT NULL,
  `Fraktion` int(2) NOT NULL,
  `Grund` text NOT NULL,
  `Eintragungsdatum` int(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `blocks`
--

CREATE TABLE `blocks` (
  `UID` int(4) NOT NULL,
  `Punkte` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bonustable`
--

CREATE TABLE `bonustable` (
  `UID` int(4) NOT NULL,
  `Lungenvolumen` varchar(50) NOT NULL,
  `Muskeln` varchar(50) NOT NULL,
  `Kondition` varchar(50) NOT NULL,
  `Boxen` varchar(50) NOT NULL,
  `KungFu` varchar(50) NOT NULL,
  `Streetfighting` varchar(50) NOT NULL,
  `CurStyle` varchar(50) NOT NULL,
  `PistolenSkill` varchar(50) NOT NULL,
  `DeagleSkill` varchar(50) NOT NULL,
  `ShotgunSkill` varchar(50) NOT NULL,
  `AssaultSkill` varchar(50) NOT NULL,
  `Vortex` varchar(50) NOT NULL DEFAULT 'none',
  `MP5Skills` varchar(50) NOT NULL DEFAULT 'none',
  `Quad` varchar(50) NOT NULL DEFAULT 'none',
  `CarslotUpgrades` varchar(50) NOT NULL DEFAULT 'none',
  `PremiumUntilDay` int(50) NOT NULL DEFAULT '0',
  `PremiumUntilYear` varchar(50) NOT NULL DEFAULT '0',
  `BonusSkin1` varchar(50) NOT NULL DEFAULT 'none',
  `CarslotUpdate2` int(11) NOT NULL DEFAULT '0',
  `CarslotUpdate3` int(11) NOT NULL DEFAULT '0',
  `CarslotUpdate4` int(11) NOT NULL DEFAULT '0',
  `CarslotUpdate5` int(11) NOT NULL DEFAULT '0',
  `Skimmer` int(1) NOT NULL DEFAULT '0',
  `Leichenwagen` int(1) NOT NULL DEFAULT '0',
  `Schach` varchar(1) NOT NULL DEFAULT '0',
  `Caddy` varchar(1) NOT NULL DEFAULT '0',
  `fglass` varchar(3) NOT NULL DEFAULT '0',
  `uzi` varchar(3) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `booster`
--

CREATE TABLE `booster` (
  `ID` int(11) NOT NULL,
  `UID` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `date` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `buyit`
--

CREATE TABLE `buyit` (
  `ID` int(50) NOT NULL,
  `Typ` varchar(50) NOT NULL,
  `AnbieterUID` int(4) NOT NULL,
  `HoechstbietenderUID` int(4) NOT NULL,
  `Hoechstgebot` int(50) NOT NULL,
  `LaeuftBis` int(50) NOT NULL,
  `Beschreibung` varchar(200) NOT NULL DEFAULT '',
  `OptischesDatum` varchar(50) NOT NULL,
  `Anzahl` varchar(50) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `carhouses_icons`
--

CREATE TABLE `carhouses_icons` (
  `Name` varchar(50) NOT NULL,
  `ID` int(3) NOT NULL,
  `X` double NOT NULL,
  `Y` double NOT NULL,
  `Z` double NOT NULL,
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `SpawnRX` float NOT NULL,
  `SpawnRY` float NOT NULL,
  `SpawnRZ` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `carhouses_vehicles`
--

CREATE TABLE `carhouses_vehicles` (
  `AutohausID` int(50) NOT NULL,
  `X` double NOT NULL,
  `Y` double NOT NULL,
  `Z` double NOT NULL,
  `RX` double NOT NULL,
  `RY` double NOT NULL,
  `RZ` double NOT NULL,
  `Preis` int(11) NOT NULL,
  `Typ` int(50) NOT NULL,
  `Info` varchar(50) NOT NULL,
  `Comment` varchar(999) NOT NULL DEFAULT '',
  `ID` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cars_ai`
--

CREATE TABLE `cars_ai` (
  `ID` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Preis` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cars_peds_ai`
--

CREATE TABLE `cars_peds_ai` (
  `ID` int(11) NOT NULL,
  `VehX` float NOT NULL,
  `VehY` float NOT NULL,
  `VehZ` float NOT NULL,
  `VehRX` float NOT NULL,
  `VehRY` float NOT NULL,
  `VehRZ` float NOT NULL,
  `PedX` float NOT NULL,
  `PedY` float NOT NULL,
  `PedZ` float NOT NULL,
  `PedR` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `coins`
--

CREATE TABLE `coins` (
  `Name` varchar(255) NOT NULL,
  `Coins` int(15) NOT NULL,
  `txn` text NOT NULL,
  `psc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `dailylogins`
--

CREATE TABLE `dailylogins` (
  `UID` int(255) NOT NULL,
  `loginData` int(255) NOT NULL DEFAULT '0',
  `nextLoginBonus` int(255) NOT NULL DEFAULT '0',
  `expiredLoginBonus` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `email`
--

CREATE TABLE `email` (
  `EmpfaengerUID` int(4) NOT NULL,
  `Text` varchar(500) NOT NULL,
  `Yearday` int(11) NOT NULL,
  `Year` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_accounts`
--

CREATE TABLE `forum_accounts` (
  `UID` int(11) NOT NULL,
  `ForumID` varchar(11) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fraktionen`
--

CREATE TABLE `fraktionen` (
  `Name` varchar(50) NOT NULL,
  `ID` int(2) NOT NULL,
  `FKasse` varchar(50) NOT NULL,
  `DepotGeld` varchar(50) NOT NULL DEFAULT '0',
  `DepotDrogen` varchar(50) NOT NULL DEFAULT '0',
  `DepotMaterials` varchar(50) NOT NULL DEFAULT '0',
  `Notiz` longtext NOT NULL,
  `maxVehs` int(100) NOT NULL DEFAULT '20',
  `level` int(100) NOT NULL DEFAULT '0',
  `swatsets` int(11) NOT NULL,
  `rearms` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fraktionen_buy_vehicle`
--

CREATE TABLE `fraktionen_buy_vehicle` (
  `ID` int(255) NOT NULL,
  `Modell` int(255) NOT NULL,
  `OwnerID` int(255) NOT NULL,
  `Preis` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fraktionen_vehicle`
--

CREATE TABLE `fraktionen_vehicle` (
  `ID` int(11) NOT NULL,
  `Modell` int(11) NOT NULL,
  `OwnerID` int(11) NOT NULL,
  `X` int(11) NOT NULL,
  `Y` int(11) NOT NULL,
  `Z` int(255) NOT NULL,
  `RX` int(255) NOT NULL,
  `RY` int(255) NOT NULL,
  `RZ` int(255) NOT NULL,
  `Rang` int(255) NOT NULL DEFAULT '0',
  `Aufwertung` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `fraktionen_warns`
--

CREATE TABLE `fraktionen_warns` (
  `ID` int(255) NOT NULL,
  `UID` int(255) NOT NULL,
  `Fraktion` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `ExpirationDate` int(255) NOT NULL,
  `Expiration` int(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gangs`
--

CREATE TABLE `gangs` (
  `ID` int(2) NOT NULL,
  `X1` varchar(50) NOT NULL,
  `Y1` varchar(50) NOT NULL,
  `X2` varchar(50) NOT NULL,
  `Y2` varchar(50) NOT NULL,
  `X3` varchar(50) NOT NULL,
  `Y3` varchar(50) NOT NULL,
  `Z3` varchar(50) NOT NULL,
  `BesitzerFraktion` int(2) NOT NULL,
  `Einnahmen` int(5) NOT NULL,
  `Name` text NOT NULL,
  `Aktiviert` int(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gang_basic`
--

CREATE TABLE `gang_basic` (
  `ID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL DEFAULT 'Gang',
  `LeaderMSG` varchar(50) NOT NULL DEFAULT '',
  `Waffe` int(2) NOT NULL DEFAULT '0',
  `Skin` int(3) NOT NULL DEFAULT '7',
  `HausID` int(4) NOT NULL DEFAULT '0',
  `Rang1` varchar(50) NOT NULL DEFAULT 'Anfaenger',
  `Rang2` varchar(50) NOT NULL DEFAULT 'Mitglied',
  `Rang3` varchar(50) NOT NULL DEFAULT 'Anfuehrer',
  `MaxMembers` int(4) NOT NULL DEFAULT '8',
  `Drugs` int(10) NOT NULL DEFAULT '0',
  `Mats` int(10) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gang_members`
--

CREATE TABLE `gang_members` (
  `UID` int(4) NOT NULL,
  `Gang` int(4) NOT NULL DEFAULT '0',
  `Rang` int(2) NOT NULL DEFAULT '1',
  `Founder` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gang_vehicles`
--

CREATE TABLE `gang_vehicles` (
  `GangID` int(4) NOT NULL,
  `Typ` int(3) NOT NULL DEFAULT '500',
  `Tuning` varchar(50) NOT NULL DEFAULT '|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|',
  `Spawnpos_X` double NOT NULL DEFAULT '0',
  `Spawnpos_Y` double NOT NULL DEFAULT '0',
  `Spawnpos_Z` double NOT NULL DEFAULT '0',
  `Spawnrot_X` double NOT NULL DEFAULT '0',
  `Spawnrot_Y` double NOT NULL DEFAULT '0',
  `Spawnrot_Z` double NOT NULL DEFAULT '0',
  `Farbe` varchar(50) NOT NULL DEFAULT '|0|0|0|0|',
  `Paintjob` int(4) NOT NULL DEFAULT '0',
  `Lights` varchar(13) NOT NULL DEFAULT '|255|255|255|'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `ID` int(11) NOT NULL,
  `SymbolX` double NOT NULL,
  `SymbolY` double NOT NULL,
  `SymbolZ` double NOT NULL,
  `UID` int(4) NOT NULL,
  `Preis` int(11) NOT NULL,
  `CurrentInterior` int(11) NOT NULL,
  `Kasse` int(11) NOT NULL,
  `Miete` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `idcounter`
--

CREATE TABLE `idcounter` (
  `id` int(50) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inventar`
--

CREATE TABLE `inventar` (
  `UID` int(4) NOT NULL,
  `Wuerfel` tinyint(1) NOT NULL DEFAULT '0',
  `Blumensamen` int(11) NOT NULL DEFAULT '0',
  `Lottoschein` varchar(50) NOT NULL DEFAULT '0|0|0|0|0|0',
  `Essensslot1` int(2) NOT NULL DEFAULT '0',
  `Essensslot2` int(2) NOT NULL DEFAULT '0',
  `Essensslot3` int(2) NOT NULL DEFAULT '0',
  `Waffenslot1` varchar(50) NOT NULL DEFAULT '0|0',
  `Waffenslot2` varchar(50) NOT NULL DEFAULT '0|0',
  `Waffenslot3` varchar(50) NOT NULL DEFAULT '0|0',
  `Zigaretten` int(5) NOT NULL DEFAULT '0',
  `Materials` int(10) NOT NULL DEFAULT '0',
  `Benzinkanister` int(10) NOT NULL DEFAULT '0',
  `FruitNotebook` tinyint(1) NOT NULL DEFAULT '1',
  `Gameboy` int(1) NOT NULL DEFAULT '0',
  `Objekt` int(10) NOT NULL DEFAULT '0',
  `Chips` int(50) NOT NULL DEFAULT '0',
  `Geschenke` int(50) NOT NULL DEFAULT '0',
  `fishing` varchar(39) NOT NULL DEFAULT '0|0|0|0;0|0;0|0;0',
  `fglass` tinyint(1) NOT NULL DEFAULT '0',
  `Medikit` int(10) NOT NULL DEFAULT '0',
  `Spezial` text NOT NULL,
  `Repairkit` int(10) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `levelsystem`
--

CREATE TABLE `levelsystem` (
  `UID` int(11) NOT NULL,
  `prestigeLevel` int(255) NOT NULL DEFAULT '0',
  `MainLevel` int(11) NOT NULL DEFAULT '1',
  `MainXP` int(11) NOT NULL DEFAULT '0',
  `GWLevel` int(11) NOT NULL DEFAULT '0',
  `GWXP` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `loggedin`
--

CREATE TABLE `loggedin` (
  `UID` int(4) NOT NULL,
  `Serial` varchar(32) NOT NULL DEFAULT 'ABCD1234ABCD1234',
  `IP` varchar(50) NOT NULL DEFAULT '0.0.0.0',
  `Loggedin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logout`
--

CREATE TABLE `logout` (
  `UID` int(4) NOT NULL,
  `Position` varchar(50) NOT NULL,
  `Waffen` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `ID` int(11) NOT NULL,
  `Typ` int(200) NOT NULL,
  `Text` varchar(255) NOT NULL,
  `faction` int(11) NOT NULL DEFAULT '0',
  `Timestamp` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `lotto`
--

CREATE TABLE `lotto` (
  `id` int(10) NOT NULL,
  `UID` int(4) NOT NULL,
  `z1` int(2) NOT NULL DEFAULT '0',
  `z2` int(2) NOT NULL DEFAULT '0',
  `z3` int(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `marktplatz`
--

CREATE TABLE `marktplatz` (
  `ID` int(10) NOT NULL,
  `seller` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` int(15) NOT NULL,
  `buyer` varchar(50) NOT NULL,
  `starttime` datetime NOT NULL,
  `endtime` datetime NOT NULL,
  `objecttyp` varchar(25) NOT NULL,
  `objectID` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `object`
--

CREATE TABLE `object` (
  `UID` int(4) NOT NULL,
  `id` int(10) NOT NULL,
  `model` int(6) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `taken` tinyint(1) NOT NULL DEFAULT '0',
  `placer` varchar(50) NOT NULL,
  `deleteTime` int(15) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `UID` int(4) NOT NULL,
  `Paket1` int(11) NOT NULL,
  `Paket2` int(11) NOT NULL,
  `Paket3` int(11) NOT NULL,
  `Paket4` int(11) NOT NULL,
  `Paket5` int(11) NOT NULL,
  `Paket6` int(11) NOT NULL,
  `Paket7` int(11) NOT NULL,
  `Paket8` int(11) NOT NULL,
  `Paket9` int(11) NOT NULL,
  `Paket10` int(11) NOT NULL,
  `Paket11` int(11) NOT NULL,
  `Paket12` int(11) NOT NULL,
  `Paket13` int(11) NOT NULL,
  `Paket14` int(11) NOT NULL,
  `Paket15` int(11) NOT NULL,
  `Paket16` int(11) NOT NULL,
  `Paket17` int(11) NOT NULL,
  `Paket18` int(11) NOT NULL,
  `Paket19` int(11) NOT NULL,
  `Paket20` int(11) NOT NULL,
  `Paket21` int(11) NOT NULL,
  `Paket22` int(11) NOT NULL,
  `Paket23` int(11) NOT NULL,
  `Paket24` int(11) NOT NULL,
  `Paket25` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `UID` int(4) NOT NULL,
  `email` varchar(255) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `IP` varchar(50) NOT NULL,
  `Last_login` varchar(50) NOT NULL,
  `Geburtsdatum_Tag` int(11) NOT NULL,
  `Geburtsdatum_Monat` int(11) NOT NULL,
  `Geburtsdatum_Jahr` int(4) NOT NULL,
  `Passwort` text NOT NULL,
  `Geschlecht` int(50) NOT NULL,
  `RegisterDatum` varchar(50) NOT NULL,
  `LastLogin` int(50) NOT NULL DEFAULT '1',
  `Erlaubnis` varchar(1) NOT NULL DEFAULT '0',
  `ts3uid` text NOT NULL,
  `timebans` int(11) NOT NULL DEFAULT '0',
  `permabans` int(11) NOT NULL DEFAULT '0',
  `permaSuppToken` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `playingtime`
--

CREATE TABLE `playingtime` (
  `UID` int(4) NOT NULL,
  `Time` int(4) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pm`
--

CREATE TABLE `pm` (
  `Sender` varchar(50) NOT NULL,
  `EmpfaengerUID` int(4) NOT NULL,
  `Text` varchar(500) NOT NULL,
  `Datum` varchar(50) NOT NULL,
  `ids` int(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `prestige`
--

CREATE TABLE `prestige` (
  `ID` int(10) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Besitzer` varchar(50) NOT NULL,
  `UID` int(11) NOT NULL,
  `Preis` int(7) NOT NULL,
  `Beschreibung` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `racing`
--

CREATE TABLE `racing` (
  `UID` int(4) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `MilliSekunden` int(1) NOT NULL,
  `Sekunden` int(2) NOT NULL,
  `Minuten` int(5) NOT NULL,
  `Platz` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `server_data`
--

CREATE TABLE `server_data` (
  `ID` int(11) NOT NULL,
  `name` int(11) NOT NULL,
  `data` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `UID` int(4) NOT NULL,
  `fishing` int(5) NOT NULL DEFAULT '0',
  `repair` int(5) NOT NULL DEFAULT '0',
  `gamble` int(10) NOT NULL DEFAULT '0',
  `cook` int(5) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `socialstatelist`
--

CREATE TABLE `socialstatelist` (
  `ID` int(11) NOT NULL,
  `Name` int(11) NOT NULL,
  `Description` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `socialstates`
--

CREATE TABLE `socialstates` (
  `ID` int(11) NOT NULL,
  `UID` int(11) NOT NULL,
  `socialStateID` int(11) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `state_files`
--

CREATE TABLE `state_files` (
  `UID` int(4) NOT NULL,
  `text` varchar(1000) NOT NULL,
  `editor` varchar(50) NOT NULL,
  `faction` int(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `statistics`
--

CREATE TABLE `statistics` (
  `UID` int(4) NOT NULL,
  `AnzahlEingeknastet` int(11) NOT NULL DEFAULT '0',
  `AnzahlImKnast` int(11) NOT NULL DEFAULT '0',
  `AnzahlGangwars` int(11) NOT NULL DEFAULT '0',
  `AnzahlGangwarsGewonnen` int(11) NOT NULL DEFAULT '0',
  `AnzahlGangwarsVerloren` int(11) NOT NULL DEFAULT '0',
  `Kills` int(11) NOT NULL DEFAULT '0',
  `Tode` int(11) NOT NULL DEFAULT '0',
  `GangwarKills` int(11) NOT NULL DEFAULT '0',
  `GangwarTode` int(11) NOT NULL DEFAULT '0',
  `HaeuserGekauft` int(11) NOT NULL DEFAULT '0',
  `FahrzeugeGekauft` int(11) NOT NULL DEFAULT '0',
  `FahrzeugeVerkauft` int(11) NOT NULL DEFAULT '0',
  `DamageGemacht` int(11) NOT NULL DEFAULT '0',
  `DamageBekommen` int(11) NOT NULL DEFAULT '0',
  `GangwarDamageGemacht` int(11) NOT NULL DEFAULT '0',
  `GangwarDamageBekommen` int(11) NOT NULL DEFAULT '0',
  `FraktionenBetreten` int(11) NOT NULL DEFAULT '0',
  `FraktionenVerlassen` int(11) NOT NULL DEFAULT '0',
  `Eingeloggt` int(11) NOT NULL DEFAULT '0',
  `MontagSpielzeit` int(11) NOT NULL DEFAULT '0',
  `DienstagSpielzeit` int(11) NOT NULL DEFAULT '0',
  `MittwochSpielzeit` int(11) NOT NULL DEFAULT '0',
  `DonnerstagSpielzeit` int(11) NOT NULL DEFAULT '0',
  `FreitagSpielzeit` int(11) NOT NULL DEFAULT '0',
  `SamstagSpielzeit` int(11) NOT NULL DEFAULT '0',
  `SonntagSpielzeit` int(11) NOT NULL DEFAULT '0',
  `LetzteWocheSpielzeit` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `support`
--

CREATE TABLE `support` (
  `ID` int(11) NOT NULL,
  `player` text NOT NULL,
  `subject` text NOT NULL,
  `message` text NOT NULL,
  `state` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `ID` int(255) NOT NULL,
  `UID` int(255) NOT NULL,
  `AdminUID` int(255) NOT NULL,
  `type` int(11) NOT NULL,
  `state` int(11) NOT NULL,
  `subject` tinytext NOT NULL,
  `text` text NOT NULL,
  `reviewRate` int(255) NOT NULL,
  `reviewText` mediumtext NOT NULL,
  `timesamp` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tickets_answers`
--

CREATE TABLE `tickets_answers` (
  `ID` int(11) NOT NULL,
  `UID` int(11) NOT NULL,
  `text` text NOT NULL,
  `timesamp` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `userdata`
--

CREATE TABLE `userdata` (
  `UID` int(4) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `LastLogin` int(255) NOT NULL,
  `alkatime` int(255) NOT NULL,
  `ID` int(11) NOT NULL,
  `Geld` double NOT NULL DEFAULT '15000',
  `Spawnpos_X` varchar(50) NOT NULL DEFAULT '-2458.288085',
  `Spawnpos_Y` varchar(50) NOT NULL DEFAULT '774.354492',
  `Spawnpos_Z` varchar(50) NOT NULL DEFAULT '35.171875',
  `Spawnrot_X` varchar(50) NOT NULL DEFAULT '52.94',
  `SpawnInterior` double NOT NULL DEFAULT '0',
  `SpawnDimension` double NOT NULL DEFAULT '0',
  `Fraktion` double NOT NULL DEFAULT '0',
  `FraktionsRang` double NOT NULL DEFAULT '0',
  `FraktionsWarns` int(100) NOT NULL DEFAULT '0',
  `FraktionsBan` int(2) NOT NULL DEFAULT '0',
  `FraktionsBanReason` varchar(255) DEFAULT NULL,
  `FraktionsBanDate` int(255) NOT NULL,
  `Adminlevel` int(10) NOT NULL DEFAULT '0',
  `Spielzeit` double NOT NULL DEFAULT '180',
  `Hitglocke` int(1) NOT NULL DEFAULT '0',
  `CurrentCars` double NOT NULL DEFAULT '0',
  `MaximumCars` double NOT NULL DEFAULT '5',
  `Knastzeit` double NOT NULL DEFAULT '0',
  `Prison` double NOT NULL DEFAULT '0',
  `Kaution` int(4) NOT NULL DEFAULT '0',
  `Himmelszeit` double NOT NULL DEFAULT '0',
  `Hausschluessel` int(50) NOT NULL DEFAULT '0',
  `Bizschluessel` int(50) NOT NULL DEFAULT '0',
  `Bankgeld` double NOT NULL DEFAULT '1000000',
  `Drogen` double NOT NULL DEFAULT '0',
  `Skinid` int(3) NOT NULL DEFAULT '0',
  `Autofuehrerschein` int(1) NOT NULL DEFAULT '0',
  `Motorradtfuehrerschein` int(1) NOT NULL DEFAULT '0',
  `LKWfuehrerschein` int(1) NOT NULL DEFAULT '0',
  `Helikopterfuehrerschein` int(1) NOT NULL DEFAULT '0',
  `FlugscheinKlasseA` int(1) NOT NULL DEFAULT '0',
  `FlugscheinKlasseB` int(1) NOT NULL DEFAULT '0',
  `Motorbootschein` int(1) NOT NULL DEFAULT '0',
  `Segelschein` int(1) NOT NULL DEFAULT '0',
  `Angelschein` int(1) NOT NULL DEFAULT '0',
  `Wanteds` int(1) NOT NULL DEFAULT '0',
  `StvoPunkte` int(2) NOT NULL DEFAULT '0',
  `Waffenschein` int(1) NOT NULL DEFAULT '0',
  `Perso` int(1) NOT NULL DEFAULT '0',
  `Boni` double NOT NULL DEFAULT '0',
  `PdayIncome` double NOT NULL DEFAULT '0',
  `Telefonnr` int(6) NOT NULL DEFAULT '0',
  `Warns` int(50) NOT NULL DEFAULT '0',
  `Gunbox1` varchar(50) NOT NULL DEFAULT '0|0',
  `Gunbox2` varchar(50) NOT NULL DEFAULT '0|0',
  `Gunbox3` varchar(50) NOT NULL DEFAULT '0|0',
  `Job` varchar(50) NOT NULL DEFAULT 'none',
  `Jobtime` double NOT NULL DEFAULT '0',
  `Club` varchar(50) NOT NULL DEFAULT 'none',
  `FavRadio` varchar(50) NOT NULL DEFAULT '0',
  `Bonuspunkte` int(11) NOT NULL DEFAULT '0',
  `Truckerskill` varchar(50) NOT NULL DEFAULT 'none',
  `AirportLevel` varchar(50) NOT NULL DEFAULT '1',
  `farmerLVL` int(10) NOT NULL DEFAULT '0',
  `bauarbeiterLVL` int(10) NOT NULL DEFAULT '0',
  `Contract` int(7) NOT NULL DEFAULT '0',
  `ArmyPermissions` varchar(50) NOT NULL DEFAULT '|0|0|0|0|0|0|0|0|0|',
  `SocialState` varchar(50) NOT NULL DEFAULT 'Obdachloser',
  `fversicherung` int(11) NOT NULL DEFAULT '0',
  `LastFactionChange` varchar(50) NOT NULL DEFAULT '-',
  `StreetCleanPoints` int(11) NOT NULL DEFAULT '0',
  `Handy` varchar(50) NOT NULL DEFAULT '|1|0|',
  `Rausch` varchar(50) NOT NULL DEFAULT '0|0|0|',
  `Sucht` varchar(50) NOT NULL DEFAULT '0|0|0|',
  `pred` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Ob das Promt-Fenster gelesen wurde',
  `Buslevel` int(11) NOT NULL DEFAULT '0',
  `PremiumPaket` int(255) NOT NULL,
  `PremiumData` int(255) NOT NULL DEFAULT '0',
  `lastSocialChange` int(11) NOT NULL,
  `lastNumberChange` int(11) NOT NULL,
  `lastPremCarGive` int(11) NOT NULL,
  `PremiumCars` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `UID` int(4) NOT NULL,
  `id` int(11) NOT NULL,
  `Kofferraum` varchar(50) NOT NULL DEFAULT '0|0|0|0|',
  `Typ` int(11) NOT NULL,
  `Tuning` varchar(255) NOT NULL,
  `Spawnpos_X` varchar(50) NOT NULL,
  `Spawnpos_Y` varchar(50) NOT NULL,
  `Spawnpos_Z` varchar(50) NOT NULL,
  `Spawnrot_X` varchar(50) NOT NULL,
  `Spawnrot_Y` varchar(50) NOT NULL,
  `Spawnrot_Z` varchar(50) NOT NULL,
  `Farbe` varchar(50) NOT NULL,
  `Paintjob` varchar(50) NOT NULL DEFAULT '3',
  `Benzin` varchar(50) NOT NULL DEFAULT '100',
  `Slot` float NOT NULL,
  `Special` int(11) NOT NULL DEFAULT '0',
  `Lights` varchar(50) NOT NULL DEFAULT '|255|255|255|',
  `Distance` double NOT NULL DEFAULT '0',
  `STuning` varchar(50) NOT NULL DEFAULT '0|0|0|0|0|0|',
  `AuktionsID` int(10) NOT NULL DEFAULT '0',
  `GangVehicle` tinyint(1) NOT NULL DEFAULT '0',
  `rc` int(1) NOT NULL DEFAULT '0',
  `spezcolor` varchar(50) NOT NULL DEFAULT '|0|0|0|0|0|0|',
  `Sportmotor` int(1) NOT NULL DEFAULT '0',
  `Bremse` varchar(1) NOT NULL DEFAULT '0',
  `Antrieb` varchar(10) NOT NULL,
  `plate` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `warns`
--

CREATE TABLE `warns` (
  `UID` int(4) NOT NULL,
  `id` int(11) NOT NULL,
  `adminUID` int(4) NOT NULL,
  `reason` text NOT NULL,
  `time` int(255) NOT NULL DEFAULT '0',
  `date` int(255) NOT NULL,
  `Abgelaufen` int(255) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `warps`
--

CREATE TABLE `warps` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `x` varchar(255) NOT NULL,
  `y` varchar(255) NOT NULL,
  `z` varchar(255) NOT NULL,
  `int` varchar(255) NOT NULL,
  `dim` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `weed`
--

CREATE TABLE `weed` (
  `id` int(11) NOT NULL,
  `x` int(20) NOT NULL,
  `y` int(20) NOT NULL,
  `z` int(20) NOT NULL,
  `time` int(50) NOT NULL,
  `UID` int(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `achievementlist`
--
ALTER TABLE `achievementlist`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `achievements`
--
ALTER TABLE `achievements`
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `achievments`
--
ALTER TABLE `achievments`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `advertisedplayers`
--
ALTER TABLE `advertisedplayers`
  ADD UNIQUE KEY `werberUID` (`werberUID`);

--
-- Indexes for table `ban`
--
ALTER TABLE `ban`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `biz`
--
ALTER TABLE `biz`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Biz` (`Biz`);

--
-- Indexes for table `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blocks`
--
ALTER TABLE `blocks`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `bonustable`
--
ALTER TABLE `bonustable`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `booster`
--
ALTER TABLE `booster`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `carhouses_icons`
--
ALTER TABLE `carhouses_icons`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `carhouses_vehicles`
--
ALTER TABLE `carhouses_vehicles`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_2` (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `cars_ai`
--
ALTER TABLE `cars_ai`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `cars_peds_ai`
--
ALTER TABLE `cars_peds_ai`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `coins`
--
ALTER TABLE `coins`
  ADD PRIMARY KEY (`Name`);

--
-- Indexes for table `dailylogins`
--
ALTER TABLE `dailylogins`
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `email`
--
ALTER TABLE `email`
  ADD KEY `Empfaenger` (`EmpfaengerUID`);

--
-- Indexes for table `forum_accounts`
--
ALTER TABLE `forum_accounts`
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `fraktionen`
--
ALTER TABLE `fraktionen`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `fraktionen_buy_vehicle`
--
ALTER TABLE `fraktionen_buy_vehicle`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `fraktionen_vehicle`
--
ALTER TABLE `fraktionen_vehicle`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `fraktionen_warns`
--
ALTER TABLE `fraktionen_warns`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `gangs`
--
ALTER TABLE `gangs`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nummer` (`ID`);

--
-- Indexes for table `gang_basic`
--
ALTER TABLE `gang_basic`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `gang_members`
--
ALTER TABLE `gang_members`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `gang_vehicles`
--
ALTER TABLE `gang_vehicles`
  ADD PRIMARY KEY (`GangID`),
  ADD UNIQUE KEY `GangID` (`GangID`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`),
  ADD KEY `Besitzer` (`UID`);

--
-- Indexes for table `idcounter`
--
ALTER TABLE `idcounter`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `inventar`
--
ALTER TABLE `inventar`
  ADD UNIQUE KEY `UID` (`UID`),
  ADD KEY `UID_2` (`UID`);

--
-- Indexes for table `levelsystem`
--
ALTER TABLE `levelsystem`
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `loggedin`
--
ALTER TABLE `loggedin`
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `logout`
--
ALTER TABLE `logout`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `lotto`
--
ALTER TABLE `lotto`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `marktplatz`
--
ALTER TABLE `marktplatz`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `object`
--
ALTER TABLE `object`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`Name`),
  ADD KEY `id` (`UID`);

--
-- Indexes for table `playingtime`
--
ALTER TABLE `playingtime`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `pm`
--
ALTER TABLE `pm`
  ADD PRIMARY KEY (`ids`),
  ADD KEY `Empfaenger` (`EmpfaengerUID`);

--
-- Indexes for table `prestige`
--
ALTER TABLE `prestige`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `racing`
--
ALTER TABLE `racing`
  ADD UNIQUE KEY `Name` (`Name`);

--
-- Indexes for table `server_data`
--
ALTER TABLE `server_data`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `UID` (`UID`),
  ADD KEY `id` (`UID`);

--
-- Indexes for table `socialstatelist`
--
ALTER TABLE `socialstatelist`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `socialstates`
--
ALTER TABLE `socialstates`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `state_files`
--
ALTER TABLE `state_files`
  ADD PRIMARY KEY (`UID`);

--
-- Indexes for table `statistics`
--
ALTER TABLE `statistics`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `support`
--
ALTER TABLE `support`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `tickets_answers`
--
ALTER TABLE `tickets_answers`
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`UID`),
  ADD UNIQUE KEY `UID` (`UID`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warns`
--
ALTER TABLE `warns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warps`
--
ALTER TABLE `warps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weed`
--
ALTER TABLE `weed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `achievementlist`
--
ALTER TABLE `achievementlist`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `achievements`
--
ALTER TABLE `achievements`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ban`
--
ALTER TABLE `ban`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `biz`
--
ALTER TABLE `biz`
  MODIFY `ID` int(2) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blacklist`
--
ALTER TABLE `blacklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `booster`
--
ALTER TABLE `booster`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carhouses_vehicles`
--
ALTER TABLE `carhouses_vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fraktionen_buy_vehicle`
--
ALTER TABLE `fraktionen_buy_vehicle`
  MODIFY `ID` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fraktionen_vehicle`
--
ALTER TABLE `fraktionen_vehicle`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fraktionen_warns`
--
ALTER TABLE `fraktionen_warns`
  MODIFY `ID` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gangs`
--
ALTER TABLE `gangs`
  MODIFY `ID` int(2) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gang_basic`
--
ALTER TABLE `gang_basic`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lotto`
--
ALTER TABLE `lotto`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `marktplatz`
--
ALTER TABLE `marktplatz`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `object`
--
ALTER TABLE `object`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pm`
--
ALTER TABLE `pm`
  MODIFY `ids` int(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `server_data`
--
ALTER TABLE `server_data`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socialstatelist`
--
ALTER TABLE `socialstatelist`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socialstates`
--
ALTER TABLE `socialstates`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support`
--
ALTER TABLE `support`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ID` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets_answers`
--
ALTER TABLE `tickets_answers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `userdata`
--
ALTER TABLE `userdata`
  MODIFY `UID` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warns`
--
ALTER TABLE `warns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warps`
--
ALTER TABLE `warps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `weed`
--
ALTER TABLE `weed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
