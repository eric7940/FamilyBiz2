package com.systex.emp.manager.util;

import com.systex.emp.base.util.BaseCodeType;
import com.systex.emp.base.util.ConstEnumerable;
import com.systex.emp.base.util.EnumUtil;

public class EmpEnum {

	public enum CodeType implements BaseCodeType {
		是否選項, 鍵值種類, 參數值形態, 角色類別, 部門現況, 使用者現況, 性別, 群組類別
		// menu
		, 選單種類, 選單層級, 選單actionType, 資料權限種類, 選單開啟方式
		//oss
		,OSS交付項目類型, OSS適用委外條件
		;

		static {
			EnumUtil.runEnum(EmpEnum.class);
		}
	}	
	
	public enum 是否選項 implements ConstEnumerable {
		否(0), 是(1);

		private int value;

		private 是否選項(int value) {
			this.value = value;
			EnumUtil.setEnum(CodeType.是否選項, this);
		}

		public int getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "global.option." + (value == 1);
		}

		public boolean isDisplay() {
			return true;
		}

		@Override
		public String toString() {
			return "" + this.value;
		}
	}

	public enum 群組類別 implements ConstEnumerable {
		部門群組("group_dept"), 使用者群組("group_user");

		private String value;

		private 群組類別(String value) {
			this.value = value;
			EnumUtil.setEnum(CodeType.群組類別, this);
		}

		public String getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "group.groupType." + value;
		}

		public boolean isDisplay() {
			return true;
		}

		@Override
		public String toString() {
			return this.value;
		}
	}

	public enum 參數值形態 implements ConstEnumerable {
		數字(1), 字串(2), 日期(3), 圖檔(4);

		private int value;

		private 參數值形態(int value) {
			this.value = value;
			EnumUtil.setEnum(CodeType.參數值形態, this);
		}

		public int getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "config.type." + value;
		}

		public boolean isDisplay() {
			return true;
		}

		@Override
		public String toString() {
			return "" + this.value;
		}
	}

	public enum 鍵值種類 implements ConstEnumerable {
		選單名稱("menu", true), 選單細項名稱("menu_item", false), 選單Function名稱("menu_function", true);

		private String value;
		private boolean isDisplay;

		private 鍵值種類(String value, boolean isDisplay) {
			this.value = value;
			this.isDisplay = isDisplay;
			EnumUtil.setEnum(CodeType.鍵值種類, this);
		}

		public String getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "lang.kind." + value;
		}

		public boolean isDisplay() {
			return this.isDisplay;
		}

		@Override
		public String toString() {
			return this.value;
		}
	}

	public enum 角色類別 implements ConstEnumerable {
		部門主管("D", true), 部門助理("A", false), 員工("E", true), 自訂群組("G", true);

		private String value;
		private boolean isDisplay;

		private 角色類別(String value, boolean isDisplay) {
			this.value = value;
			this.isDisplay = isDisplay;
			EnumUtil.setEnum(CodeType.角色類別, this);
		}

		public String getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "permission.type." + value;
		}

		public boolean isDisplay() {
			return this.isDisplay;
		}

		@Override
		public String toString() {
			return this.value;
		}
	}

	public enum 部門現況 implements ConstEnumerable {
		集團("A"), 廢除("D"), 使用中("U");

		private String value;

		private 部門現況(String value) {
			this.value = value;
			EnumUtil.setEnum(CodeType.部門現況, this);
		}

		public String getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "dept.status." + value;
		}

		public boolean isDisplay() {
			return true;
		}

		@Override
		public String toString() {
			return this.value;
		}
	}

	public enum 使用者現況 implements ConstEnumerable {
		使用中("U"), 廢除("D");

		private String value;

		private 使用者現況(String value) {
			this.value = value;
			EnumUtil.setEnum(CodeType.使用者現況, this);
		}

		public String getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "user.status." + value;
		}

		public boolean isDisplay() {
			return true;
		}

		@Override
		public String toString() {
			return this.value;
		}
	}

	public enum 性別 implements ConstEnumerable {
		女("F"), 男("M");

		private String value;

		private 性別(String value) {
			this.value = value;
			EnumUtil.setEnum(CodeType.性別, this);
		}

		public String getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "global.sex." + value;
		}

		public boolean isDisplay() {
			return true;
		}

		@Override
		public String toString() {
			return this.value;
		}
	}

	public enum 選單種類 implements ConstEnumerable {
		前台app(1), 後台web(2);

		private int value;

		private 選單種類(int value) {
			this.value = value;
			EnumUtil.setEnum(CodeType.選單種類, this);
		}

		public int getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "menu.kind." + value;
		}

		public boolean isDisplay() {
			return true;
		}

		@Override
		public String toString() {
			return "" + this.value;
		}
	}

	public enum 選單層級 implements ConstEnumerable {
		第一層(1), 第二層(2);

		private int value;

		private 選單層級(int value) {
			this.value = value;
			EnumUtil.setEnum(CodeType.選單層級, this);
		}

		public int getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "menu.level." + value;
		}

		public boolean isDisplay() {
			return true;
		}

		@Override
		public String toString() {
			return "" + this.value;
		}
	}

	public enum 選單actionType implements ConstEnumerable {
		URL(0, true), 影片(1, true), 動態選單(2, true), 訊息(3, false);

		private int value;
		private boolean isDisplay;

		private 選單actionType(int value, boolean isDisplay) {
			this.value = value;
			this.isDisplay = isDisplay;
			EnumUtil.setEnum(CodeType.選單actionType, this);
		}

		public int getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "menu.actionType." + value;
		}

		public boolean isDisplay() {
			return this.isDisplay;
		}

		@Override
		public String toString() {
			return "" + this.value;
		}
	}

	public enum 選單開啟方式 implements ConstEnumerable {
		內部開啟(0), 另開視窗(1);

		private int value;

		private 選單開啟方式(int value) {
			this.value = value;
			EnumUtil.setEnum(CodeType.選單開啟方式, this);
		}

		public int getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "menu.openType." + value;
		}

		public boolean isDisplay() {
			return true;
		}

		@Override
		public String toString() {
			return "" + this.value;
		}
	}

	public enum 資料權限種類 implements ConstEnumerable {
		部門(0), 部門含轄下(1), 部門群組(2);

		private int value;

		private 資料權限種類(int value) {
			this.value = value;
			EnumUtil.setEnum(CodeType.資料權限種類, this);
		}

		public int getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "permissionMenuData.kind." + value;
		}

		public boolean isDisplay() {
			return true;
		}

		@Override
		public String toString() {
			return "" + this.value;
		}
	}

	public enum OSS交付項目類型 implements ConstEnumerable {
		整體("1", true), 程式("2", true), 元件設計("3", true), 美術設計("4", true), 網頁設計("5", true), 其它("6", true);

		private String value;
		private boolean isDisplay;

		private OSS交付項目類型(String value, boolean isDisplay) {
			this.value = value;
			this.isDisplay = isDisplay;
			EnumUtil.setEnum(CodeType.OSS交付項目類型, this);
		}

		public String getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "oss.supplierType." + value;
		}

		public boolean isDisplay() {
			return this.isDisplay;
		}

		@Override
		public String toString() {
			return "" + this.value;
		}
	}
	
	public enum OSS適用委外條件 implements ConstEnumerable {
		軟體開發("1", true), 系統整合("2", true), 人力派遣("3", true), 教育訓練("4", true), 顧問諮詢("5", true), 維護("6", true), 外包工程("7", true), 其他("8", true);

		private String value;
		private boolean isDisplay;

		private OSS適用委外條件(String value, boolean isDisplay) {
			this.value = value;
			this.isDisplay = isDisplay;
			EnumUtil.setEnum(CodeType.OSS適用委外條件, this);
		}

		public String getValue() {
			return this.value;
		}

		public String getResourceKey() {
			return "oss.supplierOutside." + value;
		}

		public boolean isDisplay() {
			return this.isDisplay;
		}

		@Override
		public String toString() {
			return "" + this.value;
		}
	}


	/**
	 * 權限名稱key[多語設定內容](i18n)
	 */
	public enum PermissionName {
		employee("employee"), departmentHead("department.head"), departmentAssistant("department.assistant");
		String value = "";
		String resourceKey = "";

		private PermissionName(String value) {
			this.value = value;
			this.resourceKey = "permission.permissionName." + value;
		}

		/**
		 * i18n的resourceKey
		 * 
		 * @return
		 */
		public String resourceKey() {
			return this.resourceKey;
		}

		/**
		 * 資料庫的值(permission.permissionName)
		 * 
		 * @return
		 */
		public String getValue() {
			return "" + this.value;
		}
	}
}
