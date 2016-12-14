CREATE TABLE `tb_pbt` (
  `project_id` varchar(24) NOT NULL COMMENT '專案代碼',
  `stage` varchar(1) NOT NULL COMMENT 'P: Pipleline立案階段 / B: Backlog立案階段 / I: Internal內部立案',
  `version` varchar(4) NOT NULL COMMENT '版本：0000 (草稿：9999；版本自0001起算；然而Pipeline沒有版本歷程，所以僅會有0001版)',
  `total_cost` float NOT NULL DEFAULT '0' COMMENT '預估總金額',
  `total_manday` float NOT NULL DEFAULT '0' COMMENT '預估總人天',
  `start_date` date DEFAULT NULL COMMENT '預估起日',
  `end_date` date DEFAULT NULL COMMENT '預估迄日',
  `create_user` varchar(10) NOT NULL COMMENT '建立者',
  `create_date` datetime NOT NULL COMMENT '建立時間',
  `modify_user` varchar(10) NOT NULL COMMENT '修改者',
  `modify_date` datetime NOT NULL COMMENT '修改時間',
  PRIMARY KEY (`project_id`,`stage`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='專案人力成本預估主檔';

CREATE TABLE `tb_pbt_details` (
  `id` varchar(35) NOT NULL COMMENT '編號：project_id + stage + version + 0000',
  `project_id` varchar(24) NOT NULL COMMENT '專案代碼',
  `stage` varchar(1) NOT NULL COMMENT 'P: Pipleline立案階段 / B: Backlog立案階段 / I: Internal內部立案',
  `version` varchar(4) NOT NULL COMMENT '版本：0000 (草稿：9999；版本自0001起算；然而Pipeline沒有版本歷程，所以僅會有0001版)',
  `dept_id` varchar(20) NOT NULL COMMENT '支援部門',
  `user_id` varchar(10) NOT NULL COMMENT '支援人員 / -:人員未定 或者為 Pipeline立案階段)',
  `role` varchar(20) NOT NULL COMMENT '角色',
  `grade` int(10) NOT NULL COMMENT '職等',
  `cost_rate` float NOT NULL COMMENT '每個人天的成本',
  `manday` float NOT NULL COMMENT '預估人天',
  `head_count` int(10) NOT NULL COMMENT '人數',
  `manday_details` text COMMENT '起迄期間每月的預估人天，以JSON表示',
  `state` varchar(20) DEFAULT NULL COMMENT '簽核選擇狀態 (APPLY: 挑選送簽 /  NULL: 未被挑選)',
  `create_user` varchar(10) NOT NULL COMMENT '建立者',
  `create_date` datetime NOT NULL COMMENT '建立時間',
  `modify_user` varchar(10) NOT NULL COMMENT '修改者',
  `modify_date` datetime NOT NULL COMMENT '修改時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_pbt_details1` (`project_id`,`stage`,`version`,`dept_id`,`user_id`,`role`,`grade`),
  KEY `idx_pbt_details2` (`project_id`,`stage`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='專案人力成本預估明細檔';

CREATE TABLE `tb_pbt_internal` (
  `form_id` varchar(20) NOT NULL COMMENT 'WF單號',
  `form_type` varchar(20) NOT NULL COMMENT 'WF表單類型 {INT: 内部立案, INC: 内部立案變更}',
  `project_id` varchar(24) DEFAULT NULL COMMENT '内部專案代碼（審核通過後才更新）',
  `project_name` varchar(100) NOT NULL COMMENT '專案名稱',
  `initiator_dept_fin_code` varchar(20) NOT NULL COMMENT 'WF流程發起人部門財務碼',
  `initiator_user_id` varchar(10) DEFAULT NULL COMMENT 'WF流程發起人員工編號',
  `pm_dept_fin_code` varchar(20) NOT NULL COMMENT 'PM部門財務碼',
  `pm_user_id` varchar(10) NOT NULL COMMENT 'PM員工編號',
  `company_code` varchar(20) NOT NULL COMMENT '公司代碼',
  `modify_date` datetime NOT NULL COMMENT '修改時間',
  PRIMARY KEY (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='内部立案發起記錄';

CREATE TABLE `tb_pbt_versions` (
  `project_id` varchar(24) NOT NULL COMMENT '專案代碼',
  `stage` varchar(1) NOT NULL COMMENT 'P: Pipleline立案階段 / B: Backlog立案階段 / I: Internal內部立案',
  `version` varchar(4) NOT NULL COMMENT '版本：0000 (草稿：9999；版本自0001起算；然而Pipeline沒有版本歷程，所以僅會有0001版)',
  `status` varchar(20) DEFAULT NULL COMMENT '狀態 (LOCK: 鎖定(適用於Pipeline) / APPLY: 送簽(適用於Backlog及內部立案) / APPROVED: 簽核同意 /  REJECT: 簽核不同意)',
  `description` varchar(255) DEFAULT NULL COMMENT '版本說明',
  `form_id` varchar(10) DEFAULT NULL COMMENT 'WF流程表單單號',
  `create_user` varchar(10) NOT NULL COMMENT '建立者',
  `create_date` datetime NOT NULL COMMENT '建立時間',
  `modify_user` varchar(10) NOT NULL COMMENT '修改者',
  `modify_date` datetime NOT NULL COMMENT '修改時間',
  PRIMARY KEY (`project_id`,`stage`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='專案人力成本預估版本記錄';

insert into tb_tcs_lookup_code values('PBT','DUMMY_LOGIN','PASSWORD','ca2d3140ba7d4abe3df0e6c67966ed28',NULL,NULL,NULL);
insert into tb_tcs_lookup_code values('PBT','DATA_PERMS_SYS','1400404',NULL,NULL,NULL,'李聿城');


