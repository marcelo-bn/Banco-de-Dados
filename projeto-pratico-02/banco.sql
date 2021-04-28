CREATE DATABASE  IF NOT EXISTS `pp02marcelo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pp02marcelo`;
-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: localhost    Database: pp02marcelo
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `Ano`
--

DROP TABLE IF EXISTS `Ano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ano` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ano` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ano`
--

LOCK TABLES `Ano` WRITE;
/*!40000 ALTER TABLE `Ano` DISABLE KEYS */;
INSERT INTO `Ano` VALUES (1,'2018'),(2,'2019'),(3,'2021'),(4,'2020');
/*!40000 ALTER TABLE `Ano` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cidade`
--

DROP TABLE IF EXISTS `Cidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cidade` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cidade`
--

LOCK TABLES `Cidade` WRITE;
/*!40000 ALTER TABLE `Cidade` DISABLE KEYS */;
INSERT INTO `Cidade` VALUES (1,'Florianópolis'),(2,'Palhoça'),(3,'São José');
/*!40000 ALTER TABLE `Cidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Compra`
--

DROP TABLE IF EXISTS `Compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Compra` (
  `lote` int NOT NULL,
  `idVacina` int NOT NULL,
  `custo` int NOT NULL,
  `dataCompra` date NOT NULL,
  `fabricacao` date NOT NULL,
  `validade` date NOT NULL,
  PRIMARY KEY (`lote`),
  KEY `fk_Estoque_Vacina1_idx` (`idVacina`),
  CONSTRAINT `fk_Estoque_Vacina1` FOREIGN KEY (`idVacina`) REFERENCES `Vacina` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Compra`
--

LOCK TABLES `Compra` WRITE;
/*!40000 ALTER TABLE `Compra` DISABLE KEYS */;
INSERT INTO `Compra` VALUES (1,1,5000,'2021-01-10','2020-11-15','2022-11-15'),(2,2,2000,'2021-01-10','2020-11-15','2022-11-15'),(3,3,3500,'2021-01-10','2020-11-15','2022-11-15'),(4,4,5670,'2021-01-10','2020-11-15','2022-11-15'),(5,5,3445,'2021-01-10','2020-11-15','2022-11-15'),(6,6,8097,'2021-01-10','2020-11-15','2022-11-15'),(7,7,23456,'2021-01-10','2020-11-15','2022-11-15'),(8,8,33445,'2021-01-10','2020-11-15','2022-11-15'),(9,9,34565,'2021-01-10','2020-11-15','2022-11-15'),(10,10,34567,'2021-01-10','2020-11-15','2022-11-15'),(11,11,23478,'2021-01-10','2020-11-15','2022-11-15'),(12,12,8789,'2021-01-10','2020-11-15','2022-11-15'),(13,13,7867,'2021-01-10','2020-11-15','2022-11-15'),(14,14,8789,'2021-01-10','2020-11-15','2022-11-15'),(15,15,5787,'2021-01-10','2020-11-15','2022-11-15'),(16,16,7890,'2021-01-10','2020-11-15','2022-11-15'),(17,17,1234,'2021-01-10','2020-11-15','2022-11-15'),(18,18,12324,'2021-01-10','2020-11-15','2022-11-15'),(19,19,9983,'2021-01-10','2020-11-15','2022-11-15'),(20,20,2345,'2021-01-10','2020-11-15','2022-11-15'),(21,21,23456,'2021-01-10','2020-11-15','2022-11-15'),(22,22,5000,'2021-01-10','2020-11-15','2022-11-15'),(23,23,2345,'2021-01-10','2020-11-15','2022-11-15'),(24,24,6000,'2021-01-10','2020-11-15','2022-11-15'),(25,25,7000,'2021-01-10','2020-11-15','2022-11-15'),(26,26,8000,'2021-01-10','2020-11-15','2022-11-15');
/*!40000 ALTER TABLE `Compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Doenca`
--

DROP TABLE IF EXISTS `Doenca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Doenca` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Doenca`
--

LOCK TABLES `Doenca` WRITE;
/*!40000 ALTER TABLE `Doenca` DISABLE KEYS */;
INSERT INTO `Doenca` VALUES (1,'Tuberculose'),(2,'Hepatite B'),(3,'Doenças diarréicas'),(4,'Difteria'),(5,'Tétano'),(6,'Coqueluche'),(7,'Meningite'),(8,'Poliomielite'),(9,'Pneumonia'),(10,'Meningite'),(11,'Otite'),(12,'Meningococcemia'),(13,'Gripe'),(14,'Febre Amarela'),(15,'Sarampo'),(16,'Caxumba'),(17,'Rubéola'),(18,'Catapora'),(19,'Hepatite A'),(20,'HPV'),(21,'Doenças penumococos'),(22,'Herpes Zóster'),(23,'Dengue');
/*!40000 ALTER TABLE `Doenca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Endereco`
--

DROP TABLE IF EXISTS `Endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Endereco` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rua` varchar(45) NOT NULL,
  `idCidade` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Endereco_Cidade1_idx` (`idCidade`),
  CONSTRAINT `fk_Endereco_Cidade1` FOREIGN KEY (`idCidade`) REFERENCES `Cidade` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Endereco`
--

LOCK TABLES `Endereco` WRITE;
/*!40000 ALTER TABLE `Endereco` DISABLE KEYS */;
INSERT INTO `Endereco` VALUES (1,'Rua A',1),(2,'Rua B',1),(3,'Rua C',2),(4,'Rua D',3);
/*!40000 ALTER TABLE `Endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Estoque`
--

DROP TABLE IF EXISTS `Estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Estoque` (
  `idVacina` int NOT NULL,
  `vacAplicadas` int NOT NULL,
  `vacDescartadas` int NOT NULL,
  `dosesTotal` int NOT NULL,
  PRIMARY KEY (`idVacina`),
  KEY `fk_Vacina_has_Doenca_Vacina2_idx` (`idVacina`),
  CONSTRAINT `fk_Vacina_has_Doenca_Vacina2` FOREIGN KEY (`idVacina`) REFERENCES `Vacina` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estoque`
--

LOCK TABLES `Estoque` WRITE;
/*!40000 ALTER TABLE `Estoque` DISABLE KEYS */;
INSERT INTO `Estoque` VALUES (1,0,0,500),(2,0,0,500),(3,0,0,500),(4,0,0,500),(5,0,0,500),(6,0,0,500),(7,0,0,500),(8,0,0,500),(9,0,0,500),(10,0,0,500),(11,0,0,500),(12,0,0,500),(13,0,0,500),(14,500,0,500),(15,0,0,500),(16,0,0,500),(17,0,0,500),(18,0,0,500),(19,0,0,500),(20,0,0,500),(21,0,0,500),(22,0,0,500),(23,0,0,500),(24,0,0,500),(25,0,0,500),(26,0,0,500);
/*!40000 ALTER TABLE `Estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Fabricante`
--

DROP TABLE IF EXISTS `Fabricante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Fabricante` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Fabricante`
--

LOCK TABLES `Fabricante` WRITE;
/*!40000 ALTER TABLE `Fabricante` DISABLE KEYS */;
INSERT INTO `Fabricante` VALUES (1,'Pfizer'),(2,'FioCruz'),(3,'Butantan'),(4,'AstraZeneca'),(5,'Janssen'),(6,'Aché'),(7,'Johnson&Johnson'),(8,'Sanofi');
/*!40000 ALTER TABLE `Fabricante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Faixa_Etaria`
--

DROP TABLE IF EXISTS `Faixa_Etaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Faixa_Etaria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `faixa` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faixa_Etaria`
--

LOCK TABLES `Faixa_Etaria` WRITE;
/*!40000 ALTER TABLE `Faixa_Etaria` DISABLE KEYS */;
INSERT INTO `Faixa_Etaria` VALUES (1,2),(2,3),(3,4),(4,5),(5,6),(6,9),(7,12),(8,13),(9,14),(10,15),(11,108),(12,110),(13,180),(14,720),(15,0),(16,8),(17,48),(18,114),(19,780);
/*!40000 ALTER TABLE `Faixa_Etaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Historico`
--

DROP TABLE IF EXISTS `Historico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Historico` (
  `idVacinaGeral` int NOT NULL,
  `idFaixaEtaria` int NOT NULL,
  `idAno` int NOT NULL,
  `idPessoa` int NOT NULL,
  `idUnidadeSaude` int NOT NULL,
  `data` date NOT NULL,
  `doseAtual` int NOT NULL,
  `idVacina` int NOT NULL,
  PRIMARY KEY (`idVacinaGeral`,`idFaixaEtaria`,`idAno`,`idPessoa`),
  KEY `fk_Dose_has_Pessoa_Pessoa1_idx` (`idPessoa`),
  KEY `fk_Dose_has_Pessoa_Dose1_idx` (`idVacinaGeral`,`idFaixaEtaria`,`idAno`),
  KEY `fk_Historico_Unidade_Saude1_idx` (`idUnidadeSaude`),
  KEY `fk_Historico_Vacina1_idx` (`idVacina`),
  CONSTRAINT `fk_Dose_has_Pessoa_Dose1` FOREIGN KEY (`idVacinaGeral`, `idFaixaEtaria`, `idAno`) REFERENCES `Vacinacao` (`idVacinaGeral`, `idFaixaEtaria`, `idAno`),
  CONSTRAINT `fk_Dose_has_Pessoa_Pessoa1` FOREIGN KEY (`idPessoa`) REFERENCES `Pessoa` (`id`),
  CONSTRAINT `fk_Historico_Unidade_Saude1` FOREIGN KEY (`idUnidadeSaude`) REFERENCES `Unidade_Saude` (`id`),
  CONSTRAINT `fk_Historico_Vacina1` FOREIGN KEY (`idVacina`) REFERENCES `Vacina` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Historico`
--

LOCK TABLES `Historico` WRITE;
/*!40000 ALTER TABLE `Historico` DISABLE KEYS */;
INSERT INTO `Historico` VALUES (1,15,4,1,1,'2020-12-03',1,1),(1,15,4,3,1,'2021-01-11',1,1),(2,1,3,1,1,'2021-02-04',1,5),(2,1,3,3,1,'2021-03-12',1,5),(3,1,3,1,1,'2021-02-05',1,6),(3,1,3,3,1,'2021-03-12',1,6),(4,1,3,1,1,'2021-02-05',1,7),(4,1,3,3,1,'2021-03-12',1,7),(5,1,3,1,1,'2021-02-05',1,9),(5,1,3,3,1,'2021-03-12',1,9),(6,1,3,1,1,'2021-02-05',1,11),(6,1,3,3,1,'2021-03-13',1,11),(8,2,3,1,1,'2021-03-05',1,13),(9,2,3,1,1,'2021-03-05',1,14);
/*!40000 ALTER TABLE `Historico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Intervalo`
--

DROP TABLE IF EXISTS `Intervalo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Intervalo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `periodo` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Intervalo`
--

LOCK TABLES `Intervalo` WRITE;
/*!40000 ALTER TABLE `Intervalo` DISABLE KEYS */;
INSERT INTO `Intervalo` VALUES (1,0),(2,60),(3,180),(4,365),(5,1170),(6,1800);
/*!40000 ALTER TABLE `Intervalo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pessoa`
--

DROP TABLE IF EXISTS `Pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pessoa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `nascimento` date NOT NULL,
  `idEndereco` int NOT NULL,
  `cpf` varchar(45) NOT NULL,
  `idTelefone` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Pessoa_Endereco1_idx` (`idEndereco`),
  KEY `fk_Pessoa_Telefone1_idx` (`idTelefone`),
  CONSTRAINT `fk_Pessoa_Endereco1` FOREIGN KEY (`idEndereco`) REFERENCES `Endereco` (`id`),
  CONSTRAINT `fk_Pessoa_Telefone1` FOREIGN KEY (`idTelefone`) REFERENCES `Telefone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pessoa`
--

LOCK TABLES `Pessoa` WRITE;
/*!40000 ALTER TABLE `Pessoa` DISABLE KEYS */;
INSERT INTO `Pessoa` VALUES (1,'Maria Helena da Luz','2020-12-03',1,'11111111111',5),(2,'Tiago Hugo','1961-04-27',1,'22222222222',1),(3,'Augusto Igor','2021-01-11',2,'33333333333',2),(8,'Marcelo Teste','2020-12-11',1,'TESTECPF',5);
/*!40000 ALTER TABLE `Pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Proxima_Dose`
--

DROP TABLE IF EXISTS `Proxima_Dose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Proxima_Dose` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `idPessoa` int NOT NULL,
  `idVacinaGeral` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Proxima_Dose_Pessoa1_idx` (`idPessoa`),
  KEY `fk_Proxima_Dose_Vacina_Geral1_idx` (`idVacinaGeral`),
  CONSTRAINT `fk_Proxima_Dose_Pessoa1` FOREIGN KEY (`idPessoa`) REFERENCES `Pessoa` (`id`),
  CONSTRAINT `fk_Proxima_Dose_Vacina_Geral1` FOREIGN KEY (`idVacinaGeral`) REFERENCES `Vacina_Geral` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Proxima_Dose`
--

LOCK TABLES `Proxima_Dose` WRITE;
/*!40000 ALTER TABLE `Proxima_Dose` DISABLE KEYS */;
INSERT INTO `Proxima_Dose` VALUES (1,'2021-11-11',8,1);
/*!40000 ALTER TABLE `Proxima_Dose` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Telefone`
--

DROP TABLE IF EXISTS `Telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Telefone` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Telefone`
--

LOCK TABLES `Telefone` WRITE;
/*!40000 ALTER TABLE `Telefone` DISABLE KEYS */;
INSERT INTO `Telefone` VALUES (1,'32323232'),(2,'99885657'),(3,'32325659'),(4,'54654845'),(5,'322565945');
/*!40000 ALTER TABLE `Telefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Unidade_Saude`
--

DROP TABLE IF EXISTS `Unidade_Saude`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Unidade_Saude` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Unidade_Saude`
--

LOCK TABLES `Unidade_Saude` WRITE;
/*!40000 ALTER TABLE `Unidade_Saude` DISABLE KEYS */;
INSERT INTO `Unidade_Saude` VALUES (1,'C.S Itacorubi'),(2,'C.S Rio Tavares'),(3,'C.S Praia Comprida'),(4,'C.S Palhoça');
/*!40000 ALTER TABLE `Unidade_Saude` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vacina`
--

DROP TABLE IF EXISTS `Vacina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vacina` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idFabricante` int NOT NULL,
  `nome` varchar(45) NOT NULL,
  `doseFrasco` int NOT NULL,
  `nDose` int NOT NULL,
  `idIntervalo` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Vacina_Fabricante_idx` (`idFabricante`),
  KEY `fk_Vacina_Intervalo1_idx` (`idIntervalo`),
  CONSTRAINT `fk_Vacina_Fabricante` FOREIGN KEY (`idFabricante`) REFERENCES `Fabricante` (`id`),
  CONSTRAINT `fk_Vacina_Intervalo1` FOREIGN KEY (`idIntervalo`) REFERENCES `Intervalo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vacina`
--

LOCK TABLES `Vacina` WRITE;
/*!40000 ALTER TABLE `Vacina` DISABLE KEYS */;
INSERT INTO `Vacina` VALUES (1,1,'BCGvac',10,1,1),(2,2,'BCGvacA',10,1,1),(3,3,'BCGvacB',8,1,1),(4,1,'HEPATITEx',10,3,2),(5,3,'HEPATITEy',10,2,2),(6,4,'vacROTAVIRUS',10,2,3),(7,5,'TrípliceBIO',10,3,2),(8,2,'TrípliceVAC',10,3,2),(9,6,'HaemophilusVAC',10,3,2),(10,5,'PoliomieliteVAC',10,3,2),(11,4,'PoliomieliteVACa',8,3,2),(12,7,'PneumoVACbb',8,3,2),(13,3,'MeningoConjVAC',8,2,2),(14,2,'MeningoBvac',8,2,2),(15,4,'MeningoBvacX',10,2,2),(16,5,'influenzaA',10,1,4),(17,7,'influenzaB',10,1,4),(18,8,'febreVAC',10,2,5),(19,8,'tripliceA',8,2,4),(20,6,'tripliceB',8,2,4),(21,3,'tripliceC',8,2,4),(22,5,'VARICELAvac',8,2,2),(23,2,'vacHPV',10,2,3),(24,7,'VALENTE23vac',10,2,6),(25,6,'zosterVAC',10,1,1),(26,1,'VACdengue',8,2,3);
/*!40000 ALTER TABLE `Vacina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vacina_Doenca`
--

DROP TABLE IF EXISTS `Vacina_Doenca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vacina_Doenca` (
  `idVacina` int NOT NULL,
  `idDoenca` int NOT NULL,
  `idVacinaGeral` int NOT NULL,
  PRIMARY KEY (`idVacina`,`idDoenca`,`idVacinaGeral`),
  KEY `fk_Vacina_has_Doenca_Doenca1_idx` (`idDoenca`),
  KEY `fk_Vacina_has_Doenca_Vacina1_idx` (`idVacina`),
  KEY `fk_Vacina_Doenca_Vacina_Geral1_idx` (`idVacinaGeral`),
  CONSTRAINT `fk_Vacina_Doenca_Vacina_Geral1` FOREIGN KEY (`idVacinaGeral`) REFERENCES `Vacina_Geral` (`id`),
  CONSTRAINT `fk_Vacina_has_Doenca_Doenca1` FOREIGN KEY (`idDoenca`) REFERENCES `Doenca` (`id`),
  CONSTRAINT `fk_Vacina_has_Doenca_Vacina1` FOREIGN KEY (`idVacina`) REFERENCES `Vacina` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vacina_Doenca`
--

LOCK TABLES `Vacina_Doenca` WRITE;
/*!40000 ALTER TABLE `Vacina_Doenca` DISABLE KEYS */;
INSERT INTO `Vacina_Doenca` VALUES (1,1,1),(2,1,1),(3,1,1),(4,2,2),(5,2,2),(6,3,3),(7,4,4),(8,4,4),(7,5,4),(8,5,4),(7,6,4),(8,6,4),(9,7,5),(10,8,6),(11,8,6),(12,9,7),(12,10,7),(13,10,8),(14,10,9),(15,10,9),(12,11,7),(13,12,8),(16,13,10),(17,13,10),(18,14,11),(19,15,12),(20,15,12),(21,15,12),(19,16,12),(20,16,12),(21,16,12),(19,17,12),(20,17,12),(21,17,12),(22,18,13),(23,20,14),(24,21,15),(25,22,16),(26,23,17);
/*!40000 ALTER TABLE `Vacina_Doenca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vacina_Geral`
--

DROP TABLE IF EXISTS `Vacina_Geral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vacina_Geral` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vacina_Geral`
--

LOCK TABLES `Vacina_Geral` WRITE;
/*!40000 ALTER TABLE `Vacina_Geral` DISABLE KEYS */;
INSERT INTO `Vacina_Geral` VALUES (1,'BCG ID'),(2,'Hepatite B'),(3,'Rotavírus'),(4,'Tríplice Bacteriana'),(5,'Haemophilus influenzae b'),(6,'Poliomielite'),(7,'Pneumocócicas conjugadas'),(8,'Meningocócicas conjugadas'),(9,'Meningocócicas B'),(10,'Influenza (gripe)'),(11,'Febre amarela'),(12,'Tríplice viral'),(13,'Varicela'),(14,'HPV'),(15,'Pneumocócica 23 valente'),(16,'Herpes zóster'),(17,'Dengue');
/*!40000 ALTER TABLE `Vacina_Geral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vacinacao`
--

DROP TABLE IF EXISTS `Vacinacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vacinacao` (
  `idVacinaGeral` int NOT NULL,
  `idFaixaEtaria` int NOT NULL,
  `idAno` int NOT NULL,
  PRIMARY KEY (`idVacinaGeral`,`idFaixaEtaria`,`idAno`),
  KEY `fk_Vacina_Geral_has_Faixa_Etaria_Faixa_Etaria1_idx` (`idFaixaEtaria`),
  KEY `fk_Vacina_Geral_has_Faixa_Etaria_Vacina_Geral1_idx` (`idVacinaGeral`),
  KEY `fk_Dose_Calendario1_idx` (`idAno`),
  CONSTRAINT `fk_Dose_Calendario1` FOREIGN KEY (`idAno`) REFERENCES `Ano` (`id`),
  CONSTRAINT `fk_Vacina_Geral_has_Faixa_Etaria_Faixa_Etaria1` FOREIGN KEY (`idFaixaEtaria`) REFERENCES `Faixa_Etaria` (`id`),
  CONSTRAINT `fk_Vacina_Geral_has_Faixa_Etaria_Vacina_Geral1` FOREIGN KEY (`idVacinaGeral`) REFERENCES `Vacina_Geral` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vacinacao`
--

LOCK TABLES `Vacinacao` WRITE;
/*!40000 ALTER TABLE `Vacinacao` DISABLE KEYS */;
INSERT INTO `Vacinacao` VALUES (2,1,1),(2,1,2),(2,1,3),(2,1,4),(3,1,1),(3,1,2),(3,1,3),(3,1,4),(4,1,1),(4,1,2),(4,1,3),(4,1,4),(5,1,1),(5,1,2),(5,1,3),(5,1,4),(6,1,1),(6,1,2),(6,1,3),(6,1,4),(8,2,1),(8,2,2),(8,2,3),(8,2,4),(9,2,1),(9,2,2),(9,2,3),(9,2,4),(2,3,1),(2,3,2),(2,3,3),(2,3,4),(4,3,1),(4,3,2),(4,3,3),(4,3,4),(5,3,1),(5,3,2),(5,3,3),(5,3,4),(6,3,1),(6,3,2),(6,3,3),(6,3,4),(8,4,1),(8,4,2),(8,4,3),(8,4,4),(9,4,1),(9,4,2),(9,4,3),(9,4,4),(2,5,1),(2,5,2),(2,5,3),(2,5,4),(4,5,1),(4,5,2),(4,5,3),(4,5,4),(5,5,1),(5,5,2),(5,5,3),(5,5,4),(6,5,1),(6,5,2),(6,5,3),(6,5,4),(10,5,1),(10,5,2),(10,5,3),(10,5,4),(11,6,2),(11,6,3),(11,6,4),(7,7,1),(7,7,2),(7,7,3),(7,7,4),(12,7,2),(12,7,3),(12,7,4),(13,7,2),(13,7,3),(13,7,4),(12,8,2),(12,8,3),(12,8,4),(7,9,1),(7,9,2),(7,9,3),(7,9,4),(13,9,2),(13,9,3),(13,9,4),(14,11,2),(14,11,3),(14,11,4),(17,11,3),(17,11,4),(15,14,3),(15,14,4),(16,14,3),(16,14,4),(1,15,1),(1,15,2),(1,15,3),(1,15,4),(3,16,1),(3,16,2),(3,16,3),(3,16,4),(11,17,2),(11,17,3),(11,17,4),(14,18,2),(14,18,3),(14,18,4),(17,18,3),(17,18,4),(15,19,3),(15,19,4);
/*!40000 ALTER TABLE `Vacinacao` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-16 22:04:06
