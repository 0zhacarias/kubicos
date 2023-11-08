-- --------------------------------------------------------
-- Anfitrião:                    127.0.0.1
-- Versão do servidor:           8.0.30 - MySQL Community Server - GPL
-- SO do servidor:               Win64
-- HeidiSQL Versão:              12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- A despejar estrutura da base de dados para bd_sigim
DROP DATABASE IF EXISTS `bd_sigim`;
CREATE DATABASE IF NOT EXISTS `bd_sigim` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_sigim`;

-- A despejar estrutura para tabela bd_sigim.actividade_imoveis
DROP TABLE IF EXISTS `actividade_imoveis`;
CREATE TABLE IF NOT EXISTS `actividade_imoveis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int DEFAULT NULL,
  `imoveis_id` int DEFAULT NULL,
  `operacao_imoveis_id` int DEFAULT NULL,
  `proprietario_colaborador` enum('1','2') CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `quantidade_prestacoes` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `tempo_arrendar` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_actividade_imoveis_imoveis` (`imoveis_id`),
  KEY `FK_actividade_imoveis_operacao_imoveis` (`operacao_imoveis_id`),
  KEY `FK_actividade_imoveis_clientes` (`users_id`),
  CONSTRAINT `FK_actividade_imoveis_clientes` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_actividade_imoveis_imoveis` FOREIGN KEY (`imoveis_id`) REFERENCES `imoveis` (`id`),
  CONSTRAINT `FK_actividade_imoveis_operacao_imoveis` FOREIGN KEY (`operacao_imoveis_id`) REFERENCES `operacao_imoveis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.actividade_imoveis: ~4 rows (aproximadamente)
DELETE FROM `actividade_imoveis`;
INSERT INTO `actividade_imoveis` (`id`, `users_id`, `imoveis_id`, `operacao_imoveis_id`, `proprietario_colaborador`, `quantidade_prestacoes`, `created_at`, `updated_at`, `deleted_at`, `tempo_arrendar`) VALUES
	(17, NULL, 67, 2, '1', 22, '2023-09-06 06:56:27', '2023-09-06 06:56:27', NULL, 0),
	(18, NULL, 68, 1, '2', 0, '2023-09-06 07:09:41', '2023-09-06 07:09:41', NULL, 1),
	(19, NULL, 69, 2, '1', 0, '2023-09-07 13:18:50', '2023-09-07 13:18:50', NULL, 0),
	(20, NULL, 70, 1, '2', 0, '2023-09-07 13:24:53', '2023-09-07 13:24:53', NULL, 2);

-- A despejar estrutura para tabela bd_sigim.bancos
DROP TABLE IF EXISTS `bancos`;
CREATE TABLE IF NOT EXISTS `bancos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sigla` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `numero_conta` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `iban` varchar(45) NOT NULL,
  `status` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `banco_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_bancos_clientes` (`created_by`),
  KEY `FK_bancos_users` (`updated_by`),
  CONSTRAINT `FK_bancos_clientes` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_bancos_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.bancos: ~0 rows (aproximadamente)
DELETE FROM `bancos`;

-- A despejar estrutura para tabela bd_sigim.bancos_pessoas
DROP TABLE IF EXISTS `bancos_pessoas`;
CREATE TABLE IF NOT EXISTS `bancos_pessoas` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `designacao` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `numero_conta` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '',
  `iban` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `users_id` int DEFAULT NULL,
  `sigla` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` int unsigned DEFAULT '0',
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `deleted_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_bancos_condominios` (`users_id`),
  CONSTRAINT `FK_bancos_pessoas_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.bancos_pessoas: ~0 rows (aproximadamente)
DELETE FROM `bancos_pessoas`;

-- A despejar estrutura para tabela bd_sigim.categoria_imoveis
DROP TABLE IF EXISTS `categoria_imoveis`;
CREATE TABLE IF NOT EXISTS `categoria_imoveis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `descricao` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- A despejar dados para tabela bd_sigim.categoria_imoveis: ~0 rows (aproximadamente)
DELETE FROM `categoria_imoveis`;

-- A despejar estrutura para tabela bd_sigim.condicao_imoveis
DROP TABLE IF EXISTS `condicao_imoveis`;
CREATE TABLE IF NOT EXISTS `condicao_imoveis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descricao` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int unsigned DEFAULT NULL,
  `deleted_by` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `designacao` (`designacao`) USING BTREE,
  KEY `FK_condicao_imoveis_users` (`created_by`),
  CONSTRAINT `FK_condicao_imoveis_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.condicao_imoveis: ~5 rows (aproximadamente)
DELETE FROM `condicao_imoveis`;
INSERT INTO `condicao_imoveis` (`id`, `designacao`, `descricao`, `created_by`, `updated_by`, `deleted_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Novo', NULL, NULL, NULL, NULL, '2023-01-03 17:55:21', '2023-01-03 17:55:20', NULL),
	(2, 'Em construção', NULL, NULL, NULL, NULL, '2023-01-03 17:55:27', '2023-01-03 17:55:27', NULL),
	(3, 'Renovado', NULL, NULL, NULL, NULL, '2023-01-03 17:55:35', '2023-01-03 17:55:35', NULL),
	(4, 'Para repararUsado', NULL, NULL, NULL, NULL, '2023-01-03 17:55:58', '2023-01-03 16:55:58', NULL),
	(5, 'Em construção1', NULL, NULL, NULL, NULL, '2023-01-03 17:56:17', '2023-01-03 17:56:18', NULL);

-- A despejar estrutura para tabela bd_sigim.documentacoes
DROP TABLE IF EXISTS `documentacoes`;
CREATE TABLE IF NOT EXISTS `documentacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `imoveis_id` int DEFAULT NULL,
  `tipo_domumentacoes` int DEFAULT NULL,
  `nome_arquivo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_domumentacoes` (`tipo_domumentacoes`),
  KEY `imovel_id` (`imoveis_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- A despejar dados para tabela bd_sigim.documentacoes: ~29 rows (aproximadamente)
