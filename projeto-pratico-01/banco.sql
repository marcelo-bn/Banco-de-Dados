CREATE DATABASE  IF NOT EXISTS `pp01` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pp01`;
-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: localhost    Database: pp01
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
-- Table structure for table `Categoria`
--

DROP TABLE IF EXISTS `Categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`nome`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categoria`
--

LOCK TABLES `Categoria` WRITE;
/*!40000 ALTER TABLE `Categoria` DISABLE KEYS */;
INSERT INTO `Categoria` VALUES (1,'Comida'),(2,'Serviços Gerais'),(3,'Roupa'),(4,'Transporte'),(5,'Educação'),(6,'Esporte');
/*!40000 ALTER TABLE `Categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Compra`
--

DROP TABLE IF EXISTS `Compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Compra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inicio` date NOT NULL,
  `status` varchar(45) NOT NULL,
  `total` double NOT NULL,
  `formaPagamento` varchar(45) DEFAULT NULL,
  `fim` date DEFAULT NULL,
  `loginConsumidor` varchar(45) NOT NULL,
  `loginPrestador` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Compra_Consumidor1_idx` (`loginConsumidor`),
  KEY `fk_Compra_Prestador1_idx` (`loginPrestador`),
  CONSTRAINT `fk_Compra_Consumidor1` FOREIGN KEY (`loginConsumidor`) REFERENCES `Consumidor` (`login`),
  CONSTRAINT `fk_Compra_Prestador1` FOREIGN KEY (`loginPrestador`) REFERENCES `Prestador` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Compra`
--

LOCK TABLES `Compra` WRITE;
/*!40000 ALTER TABLE `Compra` DISABLE KEYS */;
INSERT INTO `Compra` VALUES (1,'2021-02-10','pendente',25.5,'dinheiro',NULL,'miguel','VEG'),(2,'2021-02-14','concluida',40,'dinheiro','2021-02-15','roberto','Lurdes'),(3,'2021-02-20','pendente',41.8,'cartao',NULL,'juliana','zecaA'),(4,'2021-02-20','concluida',250,'dinheiro','2021-02-21','miguel','mariaprof'),(5,'2021-02-21','pendente',8.8,'dinheiro',NULL,'roberto','VEG'),(6,'2021-02-20','concluida',51.8,'cartao','2021-02-20','juliana','zecaA'),(7,'2021-03-20','concluida',100,'dinheiro','2021-02-22','mariaAB','joao'),(8,'2021-03-20','pendente',250,'dinheiro',NULL,'mariaAB','joao'),(9,'2021-03-25','pendente',300,'dinheiro',NULL,'miguel','marcos'),(10,'2020-08-15','concluida',300,'dinheiro','2020-08-22','mariaAB','marcos'),(11,'2020-12-10','concluida',300,'dinheiro','2020-12-20','juliana','marcos'),(12,'2021-01-10','concluida',120,'cartao','2020-01-24','priscilaD','boxeX'),(13,'2021-01-15','pendente',130,'dinheiro',NULL,'priscilaD','raul'),(14,'2020-12-28','pendente',130,'dinheiro',NULL,'roberto','boxeX'),(15,'2020-11-15','pendente',130,'dinheiro',NULL,'miguel','boxeX'),(16,'2020-09-26','pendente',90,'cartao',NULL,'juliana','raul'),(17,'2021-03-20','pendente',90,'dinheiro',NULL,'mariaAB','academiaACAO'),(18,'2021-01-15','concluida',90,'cartao','2020-01-25','priscilaD','academiaACAO');
/*!40000 ALTER TABLE `Compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Consumidor`
--

DROP TABLE IF EXISTS `Consumidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Consumidor` (
  `numCartao` varchar(45) DEFAULT NULL,
  `login` varchar(45) NOT NULL,
  PRIMARY KEY (`login`),
  KEY `fk_Consumidor_Usuario1_idx` (`login`),
  CONSTRAINT `fk_Consumidor_Usuario1` FOREIGN KEY (`login`) REFERENCES `Usuario` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Consumidor`
--

