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
  `cadastrado_por` int DEFAULT NULL,
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
  KEY `FK_actividade_imoveis_clientes` (`cadastrado_por`) USING BTREE,
  CONSTRAINT `FK_actividade_imoveis_clientes` FOREIGN KEY (`cadastrado_por`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_actividade_imoveis_imoveis` FOREIGN KEY (`imoveis_id`) REFERENCES `imoveis` (`id`),
  CONSTRAINT `FK_actividade_imoveis_operacao_imoveis` FOREIGN KEY (`operacao_imoveis_id`) REFERENCES `operacao_imoveis` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.actividade_imoveis: ~8 rows (aproximadamente)
DELETE FROM `actividade_imoveis`;
INSERT INTO `actividade_imoveis` (`id`, `cadastrado_por`, `imoveis_id`, `operacao_imoveis_id`, `proprietario_colaborador`, `quantidade_prestacoes`, `created_at`, `updated_at`, `deleted_at`, `tempo_arrendar`) VALUES
	(23, NULL, 74, 1, '1', 0, '2023-09-08 20:18:03', '2023-09-08 20:18:03', NULL, 0),
	(24, NULL, 75, 1, '1', 0, '2023-09-08 20:19:43', '2023-09-08 20:19:43', NULL, 0),
	(25, NULL, 76, 1, '1', 0, '2023-09-08 20:21:03', '2023-09-08 20:21:03', NULL, 0),
	(26, NULL, 77, 2, '1', 0, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL, 2),
	(27, NULL, 78, 2, '1', 0, '2023-09-08 20:26:39', '2023-09-08 20:26:39', NULL, 2),
	(28, NULL, 79, 2, '1', 0, '2023-09-08 20:27:28', '2023-09-08 20:27:28', NULL, 2),
	(29, 406, 82, 2, '2', 0, '2023-09-11 19:19:54', '2023-09-11 19:19:54', NULL, 2),
	(30, 406, 83, 2, '2', 0, '2023-09-11 19:25:11', '2023-09-11 19:25:11', NULL, 2);

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

-- A despejar dados para tabela bd_sigim.categoria_imoveis: ~4 rows (aproximadamente)
DELETE FROM `categoria_imoveis`;
INSERT INTO `categoria_imoveis` (`id`, `designacao`, `descricao`, `criado_por`, `apagado_por`, `created_at`, `updated_at`, `deleted_at`, `tipo_imovel_id`) VALUES
	(1, 'Vivenda', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 'Apartamento', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 'Quartos', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 'Quintal Comum', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.estado_imoveis: ~7 rows (aproximadamente)
DELETE FROM `estado_imoveis`;
INSERT INTO `estado_imoveis` (`id`, `designacao`, `descricao`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Activo', 'Activo', '2023-06-09 10:46:34', NULL, NULL),
	(2, 'Desativado', 'Desativado', '2023-09-07 08:35:41', NULL, NULL),
	(3, 'Pendente', 'Pendente', '2023-09-07 08:36:33', NULL, NULL),
	(4, 'Visita pendente', 'Visita pendente', '2023-09-07 08:37:17', NULL, NULL),
	(5, ' Visita confirmada', ' Visita confirmada', '2023-09-07 08:37:43', NULL, NULL),
	(6, 'Vendido', 'Vendido', '2023-09-07 08:38:29', NULL, NULL),
	(7, 'Arrendado', 'Arrendado', '2023-09-07 08:38:43', NULL, NULL),
	(8, 'Em negociação', 'Em negociação', '2023-09-10 20:37:12', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.fotos_imoveis: ~109 rows (aproximadamente)
DELETE FROM `fotos_imoveis`;
INSERT INTO `fotos_imoveis` (`id`, `foto`, `imoveis_id`, `created_by`, `updated_by`, `deleted_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(153, 'Foto_Multipla/0PCK3NPrUso27PAs3gVEwWk5ruos4PcJ85hcXXmy.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:02', '2023-09-08 20:18:02', NULL),
	(154, 'Foto_Multipla/uJHEklfi0drSQW2gBzlvnrLV3RS2SF9xO4y3hrfD.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:02', '2023-09-08 20:18:02', NULL),
	(155, 'Foto_Multipla/N2OrpEY3SzX3XphiKSOeEy0nkJvwFaEFJHkVZMYe.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:03', '2023-09-08 20:18:03', NULL),
	(156, 'Foto_Multipla/Pnl93yuOHB4xmiuP8O94tdGD5MZFpWFzpEoLxJbC.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:03', '2023-09-08 20:18:03', NULL),
	(157, 'Foto_Multipla/LJ3PqRT6ej9joYH2SEl9yW9wVrIx1brwITzTRy2s.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:03', '2023-09-08 20:18:03', NULL),
	(158, 'Foto_Multipla/kRNlx9BLCH2IQONSAaKMpsdcQER8H9gffXjABuzl.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:03', '2023-09-08 20:18:03', NULL),
	(159, 'Foto_Multipla/NRFrsjBRCbp4PioT0zmzkNdKVPjvy5Lw06Tr7SUG.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:03', '2023-09-08 20:18:03', NULL),
	(160, 'Foto_Multipla/rwFgF1MdlTmojyxIrhufcUzLcdUAT99h76HFXGyM.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:03', '2023-09-08 20:18:03', NULL),
	(161, 'Foto_Multipla/SwmEYNo8io3ce3gassGGZ7rx8U5S701VVRim0zdh.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:03', '2023-09-08 20:18:03', NULL),
	(162, 'Foto_Multipla/9UR5S1MGUfrEvCVLdmt7ubWUXnWkbzXm2ASFCi4z.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:03', '2023-09-08 20:18:03', NULL),
	(163, 'Foto_Multipla/bhiAOtMBcaMug5gG9iS9zEQNN2xBHbE7KZfwyiA3.jpg', 74, NULL, NULL, NULL, '2023-09-08 20:18:03', '2023-09-08 20:18:03', NULL),
	(164, 'Foto_Multipla/tGjUtT9MkBM6Nz8sMHsgtEG3jhCJ7UUhtO4yk3OW.jpg', 75, NULL, NULL, NULL, '2023-09-08 20:19:43', '2023-09-08 20:19:43', NULL),
	(165, 'Foto_Multipla/HVeXBQtheKBWIMand2oxnf8tCU0YVsSt6nd8nInE.jpg', 75, NULL, NULL, NULL, '2023-09-08 20:19:43', '2023-09-08 20:19:43', NULL),
	(166, 'Foto_Multipla/yeXwKOreTOlucfgnM4DTG8FQXEf6TZ1ffpWvVaGe.jpg', 75, NULL, NULL, NULL, '2023-09-08 20:19:43', '2023-09-08 20:19:43', NULL),
	(167, 'Foto_Multipla/NukzVsbAY0KKJdRJ7t3vGrmPhqVPTYlT8b5Ne1Lb.jpg', 75, NULL, NULL, NULL, '2023-09-08 20:19:43', '2023-09-08 20:19:43', NULL),
	(168, 'Foto_Multipla/1ZZkfALUPboB4poLCEHRpueZNOJiefAVLAzsy82B.jpg', 75, NULL, NULL, NULL, '2023-09-08 20:19:43', '2023-09-08 20:19:43', NULL),
	(169, 'Foto_Multipla/vTXQRH5BESnQU6D5ESavc4Rw4TxC7Ge4PtahsxS3.jpg', 75, NULL, NULL, NULL, '2023-09-08 20:19:43', '2023-09-08 20:19:43', NULL),
	(170, 'Foto_Multipla/RF4HtG0yE01k3UUkSidrTrJiPr9iVGRVu0KvNKog.jpg', 76, NULL, NULL, NULL, '2023-09-08 20:21:03', '2023-09-08 20:21:03', NULL),
	(171, 'Foto_Multipla/D3DKhNvLkaUOpRDCRwG4bo3JGNOQLo2eBOzD7MJQ.jpg', 76, NULL, NULL, NULL, '2023-09-08 20:21:03', '2023-09-08 20:21:03', NULL),
	(172, 'Foto_Multipla/n7yenArB9Lf0t5B4NMmovYnk7obuN6DCE30IbpDG.jpg', 76, NULL, NULL, NULL, '2023-09-08 20:21:03', '2023-09-08 20:21:03', NULL),
	(173, 'Foto_Multipla/rRKf8HK3Q7JVNHKOWzdOkJiNfwzD0PwWs7voGweH.jpg', 76, NULL, NULL, NULL, '2023-09-08 20:21:03', '2023-09-08 20:21:03', NULL),
	(174, 'Foto_Multipla/rzhmfbdjGunNr8r0JHj6LIobLkqPfAAr7aTEAJ54.jpg', 76, NULL, NULL, NULL, '2023-09-08 20:21:03', '2023-09-08 20:21:03', NULL),
	(175, 'Foto_Multipla/Lf2W4TLig5TG6lIXQLg30Mz69CT2YhbPXhSFZXVo.jpg', 76, NULL, NULL, NULL, '2023-09-08 20:21:03', '2023-09-08 20:21:03', NULL),
	(176, 'Foto_Multipla/os8Oxm4E5AJoPMthY1WVzckJxhTgJOgH2AozFai8.jpg', 76, NULL, NULL, NULL, '2023-09-08 20:21:03', '2023-09-08 20:21:03', NULL),
	(177, 'Foto_Multipla/S0w4J6VcyGqEfQpdvYXFfp4HFoKkNJ7PSSBfW3oS.jpg', 76, NULL, NULL, NULL, '2023-09-08 20:21:03', '2023-09-08 20:21:03', NULL),
	(178, 'Foto_Multipla/npOxdhC9JyITVkR42IeUJiaSwowqddn7zmccO97r.jpg', 76, NULL, NULL, NULL, '2023-09-08 20:21:03', '2023-09-08 20:21:03', NULL),
	(179, 'Foto_Multipla/kp6U8C5f4joRvJ5bZex366eRl5zIu7P8FpJSPg8s.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(180, 'Foto_Multipla/Rx1CF6diSHL9bDsH08RddOzlNhJdUbVVOB0SGYWt.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(181, 'Foto_Multipla/qL2CoSRk7gCuBzvUu0J8P4CdDcYMWRJGQe29Bw49.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(182, 'Foto_Multipla/7rebg3eRRMyitVcLtCAyI7YvfFgQQg02glnu2eYI.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(183, 'Foto_Multipla/QHcxBwMb8rG1pYttnkuYSLlETJpE1Xp0Zt49wg5m.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(184, 'Foto_Multipla/Nl3zQslmW4AmEgKqkanfQLuYkoAWK4baIYTaisRx.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(185, 'Foto_Multipla/53K5dTYB4r9ueEOHG22offncPKmNr02gZ4mPT24E.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(186, 'Foto_Multipla/ztkeTD7IpaU4Xbk4TlLa0NkmkDDf4w5SdzMWZDGV.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(187, 'Foto_Multipla/Gam8LkR6BCTtMbJIHy61BIN2O5HwjJwE4TCDdb86.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(188, 'Foto_Multipla/YCzn1AT129WqUjJkFhTXeizKq6GuKU31O5DME3Ur.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(189, 'Foto_Multipla/YaqZPdTCMiZfVwXDp4ittIxDuZLXyxqbNAAWNwRk.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(190, 'Foto_Multipla/B8LWDXUFBIQQ56TNxZXqmCat70vD2r7h3xhNf0c4.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(191, 'Foto_Multipla/X4YLHtahV4uLO6UdLCJRcC8LQml7lmR1RLKd6S4n.jpg', 77, NULL, NULL, NULL, '2023-09-08 20:24:28', '2023-09-08 20:24:28', NULL),
	(192, 'Foto_Multipla/lQsIHw1JYj4ockQYHLwsmxp1eEx7HGM2T7MbnJFn.jpg', 78, NULL, NULL, NULL, '2023-09-08 20:26:39', '2023-09-08 20:26:39', NULL),
	(193, 'Foto_Multipla/3hIPG29jdVLNvIaUbgHzFYJ2WQVIkjtqUp9NeVsv.jpg', 78, NULL, NULL, NULL, '2023-09-08 20:26:39', '2023-09-08 20:26:39', NULL),
	(194, 'Foto_Multipla/bWSvSxUQN64D1zoGegv6RWHHlC2rcW33DE9UfABV.jpg', 78, NULL, NULL, NULL, '2023-09-08 20:26:39', '2023-09-08 20:26:39', NULL),
	(195, 'Foto_Multipla/7tVuSEq6M7d47htj3STdAszfuWE8VlaksYDx8syD.jpg', 78, NULL, NULL, NULL, '2023-09-08 20:26:39', '2023-09-08 20:26:39', NULL),
	(196, 'Foto_Multipla/CIzlHztv5S1ZVq6Y9C4Yv7RqKhMSCyrHaJjZj88w.jpg', 79, NULL, NULL, NULL, '2023-09-08 20:27:28', '2023-09-08 20:27:28', NULL),
	(197, 'Foto_Multipla/6biuTrJrNbfrRNjlWniqYzk0M7OguMxid78dsHcM.jpg', 79, NULL, NULL, NULL, '2023-09-08 20:27:28', '2023-09-08 20:27:28', NULL),
	(198, 'Foto_Multipla/EEpQyY6qjPO6BdvmTVDfPfVfy0AQWJNHrY5FjpMO.jpg', 79, NULL, NULL, NULL, '2023-09-08 20:27:28', '2023-09-08 20:27:28', NULL),
	(199, 'Foto_Multipla/RspEEYxdtXfqp2RsQTEVn69JxqXoIcNBwI4CxcJc.jpg', 79, NULL, NULL, NULL, '2023-09-08 20:27:28', '2023-09-08 20:27:28', NULL),
	(200, 'Foto_Multipla/hofVt3TdQPmcRm9mx85Q4KW01ZlTPgexL0S6k4jl.jpg', 79, NULL, NULL, NULL, '2023-09-08 20:27:28', '2023-09-08 20:27:28', NULL),
	(201, 'Foto_Multipla/i9Ly8RWTqx8MluoxQKsl2S32xqXeylULGkO6hcST.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(202, 'Foto_Multipla/Mxbf4tVGWuMuvHfE5rPeVYh8BpX0wsRxHTJ2vRrQ.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(203, 'Foto_Multipla/2TvFjtJOpxkDEcz6jDYuBh7SMOQrk3a6HEvEoUD1.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(204, 'Foto_Multipla/fEBr8x55nyaV83aGligPSSges67DC9z5K9sGcicM.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(205, 'Foto_Multipla/pgouSaW3TupPDodH78G5Y8noMFteLrF2kZYd6yeG.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(206, 'Foto_Multipla/DJnZnOuYU4cB0PNIW2TQHVsYgO0dwr9OnZBcwirt.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(207, 'Foto_Multipla/ByJoQOiNAhhpD7trcExF41RyUhoIS3ejOnxPhv1c.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(208, 'Foto_Multipla/7K5mJeQ4LvD2bh7mafFc5C6drNDYccO5alPJTNie.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(209, 'Foto_Multipla/iiN6yBZiejAhqT3IfTTrI9HDmIUJDSsZ5cAcuytp.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(210, 'Foto_Multipla/1wvJDO15Qq5LZHuOMH2V8gdy1zMJelraOV3j6KsM.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(211, 'Foto_Multipla/EOV8XWw5Suvw6NnEnVCczS6aR41Ci74MVs8S0RWF.jpg', 81, NULL, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL),
	(212, 'Foto_Multipla/1elJn3nUvfqYHoZYEGeXt4JnW6Hv6sA3wg73jdPY.jpg', 82, NULL, NULL, NULL, '2023-09-11 19:19:54', '2023-09-11 19:19:54', NULL),
	(213, 'Foto_Multipla/tSqNv3jQ3sHuVIAfsgrUbarKuW3RpVKexZPDdZTq.jpg', 82, NULL, NULL, NULL, '2023-09-11 19:19:54', '2023-09-11 19:19:54', NULL),
	(214, 'Foto_Multipla/VwiFhv6oXTlFhEBPXwwNS5pD8yU1Po7nLuc1GLAo.jpg', 82, NULL, NULL, NULL, '2023-09-11 19:19:54', '2023-09-11 19:19:54', NULL),
	(215, 'Foto_Multipla/aqWOzBCNOqfUl5p5Coz1Egdt4W5yp5h4zJV13bes.jpg', 82, NULL, NULL, NULL, '2023-09-11 19:19:54', '2023-09-11 19:19:54', NULL),
	(216, 'Foto_Multipla/YIAiTdE2S2fdZzVNZ6MBFVgPfPgmx69KM3Phcw2W.jpg', 82, NULL, NULL, NULL, '2023-09-11 19:19:54', '2023-09-11 19:19:54', NULL),
	(217, 'Foto_Multipla/E5FydnO3uiCHYjynAk8sKd8PpIaXlI7TzUJQIGA0.jpg', 82, NULL, NULL, NULL, '2023-09-11 19:19:54', '2023-09-11 19:19:54', NULL),
	(218, 'Foto_Multipla/s2kLcFmaagQcCNrjB71qf7KevdpRfnkjk1BVyjE9.jpg', 83, NULL, NULL, NULL, '2023-09-11 19:25:11', '2023-09-11 19:25:11', NULL),
	(219, 'Foto_Multipla/IrV2lR9FtNclP99aR31EDEAHybKr1STRrADovRjv.jpg', 83, NULL, NULL, NULL, '2023-09-11 19:25:11', '2023-09-11 19:25:11', NULL),
	(220, 'Foto_Multipla/f01dVA2jIUsU3zwOdKMohbkAViuxHjBuodRqedHu.jpg', 83, NULL, NULL, NULL, '2023-09-11 19:25:11', '2023-09-11 19:25:11', NULL),
	(221, 'Foto_Multipla/9LKZITsIoBUUSMh2KuN5JOxpP7viGUVTylfYoC6d.jpg', 83, NULL, NULL, NULL, '2023-09-11 19:25:11', '2023-09-11 19:25:11', NULL),
	(222, 'Foto_Multipla/sHO0uYm1CzdlEbR5Yyp5Uz32ABH8Bzc3zVe2srQg.jpg', 83, NULL, NULL, NULL, '2023-09-11 19:25:11', '2023-09-11 19:25:11', NULL),
	(223, 'Foto_Multipla/s3dPNFJeQlYAjaqBsPphnsatWbCisQVsgho2RSW7.jpg', 83, NULL, NULL, NULL, '2023-09-11 19:25:11', '2023-09-11 19:25:11', NULL),
	(224, 'Foto_Multipla/IUH3MpC9iSS7FqMjKkOYIGsV50DYk3N46FrykSmk.jpg', 84, NULL, NULL, NULL, '2023-09-11 19:27:34', '2023-09-11 19:27:34', NULL),
	(225, 'Foto_Multipla/x9wOK3rJg3siDJyOUelWfCypnpcHwZoFlHfKz0Tz.jpg', 84, NULL, NULL, NULL, '2023-09-11 19:27:34', '2023-09-11 19:27:34', NULL),
	(226, 'Foto_Multipla/TdLW3kn4TA7JFNpfc48I82dKrGXqrIvmArI6CRYF.jpg', 84, NULL, NULL, NULL, '2023-09-11 19:27:34', '2023-09-11 19:27:34', NULL),
	(227, 'Foto_Multipla/8xQ57ZL1o7tPnQi5PZa95zxdEwEg1UHwVPcCAtR0.jpg', 84, NULL, NULL, NULL, '2023-09-11 19:27:34', '2023-09-11 19:27:34', NULL),
	(228, 'Foto_Multipla/Ge71mC8afNxJoJhZd4hPWbNdMKBAeK6Ry8PN3uR3.jpg', 84, NULL, NULL, NULL, '2023-09-11 19:27:34', '2023-09-11 19:27:34', NULL),
	(229, 'Foto_Multipla/hfoc3VsmDfLlNlYSaCQ29H4Bzb70H2Gf8hA9jX6c.jpg', 84, NULL, NULL, NULL, '2023-09-11 19:27:34', '2023-09-11 19:27:34', NULL),
	(230, 'Foto_Multipla/9cmsf8xHkijxYl692pzghNERfo6ZHt0kITdDHkHg.jpg', 85, NULL, NULL, NULL, '2023-09-11 19:32:34', '2023-09-11 19:32:34', NULL),
	(231, 'Foto_Multipla/hEKCHquqQTuDg6M20cz70PZEHxlWG9t1A0CqS0Ba.jpg', 85, NULL, NULL, NULL, '2023-09-11 19:32:34', '2023-09-11 19:32:34', NULL),
	(232, 'Foto_Multipla/LJhQjVj2g2RnmxwQ2evfLDEUe1BbM4Ets7CGEwXJ.jpg', 85, NULL, NULL, NULL, '2023-09-11 19:32:34', '2023-09-11 19:32:34', NULL),
	(233, 'Foto_Multipla/ouWk3eqr0crLwz3qbhiMUzGQ3WPB5Fz1ww7AoKA6.jpg', 85, NULL, NULL, NULL, '2023-09-11 19:32:34', '2023-09-11 19:32:34', NULL),
	(234, 'Foto_Multipla/kaVQQyxP9QBjbt9IsVajFDn2wnMeHm92Ia6k842Z.jpg', 85, NULL, NULL, NULL, '2023-09-11 19:32:34', '2023-09-11 19:32:34', NULL),
	(235, 'Foto_Multipla/kQNPRPf0UUDwOaOUkaplukNxyAt3WBdSPKQBdxoR.jpg', 86, NULL, NULL, NULL, '2023-09-11 19:32:43', '2023-09-11 19:32:43', NULL),
	(236, 'Foto_Multipla/M5iRElJvMdB3gO7hRSNZKdniezmtcaQrKJg2kk5G.jpg', 86, NULL, NULL, NULL, '2023-09-11 19:32:43', '2023-09-11 19:32:43', NULL),
	(237, 'Foto_Multipla/XidCzYi0WEbcYmgNP1j1Sr0kilMjwUbLCOkHkjoz.jpg', 86, NULL, NULL, NULL, '2023-09-11 19:32:43', '2023-09-11 19:32:43', NULL),
	(238, 'Foto_Multipla/wX6xv8cSAQYnJcrit3pDMHWivOe36FpxARLIeQo6.jpg', 86, NULL, NULL, NULL, '2023-09-11 19:32:43', '2023-09-11 19:32:43', NULL),
	(239, 'Foto_Multipla/0N46TDPZy8w1qACQOrDnrWWvBG3R9HicC9ONg5x6.jpg', 86, NULL, NULL, NULL, '2023-09-11 19:32:43', '2023-09-11 19:32:43', NULL),
	(240, 'Foto_Multipla/7BtABJbQDeruoOpdibnhRniCQbTfhwdfN0A4Hcu6.jpg', 87, NULL, NULL, NULL, '2023-09-11 20:23:45', '2023-09-11 20:23:45', NULL),
	(241, 'Foto_Multipla/j6Ltr93tIBnQ9rQAs9ihPIzrYrW6c2lBZYZbvV4Z.jpg', 87, NULL, NULL, NULL, '2023-09-11 20:23:45', '2023-09-11 20:23:45', NULL),
	(242, 'Foto_Multipla/N7UzbJDkyECcURMrTWkpMz2eab6C6Kt2QWkU8c3M.jpg', 87, NULL, NULL, NULL, '2023-09-11 20:23:45', '2023-09-11 20:23:45', NULL),
	(243, 'Foto_Multipla/xKDneOXzprc0GqDoV7pVo25NoFd3mIXwf5FX6sC4.jpg', 87, NULL, NULL, NULL, '2023-09-11 20:23:45', '2023-09-11 20:23:45', NULL),
	(244, 'Foto_Multipla/XmUBQPuSlorpzxiFAFYyM0VSv3l7GZPqMj2NJymK.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(245, 'Foto_Multipla/sG9lyjlpQIBYcMULQ67Jr7LeAds1W017SjTKJLWc.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(246, 'Foto_Multipla/mTGuBs7qwTtLEBCPNlejfos9mcburhJQrpK5GJGp.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(247, 'Foto_Multipla/yHdUgOfnSBnK4bOuHdLvIIqMa8KZLkvGRtQDo40X.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(248, 'Foto_Multipla/N6rjfwxpnp3JHv2bDz76wC9eD4Z9SIIfqs2LhGCb.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(249, 'Foto_Multipla/ZY5Dz4qVrzBpvPLihMBlgH4n67ZnkCwf9wcBxBMi.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(250, 'Foto_Multipla/y3XRU6X984pkF6nEzEUgD9UcQvVJXAK85mSEzd8J.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(251, 'Foto_Multipla/vHbUftyJLE20AOuNEUZyvnOoZjfY8xR5RtGkWhk2.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(252, 'Foto_Multipla/FbEihKWMPrDumXtAEjDHsCGZNGAAjtsRFooENrB7.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(253, 'Foto_Multipla/giRYWBbafu28HvbjQnM1ypGvzK4nz21zQsEOzB8H.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(254, 'Foto_Multipla/oG1cpljoA51Q6guEnsigWqnt4YdPMn06pQyigqCF.jpg', 88, NULL, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL),
	(255, 'Foto_Multipla/sBNb3iqQanL5Gtqcw3LrbSrYJv92R5evs7mz5mkW.jpg', 89, NULL, NULL, NULL, '2023-09-11 20:30:49', '2023-09-11 20:30:49', NULL),
	(256, 'Foto_Multipla/nVy5Nl5WaPbqoJDzu74swBbqxiotPa28xDNapFOJ.jpg', 89, NULL, NULL, NULL, '2023-09-11 20:30:50', '2023-09-11 20:30:50', NULL),
	(257, 'Foto_Multipla/HR8hbf2ZUFJmIQuf7CvRcqXlvr5VavqaZXr1DsWm.jpg', 89, NULL, NULL, NULL, '2023-09-11 20:30:50', '2023-09-11 20:30:50', NULL),
	(258, 'Foto_Multipla/04MHWYHJnO6ObTNERpDYQDGgjSYW8U2Uc216mbk4.jpg', 93, NULL, NULL, NULL, '2023-09-11 20:37:59', '2023-09-11 20:37:59', NULL),
	(259, 'Foto_Multipla/6p1YjcO73j0XYYZVASpkFzRHVsjUxZ8rUYKGe88C.jpg', 93, NULL, NULL, NULL, '2023-09-11 20:37:59', '2023-09-11 20:37:59', NULL),
	(260, 'Foto_Multipla/bnJZ4QzpL3w9ZBAK5bbnULcu0hi6V33kqf6vJcCh.jpg', 93, NULL, NULL, NULL, '2023-09-11 20:37:59', '2023-09-11 20:37:59', NULL),
	(261, 'Foto_Multipla/AoRDZ9GPcbWl39Xgmva0E6bcUSZV26YAAIFVBLRU.jpg', 93, NULL, NULL, NULL, '2023-09-11 20:37:59', '2023-09-11 20:37:59', NULL),
	(262, 'Foto_Multipla/I9kwgURSNYFzW0d2yKuAyY4Ax3tlrEOYjrKa3LQq.jpg', 93, NULL, NULL, NULL, '2023-09-11 20:37:59', '2023-09-11 20:37:59', NULL),
	(263, 'Foto_Multipla/c0VIfpI2NCNs22P3K4GltsWStkZkv7F1TxjW62MJ.jpg', 94, NULL, NULL, NULL, '2023-09-11 20:43:10', '2023-09-11 20:43:10', NULL),
	(264, 'Foto_Multipla/XC00WevEKrfNQXtVuH9eSNXbj950ZVZ9D06CIChY.jpg', 97, NULL, NULL, NULL, '2023-09-11 20:47:46', '2023-09-11 20:47:46', NULL),
	(265, 'Foto_Multipla/rUTamETDVB56CefyXtyFl45fZ5atPipRjLG8ndOX.jpg', 97, NULL, NULL, NULL, '2023-09-11 20:47:46', '2023-09-11 20:47:46', NULL),
	(266, 'Foto_Multipla/575nxu5t0XOwdN0gxZfkwp5mChFtMUznz5O9gvUp.jpg', 97, NULL, NULL, NULL, '2023-09-11 20:47:46', '2023-09-11 20:47:46', NULL),
	(267, 'Foto_Multipla/419HzRiqvyxN9kNiLeig3RsheBKEeC6YEo6UxgU3.jpg', 97, NULL, NULL, NULL, '2023-09-11 20:47:46', '2023-09-11 20:47:46', NULL),
	(268, 'Foto_Multipla/JnF0HTWUUxckgUg6MrckKmIEZDygibib9YwvNryU.jpg', 97, NULL, NULL, NULL, '2023-09-11 20:47:46', '2023-09-11 20:47:46', NULL),
	(269, 'Foto_Multipla/K1uCJtXei7KYNADVkXUT72WRTHYWV22H1GZ0zcDA.jpg', 97, NULL, NULL, NULL, '2023-09-11 20:47:46', '2023-09-11 20:47:46', NULL),
	(270, 'Foto_Multipla/L1ESdVzgu2O2tuGawfSkwykKj140pD6Iv7muLQWn.jpg', 97, NULL, NULL, NULL, '2023-09-11 20:47:46', '2023-09-11 20:47:46', NULL),
	(271, 'Foto_Multipla/L3kLoMv7cYy3Mzqqxx8GX2y3XAdGNSQrL3l9zNHF.jpg', 97, NULL, NULL, NULL, '2023-09-11 20:47:46', '2023-09-11 20:47:46', NULL);

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
  `mobiliado` enum('TRUE','FALSE') CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- A despejar dados para tabela bd_sigim.imoveis: ~19 rows (aproximadamente)
DELETE FROM `imoveis`;
INSERT INTO `imoveis` (`id`, `designacao`, `descricao`, `cozinha`, `mobiliado_id`, `suite`, `sala_de_estar`, `numero_banheiro`, `metros`, `preco`, `tempo_arrendar`, `lote`, `operacao_imoveis_id`, `estado_imoveis_id`, `tipologia_imoveis_id`, `categoria_imoveis_id`, `cadastrado_por`, `publicado_por`, `tipo_documentacoes_id`, `condicao_imoveis_id`, `tanqueagua`, `regeitado_por`, `created_at`, `updated_at`, `deleted_at`, `localizacao`, `imposto_predial`, `ginasio`, `gerador`, `piscina`, `churrasqueira`, `maquina_lavar_roupa`, `numero_garagem`, `mesa_cadeira`, `arcondicionados`, `armario_embutido`, `mobiliado`, `provincia_id`, `foto_principal`) VALUES
	(74, 'VIVENDA V6 NO CONDOMÍNIO PARAÍSO REAL (TALATONA)', 'VIVENDA V6 NO CONDOMÍNIO PARAÍSO REAL (TALATONA)', 2, NULL, 4, NULL, 1, 1999, 400094, NULL, NULL, NULL, 8, NULL, NULL, 406, NULL, NULL, 1, 1, NULL, '2023-09-08 20:18:02', '2023-09-12 20:36:25', NULL, 'Talatona', NULL, NULL, NULL, 1, NULL, 1, 1, 1, 1, 1, 'TRUE', 6, 'Foto_principal/uVQZzNSJCcOfUh9QV35v5FeuLDgrgdkhocI69UvR.jpg'),
	(75, 'VIVENDA V6 NO CONDOMÍNIO PARAÍSO REAL (Benguela)', 'VIVENDA V6 NO CONDOMÍNIO PARAÍSO REAL (Benguela)', 3, NULL, 5, NULL, 3, 1000, 5000099, NULL, NULL, NULL, 3, NULL, NULL, 406, NULL, NULL, 1, 1, NULL, '2023-09-08 20:19:43', '2023-09-14 18:15:46', NULL, 'Talatona', NULL, NULL, NULL, 0, NULL, 0, 2, 1, 1, 1, '', 13, 'Foto_principal/QdXAL95peVs4M1MESzanN9RsRd4QWnZHQhD7ACXS.jpg'),
	(76, 'VIVENDA V6 NO CONDOMÍNIO PARAÍSO REAL (Benguela)', 'VIVENDA V6 NO CONDOMÍNIO PARAÍSO REAL (Benguela)', 3, NULL, 3, NULL, 3, 4, 3444455, NULL, NULL, NULL, 3, NULL, NULL, 406, NULL, NULL, 1, 1, NULL, '2023-09-08 20:21:03', '2023-09-10 18:27:31', NULL, 'Talatona', NULL, NULL, NULL, 0, NULL, 1, 2, 1, 1, 1, 'TRUE', 13, 'Foto_principal/8S3v8JwhDiVumtaorj1CskGkU9W3N7trFaEhzWVq.jpg'),
	(77, 'APARTAMENTO T3 NO PROJETO NOVA VIDA\n', 'APARTAMENTO T3 NO PROJETO NOVA VIDA\n', 1, NULL, 4, NULL, 1, 4555, 400000, NULL, NULL, NULL, 3, NULL, NULL, 406, NULL, NULL, 1, 1, NULL, '2023-09-08 20:24:28', '2023-09-14 18:15:55', NULL, 'Luanda Luanda', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1, '', 1, 'Foto_principal/1XhD8JFGT2rNcw23UeKl1eLCkjf6Oc710HnS6e7G.jpg'),
	(78, 'APARTAMENTO T3 NO PROJETO NOVA VIDA\n', 'APARTAMENTO T4 NO PROJETO NOVA VIDA\n', 0, NULL, 1, NULL, 0, 455, 400000, NULL, NULL, NULL, 3, NULL, NULL, 407, NULL, NULL, 3, 0, NULL, '2023-09-08 20:26:39', '2023-09-08 20:26:39', NULL, 'Luanda Viana', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, '', 1, 'Foto_principal/TpMe3jIpx9dBhU3yhJTFN563z9Bo7ZafLS9GoI3E.jpg'),
	(79, 'APARTAMENTO T3 NO PROJETO NOVA VIDA\n', 'APARTAMENTO T3 NO PROJETO NOVA VIDA\n', 0, NULL, 1, NULL, 0, 455, 900000, NULL, NULL, NULL, 3, NULL, NULL, 407, NULL, NULL, 3, 0, NULL, '2023-09-08 20:27:28', '2023-09-08 20:27:28', NULL, 'Luanda Viana', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, '', 1, 'Foto_principal/yijwcilok2CAluJp0G5BUJvdYIRgkW3wi2WQBrWc.jpg'),
	(81, 'Apartamento T3 situado no 3°andar, disponível para venda no Projeto Nova Vida', 'Apartamento T3 situado no 3°andar, disponível para venda no Projeto Nova Vida', 2, NULL, 3, NULL, 2, 0, 1000000, NULL, NULL, NULL, 3, 11, 4, 406, NULL, NULL, 1, NULL, NULL, '2023-09-08 20:56:39', '2023-09-08 20:56:39', NULL, NULL, NULL, 1, 1, 1, 1, 1, 4, 1, 1, 1, 'TRUE', 3, 'Foto_principal/pGbjSzwbgr70BBj5MFIeeaKvDQHfMKi0gCBMusph.jpg'),
	(82, 'Casa de apartamento super duran', 'Cata de apartamento super duran', 1, NULL, 1, NULL, 1, 22000000, 9000000, NULL, NULL, NULL, 3, 1, 2, 406, NULL, NULL, 1, 1, NULL, '2023-09-11 19:19:54', '2023-09-11 19:19:54', NULL, 'Luanda pe dale', NULL, 1, NULL, NULL, NULL, NULL, 2, NULL, NULL, NULL, '', 1, 'Foto_principal/JkR1TKjQFTdNBMRi8c0vVc8H4VoaY8yxWBB3vVvI.jpg'),
	(83, 'Cata de apartamento super duran', 'Cata de apartamento super duran', 1, NULL, 1, NULL, 1, 22000000, 9800, NULL, NULL, NULL, 3, 1, 2, 406, NULL, NULL, 1, 1, NULL, '2023-09-11 19:25:11', '2023-09-11 19:25:11', NULL, 'Luanda pe dale', NULL, 1, NULL, NULL, NULL, 1, 2, 1, 1, NULL, 'TRUE', 2, 'Foto_principal/5l268H09i1svx1oWJEvDRfkA9KRsEpbXZuBoAIbv.jpg'),
	(84, 'APARTAMENTO T5 NO PROJETO NOVA VIDA', 'APARTAMENTO T3 NO PROJETO NOVA VIDA', 3, NULL, 2, NULL, 3, 30, NULL, NULL, NULL, NULL, 3, 11, 4, 406, NULL, NULL, 1, NULL, NULL, '2023-09-11 19:27:34', '2023-09-11 19:27:34', NULL, 'KK', NULL, NULL, NULL, 1, NULL, NULL, 3, NULL, NULL, NULL, 'TRUE', 7, 'Foto_principal/lEVVjFQ2D0EdMNLiAuyunf9KulgWDPylaYCRR6OY.jpg'),
	(85, 'APARTAMENTO T4 NO PROJETO NOVA VIDA', 'APARTAMENTO T3 NO PROJETO NOVA VIDA', 2, NULL, 2, NULL, 2, 60, 100000, NULL, NULL, NULL, 3, NULL, NULL, 406, NULL, NULL, 1, NULL, NULL, '2023-09-11 19:32:34', '2023-09-11 19:32:34', NULL, 'uige', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, '', 3, 'Foto_principal/XlkJbbtQcLZy6jVm747Zvhp5ucUJmDJINA4GWv20.jpg'),
	(86, 'APARTAMENTO T2 NO PROJETO NOVA VIDA', 'APARTAMENTO T3 NO PROJETO NOVA VIDA', 2, NULL, 2, NULL, 2, 60, 100000, NULL, NULL, NULL, 3, NULL, NULL, 406, NULL, NULL, 1, NULL, NULL, '2023-09-11 19:32:43', '2023-09-11 19:32:43', NULL, 'uige', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, '', 3, 'Foto_principal/yOopVGXo22yNWldsnceGZuzLUG2iE68rgLyFJBb9.jpg'),
	(87, 'APARTAMENTO T1 NO PROJETO NOVA VIDA', 'APARTAMENTO T3 NO PROJETO NOVA VIDA', 1, NULL, 1, NULL, 1, 22, 230000, NULL, NULL, NULL, 3, NULL, NULL, 406, NULL, NULL, 1, NULL, NULL, '2023-09-11 20:23:44', '2023-09-11 20:23:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, '', 2, 'Foto_principal/F25iWN75ydqyCjt1erGZ615kBQ3kHPuwXWItWdPL.jpg'),
	(88, 'wwwwwww', 'wwwwwww', 2, NULL, 2, NULL, 2, 33, NULL, NULL, NULL, NULL, 3, 1, 1, 406, NULL, NULL, 1, NULL, NULL, '2023-09-11 20:28:53', '2023-09-11 20:28:53', NULL, 'eeeeeeeeeeeeee', NULL, NULL, NULL, NULL, 1, 1, 3, 1, 1, NULL, 'TRUE', 1, 'Foto_principal/g50u98M3a7AMcVE2pLHyaM9g2z4anAu1lqx4su9X.jpg'),
	(89, 'sss', 'sss', 0, NULL, 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 3, 1, 1, 406, NULL, NULL, 1, NULL, NULL, '2023-09-11 20:30:49', '2023-09-11 20:30:49', NULL, 'ss', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, '', 2, 'Foto_principal/0lS293WMK2ttqdR4Wvgm76H0M3O8aqPF32JecItr.jpg'),
	(93, 'dddd', 'dddd', 1, NULL, 1, NULL, 1, 0, NULL, NULL, NULL, NULL, 3, 1, 1, 406, NULL, NULL, 1, 1, NULL, '2023-09-11 20:37:59', '2023-09-11 20:37:59', NULL, 'ddd', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1, '', 2, 'Foto_principal/LWqNzQJGMiKYYhJU75qVdZEJkXVipQCPqixqIwhr.jpg'),
	(94, '1www', '1www', 1, NULL, 1, NULL, 1, 22, NULL, NULL, NULL, NULL, 3, 1, 1, 406, NULL, NULL, 1, NULL, NULL, '2023-09-11 20:43:10', '2023-09-11 20:43:10', NULL, 'dddd', NULL, 1, NULL, NULL, 1, 1, 1, 1, 1, 1, 'TRUE', 1, 'Foto_principal/iEOeCjrrnoC40t2LSzjkVROrij15Yuc1EM0A8kXZ.jpg'),
	(97, 'sss', 'sss', 1, NULL, 1, NULL, 1, 300, NULL, NULL, NULL, NULL, 3, 1, 1, 406, NULL, NULL, 1, NULL, NULL, '2023-09-11 20:47:46', '2023-09-11 20:47:46', NULL, '333 ddd', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, 'TRUE', 6, 'Foto_principal/lw5tFn0yVFj6viI9hNkLfQFG7JBRnXSx4K7focVF.jpg'),
	(98, NULL, NULL, 0, NULL, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, 3, NULL, NULL, 406, NULL, NULL, NULL, NULL, NULL, '2023-09-11 20:49:35', '2023-09-11 20:49:35', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

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

-- A despejar dados para tabela bd_sigim.operacao_imoveis: ~3 rows (aproximadamente)
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
  `designacao` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `actividade_imoveis_id` int DEFAULT NULL,
  `imoveis_id` int DEFAULT NULL,
  `funcionarios_id` int DEFAULT NULL,
  `user_marca_visita` int DEFAULT NULL,
  `data_visita` date DEFAULT NULL,
  `hora_visita` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_solicitar_visitas_actividade_imoveis` (`actividade_imoveis_id`),
  KEY `FK_solicitar_visitas_funcionarios` (`funcionarios_id`),
  KEY `FK_solicitar_visitas_imoveis` (`imoveis_id`),
  KEY `FK_solicitar_visitas_users` (`user_marca_visita`) USING BTREE,
  CONSTRAINT `FK_solicitar_visitas_actividade_imoveis` FOREIGN KEY (`actividade_imoveis_id`) REFERENCES `actividade_imoveis` (`id`),
  CONSTRAINT `FK_solicitar_visitas_funcionarios` FOREIGN KEY (`funcionarios_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_solicitar_visitas_imoveis` FOREIGN KEY (`imoveis_id`) REFERENCES `imoveis` (`id`),
  CONSTRAINT `FK_solicitar_visitas_users` FOREIGN KEY (`user_marca_visita`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.solicitar_visitas: ~3 rows (aproximadamente)
DELETE FROM `solicitar_visitas`;
INSERT INTO `solicitar_visitas` (`id`, `designacao`, `actividade_imoveis_id`, `imoveis_id`, `funcionarios_id`, `user_marca_visita`, `data_visita`, `hora_visita`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(15, 'Seconsegurem me agendar para esse dia agradeço.', 26, 77, NULL, 406, '2023-09-15', '16:01:00', '2023-09-10 23:20:03', '2023-09-10 23:20:03', NULL),
	(16, NULL, 23, 74, NULL, 407, '2023-09-14', '13:20:00', '2023-09-12 17:19:12', '2023-09-12 17:19:12', NULL),
	(17, NULL, 23, 74, NULL, 407, '2023-09-16', '10:25:00', '2023-09-12 20:19:50', '2023-09-12 20:19:50', NULL),
	(18, NULL, 24, 75, NULL, 406, '2023-09-21', '12:00:00', '2023-09-14 18:13:12', '2023-09-14 18:13:12', NULL);

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

-- A despejar dados para tabela bd_sigim.tipo_imoveis: ~4 rows (aproximadamente)
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_bin ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.tipo_users: ~3 rows (aproximadamente)
DELETE FROM `tipo_users`;
INSERT INTO `tipo_users` (`id`, `designacao`, `descricao`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Funcionarios', 'Funcionarios', '2023-05-07 19:57:41', NULL, NULL),
	(2, 'Clientes', 'Clientes', '2023-05-07 19:57:56', NULL, NULL),
	(3, 'Proprietários', 'Proprietários', '2023-05-07 19:58:16', NULL, NULL),
	(4, 'Colaborador', 'Colaborador', '2023-09-16 04:08:08', NULL, NULL),
	(5, 'Corretor', 'Corretor', '2023-09-16 04:08:21', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- A despejar dados para tabela bd_sigim.users: ~4 rows (aproximadamente)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `lastName`, `telefone`, `email`, `username`, `email_verified_at`, `password`, `tipo_users_id`, `remember_token`, `created_at`, `updated_at`, `deleted_at`, `avatar`) VALUES
	(403, 'Zacarias', 'Milonga', NULL, 'angelfiremilonga@gmail.com', NULL, '2023-05-12 13:23:38', '789654123', NULL, NULL, '2023-05-12 13:23:38', NULL, NULL, 'https://lh3.googleusercontent.com/a/AGNmyxZ2z7jf2sIHmo0C7ONgOm5tYPxhtLvZEIelF138=s96-c'),
	(404, 'Zacarias Zage Milonga', NULL, NULL, 'a@gmail.com', NULL, '2023-07-14 10:49:14', '$2y$10$KgeQt5zJnN8qG6zQRcjGAe5BA3OtcFPUiYnYGcR.nrFmmOrcvUipO', NULL, NULL, '2023-07-14 09:49:14', '2023-07-14 09:49:14', NULL, NULL),
	(405, 'Milonga', NULL, NULL, 'm@gmail.com', NULL, '2023-08-11 09:43:06', '$2y$10$VRaro89sSfZ1JXIfVW4CAuVTyh7XZhfl4.T4NCVcxXnKvewJ1O5Cq', NULL, NULL, '2023-08-11 08:43:06', '2023-08-11 08:43:06', NULL, NULL),
	(406, 'testando', NULL, NULL, 'testando@gmail.com', NULL, '2023-09-04 15:39:36', '$2y$10$uIBwU8D9cT1fxgR1rYuire./tUaBY0CryRzuvKLOcrdC6a7lxU0X.', NULL, NULL, '2023-09-04 14:39:36', '2023-09-04 14:39:36', NULL, NULL),
	(407, 'garciapetter99@gmail.com', NULL, NULL, 'garciapetter99@gmail.com', NULL, '2023-09-09 01:27:33', '$2y$10$aB8SpLIjJEbBgnK5D6jCDudmMzmCQpfQLvkUkrRPRddy2aW9DpIjC', NULL, NULL, '2023-09-08 23:27:33', '2023-09-08 23:27:33', NULL, NULL);

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