DELETE FROM `documentacoes`;
INSERT INTO `documentacoes` (`id`, `imoveis_id`, `tipo_domumentacoes`, `nome_arquivo`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(4, 28, 1, NULL, '2023-09-04 14:43:04', '2023-09-04 14:43:04', NULL),
	(5, 28, 2, 'Croquis/UPh1gT6PNnKJVln6yxQK0ENXLuaT4JM3NbMiMr6o.png', '2023-09-04 14:43:04', '2023-09-04 14:43:04', NULL),
	(6, 29, 1, NULL, '2023-09-04 14:45:42', '2023-09-04 14:45:42', NULL),
	(7, 29, 2, 'Croquis/q2wfYTTgmf2kRnNwSbmHTvK2CH0HuTob2wzc1L43.png', '2023-09-04 14:45:42', '2023-09-04 14:45:42', NULL),
	(8, 30, 1, NULL, '2023-09-05 13:46:26', '2023-09-05 13:46:26', NULL),
	(9, 30, 2, 'Croquis/4xKL6rDdEdRswbVjEUGcAAKaXiV2LwoDmmOHI86D.jpg', '2023-09-05 13:46:26', '2023-09-05 13:46:26', NULL),
	(10, 31, 1, NULL, '2023-09-05 13:52:18', '2023-09-05 13:52:18', NULL),
	(11, 31, 2, 'Croquis/my7psfumzH9eYj0VUOkLpiSEcHIYnSVtZB6FGC4P.jpg', '2023-09-05 13:52:18', '2023-09-05 13:52:18', NULL),
	(12, 32, 1, NULL, '2023-09-05 13:53:54', '2023-09-05 13:53:54', NULL),
	(13, 32, 2, 'Croquis/edgQJgCEDccl7MLz7UDCr8QYoN9FyN3gCyDaHdH3.jpg', '2023-09-05 13:53:54', '2023-09-05 13:53:54', NULL),
	(14, 33, 1, NULL, '2023-09-05 14:01:08', '2023-09-05 14:01:08', NULL),
	(15, 33, 2, 'Croquis/4nT1YO2UesTELQFTjZhiv91CnDnQedE5iHgTuEbU.jpg', '2023-09-05 14:01:08', '2023-09-05 14:01:08', NULL),
	(16, 34, 1, NULL, '2023-09-05 14:04:54', '2023-09-05 14:04:54', NULL),
	(17, 34, 2, 'Croquis/K84sBW02RxftZRvtCruXGbj7FnybfmwKqx67aoBw.jpg', '2023-09-05 14:04:54', '2023-09-05 14:04:54', NULL),
	(18, 46, 2, 'Croquis/XGmImAltIDjVa154Z0HhacU0s2guR7HUy07WlktE.jpg', '2023-09-05 14:10:43', '2023-09-05 14:10:43', NULL),
	(19, 59, 1, NULL, '2023-09-05 15:05:32', '2023-09-05 15:05:32', NULL),
	(20, 59, 2, 'Croquis/xOrUm0iasvOt9WJiF3bJAbLS1hLhD4rd6zgE1Uc5.jpg', '2023-09-05 15:05:32', '2023-09-05 15:05:32', NULL),
	(21, 62, 1, NULL, '2023-09-06 06:52:25', '2023-09-06 06:52:25', NULL),
	(22, 62, 2, 'Croquis/T5R9BsBrHt65fvDZDc7qfFAWk6xv2dFqqU9pakkX.jpg', '2023-09-06 06:52:25', '2023-09-06 06:52:25', NULL),
	(23, 64, 1, NULL, '2023-09-06 06:53:07', '2023-09-06 06:53:07', NULL),
	(24, 64, 2, 'Croquis/c3ifvws4ISDeC4UJPiPgtAS77dyPL2LahHdNToiL.jpg', '2023-09-06 06:53:07', '2023-09-06 06:53:07', NULL),
	(25, 66, 1, NULL, '2023-09-06 06:54:37', '2023-09-06 06:54:37', NULL),
	(26, 66, 2, 'Croquis/pSvWmksv9gAvk1V4wGpObnJK0SwER9NU2YllDaFk.jpg', '2023-09-06 06:54:37', '2023-09-06 06:54:37', NULL),
	(27, 67, 1, NULL, '2023-09-06 06:56:27', '2023-09-06 06:56:27', NULL),
	(28, 67, 2, 'Croquis/ZNRPHT8Zff83lYnZpY5w8SIcMC8jhnUvRd88hqX6.jpg', '2023-09-06 06:56:27', '2023-09-06 06:56:27', NULL),
	(29, 69, 1, NULL, '2023-09-07 13:18:49', '2023-09-07 13:18:49', NULL),
	(30, 69, 2, 'Croquis/RtabecTjFtDnO4Jk8Jmdc8TiSaHYk3Gic0hzF76x.jpg', '2023-09-07 13:18:49', '2023-09-07 13:18:49', NULL),
	(31, 70, 1, NULL, '2023-09-07 13:24:53', '2023-09-07 13:24:53', NULL),
	(32, 70, 2, 'Croquis/49rB1TNmg7YWceJ8aL1aNfmNJH8Fx6ZW3q8FFrCk.jpg', '2023-09-07 13:24:53', '2023-09-07 13:24:53', NULL);

-- A despejar estrutura para tabela bd_sigim.estado_civis
DROP TABLE IF EXISTS `estado_civis`;
CREATE TABLE IF NOT EXISTS `estado_civis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `descricao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- A despejar dados para tabela bd_sigim.estado_civis: ~0 rows (aproximadamente)
DELETE FROM `estado_civis`;
INSERT INTO `estado_civis` (`id`, `designacao`, `descricao`, `created_at`, `updated_at`) VALUES
	(1, 'Solteiro', 'Solteiro', '2023-06-09 10:46:53', NULL);

-- A despejar estrutura para tabela bd_sigim.estado_imoveis
DROP TABLE IF EXISTS `estado_imoveis`;
CREATE TABLE IF NOT EXISTS `estado_imoveis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `descricao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.estado_imoveis: ~7 rows (aproximadamente)
DELETE FROM `estado_imoveis`;
INSERT INTO `estado_imoveis` (`id`, `designacao`, `descricao`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Activo', 'Activo', '2023-06-09 10:46:34', NULL, NULL),
	(2, 'Desativado', 'Desativado', '2023-09-07 08:35:41', NULL, NULL),
	(3, 'Pendente', 'Pendente', '2023-09-07 08:36:33', NULL, NULL),
	(4, 'Em visita', 'Em visita', '2023-09-07 08:37:17', NULL, NULL),
	(5, 'Em negociação', 'Em negociação', '2023-09-07 08:37:43', NULL, NULL),
	(6, 'Vendido', 'Vendido', '2023-09-07 08:38:29', NULL, NULL),
	(7, 'Arrendado', 'Arrendado', '2023-09-07 08:38:43', NULL, NULL);

-- A despejar estrutura para tabela bd_sigim.estado_pagamentos
DROP TABLE IF EXISTS `estado_pagamentos`;
CREATE TABLE IF NOT EXISTS `estado_pagamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `descricao` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `updated_by` bigint unsigned DEFAULT NULL,
  `deleted_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `designacao` (`designacao`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.estado_pagamentos: ~3 rows (aproximadamente)
DELETE FROM `estado_pagamentos`;
INSERT INTO `estado_pagamentos` (`id`, `designacao`, `descricao`, `created_by`, `updated_by`, `deleted_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Pendente', 'Pagamento Pendente', NULL, NULL, NULL, '2023-01-23 16:22:33', '2023-01-23 16:22:34', NULL),
	(2, 'Validado', 'Pagamento Validado', NULL, NULL, NULL, '2023-01-23 16:22:43', '2023-01-23 16:22:44', NULL),
	(3, 'Rejeitado', 'Pagamento Rejeitado ', NULL, NULL, NULL, '2023-01-23 16:22:51', '2023-01-23 16:22:52', NULL);

-- A despejar estrutura para tabela bd_sigim.facturas
DROP TABLE IF EXISTS `facturas`;
CREATE TABLE IF NOT EXISTS `facturas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total_preco_factura` double DEFAULT '0',
  `valor_entregue` double DEFAULT '0',
  `valor_a_pagar` double DEFAULT '0',
  `total_desconto` double DEFAULT '0',
  `total_iva` double(10,2) DEFAULT '0.00',
  `total_retencao` double DEFAULT '0',
  `total_incidencia` double DEFAULT '0',
  `troco` double DEFAULT NULL,
  `valor_extenso` varchar(345) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `codigo_moeda` varchar(50) DEFAULT NULL,
  `nome_do_cliente` varchar(145) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `telefone_cliente` varchar(145) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `nif_cliente` varchar(145) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `statusFactura` enum('1','2') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '1' COMMENT '1=>divida; 2=>Pago',
  `email_cliente` varchar(145) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `endereco_cliente` varchar(145) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `actividade_imoveis_id` int NOT NULL,
  `numeracaoFactura` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `formas_pagamento_id` int unsigned DEFAULT NULL,
  `descricao` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `estado_factura_id` int DEFAULT NULL,
  `created_by` int unsigned DEFAULT NULL,
  `updated_by` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `data_vencimento` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_facturas_user` (`created_by`) USING BTREE,
  KEY `FK_facturas_actividade_imoveis` (`actividade_imoveis_id`),
  CONSTRAINT `FK_facturas_actividade_imoveis` FOREIGN KEY (`actividade_imoveis_id`) REFERENCES `actividade_imoveis` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.facturas: ~0 rows (aproximadamente)
DELETE FROM `facturas`;

-- A despejar estrutura para tabela bd_sigim.factura_items
DROP TABLE IF EXISTS `factura_items`;
CREATE TABLE IF NOT EXISTS `factura_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `facturas_id` int DEFAULT NULL,
  `descricao_produto` varchar(50) DEFAULT NULL,
  `tipo_aquisicao_id` int unsigned DEFAULT NULL,
  `preco_servico` double DEFAULT '0',
  `quantidade` int unsigned DEFAULT '1',
  `total_preco` double DEFAULT '0',
  `desconto` double DEFAULT '0',
  `taxa_desconto` int DEFAULT '0',
  `retencao` double DEFAULT '0',
  `incidencia` double DEFAULT '0',
  `taxa_iva` int DEFAULT '0',
  `valor_iva` double(10,2) unsigned DEFAULT '0.00',
  `data_inicio` date DEFAULT NULL,
  `data_termino` date DEFAULT NULL,
  `created_by` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_factura_items_factura` (`facturas_id`) USING BTREE,
  CONSTRAINT `FK_factura_items_facturas` FOREIGN KEY (`facturas_id`) REFERENCES `facturas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.factura_items: ~0 rows (aproximadamente)
DELETE FROM `factura_items`;

-- A despejar estrutura para tabela bd_sigim.fotos_imoveis
DROP TABLE IF EXISTS `fotos_imoveis`;
CREATE TABLE IF NOT EXISTS `fotos_imoveis` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `foto` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imoveis_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_imavel_id` (`imoveis_id`) USING BTREE,
  KEY `FK_fotos_imoveis_users` (`created_by`),
  CONSTRAINT `FK_fotos_imoveis_imoveis` FOREIGN KEY (`imoveis_id`) REFERENCES `imoveis` (`id`),
  CONSTRAINT `FK_fotos_imoveis_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.fotos_imoveis: ~15 rows (aproximadamente)
DELETE FROM `fotos_imoveis`;
INSERT INTO `fotos_imoveis` (`id`, `foto`, `imoveis_id`, `created_by`, `updated_by`, `deleted_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(106, 'Foto_Multipla/M7fwhJvecvO99vYIB3OzR0j9Z2RIPS6uMjQK361X.jpg', 67, NULL, NULL, NULL, '2023-09-06 06:56:27', '2023-09-06 06:56:27', NULL),
	(107, 'Foto_Multipla/89hHV9eD9AzUxVVtQa4795xyCVijr8Wl1JERE6Uw.jpg', 67, NULL, NULL, NULL, '2023-09-06 06:56:27', '2023-09-06 06:56:27', NULL),
	(108, 'Foto_Multipla/njDFE08VEPe0w5Idq9vMKhxLjFIIMwNjDQLzr9Z2.jpg', 67, NULL, NULL, NULL, '2023-09-06 06:56:27', '2023-09-06 06:56:27', NULL),
	(109, 'Foto_Multipla/lXFQ0t6cefuDZYW7brMTZ1Ts2UvXCBKNnxVFEeHM.jpg', 67, NULL, NULL, NULL, '2023-09-06 06:56:27', '2023-09-06 06:56:27', NULL),
	(110, 'Foto_Multipla/yPWX9RcV8hWmrIlMYuJVUH1UdTHIXvGpf8qTc4Dd.jpg', 68, NULL, NULL, NULL, '2023-09-06 07:09:41', '2023-09-06 07:09:41', NULL),
	(111, 'Foto_Multipla/Kk4BfWcwSn5ILke6gO3yqeIt4VJwykRedQekb3eV.jpg', 68, NULL, NULL, NULL, '2023-09-06 07:09:41', '2023-09-06 07:09:41', NULL),
	(112, 'Foto_Multipla/Rzs97LreF2EQGmb613x5fd0bqBgHiXcHUyZByzJY.jpg', 68, NULL, NULL, NULL, '2023-09-06 07:09:41', '2023-09-06 07:09:41', NULL),
	(113, 'Foto_Multipla/42u22RpF83Wpau3lVGhWOCLZbfSk7XrJThpNsUGR.jpg', 68, NULL, NULL, NULL, '2023-09-06 07:09:41', '2023-09-06 07:09:41', NULL),
	(114, 'Foto_Multipla/VXiO7YUFKNiIod3orwiB4xEYhZmkbPC61zdre14a.jpg', 69, NULL, NULL, NULL, '2023-09-07 13:18:50', '2023-09-07 13:18:50', NULL),
	(115, 'Foto_Multipla/cWpoFognvoBVp2xCJ51By6TDbiD8HUsS0thLq5fk.jpg', 69, NULL, NULL, NULL, '2023-09-07 13:18:50', '2023-09-07 13:18:50', NULL),
	(116, 'Foto_Multipla/xK9mKJHMQYWNiSoGL4uSLXR6gWc5SX9PoEWC30f2.jpg', 69, NULL, NULL, NULL, '2023-09-07 13:18:50', '2023-09-07 13:18:50', NULL),
	(117, 'Foto_Multipla/WRzAOIh23mfciS8Qfx1PNa4QcjdOWWUf1fwxxvpx.jpg', 69, NULL, NULL, NULL, '2023-09-07 13:18:50', '2023-09-07 13:18:50', NULL),
	(118, 'Foto_Multipla/iHkZlRE9RFY6slWmTVDHSJHxTlN2dTH9CHP4i1ip.jpg', 70, NULL, NULL, NULL, '2023-09-07 13:24:53', '2023-09-07 13:24:53', NULL),
	(119, 'Foto_Multipla/PXnGJQTzROEFfDiBzWFmwVApzimdQSqRad5HySJn.jpg', 70, NULL, NULL, NULL, '2023-09-07 13:24:53', '2023-09-07 13:24:53', NULL),
	(120, 'Foto_Multipla/X3FIvwiOtEAxDSGYhlTyzt3CGNrkWru4SgBqmwWE.jpg', 70, NULL, NULL, NULL, '2023-09-07 13:24:53', '2023-09-07 13:24:53', NULL),
	(121, 'Foto_Multipla/uEZQOJXG7zsFreoDvQYlRxXMZXVaOnMslgDBFYtf.jpg', 70, NULL, NULL, NULL, '2023-09-07 13:24:53', '2023-09-07 13:24:53', NULL);

-- A despejar estrutura para tabela bd_sigim.generos
DROP TABLE IF EXISTS `generos`;
CREATE TABLE IF NOT EXISTS `generos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(50) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `descricao` varchar(50) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- A despejar dados para tabela bd_sigim.generos: ~0 rows (aproximadamente)
DELETE FROM `generos`;

-- A despejar estrutura para tabela bd_sigim.imobiliaria
DROP TABLE IF EXISTS `imobiliaria`;
CREATE TABLE IF NOT EXISTS `imobiliaria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `designacao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nif` varchar(50) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `criado_por` int DEFAULT NULL,
  `apagado_por` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_imobiliaria_imobiliaria` (`criado_por`),
  CONSTRAINT `FK_imobiliaria_imobiliaria` FOREIGN KEY (`criado_por`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.imobiliaria: ~0 rows (aproximadamente)
DELETE FROM `imobiliaria`;

-- A despejar estrutura para tabela bd_sigim.imoveis
DROP TABLE IF EXISTS `imoveis`;
CREATE TABLE IF NOT EXISTS `imoveis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `descricao` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cozinha` int DEFAULT NULL,
  `mobiliado_id` int DEFAULT NULL,
  `suite` int DEFAULT NULL,
  `sala_de_estar` int DEFAULT NULL,
  `numero_banheiro` int DEFAULT NULL,
  `metros` int DEFAULT NULL,
  `preco` int DEFAULT NULL,
  `tempo_arrendar` int DEFAULT NULL,
  `lote` int DEFAULT NULL,
  `operacao_imoveis_id` int DEFAULT NULL,
  `estado_imoveis_id` int DEFAULT '3',
  `tipologia_imoveis_id` int DEFAULT NULL,
  `categoria_imoveis_id` int DEFAULT NULL,
  `cadastrado_por` int DEFAULT NULL,
  `publicado_por` int DEFAULT NULL,
  `tipo_documentacoes_id` int DEFAULT NULL,
  `condicao_imoveis_id` int DEFAULT NULL,
  `tanqueagua` int DEFAULT NULL,
  `regeitado_por` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `localizacao` varchar(250) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `imposto_predial` int DEFAULT NULL,
  `ginasio` int DEFAULT NULL,
  `gerador` int DEFAULT NULL,
  `piscina` int DEFAULT NULL,
  `churrasqueira` int DEFAULT NULL,
  `maquina_lavar_roupa` int DEFAULT NULL,
  `numero_garagem` int DEFAULT NULL,
  `mesa_cadeira` int DEFAULT NULL,
  `arcondicionados` int DEFAULT NULL,
  `armario_embutido` int DEFAULT NULL,
  `mobiliado` enum('TRUE','FALSE') COLLATE latin1_bin DEFAULT NULL,
  `provincia_id` int DEFAULT NULL,
  `foto_principal` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_imoveis_categoria_imoveis` (`categoria_imoveis_id`),
  KEY `FK_imoveis_tipologia_imoveis` (`tipologia_imoveis_id`),
  KEY `FK_imoveis_prorietario` (`cadastrado_por`),
  KEY `FK_imoveis_funcionarios` (`publicado_por`),
  KEY `FK_imoveis_operacao_imoveis` (`operacao_imoveis_id`),
  KEY `FK_imoveis_condicao_imoveis` (`condicao_imoveis_id`),
  KEY `FK_imoveis_tipo_documentacoes` (`tipo_documentacoes_id`),
  KEY `FK_imoveis_estado_imoveis` (`estado_imoveis_id`),
  CONSTRAINT `FK_imoveis_categoria_imoveis` FOREIGN KEY (`categoria_imoveis_id`) REFERENCES `categoria_imoveis` (`id`),
  CONSTRAINT `FK_imoveis_condicao_imoveis` FOREIGN KEY (`condicao_imoveis_id`) REFERENCES `condicao_imoveis` (`id`),
  CONSTRAINT `FK_imoveis_estado_imoveis` FOREIGN KEY (`estado_imoveis_id`) REFERENCES `estado_imoveis` (`id`),
  CONSTRAINT `FK_imoveis_tipo_documentacoes` FOREIGN KEY (`tipo_documentacoes_id`) REFERENCES `tipo_documentacoes` (`id`),
  CONSTRAINT `FK_imoveis_tipologia_imoveis` FOREIGN KEY (`tipologia_imoveis_id`) REFERENCES `tipologia_imoveis` (`id`),
  CONSTRAINT `FK_imoveis_users` FOREIGN KEY (`publicado_por`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_imoveis_users_2` FOREIGN KEY (`operacao_imoveis_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_imoveis_users_3` FOREIGN KEY (`cadastrado_por`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- A despejar dados para tabela bd_sigim.imoveis: ~56 rows (aproximadamente)
DELETE FROM `imoveis`;
INSERT INTO `imoveis` (`id`, `designacao`, `descricao`, `cozinha`, `mobiliado_id`, `suite`, `sala_de_estar`, `numero_banheiro`, `metros`, `preco`, `tempo_arrendar`, `lote`, `operacao_imoveis_id`, `estado_imoveis_id`, `tipologia_imoveis_id`, `categoria_imoveis_id`, `cadastrado_por`, `publicado_por`, `tipo_documentacoes_id`, `condicao_imoveis_id`, `tanqueagua`, `regeitado_por`, `created_at`, `updated_at`, `deleted_at`, `localizacao`, `imposto_predial`, `ginasio`, `gerador`, `piscina`, `churrasqueira`, `maquina_lavar_roupa`, `numero_garagem`, `mesa_cadeira`, `arcondicionados`, `armario_embutido`, `mobiliado`, `provincia_id`, `foto_principal`) VALUES
	(1, 'Apartamento de luxo T5', 'Apartamento compacto e bem projetado, perfeito para solteiros ou casais. Com um conceito aberto, este imóvel possui uma cozinha equipada, um quarto aconchegante e uma varanda privativa com vista para a cidade. Localizado em uma área animada, oferece fácil acesso a restaurantes e áreas de lazer.', 3, 1, 1, 1, NULL, NULL, 100000000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 'Encantadora casa de campo com estilo rústico', 'Encantadora casa de campo com estilo rústico, situada em um ambiente tranquilo e arborizado. Esta residência possui 3 quartos espaçosos, uma acolhedora lareira na sala de estar e uma cozinha moderna e equipada. O amplo jardim proporciona espaço para entretenimento ao ar livre, enquanto uma varanda coberta oferece um refúgio relaxante para apreciar a natureza.', 2, 1, 1, 1, NULL, NULL, 2300000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 'Apartamento contemporâneo localizado no coração da cidade Benguela', 'Apartamento contemporâneo localizado no coração da cidade, com vistas panorâmicas deslumbrantes do horizonte urbano. Possui um design elegante e acabamentos de alta qualidade. Com 2 quartos e uma sala de estar aberta, este imóvel é ideal para quem busca o estilo de vida cosmopolita e acesso fácil a comércio e transporte.', 1, 1, 1, 1, NULL, NULL, 400000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 'Apartamento de luxo em um prédio exclusivo', 'Magnífica mansão em uma localização privilegiada, com acesso privativo a uma praia de areias brancas. Esta propriedade de luxo conta com 5 suítes espaçosas, um cinema em casa, uma piscina infinita e um spa privativo. Cada detalhe foi cuidadosamente projetado para oferecer conforto e sofisticação em um ambiente paradisíaco.', 2, 1, 1, 1, NULL, NULL, 6000000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 'Casa moderna e sustentável', 'Apartamento compacto e bem projetado, perfeito para solteiros ou casais. Com um conceito aberto, este imóvel possui uma cozinha equipada, um quarto aconchegante e uma varanda privativa com vista para a cidade. Localizado em uma área animada, oferece fácil acesso a restaurantes e áreas de lazer.', 1, 1, 1, 1, NULL, NULL, 800000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(6, 'Elegante casa colonial,', 'Elegante casa colonial, cercada por um exuberante jardim paisagístico. Com 4 quartos espaçosos, uma biblioteca e uma piscina privativa, esta propriedade é um oásis de tranquilidade em meio à agitação da cidade. A decoração clássica e os acabamentos de alta qualidade dão um toque de requinte a cada ambiente.', 3, 1, 1, 1, NULL, NULL, 400000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(7, 'Apartamento contemporâneo localizado no coração da cidade Lubito', 'Apartamento contemporâneo localizado no coração da cidade, com vistas panorâmicas deslumbrantes do horizonte urbano. Possui um design elegante e acabamentos de alta qualidade. Com 2 quartos e uma sala de estar aberta, este imóvel é ideal para quem busca o estilo de vida cosmopolita e acesso fácil a comércio e transporte.', 2, 1, 1, 1, NULL, NULL, 800000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 'Apartamento de luxo em um prédio exclusivo', 'Magnífica mansão em uma localização privilegiada, com acesso privativo a uma praia de areias brancas. Esta propriedade de luxo conta com 5 suítes espaçosas, um cinema em casa, uma piscina infinita e um spa privativo. Cada detalhe foi cuidadosamente projetado para oferecer conforto e sofisticação em um ambiente paradisíaco.', 2, 1, 1, 1, NULL, NULL, 400000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 'Casa moderna e sustentável', 'Aconchegante casa de família em um bairro tranquilo e seguro, com proximidade a escolas e parques. Com 4 quartos, uma sala de jogos e um amplo quintal, esta residência é perfeita para uma família que valoriza conforto e lazer. A varanda da frente é ideal para relaxar e apreciar o pôr do sol.', 1, 1, 1, 1, NULL, NULL, 800000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 'Chalé ', 'Charmoso chalé de montanha, com vista para picos nevados e ar puro. Esta propriedade acolhedora possui 2 quartos, uma lareira tradicional e uma ampla varanda para apreciar a paisagem. Ideal para os amantes da natureza e dos esportes de inverno.', 1, 1, 1, 1, NULL, NULL, 400000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(11, 'Apartamento contemporâneo localizado no coração da cidade Menongue', 'Apartamento contemporâneo localizado no coração da cidade, com vistas panorâmicas deslumbrantes do horizonte urbano. Possui um design elegante e acabamentos de alta qualidade. Com 2 quartos e uma sala de estar aberta, este imóvel é ideal para quem busca o estilo de vida cosmopolita e acesso fácil a comércio e transporte.', 1, 1, 1, 1, NULL, NULL, 500000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(12, 'T3', 'Aconchegante casa de família em um bairro tranquilo e seguro, com proximidade a escolas e parques. Com 4 quartos, uma sala de jogos e um amplo quintal, esta residência é perfeita para uma família que valoriza conforto e lazer. A varanda da frente é ideal para relaxar e apreciar o pôr do sol.', 1, 1, 1, 1, NULL, NULL, 100000000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(13, 'Casa moderna e sustentável', 'Apartamento de luxo em um prédio exclusivo com serviços de concierge e segurança 24 horas. Com uma elegante suíte master, cozinha gourmet e uma espaçosa área de estar, este imóvel é um refúgio perfeito para os apreciadores do bom gosto e da comodidade de viver no coração da cidade.', 2, 1, 1, 1, NULL, NULL, 2300000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(14, 'Loft contemporâneo com estilo industrial', 'Loft contemporâneo com estilo industrial, localizado em um bairro revitalizado. Possui uma área aberta com tijolos expostos, tetos altos e grandes janelas que proporcionam muita luz natural. Esse imóvel é perfeito para os amantes de um espaço moderno e único para viver e trabalhar', 1, 1, 1, 1, NULL, NULL, 800000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(15, 'Casa moderna e sustentável', 'Aconchegante casa de família em um bairro tranquilo e seguro, com proximidade a escolas e parques. Com 4 quartos, uma sala de jogos e um amplo quintal, esta residência é perfeita para uma família que valoriza conforto e lazer. A varanda da frente é ideal para relaxar e apreciar o pôr do sol.', 2, 1, 1, 1, NULL, NULL, 2300000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(16, 'Apartamento compacto e bem projetadoApartamento compacto e bem projetado', 'Encantadora casa de campo com estilo rústico, situada em um ambiente tranquilo e arborizado. Esta residência possui 3 quartos espaçosos, uma acolhedora lareira na sala de estar e uma cozinha moderna e equipada. O amplo jardim proporciona espaço para entretenimento ao ar livre, enquanto uma varanda coberta oferece um refúgio relaxante para apreciar a natureza.', 1, 1, 1, 1, NULL, NULL, 2300000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:47', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(17, 'Apartamento de luxo em um prédio exclusivo', 'Apartamento de luxo em um prédio exclusivo com serviços de concierge e segurança 24 horas. Com uma elegante suíte master, cozinha gourmet e uma espaçosa área de estar, este imóvel é um refúgio perfeito para os apreciadores do bom gosto e da comodidade de viver no coração da cidade.', 1, 1, 1, 1, NULL, NULL, 800000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(18, 'Charmoso chalé de montanha', 'Charmoso chalé de montanha, com vista para picos nevados e ar puro. Esta propriedade acolhedora possui 2 quartos, uma lareira tradicional e uma ampla varanda para apreciar a paisagem. Ideal para os amantes da natureza e dos esportes de inverno.', 2, 1, 1, 1, NULL, NULL, 400000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 15:58:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(19, 'Apartamento compacto e bem projetado', 'Encantadora casa de campo com estilo rústico, situada em um ambiente tranquilo e arborizado. Esta residência possui 3 quartos espaçosos, uma acolhedora lareira na sala de estar e uma cozinha moderna e equipada. O amplo jardim proporciona espaço para entretenimento ao ar livre, enquanto uma varanda coberta oferece um refúgio relaxante para apreciar a natureza.', 2, 1, 1, 1, NULL, NULL, 2300000, 1, 1, 403, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-06-09 10:49:58', NULL, '2023-09-05 16:02:39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(24, 'eee', 'eee', 1, 1, 1, 1, 1, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-15 14:59:42', '2023-08-15 14:59:42', '2023-09-05 16:02:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(25, 'eee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-16 15:13:07', '2023-08-16 15:13:07', '2023-09-05 16:02:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(26, 'eee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-16 15:15:52', '2023-08-16 15:15:52', '2023-09-05 16:02:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(27, 'eee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-08-16 15:16:22', '2023-08-16 15:16:22', '2023-09-05 16:02:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(28, 'Uma casa com 3 quartos uma cozinha, casa com pscina', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-04 14:43:04', '2023-09-04 14:43:04', '2023-09-05 16:02:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(29, 'Uma casa com 3 quartos uma cozinha, casa com pscina', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-04 14:45:42', '2023-09-04 14:45:42', '2023-09-05 16:02:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(30, 'ddddddddd', NULL, 1, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 13:46:25', '2023-09-05 13:46:25', '2023-09-05 16:02:43', 'ddddd', 32323, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(31, 'ddddddddd', NULL, 1, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 13:52:18', '2023-09-05 13:52:18', '2023-09-05 16:02:47', 'ddddd', 32323, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(32, 'ddddddddd', NULL, 1, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 13:53:54', '2023-09-05 13:53:54', '2023-09-05 16:02:47', 'ddddd', 32323, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(33, 'dd', NULL, 1, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:01:08', '2023-09-05 14:01:08', '2023-09-05 16:02:48', 'ddd', NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(34, 'dd', NULL, 1, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:04:54', '2023-09-05 14:04:54', '2023-09-05 16:02:49', 'ddd', NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(35, '333', NULL, 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:05:44', '2023-09-05 14:05:44', '2023-09-05 16:02:49', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(36, '333', NULL, 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:05:49', '2023-09-05 14:05:49', '2023-09-05 16:02:49', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(37, '333', NULL, 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:06:24', '2023-09-05 14:06:24', '2023-09-05 16:02:52', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(38, '333', NULL, 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:06:24', '2023-09-05 14:06:24', '2023-09-05 16:04:04', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(39, '333', NULL, 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:06:25', '2023-09-05 14:06:25', '2023-09-05 16:04:04', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(40, '333', NULL, 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:06:25', '2023-09-05 14:06:25', '2023-09-05 16:04:05', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(41, '333', 'fffffffffffffffff', 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:06:25', '2023-09-05 14:06:25', '2023-09-05 16:04:06', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(42, '333', 'fffffffffffffffff', 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:06:26', '2023-09-05 14:06:26', '2023-09-05 16:04:05', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(43, '333', 'fffffffffffffffff', 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:06:30', '2023-09-05 14:06:30', '2023-09-05 16:04:06', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(44, '333', 'fffffffffffffffff', 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:06:44', '2023-09-05 14:06:44', '2023-09-05 16:04:07', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(45, '333', 'fffffffffffffffff', 1, NULL, 0, NULL, 0, NULL, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:09:00', '2023-09-05 14:09:00', '2023-09-05 16:04:08', '33', 333, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'TRUE', NULL, NULL),
	(46, 'fffffffffffffffff', 'fffffffffffffffff', 3, NULL, 2, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-05 14:10:43', '2023-09-05 14:10:43', '2023-09-05 16:04:08', 'ffffffffffffffff', NULL, 1, 1, 1, 1, 1, 3, 1, 1, 1, 'TRUE', NULL, NULL),
	(47, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:11:13', '2023-09-05 14:11:13', '2023-09-05 16:04:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(48, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:11:16', '2023-09-05 14:11:16', '2023-09-05 16:04:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(49, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:11:27', '2023-09-05 14:11:27', '2023-09-05 16:04:10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(50, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:12:47', '2023-09-05 14:12:47', '2023-09-05 16:04:10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(51, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:13:13', '2023-09-05 14:13:13', '2023-09-05 16:04:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(52, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:13:35', '2023-09-05 14:13:35', '2023-09-05 16:04:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(53, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:14:06', '2023-09-05 14:14:06', '2023-09-05 16:04:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(54, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:14:37', '2023-09-05 14:14:37', '2023-09-05 16:04:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(55, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:14:48', '2023-09-05 14:14:48', '2023-09-05 16:04:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(56, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:15:29', '2023-09-05 14:15:29', '2023-09-05 16:04:13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(57, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-05 14:15:32', '2023-09-05 14:15:32', '2023-09-05 16:04:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL),
	(58, 'fffffffffffffffff', 'fffffffffffffffff', 0, NULL, 0, NULL, 0, 50000, 50000, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, 2, NULL, NULL, '2023-09-05 14:16:10', '2023-09-05 14:16:10', NULL, 'Malanje', NULL, 1, 1, 1, 0, 0, 0, 0, 0, 0, 'TRUE', NULL, 'Foto_principal/e25cjQd85D4mMog3WXtRiCxKBbFKxhO1VKq9cF50.jpg'),
	(67, 'Casa moderna e sustentável', 'Casa moderna e sustentável', 2, NULL, 2, NULL, NULL, 100, 5, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-06 06:56:27', '2023-09-06 06:56:27', NULL, 'Casa moderna e sustentável', 222, 1, 1, 1, 1, 1, 2, 1, 1, 1, 'TRUE', NULL, 'Foto_principal/e25cjQd85D4mMog3WXtRiCxKBbFKxhO1VKq9cF50.jpg'),
	(68, 'Moradia V6 na Samba', 'Moradia V6 na Samba', 1, NULL, 1, NULL, 1, 90, 50000, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, '2023-09-06 07:09:41', '2023-09-06 07:09:41', NULL, 'samba', 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 'FALSE', 1, 'Foto_principal/iEpkFme5yaiLmrn1w5J2nTYVVcsyNfhKISuws4Ml.jpg'),
	(69, 'Esta casa exite a noventas anos tem 20 quartos', 'Esta casa exite a noventas anos tem 20 quartos', 4, NULL, 20, NULL, 6, 9000, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2023-09-07 13:18:49', '2023-09-07 13:18:49', NULL, 'Belo monte', NULL, NULL, 1, 0, 1, 1, 5, 1, 1, NULL, 'TRUE', 2, 'Foto_principal/hFE7eUSSgG4rMkIII9zhYyO5Z5AjZkoc45kpPmqp.jpg'),
	(70, 'Casa arrendado no municipio de luanda', 'Casa arrendado no municipio de luanda', 2, NULL, 2, NULL, 2, 966, 90000, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2023-09-07 13:24:53', '2023-09-07 13:24:53', NULL, 'Belo horizonte', NULL, NULL, NULL, NULL, NULL, NULL, 2, 1, 1, NULL, 'TRUE', 1, 'Foto_principal/QvztcsBKfTCEKELAER88Vk4LM2BAG5Ej0IGeiH3g.jpg');

-- A despejar estrutura para tabela bd_sigim.municipios
DROP TABLE IF EXISTS `municipios`;
CREATE TABLE IF NOT EXISTS `municipios` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `designacao` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `provincia_id` int unsigned DEFAULT NULL,
  `valor_entrega` double NOT NULL DEFAULT '5000',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_municipios_provincia_id` (`provincia_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.municipios: ~9 rows (aproximadamente)
DELETE FROM `municipios`;
INSERT INTO `municipios` (`id`, `designacao`, `provincia_id`, `valor_entrega`, `created_at`, `updated_at`, `deleted_at`, `status_id`) VALUES
	(1, 'Icolo-e-Bengo', 1, 5000, '2023-09-01 15:23:51', '2023-09-01 15:30:56', NULL, 1),
	(2, 'Luanda', 1, 4000, '2023-09-01 15:24:42', '2023-09-01 15:53:41', NULL, 1),
	(3, 'Quiçama', 1, 3000, '2023-09-01 15:24:49', '2023-09-01 15:53:47', NULL, 1),
	(4, 'Cacuaco', 1, 2000, '2023-09-01 15:24:56', '2023-09-01 15:53:50', NULL, 1),
	(5, 'Cazenga', 1, 1000, '2023-09-01 15:25:04', '2023-09-01 15:53:53', NULL, 1),
	(6, 'Viana', 1, 6000, '2023-09-01 15:25:11', '2023-09-01 15:53:57', NULL, 1),
	(7, 'Belas', 1, 0, '2023-09-01 15:25:18', '2023-09-01 15:53:59', NULL, 1),
	(8, 'Kilamba Kiaxi', 1, 0, '2023-09-01 15:25:27', '2023-09-01 15:54:00', NULL, 1),
	(9, 'Talatona', 1, 7000, '2023-09-01 15:25:34', '2023-09-01 15:54:06', NULL, 1);

-- A despejar estrutura para tabela bd_sigim.operacao_imoveis
DROP TABLE IF EXISTS `operacao_imoveis`;
CREATE TABLE IF NOT EXISTS `operacao_imoveis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(50) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- A despejar dados para tabela bd_sigim.operacao_imoveis: ~2 rows (aproximadamente)
DELETE FROM `operacao_imoveis`;
INSERT INTO `operacao_imoveis` (`id`, `designacao`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Venda', '2023-09-05 15:07:56', NULL, NULL),
	(2, 'Arrendamento', '2023-09-05 15:08:05', NULL, NULL),
	(3, 'Compra', '2023-09-05 15:08:14', NULL, NULL);

-- A despejar estrutura para tabela bd_sigim.pagamentos
DROP TABLE IF EXISTS `pagamentos`;
CREATE TABLE IF NOT EXISTS `pagamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `n_operacao_bancaria` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `n_operacao_bancaria2` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `obs` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `motivo_regeicao` varchar(256) DEFAULT NULL,
  `motivo_regeicao_id` int unsigned DEFAULT NULL,
  `total_geral` decimal(10,2) DEFAULT NULL,
  `data_banco` date DEFAULT NULL,
  `forma_de_pagamento_id` bigint DEFAULT NULL,
  `valor_depositado` decimal(10,2) NOT NULL,
  `control_banco_condominio_id` int unsigned DEFAULT NULL,
  `data_registo` datetime DEFAULT NULL,
  `facturas_id` int DEFAULT NULL,
  `next` varchar(50) DEFAULT NULL,
  `tipo_documento_factura_id` int unsigned DEFAULT NULL,
  `estado_pagamento_id` int DEFAULT NULL,
  `motivo_rejeicao_id` int unsigned DEFAULT NULL,
  ` rejeitado_by` int unsigned DEFAULT NULL,
  `validado_by` int unsigned DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `deleted_by` int unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `anexo` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `n_operacao_bancaria` (`n_operacao_bancaria`) USING BTREE,
  UNIQUE KEY `n_operacao_bancaria2` (`n_operacao_bancaria2`),
  KEY `FK_pagamentos_facturas` (`facturas_id`),
  KEY `FK_pagamentos_estado_pagamentos` (`estado_pagamento_id`),
  KEY `FK_pagamentos_users` (`created_by`),
  CONSTRAINT `FK_pagamentos_estado_pagamentos` FOREIGN KEY (`estado_pagamento_id`) REFERENCES `estado_pagamentos` (`id`),
  CONSTRAINT `FK_pagamentos_facturas` FOREIGN KEY (`facturas_id`) REFERENCES `facturas` (`id`),
  CONSTRAINT `FK_pagamentos_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.pagamentos: ~0 rows (aproximadamente)
DELETE FROM `pagamentos`;

-- A despejar estrutura para tabela bd_sigim.pagamento_corretores
DROP TABLE IF EXISTS `pagamento_corretores`;
CREATE TABLE IF NOT EXISTS `pagamento_corretores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` int DEFAULT NULL,
  `factura_id` int DEFAULT NULL,
  `actividade_imoveis_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_operacao_imoveis_imoveis` (`factura_id`),
  KEY `FK_pagamento_corretores_actividade_imoveis` (`actividade_imoveis_id`),
  CONSTRAINT `FK_pagamento_corretores_actividade_imoveis` FOREIGN KEY (`actividade_imoveis_id`) REFERENCES `actividade_imoveis` (`id`),
  CONSTRAINT `FK_pagamento_corretores_facturas` FOREIGN KEY (`factura_id`) REFERENCES `facturas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.pagamento_corretores: ~0 rows (aproximadamente)
DELETE FROM `pagamento_corretores`;

-- A despejar estrutura para tabela bd_sigim.pessoas
DROP TABLE IF EXISTS `pessoas`;
CREATE TABLE IF NOT EXISTS `pessoas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sobre_nome` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `data_nascimento` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `numero_telefone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `numero_identificacao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `foto` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `estado_civis_id` int DEFAULT NULL,
  `genero_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `tipo_documentacoes_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pessoas_users` (`user_id`),
  KEY `FK_pessoas_generos` (`genero_id`),
  KEY `FK_pessoas_estado_civis` (`estado_civis_id`),
  KEY `FK_pessoas_tipo_documentacoes` (`tipo_documentacoes_id`),
  CONSTRAINT `FK_pessoas_estado_civis` FOREIGN KEY (`estado_civis_id`) REFERENCES `estado_civis` (`id`),
  CONSTRAINT `FK_pessoas_generos` FOREIGN KEY (`genero_id`) REFERENCES `generos` (`id`),
  CONSTRAINT `FK_pessoas_tipo_documentacoes` FOREIGN KEY (`tipo_documentacoes_id`) REFERENCES `tipo_documentacoes` (`id`),
  CONSTRAINT `FK_pessoas_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- A despejar dados para tabela bd_sigim.pessoas: ~0 rows (aproximadamente)
DELETE FROM `pessoas`;

-- A despejar estrutura para tabela bd_sigim.provincias
DROP TABLE IF EXISTS `provincias`;
CREATE TABLE IF NOT EXISTS `provincias` (
  `id` int unsigned NOT NULL DEFAULT '0',
  `designacao` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.provincias: ~18 rows (aproximadamente)
DELETE FROM `provincias`;
INSERT INTO `provincias` (`id`, `designacao`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Luanda', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(2, 'Zaire', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(3, 'Uige', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(4, 'Cabinda', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(5, 'Bengo', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(6, 'Malanje', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(7, 'Kwanza Norte', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(8, 'Lunda Norte', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(9, 'Lunda Sul', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(10, 'Moxico', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(11, 'Bie', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(12, 'Huambo', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(13, 'Benguela', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(14, 'Kwanza Sul', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(15, 'Cuango Cubango', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(16, 'Huila', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(17, 'Namibe', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL),
	(18, 'Cunene', '2022-02-11 05:03:03', '2022-02-11 05:03:03', NULL);

-- A despejar estrutura para tabela bd_sigim.solicitar_visitas
DROP TABLE IF EXISTS `solicitar_visitas`;
CREATE TABLE IF NOT EXISTS `solicitar_visitas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(255) COLLATE latin1_bin DEFAULT NULL,
  `actividade_imoveis_id` int DEFAULT NULL,
  `imoveis_id` int DEFAULT NULL,
  `funcionarios_id` int DEFAULT NULL,
  `users_id` int DEFAULT NULL,
  `data_visita` date DEFAULT NULL,
  `hora_visita` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_solicitar_visitas_actividade_imoveis` (`actividade_imoveis_id`),
  KEY `FK_solicitar_visitas_funcionarios` (`funcionarios_id`),
  KEY `FK_solicitar_visitas_imoveis` (`imoveis_id`),
  KEY `FK_solicitar_visitas_users` (`users_id`),
  CONSTRAINT `FK_solicitar_visitas_actividade_imoveis` FOREIGN KEY (`actividade_imoveis_id`) REFERENCES `actividade_imoveis` (`id`),
  CONSTRAINT `FK_solicitar_visitas_funcionarios` FOREIGN KEY (`funcionarios_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_solicitar_visitas_imoveis` FOREIGN KEY (`imoveis_id`) REFERENCES `imoveis` (`id`),
  CONSTRAINT `FK_solicitar_visitas_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.solicitar_visitas: ~3 rows (aproximadamente)
DELETE FROM `solicitar_visitas`;
INSERT INTO `solicitar_visitas` (`id`, `designacao`, `actividade_imoveis_id`, `imoveis_id`, `funcionarios_id`, `users_id`, `data_visita`, `hora_visita`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(2, NULL, 18, 68, NULL, NULL, '2023-09-23', '17:25:00', '2023-09-07 12:28:29', '2023-09-07 12:28:29', NULL),
	(3, 'ver sdd', 20, 70, NULL, NULL, '2023-09-15', '15:20:00', '2023-09-07 13:34:03', '2023-09-07 13:34:03', NULL),
	(4, NULL, 19, 69, NULL, NULL, '2023-09-07', '22:15:00', '2023-09-07 14:34:50', '2023-09-07 14:34:50', NULL);

-- A despejar estrutura para tabela bd_sigim.tipologia_imoveis
DROP TABLE IF EXISTS `tipologia_imoveis`;
CREATE TABLE IF NOT EXISTS `tipologia_imoveis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `designacao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tipo_imoveis_id` int DEFAULT NULL,
  `criado_por` int DEFAULT NULL,
  `apagado_por` int DEFAULT NULL,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tipologia_imoveis_tipo_imoveis` (`tipo_imoveis_id`),
  CONSTRAINT `FK_tipologia_imoveis_tipo_imoveis` FOREIGN KEY (`tipo_imoveis_id`) REFERENCES `tipo_imoveis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- A despejar dados para tabela bd_sigim.tipologia_imoveis: ~12 rows (aproximadamente)
DELETE FROM `tipologia_imoveis`;
INSERT INTO `tipologia_imoveis` (`id`, `descricao`, `designacao`, `tipo_imoveis_id`, `criado_por`, `apagado_por`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'T1', 'T1', 2, NULL, NULL, NULL, NULL, NULL),
	(2, 'T1', 'T2', 2, NULL, NULL, NULL, NULL, NULL),
	(3, 'T1', 'T3', 2, NULL, NULL, NULL, NULL, NULL),
	(4, 'T1', 'T4', 2, NULL, NULL, NULL, NULL, NULL),
	(5, 'T1', 'T5', 2, NULL, NULL, NULL, NULL, NULL),
	(6, 'V1', 'V1', 1, NULL, NULL, NULL, NULL, NULL),
	(7, 'T1', 'V2', 1, NULL, NULL, NULL, NULL, NULL),
	(8, 'T1', 'V3', 1, NULL, NULL, NULL, NULL, NULL),
	(9, 'T1', 'V4', 1, NULL, NULL, NULL, NULL, NULL),
	(10, 'T1', 'V5', 1, NULL, NULL, NULL, NULL, NULL),
	(11, 'Moradia', 'Moradia', NULL, NULL, NULL, NULL, NULL, NULL),
	(12, 'Um quarto e sala', 'T0', 3, NULL, NULL, NULL, NULL, NULL);

-- A despejar estrutura para tabela bd_sigim.tipo_documentacoes
DROP TABLE IF EXISTS `tipo_documentacoes`;
CREATE TABLE IF NOT EXISTS `tipo_documentacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `designacao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `criado_por` bigint DEFAULT NULL,
  `apagado_por` bigint DEFAULT NULL,
  `created_at` bigint DEFAULT NULL,
  `updated_at` bigint DEFAULT NULL,
  `deleted_at` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.tipo_documentacoes: ~2 rows (aproximadamente)
DELETE FROM `tipo_documentacoes`;
INSERT INTO `tipo_documentacoes` (`id`, `descricao`, `designacao`, `criado_por`, `apagado_por`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Titulo de propriedade', 'propriedade', NULL, NULL, NULL, NULL, NULL),
	(2, 'Crockis', NULL, NULL, NULL, NULL, NULL, NULL);

-- A despejar estrutura para tabela bd_sigim.tipo_imoveis
DROP TABLE IF EXISTS `tipo_imoveis`;
CREATE TABLE IF NOT EXISTS `tipo_imoveis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `descricao` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `criado_por` int DEFAULT NULL,
  `apagado_por` int DEFAULT NULL,
  `created_at` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  `tipo_imovel_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.tipo_imoveis: ~0 rows (aproximadamente)
DELETE FROM `tipo_imoveis`;
INSERT INTO `tipo_imoveis` (`id`, `designacao`, `descricao`, `criado_por`, `apagado_por`, `created_at`, `updated_at`, `deleted_at`, `tipo_imovel_id`) VALUES
	(1, 'Vivenda', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 'Apartamento', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 'Quartos', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 'Quintal Comum', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- A despejar estrutura para tabela bd_sigim.tipo_users
DROP TABLE IF EXISTS `tipo_users`;
CREATE TABLE IF NOT EXISTS `tipo_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `designacao` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `descricao` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.tipo_users: ~3 rows (aproximadamente)
DELETE FROM `tipo_users`;
INSERT INTO `tipo_users` (`id`, `designacao`, `descricao`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Funcionarios', 'Funcionarios', '2023-05-07 19:57:41', NULL, NULL),
	(2, 'Clientes', 'Clientes', '2023-05-07 19:57:56', NULL, NULL),
	(3, 'Proprietários', 'Proprietários', '2023-05-07 19:58:16', NULL, NULL);

-- A despejar estrutura para tabela bd_sigim.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `lastName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `telefone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(450) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `tipo_users_id` int DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_users_tipo_users` (`tipo_users_id`),
  CONSTRAINT `FK_users_tipo_users` FOREIGN KEY (`tipo_users_id`) REFERENCES `tipo_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=407 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.users: ~4 rows (aproximadamente)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `lastName`, `telefone`, `email`, `username`, `email_verified_at`, `password`, `tipo_users_id`, `remember_token`, `created_at`, `updated_at`, `deleted_at`, `avatar`) VALUES
	(403, 'Zacarias', 'Milonga', NULL, 'angelfiremilonga@gmail.com', NULL, '2023-05-12 13:23:38', '789654123', NULL, NULL, '2023-05-12 13:23:38', NULL, NULL, 'https://lh3.googleusercontent.com/a/AGNmyxZ2z7jf2sIHmo0C7ONgOm5tYPxhtLvZEIelF138=s96-c'),
	(404, 'Zacarias Zage Milonga', NULL, NULL, 'a@gmail.com', NULL, '2023-07-14 10:49:14', '$2y$10$KgeQt5zJnN8qG6zQRcjGAe5BA3OtcFPUiYnYGcR.nrFmmOrcvUipO', NULL, NULL, '2023-07-14 09:49:14', '2023-07-14 09:49:14', NULL, NULL),
	(405, 'Milonga', NULL, NULL, 'm@gmail.com', NULL, '2023-08-11 09:43:06', '$2y$10$VRaro89sSfZ1JXIfVW4CAuVTyh7XZhfl4.T4NCVcxXnKvewJ1O5Cq', NULL, NULL, '2023-08-11 08:43:06', '2023-08-11 08:43:06', NULL, NULL),
	(406, 'testando', NULL, NULL, 'testando@gmail.com', NULL, '2023-09-04 15:39:36', '$2y$10$uIBwU8D9cT1fxgR1rYuire./tUaBY0CryRzuvKLOcrdC6a7lxU0X.', NULL, NULL, '2023-09-04 14:39:36', '2023-09-04 14:39:36', NULL, NULL);

-- A despejar estrutura para tabela bd_sigim.users_copy
DROP TABLE IF EXISTS `users_copy`;
CREATE TABLE IF NOT EXISTS `users_copy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `lastName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `telefone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `username` varchar(450) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `tipo_users_id` int DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_users_tipo_users` (`tipo_users_id`) USING BTREE,
  CONSTRAINT `users_copy_ibfk_1` FOREIGN KEY (`tipo_users_id`) REFERENCES `tipo_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.users_copy: ~0 rows (aproximadamente)
DELETE FROM `users_copy`;
INSERT INTO `users_copy` (`id`, `firstName`, `lastName`, `telefone`, `email`, `username`, `email_verified_at`, `password`, `tipo_users_id`, `remember_token`, `created_at`, `updated_at`, `deleted_at`, `avatar`) VALUES
	(403, 'Zacarias', 'Milonga', NULL, 'angelfiremilonga@gmail.com', NULL, '2023-05-12 13:23:38', '789654123', NULL, NULL, '2023-05-12 13:23:38', NULL, NULL, 'https://lh3.googleusercontent.com/a/AGNmyxZ2z7jf2sIHmo0C7ONgOm5tYPxhtLvZEIelF138=s96-c');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
