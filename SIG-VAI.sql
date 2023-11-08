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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

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

-- Exportação de dados não seleccionada.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
