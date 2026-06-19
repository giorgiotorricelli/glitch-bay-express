CREATE DATABASE  IF NOT EXISTS `glitch_bay` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `glitch_bay`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: glitch_bay
-- ------------------------------------------------------
-- Server version	8.4.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Illuminazione','Lampade e soluzioni di illuminazione create da hardware vintage e componenti industriali.'),(2,'Orologi','Cronografi e orologi da tavolo o parete realizzati con strumentazione analogica e display retrò.'),(3,'Audio','Sistemi audio, amplificatori e casse ricavati da vecchie radio, citofoni e hardware musicale.'),(4,'Arredamento','Elementi d\'arredo unici e tavoli strutturati con componenti di server, mainframe e dissipatori.'),(5,'Decorazioni da Parete, Piante & Terrari','Quadri materici, terrari in valvole termoioniche e fioriere ricavate da vecchi CRT.'),(6,'Da Scrivania','Organizer, macro-pad, hub e accessori per massimizzare il setup della tua scrivania con stile cyberpunk.'),(7,'Tascabili','Accessori compatti e resistenti da portare sempre con sé, ricavati da componenti tech storici.');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `total_amount` decimal(6,2) NOT NULL,
  `status` enum('paid','unpaid') NOT NULL DEFAULT 'unpaid',
  `shipping_cost` decimal(4,2) NOT NULL DEFAULT '9.99',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tracking_number` char(15) NOT NULL,
  `payment_method` enum('stripe','paypal','crypto') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,224.10,'paid',9.99,'2026-06-10 08:30:00','IT9384729104823','paypal'),(2,562.50,'paid',0.00,'2026-06-11 12:15:00','IT1029384756102','stripe'),(3,110.00,'paid',9.99,'2026-06-12 07:00:00','IT5564738291034','crypto'),(4,2500.00,'paid',0.00,'2026-06-12 16:45:00','IT4829103948571','stripe'),(5,346.00,'paid',0.00,'2026-06-14 09:20:00','IT2938471029384','paypal'),(6,114.00,'paid',9.99,'2026-06-15 14:00:00','IT3049582102938','stripe'),(7,450.55,'paid',0.00,'2026-06-16 19:10:00','IT8837461920394','crypto'),(8,89.00,'paid',9.99,'2026-06-17 11:05:00','IT7746352910293','paypal'),(9,308.75,'paid',0.00,'2026-06-18 06:30:00','IT1928374655647','stripe'),(10,193.25,'paid',9.99,'2026-06-19 12:22:00','IT5049382716253','paypal');
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `id_product` mediumint unsigned NOT NULL,
  `id_category` mediumint unsigned NOT NULL,
  PRIMARY KEY (`id_product`,`id_category`),
  KEY `product_category_id_category_foreign` (`id_category`),
  CONSTRAINT `product_category_id_category_foreign` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`),
  CONSTRAINT `product_category_id_product_foreign` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,2),(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(18,2),(19,2),(20,3),(21,3),(22,3),(23,3),(24,3),(25,4),(26,4),(27,4),(28,4),(29,4),(30,5),(31,5),(32,5),(33,5),(34,5),(35,5),(36,5),(37,5),(38,6),(39,6),(40,6),(41,6),(42,6),(43,6),(44,6),(45,6),(46,6),(47,6),(48,6),(49,6),(50,6),(51,6),(52,7),(53,7),(54,7),(55,7);
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_invoice`
--

DROP TABLE IF EXISTS `product_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_invoice` (
  `id_product` mediumint unsigned NOT NULL,
  `id_invoice` mediumint unsigned NOT NULL,
  `paid` decimal(10,2) NOT NULL,
  `qty` tinyint unsigned NOT NULL,
  PRIMARY KEY (`id_product`,`id_invoice`),
  KEY `product_invoice_id_invoice_foreign` (`id_invoice`),
  CONSTRAINT `product_invoice_id_invoice_foreign` FOREIGN KEY (`id_invoice`) REFERENCES `invoices` (`id`),
  CONSTRAINT `product_invoice_id_product_foreign` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_invoice`
--

LOCK TABLES `product_invoice` WRITE;
/*!40000 ALTER TABLE `product_invoice` DISABLE KEYS */;
INSERT INTO `product_invoice` VALUES (1,1,224.10,1),(2,8,89.00,1),(11,2,180.00,1),(12,9,213.75,1),(14,3,65.00,1),(16,2,382.50,1),(18,5,117.00,1),(22,7,342.00,1),(23,5,210.00,1),(25,4,2500.00,1),(32,10,115.00,1),(34,10,45.00,1),(35,6,39.00,1),(40,3,45.00,1),(45,7,84.55,1),(48,6,75.00,1),(49,9,95.00,1),(52,7,24.00,1),(54,5,19.00,1),(55,10,33.25,1);
/*!40000 ALTER TABLE `product_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `slug` varchar(104) NOT NULL,
  `img` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'01. The Grid (Wall Panel)','Un pannello modulare da parete composto da 16 tastiere a membrana retroilluminate. Premendo i tasti (ormai scollegati dal PC), si attivano diverse combinazioni di pattern luminosi LED.','01-the-grid-wall-panel','products/the-grid.jpg',249.00,10,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(2,'02. Game Boy Nightlight','Scocche originali di Game Boy DMG-01 (il primo modello grigio) ingiallite dal tempo, restaurate e convertite in lampade da notte USB. Lo schermo originale è sostituito da un display LED che mostra una schermata fissa retroilluminata dei giochi classici.','02-game-boy-nightlight','products/game-boy-nightlight.jpg',89.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(3,'03. Telegraph Code Luminaire','Un vecchio tasto telegrafico in ottone del primo Novecento montato su una base di legno fossile. Abbassando la leva del telegrafo, la lampadina vintage soprastante cambia intensità o si accende a impulsi.','03-telegraph-code-luminaire','products/telegraph-luminaire.jpg',185.00,5,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(4,'04. Fiber Optic Core','Una lampada cilindrica che utilizza i vecchi cavi in fibra ottica dismessi dalle telecomunicazioni industriali. La luce viaggia attraverso i filamenti creando un effetto \"pioggia digitale\" alla Blade Runner sulla punta dei cavi.','04-fiber-optic-core','products/fiber-optic-core.jpg',135.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(5,'05. Mainframe Neon Tube','Una plafoniera industriale creata inserendo strisce LED neon flessibili all\'interno di tubi protettivi trasparenti originariamente usati per il raffreddamento a liquido dei supercomputer degli anni \'90.','05-mainframe-neon-tube','products/mainframe-neon-tube.jpg',320.00,15,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(6,'06. Neon-CRT Desk Lamp','La scocca di un vecchio monitor a tubo catodico (CRT) anni \'90, svuotata dei componenti pericolosi e retroilluminata con un system LED neon personalizzabile via app. Perfetta come luce d\'atmosfera per la scrivania.','06-neon-crt-desk-lamp','products/neon-crt-lamp.jpg',199.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(7,'07. Flux Capacitor 2.0','Una lampada da parete che utilizza vecchi condensatori industriali degli anni \'70 e tubi di vetro retroilluminati a impulsi, che simulano il passaggio di corrente fantascientifico.','07-flux-capacitor-20','products/flux-capacitor.jpg',275.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(8,'08. The Motherboard Glow','Una lampada da tavolo minimalista dove la base è una scheda madre di un server dual-processor resinata, illuminata da strisce LED nascoste che fanno risaltare le piste di rame e i circuiti stampati.','08-the-motherboard-glow','products/motherboard-glow.jpg',160.00,10,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(9,'09. Floppy Disk Lantern','Una lampada a sospensione cubica composta da 40 floppy disk da 3.5 pollici sapientemente assemblati. La luce filtra attraverso i fori dei dischetti, creando pattern geometrici unici sulle pareti.','09-floppy-disk-lantern','products/floppy-lantern.jpg',75.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(10,'10. Terminal-Vibe Edison','Un vecchio oscilloscopio analogico non funzionante, riconvertito in lampada da lettura: lo schermo originale è sostituito da una griglia metallica da cui spuntano tre lampadine vintage di Edison a filamento.','10-terminal-vibe-edison','products/terminal-edison.jpg',210.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(11,'11. The Matrix LED Matrix','Orologio da parete che utilizza i display a matrice di LED verdi dei vecchi pannelli informativi delle stazioni ferroviarie. Il tempo scorre con l\'iconico effetto \"cascata di codice\".','11-the-matrix-led-matrix','products/matrix-clock.jpg',180.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(12,'12. Voltmeter Chronograph','Un orologio da scrivania realizzato con tre vecchi voltmetri analogici a lancetta inseriti in un blocco di cemento grezzo. La prima lancetta indica le ore, la seconda i minuti e la terza i secondi, muovendosi in base alla tensione elettrica modificata dal circuito interno.','12-voltmeter-chronograph','products/voltmeter-chrono.jpg',225.00,5,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(13,'13. Pager Pocket Watch','Un vecchio cercapersone (pager) degli anni \'90 svuotato e ricondizionato con un display OLED moderno. Si indossa come un orologio da taschino steampunk, mostrando l\'ora con i font pixellati dell\'epoca.','13-pager-pocket-watch','products/pager-watch.jpg',95.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(14,'14. Laser Disc Dial','Un orologio da parete gigante realizzato usando un LaserDisc (il precursore del DVD dalle dimensioni di un vinile). Le sfumature arcobaleno del disco riflettono la luce della stanza, mentre le lancette sono minimaliste e nere opache.','14-laser-disc-dial','products/laser-disc-dial.jpg',65.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(15,'15. Calculated Time','Un orologio da tavolo creato unendo tre calcolatrici scientifiche vintage degli anni \'70 (con display a LED rossi). I display sono stati sincronizzati per mostrare rispettivamente Ore, Minuti e Secondi.','15-calculated-time','products/calculated-time.jpg',145.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(16,'16. Cyber-Nixie Chronos','Orologio da tavolo di fascia alta che utilizza sei tubi Nixie originali sovietici degli anni \'80 montati su una base ricavata da un blocco di alluminio spazzolato di un vecchio dissipatore per CPU.','16-cyber-nixie-chronos','products/nixie-chronos.jpg',450.00,15,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(17,'17. HDD Relic Clock','Un orologio da parete minimalista realizzato partendo dal piatto a specchio esposto di un hard disk da 3.5 pollici guasto. Le lancette rosse fluo contrastano con il metallo lucido del disco.','17-hdd-relic-clock','products/hdd-clock.jpg',55.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(18,'18. VFD Dashboard','Un orologio/datario da scrivania che utilizza i display a fluorescenza sotto vuoto (VFD) recuperati dai vecchi videoregistratori VHS, inseriti in un guscio di legno massello bruciato (effetto Shou Sugi Ban).','18-vfd-dashboard','products/vfd-dashboard.jpg',130.00,10,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(19,'19. The Overclocked Hourglass','Una clessidra decorative dove al posto della sabbia scorrono microscopiche sfere di stagno lucido (da saldatura), incorniciata da due ventole per PC vintage in rame.','19-the-overclocked-hourglass','products/overclocked-hourglass.jpg',85.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(20,'20. Intercom Speaker System','Una coppia di casse acustiche da scaffale realizzate riutilizzando i pesanti gusci in metallo dei citofoni industriali delle fabbriche anni \'60, completi di griglia in ferro battuto.','20-intercom-speaker-system','products/intercom-speakers.jpg',290.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(21,'21. VU-Meter Desk Buddy','Un piccolo gadget da scrivania standalone contenente due enormi VU-meter analogici recuperati da un mixer da studio radiofonico. Si collegano via jack o microfono integrato per far danzare le lancette a ritmo dei rumori della stanza.','21-vu-meter-desk-buddy','products/vu-meter-buddy.jpg',110.00,5,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(22,'22. The Retro-Boomerang (Bluetooth Speaker)','Una vecchia radio a valvole degli anni \'50 svuotata della componentistica originale (irrecuperabile) e dotata di un moderno sistema audio Bluetooth da 40W, con i pomelli originali che controllano volume e accensione.','22-the-retro-boomerang-bluetooth-speaker','products/retro-boomerang.jpg',380.00,10,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(23,'23. Cassette Tape Soundbar','Una soundbar per TV assemblata all\'interno del case di un vecchio registratore a doppie cassette degli anni \'80. I misuratori VU-meter analogici ad ago sono funzionanti e oscillano a tempo di musica.','23-cassette-tape-soundbar','products/cassette-soundbar.jpg',210.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(24,'24. Walkman Amp','Un iconico lettore cassette portatile (non funzionante) trasformato in un amplificatore portatile per cuffie ad alta fedeltà, mantenendo intatto lo switch \"Click\" originale.','24-walkman-amp','products/walkman-amp.jpg',125.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(25,'25. The Server Door Dining Table','Un tavolo da pranzo per 6 persone il cui piano è costituito dalla porta grigliata d\'acciaio di un server rack IBM Mainframe, sigillata sotto uno strato di 2 cm di resina epossidica trasparente.','25-the-server-door-dining-table','products/server-door-table.jpg',1250.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(26,'26. Floppy Disk Lounge Stool','Uno sgabello cubo la cui seduta è imbottita e rivestita in ecopelle, mentre le quattro facce laterali sono composte da pannelli rigidi formati da centinaia di floppy disk da 5.25 pollici (quelli grandi e flessibili).','26-floppy-disk-lounge-stool','products/floppy-stool.jpg',185.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(27,'27. Heatsink Coffee Table','Un tavolino basso sorretto da quattro enormi blocchi dissipatori di calore in alluminio anodizzato nero prelevati da macchinari industriali, con un ripiano in vetro fumé tagliato a laser.','27-heatsink-coffee-table','products/heatsink-table.jpg',420.00,5,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(28,'28. The Matrix Coffee Table','Un tavolo da caffè basso con il ripiano in vetro temperato. Sotto il vetro si trova un diorama Cyberpunk realizzato interamente con schede video (GPU), moduli RAM e processori disposti come se fossero i grattacieli di una metropoli futuristica.','28-the-matrix-coffee-table','products/matrix-table.jpg',590.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(29,'29. Server Rack Bookshelf','Un vero rack da server industriale da 19 pollici, verniciato in nero opaco e riconvertito in libreria da salotto, con ripiani in legno grezzo che spezzano la freddezza del metallo.','29-server-rack-bookshelf','products/server-bookshelf.jpg',480.00,10,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(30,'30. Silicon Valley Terrarium','Un terrario chiuso all\'interno di una grande valvola termoionica industriale trasmittente (alta 40 cm). Il fondo del terrario è decorato con piccoli pezzi di quarzo e vecchi chip dorati.','30-silicon-valley-terrarium','products/silicon-terrarium.jpg',165.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(31,'31. Televisore Bonsai','La scocca in legno di un televisore a tubo catodico degli anni \'60, svuotata e convertita in una fioriera idroponica indoor con luci di crescita LED integrate nel telaio superiore.','31-televisore-bonsai','products/tv-bonsai.jpg',240.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(32,'32. The Deconstructed Phone Framed','Un\'opera d\'arte da parete che mostra un vecchio smartphone iconico (es. Blackberry) completamente smontato pezzo per pezzo, pulito e incorniciato con scritte tecniche che spiegano la funzione di ogni componente.','32-the-deconstructed-phone-framed','products/deconstructed-phone.jpg',115.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(33,'33. Magnetic Tape Wall Art','Un quadro astratto materico realizzato srotolando e fissando con resina centinaia di metri di nastro magnetico proveniente da vecchie bobine di computer degli anni \'70, creando onde e texture tridimensionali.','33-magnetic-tape-wall-art','products/magnetic-tape-art.jpg',195.00,15,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(34,'34. Silicon Coasters (Set da 4)','Sottobicchieri quadrati ricavati dal taglio di veri wafer di silicio (i dischi usati per stampare i microchip) scartati dalle fabbriche per micro-difetti, resinati per renderli indistruttibili e super riflettenti.','34-silicon-coasters-set-da-4','products/silicon-coasters.jpg',45.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(35,'35. CPU Key Hook','Un appendichiavi da parete magnetico realizzato allineando 5 vecchi processori con il die a specchio o i pin dorati a vista (es. vecchi Pentium o AMD Athlon). Le chiavi si attaccano magneticamente al centro di ogni CPU.','35-cpu-key-hook','products/cpu-key-hook.jpg',39.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(36,'36. CRT Planter','Il guscio in plastica di un vecchio iMac G3 colorato e trasparente, impermeabilizzato all\'interno e trasformato in un terrario per piante grasse o piccoli bonsai.','36-crt-planter','products/imac-planter.jpg',120.00,5,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(37,'37. The Macintosh G4 Fish Tank','Il leggendario case trasparente in policarbonato del PowerMac G4 Cube, sigillato e trasformato in un acquario d\'acqua dolce per piccoli pesci o gamberetti, con filtro e luci nascosti nella base.','37-the-macintosh-g4-fish-tank','products/mac-g4-aquarium.jpg',299.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(38,'38. The Power Strip Command Center','Una ciabatta elettrica da scrivania inserita all\'interno di un vecchio pannello di controllo aeronautico dismesso, dotata di interruttori a leva (toggle switches) protetti da coperture di sicurezza rosse.','38-the-power-strip-command-center','products/power-strip-command.jpg',135.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(39,'39. The Clicky Business Card Holder','Un porta-biglietti da visita da scrivania la cui base è composta da 4 switch meccanici (Cherry MX Blue). Inserendo il biglietto, questo si incastra tra i tasti emettendo il classico e soddisfacente \"click\".','39-the-clicky-business-card-holder','products/clicky-card-holder.jpg',29.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(40,'40. Hard Drive Tape Dispenser','Un dispenser per nastro adesivo pesante, ricavato dallo chassis in ghisa di un hard disk da server. Il nastro scorre sopra il cuscinetto a sfera del braccio testina originale.','40-hard-drive-tape-dispenser','products/hdd-tape-dispenser.jpg',45.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(41,'41. Mouse Bungee Retrofit','Un passacavo per mouse da gaming realizzato modificando la vecchia antenna telescopica di una TV portatile degli anni \'80, garantendo stabilità e un look unico.','41-mouse-bungee-retrofit','products/mouse-bungee-retrofit.jpg',34.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(42,'42. Mechanical Retro-Click','Una tastiera meccanica moderna assemblata all\'interno dello chassis di una vecchia macchina da scrivere elettronica degli anni \'80, con tasti tondi che richiamano l\'era industriale.','42-mechanical-retro-click','products/retro-keyboard.jpg',185.00,10,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(43,'43. The Dial-Up Desk Organizer','Un organizer da scrivania ricavato da un vecchio modem 56k esterno in metallo. Le fessure per i componenti diventano porta-penne, porta-biglietti da visita e porta-smartphone con ricarica wireless integrata sul top.','43-the-dial-up-desk-organizer','products/dialup-organizer.jpg',79.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(44,'44. RAM Mirror','Uno specchio da parete la cui cornice è interamente ricoperta da centinaia di banchi di memoria RAM vintage affiancati, creando un effetto geometrico metallico e ritmato.','44-ram-mirror','products/ram-mirror.jpg',110.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(45,'45. Arcade Joystick Lamp Switch','Una lampada da tavolo minimalista dove l\'interruttore di accensione è un vero joystick da sala giochi degli anni \'90 (stile Sanwa) con la classica pallina rossa: muovendolo a destra si accende, a sinistra si spegne.','45-arcade-joystick-lamp-switch','products/arcade-joystick-lamp.jpg',89.00,5,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(46,'46. Amiga 500 Modern Deck','Il guscio di un computer Amiga 500 trasformato in una tastiera meccanica wireless moderna per PC/Mac, che mantiene l\'estetica esatta dei tasti originali ma con switch moderni e silenziosi.','46-amiga-500-modern-deck','products/amiga-500-deck.jpg',220.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(47,'47. The Nintendo NES Hub','Una console NES (Nintendo Entertainment System) non funzionante, svuotata e trasformata in un Hub USB-C multi-porta da scrivania. Inserendo una \"cartuccia\" modificata, si attiva un Hard Disk esterno da 2TB.','47-the-nintendo-nes-hub','products/nes-usb-hub.jpg',165.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(48,'48. Game Cube Wireless Charger','La parte superiore di una console Nintendo GameCube modificata: il cerchio centrale dove si inserivano i mini-DVD è ora una piastra di ricarica rapida wireless da 15W per smartphone.','48-game-cube-wireless-charger','products/gamecube-charger.jpg',75.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(49,'49. The Knobs Macro-Pad','Un piccolo controller USB da scrivania con 5 grandi manopole in bachelite recuperate da vecchi amplificatori stereo. Serve a controllare i volumi delle singole app (Spotify, Discord, Gioco) ruotando i pomelli vintage.','49-the-knobs-macro-pad','products/knobs-macropad.jpg',95.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(50,'50. The Airplane Toggle Switch Box','Una scatola di controllo con 4 macro programmabili per PC. Gli interruttori sono i pesanti switch metallici a scatto presi dal cockpit di un aereo di linea dismesso.','50-the-airplane-toggle-switch-box','products/airplane-toggle-box.jpg',115.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(51,'51. The Grid Stream Deck','Console di controllo per streamer e creator dove i tasti sono i vecchi pulsanti quadrati e luminosi dei banchi di regia televisiva degli anni \'90, completamente rimappabili.','51-the-grid-stream-deck','products/grid-stream-deck.jpg',149.00,10,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(52,'52. The Cyber-Keychain','Un portachiavi indistruttibile ricavato ritagliando il core di rame pieno dei vecchi dissipatori per CPU ad alte prestazioni, inciso al laser con le coordinate geografiche di Glitch Bay.','52-the-cyber-keychain','products/cyber-keychain.jpg',24.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(53,'53. Smart-Watch Pocket Case','Un guscio protettivo che trasforma un moderno Apple Watch o Samsung Galaxy Watch in un orologio da tasca retrò, modellato sulle forme di un vecchio cronometro analogico sovietico.','53-smart-watch-pocket-case','products/smartwatch-pocket-case.jpg',49.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(54,'54. Cassette Tape Card Case','La classica custodia in plastica trasparente delle musicassette, rinforzata all\'interno con velluto e modificata per diventare un porta-biglietti da visita tascabile ad apertura rapida.','54-cassette-tape-card-case','products/cassette-card-case.jpg',19.00,0,'2026-06-19 15:27:59','2026-06-19 15:27:59'),(55,'55. The Floppy Wallet','Un porta-carte di credito rigido e schermato RFID, assemblato utilizzando le parti metalliche esterne (lo shutter scorrevole) di vari floppy disk, per un look tech-industrial tascabile.','55-the-floppy-wallet','products/floppy-wallet.jpg',35.00,5,'2026-06-19 15:27:59','2026-06-19 15:27:59');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `id_invoice` mediumint unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `mail` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_id_invoice_unique` (`id_invoice`),
  CONSTRAINT `users_id_invoice_foreign` FOREIGN KEY (`id_invoice`) REFERENCES `invoices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Alessandro','Rossi','alessandro.rossi@email.it','Via Roma 12, Milano','+39 333 1234567'),(2,2,'Elena','Bianchi','elena.bianchi@email.it','Via Torino 45, Torino','+39 347 9876543'),(3,3,'Marco','Verdi','marco.verdi@email.it','Corso Vittorio Emanuele 89, Napoli','+39 328 5554433'),(4,4,'Giulia','Ferrari','giulia.ferrari@email.it','Via della Moscova 3, Milano','+39 349 1112233'),(5,5,'Luca','Russo','luca.russo@email.it','Via Pisacane 14, Firenze','+39 335 4433221'),(6,6,'Chiara','Romano','chiara.romano@email.it','Piazza Navona 22, Roma','+39 331 7788990'),(7,7,'Roberto','Gallo','roberto.gallo@email.it','Via dei Mille 7, Genova','+39 340 6655443'),(8,8,'Francesca','Conti','francesca.conti@email.it','Via Dante 101, Bologna','+39 329 8877665'),(9,9,'Stefano','Marini','stefano.marini@email.it','Via San Francesco 54, Padova','+39 345 2233445'),(10,10,'Silvia','Ricci','silvia.ricci@email.it','Viale dei Giardini 12, Palermo','+39 338 9988776');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-19 17:34:42
