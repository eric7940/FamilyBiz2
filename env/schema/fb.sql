-- MySQL dump 10.13  Distrib 5.7.12, for osx10.9 (x86_64)
--
-- Host: localhost    Database: fb
-- ------------------------------------------------------
-- Server version	5.6.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_cust`
--

DROP TABLE IF EXISTS `tb_cust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cust` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '客戶編號（流水號）',
  `name` varchar(100) NOT NULL COMMENT '客戶名稱',
  `biz_no` varchar(20) DEFAULT NULL COMMENT '統一編號',
  `deliver_addr` varchar(100) DEFAULT NULL COMMENT '送貨地址',
  `tel` varchar(50) DEFAULT NULL COMMENT '聯絡電話（可含市話及手機）',
  `memo` varchar(100) DEFAULT NULL COMMENT '備註（休息時間...等）',
  `status` varchar(1) DEFAULT NULL COMMENT '狀態旗標',
  `ustamp` varchar(30) NOT NULL COMMENT '帳號標記',
  `tstamp` datetime NOT NULL COMMENT '時間標記',
  PRIMARY KEY (`id`),
  KEY `IDX_CUST_NME` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=295 DEFAULT CHARSET=utf8 COMMENT='客戶基本資料檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_cust_prod_his`
--

DROP TABLE IF EXISTS `tb_cust_prod_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_cust_prod_his` (
  `id` int(10) unsigned NOT NULL COMMENT '?史編號（流水號）',
  `cust_id` int(10) unsigned NOT NULL COMMENT '客戶編號',
  `prod_id` int(10) unsigned NOT NULL COMMENT '產品編號',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '單價',
  `offer_id` int(10) unsigned NOT NULL COMMENT '此單價所依據的出貨單號',
  PRIMARY KEY (`id`),
  KEY `IDX_CUST_PROD_HIS` (`cust_id`,`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客戶產品價格?史記錄檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_fact`
--

DROP TABLE IF EXISTS `tb_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_fact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'å» åç·¨èï¼æµæ°´èï¼',
  `name` varchar(100) NOT NULL COMMENT 'å» ååç¨±',
  `biz_no` varchar(20) DEFAULT NULL COMMENT 'çµ±ä¸ç·¨è',
  `contact` varchar(50) NOT NULL COMMENT 'Ápµ¸¤H',
  `addr` varchar(100) DEFAULT NULL COMMENT 'å°å',
  `tel` varchar(50) DEFAULT NULL COMMENT 'è¯çµ¡é»è©±ï¼å¯å«å¸è©±åææ©ï¼',
  `memo` varchar(100) DEFAULT NULL COMMENT 'åè¨»',
  `status` varchar(1) DEFAULT NULL COMMENT 'çæææ¨',
  `ustamp` varchar(30) NOT NULL COMMENT 'å¸³èæ¨è¨',
  `tstamp` datetime NOT NULL COMMENT 'æéæ¨è¨',
  PRIMARY KEY (`id`),
  KEY `IDX_FACT_NME` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8 COMMENT='å» ååºæ¬è³ææª';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_fact_prod_his`
--

DROP TABLE IF EXISTS `tb_fact_prod_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_fact_prod_his` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '?史編號（流水號）',
  `fact_id` int(10) unsigned NOT NULL COMMENT '廠商編號',
  `prod_id` int(10) unsigned NOT NULL COMMENT '產品編號',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '單價',
  `purchase_id` int(10) unsigned NOT NULL COMMENT '此單價所依據的進貨單號',
  PRIMARY KEY (`id`),
  KEY `IDX_FACT_PROD_HIS` (`fact_id`,`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4849 DEFAULT CHARSET=utf8 COMMENT='廠商產品進價?史記錄檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_func_auth`
--

DROP TABLE IF EXISTS `tb_func_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_func_auth` (
  `grade` varchar(4) NOT NULL COMMENT '使用者權限',
  `func_id` int(11) NOT NULL COMMENT '功能代碼',
  PRIMARY KEY (`grade`,`func_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='功能授權設定檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_lookup`
--

DROP TABLE IF EXISTS `tb_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_lookup` (
  `type` varchar(20) NOT NULL COMMENT '參數類別',
  `code` varchar(10) NOT NULL COMMENT '參數代碼',
  `value` varchar(50) DEFAULT NULL COMMENT '參數名稱',
  `display` tinyint(1) DEFAULT NULL COMMENT '是否顯示',
  `display_order` tinyint(3) unsigned DEFAULT '0' COMMENT '顯示順序',
  `desc` varchar(100) DEFAULT NULL COMMENT '參數說明',
  KEY `IDX_LOOKUP` (`type`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系統參數定義檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_menu`
--

DROP TABLE IF EXISTS `tb_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '功能表代碼',
  `label` varchar(30) NOT NULL COMMENT '功能表名稱',
  `parent_id` int(11) DEFAULT NULL COMMENT '父功能表代碼',
  `status` varchar(1) NOT NULL COMMENT '狀態旗標 (Y:正常, N刪除)',
  `display_order` int(3) unsigned NOT NULL,
  `folder_flag` varchar(1) NOT NULL COMMENT '功能表目錄旗標 (O:展開, C:收回)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='功能表設定檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_menu_func`
--

DROP TABLE IF EXISTS `tb_menu_func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_menu_func` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'åè½ä»£ç¢¼',
  `label` varchar(30) NOT NULL COMMENT 'åè½åç¨±',
  `menu_id` int(10) unsigned NOT NULL COMMENT 'åè½è¡¨ä»£ç¢¼',
  `url` varchar(100) NOT NULL COMMENT 'åè½é£çµURL',
  `link_type` varchar(1) NOT NULL COMMENT 'é£çµé¡å (L:link, O:open)',
  `status` varchar(1) NOT NULL COMMENT 'çæææ¨ (Y:æ­£å¸¸, N:åªé¤)',
  `display_order` int(3) unsigned NOT NULL DEFAULT '0' COMMENT 'æåé åº',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='¥¯à¸ê®ÆÀÉ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_offer_detail`
--

DROP TABLE IF EXISTS `tb_offer_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_offer_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水號',
  `master_id` int(11) NOT NULL COMMENT '出貨單號',
  `prod_id` int(11) NOT NULL COMMENT '產品編號',
  `qty` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '數量',
  `amt` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金額（數量x單價）',
  PRIMARY KEY (`id`),
  KEY `IDX_OFFER_MASTER_DETAIL` (`master_id`)
) ENGINE=InnoDB AUTO_INCREMENT=376555 DEFAULT CHARSET=utf8 COMMENT='出貨單明細資料檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_offer_master`
--

DROP TABLE IF EXISTS `tb_offer_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_offer_master` (
  `id` int(10) unsigned NOT NULL COMMENT '出貨單號(yyMMdd0000)',
  `offer_date` date NOT NULL COMMENT '單據日期',
  `cust_id` int(10) unsigned NOT NULL COMMENT '客戶編號',
  `invoice_nbr` varchar(20) DEFAULT NULL COMMENT '發票號碼',
  `stock_id` tinyint(4) DEFAULT NULL COMMENT '倉庫編號',
  `amt` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '合計（明細金額sum）',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '折讓',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '總計（合計-折讓）',
  `cost` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '進價成本',
  `receive_amt` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '未收款',
  `memo` varchar(100) DEFAULT NULL COMMENT '貨單備註',
  `back` char(1) DEFAULT NULL COMMENT '銷貨退回旗標',
  `status` char(1) NOT NULL DEFAULT 'N' COMMENT '狀態旗標 (N:正常, D:刪除; 預設:N)',
  `delivery_user_id` varchar(10) NOT NULL COMMENT '物流士使用者帳號',
  PRIMARY KEY (`id`),
  KEY `IDX_OFFER_MASTER_CUST` (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='出貨單主資料檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_prod`
--

DROP TABLE IF EXISTS `tb_prod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_prod` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '產品編號（流水號）',
  `name` varchar(100) NOT NULL COMMENT '產品名稱（可含品名及規格）',
  `unit` varchar(20) DEFAULT NULL COMMENT '單位',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '單價',
  `cost` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '成本（取最後一次進價）',
  `save_qty` int(11) NOT NULL DEFAULT '0' COMMENT '安全存量',
  `status` varchar(1) DEFAULT NULL COMMENT '狀態旗標',
  `ustamp` varchar(30) NOT NULL COMMENT '帳號標記',
  `tstamp` datetime NOT NULL COMMENT '時間標記',
  PRIMARY KEY (`id`),
  KEY `IDX_PROD_NME` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1455 DEFAULT CHARSET=utf8 COMMENT='產品基本資料檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_prod_stock_qty`
--

DROP TABLE IF EXISTS `tb_prod_stock_qty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_prod_stock_qty` (
  `stock_id` tinyint(3) unsigned NOT NULL COMMENT '倉庫編號（流水號）',
  `prod_id` int(10) unsigned NOT NULL COMMENT '產品編號（流水號）',
  `qty` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '目前存量',
  PRIMARY KEY (`stock_id`,`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='產品庫存量記錄檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_purchase_detail`
--

DROP TABLE IF EXISTS `tb_purchase_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_purchase_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水號',
  `master_id` int(11) NOT NULL COMMENT '進貨單號',
  `prod_id` int(11) NOT NULL COMMENT '產品編號',
  `qty` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '數量',
  `amt` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金額（數量x單價）',
  PRIMARY KEY (`id`),
  KEY `IDX_PURCHASE_MASTER_DETAIL` (`master_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4850 DEFAULT CHARSET=utf8 COMMENT='進貨單明細資料檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_purchase_master`
--

DROP TABLE IF EXISTS `tb_purchase_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_purchase_master` (
  `id` int(10) unsigned NOT NULL COMMENT '進貨單號(yyMMdd0000)',
  `purchase_date` date NOT NULL COMMENT '單據日期',
  `fact_id` int(10) unsigned NOT NULL COMMENT '廠商編號',
  `invoice_no` varchar(20) DEFAULT NULL COMMENT '發票號碼',
  `stock_id` tinyint(4) DEFAULT NULL COMMENT '倉庫編號',
  `amt` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '合計（明細金額sum）',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '折讓',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '總計（合計-折讓）',
  `memo` varchar(100) DEFAULT NULL COMMENT '貨單備註',
  `back` char(1) DEFAULT NULL COMMENT '進貨退出旗標',
  `status` char(1) NOT NULL DEFAULT 'N' COMMENT '狀態旗標（N:正常, D:刪除, 預設:N)',
  PRIMARY KEY (`id`),
  KEY `IDX_PURCHASE_MASTER_FACT` (`fact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='進貨單主資料檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_seq_store`
--

DROP TABLE IF EXISTS `tb_seq_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_seq_store` (
  `id` char(50) NOT NULL COMMENT '參數名稱',
  `seq` int(10) unsigned NOT NULL COMMENT '序號',
  `prefix` char(10) NOT NULL COMMENT '序號重置字符',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流水號使用記錄檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_stock`
--

DROP TABLE IF EXISTS `tb_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_stock` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '倉庫編號（流水號）',
  `name` varchar(20) NOT NULL COMMENT '倉庫名稱',
  `addr` varchar(100) DEFAULT NULL COMMENT '倉庫地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='倉庫基本資料檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tb_user` (
  `id` varchar(10) NOT NULL COMMENT '使用者代碼',
  `name` varchar(20) NOT NULL COMMENT '使用者名稱',
  `passwd` varchar(100) NOT NULL COMMENT '使用者密碼',
  `grade` varchar(10) NOT NULL COMMENT '使用者權限',
  `status` varchar(1) NOT NULL COMMENT '狀態旗標',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='使用者資料檔';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-16 15:07:40
