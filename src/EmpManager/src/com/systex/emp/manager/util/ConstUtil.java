package com.systex.emp.manager.util;

public class ConstUtil {

	public static final String SESSION_ATTR_CURR_MENU = "CURR_MENU";
	
	public static final String SESSION_ATTR_MENU = "MENU";
	public static final String SESSION_ATTR_LEFT_MENU = "LEFT_MENU";

	public static final String SESSION_ATTR_USER_INFO = "USER_INFO"; 
	
	public static final String SESSION_ATTR_TOP_DISPLAY_NONE = "TOP_DISPLAY_NONE"; 

	public static final String REQUEST_ATTR_FUNC_TITLE = "FUNC_TITLE";

	public static String WEB_APP_CONTEXT_PATH;
	public static String WEB_APP_TITLE = "WEB_APP_TITLE";
	
	public static final int REPORT_SIZE = 500000; 
	
	public static final String STAGE_PIPELINE = "P";
	public static final String STAGE_BACKLOG = "B";
	public static final String STAGE_INTERNAL = "I";

	public static final String VERSION_DRAFT = "9999";
	public static final String VERSION_PIPELINE = "0001";
	
	public static final String PERIOD_BETWEEN_MIN = "min_date";
	public static final String PERIOD_BETWEEN_MAX = "max_date";
	
	public static final String STATUS_LOCK = "LOCK";
	public static final String STATUS_APPLY = "APPLY";
	public static final String STATUS_APPROVED = "APPROVED";
	public static final String STATUS_REJECT = "REJECT";
	
	public static final String STATE_APPLY = "APPLY";
	
	public static int getActiveTab(String stage) {
		if (STAGE_PIPELINE.equals(stage))
			return 1;
		if (STAGE_BACKLOG.equals(stage))
			return 2;
		if (STAGE_INTERNAL.equals(stage))
			return 3;
		return 1;
	}
}

