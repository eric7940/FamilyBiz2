CREATE TABLE `tb_tcs_dept` (
  `id` VARCHAR(20) NOT NULL COMMENT '部門代碼',
  `parent_id` VARCHAR(20) NULL DEFAULT NULL COMMENT '上層部門代碼',
  `fin_code` VARCHAR(20) NULL DEFAULT NULL COMMENT '部門財務碼',
  `parent_fin_code` VARCHAR(20) NULL DEFAULT NULL COMMENT '上層部門財務碼，EHR不提供資料',
  `name` VARCHAR(100) NULL DEFAULT NULL COMMENT '部門名稱',
  `short_name` VARCHAR(100) NULL DEFAULT NULL COMMENT '部門名稱（精簡）',
  `eng_name` VARCHAR(100) NULL DEFAULT NULL COMMENT '部門英文名稱',
  `manager_user_id` VARCHAR(10) NULL DEFAULT NULL COMMENT '部門主管名稱',
  `assistant` VARCHAR(800) NULL DEFAULT NULL COMMENT '助理員工編號，多筆以逗號隔開',
  `advisor` VARCHAR(50) NULL DEFAULT NULL COMMENT '幕僚員工編號，多筆以逗號隔開',
  `tel_number` VARCHAR(20) NULL DEFAULT NULL COMMENT '電話號碼（目前派送相應管報組織部門代碼）',
  `fax_number` VARCHAR(20) NULL DEFAULT NULL COMMENT '傳真號碼（目前派送虛擬組代碼）',
  `level` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '部門層級',
  `use_tcs` VARCHAR(1) NOT NULL DEFAULT '0' COMMENT '是否登打日誌 {0 : 待處理, 1 : 系統判定免登打, 2 : 申請免登打, 3 : 系統判定登打, 4 : 申請登打}',
  `company_code` VARCHAR(20) NULL DEFAULT NULL COMMENT '公司代碼',
  `change_code` VARCHAR(10) NULL DEFAULT NULL COMMENT '異動代碼',
  `modify_date` DATETIME NULL DEFAULT NULL COMMENT '資料異動日期',
  `self_def1` VARCHAR(50) NULL DEFAULT NULL COMMENT '自定義欄位1',
  `self_def2` VARCHAR(50) NULL DEFAULT NULL COMMENT '自定義欄位2',
  `self_def3` VARCHAR(50) NULL DEFAULT NULL COMMENT '自定義欄位3',
  PRIMARY KEY (`id`),
  INDEX `idx_tcs_department` (`fin_code`)
)
COMMENT='部門資料'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `tb_tcs_job_level_cost` (
  `company_code` VARCHAR(20) NOT NULL COMMENT '公司代碼',
  `location` VARCHAR(20) NOT NULL COMMENT '據點代碼',
  `job_level` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '職等',
  `cost` FLOAT NOT NULL DEFAULT '0' COMMENT '人月成本（單位：萬元）',
  `currency_type` VARCHAR(20) NOT NULL DEFAULT 'NTD' COMMENT '貨幣代碼',
  PRIMARY KEY (`company_code`, `location`, `job_level`)
)
COMMENT='職等人力成本對照表'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `tb_tcs_lookup_code` (
  `module` VARCHAR(8) NOT NULL COMMENT '系統/模組',
  `type` VARCHAR(32) NOT NULL COMMENT '類型',
  `code` VARCHAR(32) NOT NULL COMMENT '代碼',
  `value` VARCHAR(255) NULL DEFAULT NULL COMMENT '值',
  `display_order` INT(11) NULL DEFAULT NULL COMMENT '顯示順序',
  `label` VARCHAR(64) NULL DEFAULT NULL COMMENT '顯示文字',
  `memo` VARCHAR(128) NULL DEFAULT NULL COMMENT '備註',
  PRIMARY KEY (`module`, `type`, `code`)
)
COMMENT='系統代碼記錄檔'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `tb_tcs_opportunities` (
  `oin` VARCHAR(50) NOT NULL COMMENT 'OIN Code',
  `company_code` VARCHAR(36) NOT NULL COMMENT '公司代碼',
  `pin` VARCHAR(50) NULL DEFAULT NULL COMMENT 'PIN Code',
  `bin` VARCHAR(50) NULL DEFAULT NULL COMMENT 'BIN Code',
  `name` VARCHAR(80) NOT NULL COMMENT '專案名稱',
  `customer_id` VARCHAR(50) NOT NULL COMMENT '客戶代碼',
  `win_rate` TINYINT(4) NOT NULL COMMENT 'Win Rate',
  `sales_dept_fin_code` VARCHAR(50) NOT NULL COMMENT '業務部門財務碼',
  `sales_user_id` VARCHAR(50) NOT NULL COMMENT '業務員工編號',
  `pm_dept_fin_code` VARCHAR(50) NULL DEFAULT NULL COMMENT 'PM部門財務碼',
  `pm_user_id` VARCHAR(50) NULL DEFAULT NULL COMMENT 'PM員工編號',
  `modify_date` DATETIME NULL DEFAULT NULL COMMENT '異動時間',
  PRIMARY KEY (`oin`, `company_code`),
  INDEX `idx_tcs_opportunities1` (`sales_dept_fin_code`),
  INDEX `idx_tcs_opportunities2` (`sales_user_id`),
  INDEX `idx_tcs_opportunities3` (`pm_dept_fin_code`),
  INDEX `idx_tcs_opportunities4` (`pm_user_id`),
  INDEX `idx_tcs_opportunities5` (`oin`),
  INDEX `idx_tcs_opportunities6` (`name`)
)
COMMENT='CRM業務機會（CRM同步至TCS）'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `tb_tcs_report_calendar` (
  `company_code` VARCHAR(20) NOT NULL COMMENT '公司代碼',
  `location` VARCHAR(20) NOT NULL COMMENT '據點代碼',
  `type` VARCHAR(20) NOT NULL COMMENT '日曆類型',
  `name` VARCHAR(50) NOT NULL COMMENT '日曆名稱',
  `start_date` DATE NOT NULL COMMENT '起始日',
  `end_date` DATE NOT NULL COMMENT '結束日',
  `total_work_hour` SMALLINT(6) NOT NULL COMMENT '總工時',
  PRIMARY KEY (`company_code`, `location`, `type`, `name`)
)
COMMENT='報表日曆'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `tb_tcs_user` (
  `id` VARCHAR(10) NOT NULL COMMENT '員工編號',
  `dept_id` VARCHAR(20) NULL DEFAULT NULL COMMENT '部門代碼',
  `name` VARCHAR(30) NULL DEFAULT NULL COMMENT '姓名',
  `eng_name` VARCHAR(50) NULL DEFAULT NULL COMMENT '英文名',
  `eng_fullname` VARCHAR(60) NULL DEFAULT NULL COMMENT '英文名（護照）',
  `title` VARCHAR(50) NULL DEFAULT NULL COMMENT '頭銜',
  `fn_manager_user_id` VARCHAR(20) NULL DEFAULT NULL COMMENT '虛擬主管員工編號，非虛擬組的概念',
  `job_type` VARCHAR(10) NULL DEFAULT NULL COMMENT '職務類別代碼',
  `job_cat` VARCHAR(60) NULL DEFAULT NULL COMMENT '職務分類',
  `job_level` VARCHAR(10) NULL DEFAULT NULL COMMENT '職級',
  `mail` VARCHAR(100) NULL DEFAULT NULL COMMENT '電子郵件',
  `onboard_date` DATETIME NULL DEFAULT NULL COMMENT '到職日',
  `leave_date` DATETIME NULL DEFAULT NULL COMMENT '離職日',
  `location_info` VARCHAR(100) NULL DEFAULT NULL COMMENT '工作地點',
  `tel_number` VARCHAR(40) NULL DEFAULT NULL COMMENT '電話號碼',
  `ext_number` VARCHAR(30) NULL DEFAULT NULL COMMENT '分機',
  `use_tcs` VARCHAR(1) NOT NULL DEFAULT '0' COMMENT '是否登打日誌{0 : 待處理, 1 : 系統判定免登打, 2 : 申請免登打, 3 : 系統判定登打, 4 : 申請登打}',
  `is_main` VARCHAR(1) NOT NULL DEFAULT '0' COMMENT '是否爲主身份 { 0 : 非主身份, 1 : 主身份}',
  `company_code` VARCHAR(20) NULL DEFAULT NULL COMMENT '公司代碼',
  `country_code` VARCHAR(10) NULL DEFAULT NULL COMMENT '國別碼',
  `change_code` VARCHAR(10) NULL DEFAULT NULL COMMENT '異動代碼',
  `modify_date` DATETIME NULL DEFAULT NULL COMMENT '修改時間',
  `self_def1` VARCHAR(50) NULL DEFAULT NULL,
  `self_def2` VARCHAR(50) NULL DEFAULT NULL,
  `self_def3` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_tcs_user` (`id`)
)
COMMENT='系統使用者'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `tb_tcs_dept_level` (
  `dept_id` varchar(20) NOT NULL DEFAULT '' COMMENT '部門代碼',
  `level1` varchar(20) DEFAULT NULL COMMENT '層級1',
  `level2` varchar(20) DEFAULT NULL COMMENT '層級2',
  `level3` varchar(20) DEFAULT NULL COMMENT '層級3',
  `level4` varchar(20) DEFAULT NULL COMMENT '層級4',
  `level5` varchar(20) DEFAULT NULL COMMENT '層級5',
  `level6` varchar(20) DEFAULT NULL COMMENT '層級6',
  `level7` varchar(20) DEFAULT NULL COMMENT '層級7',
  `level8` varchar(20) DEFAULT NULL COMMENT '層級8',
  `level9` varchar(20) DEFAULT NULL COMMENT '層級9',
  `level10` varchar(20) DEFAULT NULL COMMENT '層級10',
  `level11` varchar(20) DEFAULT NULL COMMENT '層級11',
  `level12` varchar(20) DEFAULT NULL COMMENT '層級12',
  `level13` varchar(20) DEFAULT NULL COMMENT '層級13',
  `level14` varchar(20) DEFAULT NULL COMMENT '層級14',
  `level15` varchar(20) DEFAULT NULL COMMENT '層級15',
  `level16` varchar(20) DEFAULT NULL COMMENT '層級16',
  `level17` varchar(20) DEFAULT NULL COMMENT '層級17',
  `level18` varchar(20) DEFAULT NULL COMMENT '層級18',
  `level19` varchar(20) DEFAULT NULL COMMENT '層級19',
  `level20` varchar(20) DEFAULT NULL COMMENT '層級20',
  PRIMARY KEY (`dept_id`),
  INDEX `idx_tcs_dept_level1` (`level1`),
  INDEX `idx_tcs_dept_level2` (`level2`),
  INDEX `idx_tcs_dept_level3` (`level3`),
  INDEX `idx_tcs_dept_level4` (`level4`),
  INDEX `idx_tcs_dept_level5` (`level5`),
  INDEX `idx_tcs_dept_level6` (`level6`),
  INDEX `idx_tcs_dept_level7` (`level7`),
  INDEX `idx_tcs_dept_level8` (`level8`),
  INDEX `idx_tcs_dept_level9` (`level9`),
  INDEX `idx_tcs_dept_level10` (`level10`),
  INDEX `idx_tcs_dept_level11` (`level11`),
  INDEX `idx_tcs_dept_level12` (`level12`),
  INDEX `idx_tcs_dept_level13` (`level13`),
  INDEX `idx_tcs_dept_level14` (`level14`),
  INDEX `idx_tcs_dept_level15` (`level15`),
  INDEX `idx_tcs_dept_level16` (`level16`),
  INDEX `idx_tcs_dept_level17` (`level17`),
  INDEX `idx_tcs_dept_level18` (`level18`),
  INDEX `idx_tcs_dept_level19` (`level19`),
  INDEX `idx_tcs_dept_level20` (`level20`)
)
COMMENT='部門層級資料'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `tb_tcs_kiosk` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '流水號',
  `app` VARCHAR(10) NOT NULL COMMENT '取票機系統別 (PBT/OSS/TCS)',
  `principal` VARCHAR(20) NOT NULL COMMENT '取票時的認證帳號',
  `token` VARCHAR(45) NOT NULL COMMENT '票號',
  `status` VARCHAR(1) NOT NULL COMMENT '票號狀態 (N: 新產生 / X: 已使用)',
  `time_to_life` VARCHAR(20) NOT NULL COMMENT 'TTL 票號存活時間描述',
  `api` VARCHAR(100) NULL DEFAULT NULL,
  `input` VARCHAR(255) NULL DEFAULT NULL,
  `output` TEXT NULL,
  `error_code` INT(5) NULL,
  `error_message` TEXT NULL,
  `create_user` VARCHAR(10) NOT NULL COMMENT '建立者',
  `create_date` DATETIME NOT NULL COMMENT '建立時間',
  PRIMARY KEY (`id`),
  INDEX `idx_pbt_kiosk` (`app`, `principal`, `token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系統取票機';