LOCK TABLES `Consumidor` WRITE;
/*!40000 ALTER TABLE `Consumidor` DISABLE KEYS */;
INSERT INTO `Consumidor` VALUES ('8869','Juliana'),('1221','mariaAB'),('7536','miguel'),('5588','priscilaD'),('9978','roberto');
/*!40000 ALTER TABLE `Consumidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lista_Produtos`
--

DROP TABLE IF EXISTS `Lista_Produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Lista_Produtos` (
  `idCompra` int NOT NULL,
  `idProduto` int NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`idCompra`,`idProduto`),
  KEY `fk_Compra_has_Produto_Produto1_idx` (`idProduto`),
  KEY `fk_Compra_has_Produto_Compra1_idx` (`idCompra`),
  CONSTRAINT `fk_Compra_has_Produto_Compra1` FOREIGN KEY (`idCompra`) REFERENCES `Compra` (`id`),
  CONSTRAINT `fk_Compra_has_Produto_Produto1` FOREIGN KEY (`idProduto`) REFERENCES `Produto` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lista_Produtos`
--

LOCK TABLES `Lista_Produtos` WRITE;
/*!40000 ALTER TABLE `Lista_Produtos` DISABLE KEYS */;
INSERT INTO `Lista_Produtos` VALUES (1,9,1),(1,10,1),(2,6,1),(3,1,1),(3,2,1),(4,8,1),(5,10,1),(6,1,2),(7,5,1),(8,4,1),(9,16,1),(10,16,1),(11,16,1),(12,13,1),(13,14,1),(14,14,1),(15,14,1),(16,15,1),(17,11,1),(18,11,1);
/*!40000 ALTER TABLE `Lista_Produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prestador`
--

DROP TABLE IF EXISTS `Prestador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Prestador` (
  `descGeral` varchar(200) DEFAULT NULL,
  `login` varchar(45) NOT NULL,
  PRIMARY KEY (`login`),
  KEY `fk_Prestador_Usuario1_idx` (`login`),
  CONSTRAINT `fk_Prestador_Usuario1` FOREIGN KEY (`login`) REFERENCES `Usuario` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prestador`
--

LOCK TABLES `Prestador` WRITE;
/*!40000 ALTER TABLE `Prestador` DISABLE KEYS */;
INSERT INTO `Prestador` VALUES ('Musculação e Natação','academiaACAO'),('Aulas de Boxe','boxeX'),('Instalação de Ar-Condicionado.','joao'),('Costura e Bordados','Lurdes'),('Móveis planejados','marcos'),('Aulas de inglês com professora nativa!','mariaprof'),('Fretes e Mudanças','raul'),('Lanches orgânicos e veganos :)','VEG'),('O melhor bar do bairro.','zecaA');
/*!40000 ALTER TABLE `Prestador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Produto`
--

DROP TABLE IF EXISTS `Produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Produto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `preco` double NOT NULL,
  `nomeCategoria` varchar(45) NOT NULL,
  `ativo` int NOT NULL,
  `loginPrestador` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`nome`,`loginPrestador`),
  KEY `fk_Produto_Categoria1_idx` (`nomeCategoria`),
  KEY `fk_Produto_Prestador1_idx` (`loginPrestador`),
  CONSTRAINT `fk_Produto_Categoria1` FOREIGN KEY (`nomeCategoria`) REFERENCES `Categoria` (`nome`),
  CONSTRAINT `fk_Produto_Prestador1` FOREIGN KEY (`loginPrestador`) REFERENCES `Prestador` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Produto`
--

LOCK TABLES `Produto` WRITE;
/*!40000 ALTER TABLE `Produto` DISABLE KEYS */;
INSERT INTO `Produto` VALUES (1,'Porção Mista',25.9,'Comida',1,'zecaA'),(2,'Porção Batata',15.9,'Comida',1,'zecaA'),(3,'Refrigerante',5.5,'Comida',1,'zecaA'),(4,'Instalação Split',250,'Serviços Gerais',1,'joao'),(5,'Troca de gás',100,'Serviços Gerais',1,'joao'),(6,'Costura',40,'Roupa',1,'Lurdes'),(7,'Aulas inglês 2x semana',160,'Educação',1,'mariaprof'),(8,'Aulas inglês 3x semana',230,'Educação',1,'mariaprof'),(9,'Vegburguer',16.7,'Comida',1,'VEG'),(10,'Vegcake',8.8,'Comida',1,'VEG'),(11,'Musculação 2x semana',90,'Esporte',1,'academiaACAO'),(12,'Musculação 3x semana',170,'Esporte',1,'academiaACAO'),(13,'Boxe 3x semana',120,'Esporte',1,'boxeX'),(14,'Frete caminhão',130,'Transporte',1,'raul'),(15,'Frete carro',90,'Transporte',1,'raul'),(16,'Cozinha Planejada',300,'Serviços Gerais',1,'marcos');
/*!40000 ALTER TABLE `Produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tipo`
--

DROP TABLE IF EXISTS `Tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tipo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tipo`
--

LOCK TABLES `Tipo` WRITE;
/*!40000 ALTER TABLE `Tipo` DISABLE KEYS */;
INSERT INTO `Tipo` VALUES (1,'consumidor'),(2,'prestador'),(3,'admin');
/*!40000 ALTER TABLE `Tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `login` varchar(45) NOT NULL,
  `senha` varchar(45) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `telefone` varchar(45) NOT NULL,
  `endereco` varchar(45) NOT NULL,
  `tipo` int NOT NULL,
  PRIMARY KEY (`login`),
  KEY `fk_Usuario_Tipo1_idx` (`tipo`),
  CONSTRAINT `fk_Usuario_Tipo1` FOREIGN KEY (`tipo`) REFERENCES `Tipo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES ('academiaACAO','acao','Academia Ação','32345671','Rua do Movimento',2),('boxeX','xcrossfit','Boxe X','32678643','Rua X',2),('joao','4555','SplitFreeze','998565478','Rua F',2),('juliana','1452','Juliana da Silva','985847126','Rua C',1),('Lurdes','7854','Lurdes Bordados','34351619','Rua C',2),('marcos','9999','Marcenaria M','998527843','Rua da Madeira',2),('mariaAB','7788','Maria Albuquerque','98567425','Rua C',1),('mariaprof','teste45','Maria English','98567845','Rua A',2),('miguel','1234','Miguel Cabral','998620140','Rua A',1),('priscilaD','pd777','Priscila Duarte','777788899','Rua P',1),('raul','raulFretes','Fretes do Raul','32336789','Rua A',2),('roberto','5689','Roberto de Araujo','999093120','Rua D',1),('VEG','veg','Vegano Lanches','99999999','Rua v',2),('zecaA','1234','Bar do Zeca','32324545','Rua A',2);
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-21 10:49:34
