package com.fb.web.filter;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

public class PermissionFilter extends EmpManagerFilter {

	private static final Logger logger = Logger.getLogger(PermissionFilter.class);

	private final static Pattern PATTERN = Pattern.compile("/?(\\w+)*!?(\\w+)?\\.do");

	private final Set<String> excludePatterns;
	
	public PermissionFilter() {
		this.excludePatterns = new HashSet<String>();
	}
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		super.init(config);
		
		String[] values = config.getInitParameter("excludePatterns").split(",");
		for (String value : values) {
			this.excludePatterns.add(value.trim());
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
//		HttpServletRequest request = (HttpServletRequest) req;
//		HttpServletResponse response = (HttpServletResponse) res;
//		
//		String requestURL = request.getRequestURI().toString();
//		logger.debug("request URL: " + requestURL);
//		
//		if (matchExcludePatterns(requestURL)) {
//			logger.debug("match exclude pattern, so skip. (" + requestURL + ")");
//		    chain.doFilter(request, response);
//		    return;
//		}
//		
////		final String menuId = (String) request.getSession().getAttribute(com.systex.emp.manager.util.ConstUtil.SESSION_ATTR_CURR_MENU);
//		List<MenuVO> menus = (List<MenuVO>) request.getSession().getAttribute(com.systex.emp.manager.util.ConstUtil.SESSION_ATTR_LEFT_MENU);
//		final Integer menuId = getMenuIdFromURL(menus, requestURL);
//		final String authorizedMenus = (String) request.getSession().getAttribute(com.systex.emp.manager.util.ConstUtil.SESSION_ATTR_MENU);
//		
//		//檢查1: 功能是否授權?
//		if (authorizedMenus.contains("," + menuId) == false) {
//			logger.error("the user is not authorized to access the menu:" + menuId + ")");
//			response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
//			return;
//		}
//		
////		//檢查2: 模組是否可使用?
////		final String tenantHash = (String) request.getSession().getAttribute(com.systex.emp.manager.util.ConstUtil.SESSION_ATTR_TENANT_HASH);
////		if ("empty".equals(tenantHash) == false) {
////			TenantService tenantService = (TenantService) getServiceFactory().getService("tenantService");
////			final String tenantAlias = (String) request.getSession().getAttribute(com.systex.emp.manager.util.ConstUtil.SESSION_ATTR_TENANT);
////			if (tenantService.checkModuleAuthorized(tenantAlias, menuId) == false) {
////				logger.error("the user is not authorized to access the module:" + menuId + ")");
////				response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
////				return;
////			}
////		}
//		
//		logger.debug("authorized menu:" + menuId);
//		request.getSession().setAttribute(com.systex.emp.manager.util.ConstUtil.SESSION_ATTR_CURR_MENU, menuId);
		chain.doFilter(req, res);
	}

	private boolean matchExcludePatterns(String requestURL) {
		//所有的action(除了exclude名單)都要過filter >> return false
		for (String excludePattern : excludePatterns) {
			if (StringUtils.contains(requestURL, excludePattern)) {
				logger.debug("the requestURL:" + requestURL + " match exclude pattern:" + excludePattern + " , not need to verify");
				return true;
			}
		}
		return false;
	}
	
//	private Integer getMenuIdFromURL(List<MenuVO> menus, String requestURL) {
//		String tokens[] = requestURL.split("/");
//	    requestURL = tokens[tokens.length - 1];
//	    logger.debug("requestURL: " + requestURL);
//	    
//	    //先以原本的URL去找，找不到再把method的部份拿掉後，再找一次
//	    for (MenuVO menu : menus) {
//	    	String menuAction = menu.getAction();
//	    	if (menuAction.contains(requestURL))
//	    		return menu.getId();
//		}
//	    
//	    Matcher m = PATTERN.matcher(requestURL);
//	    String actionName = null;
//	    String methodName = null;
//	    if (m.matches()) {
//	    	actionName = m.group(1);
//	    	methodName = m.group(2);
//	    	logger.debug("action:" + actionName + " ,method:" + methodName);
//	    	if (actionName != null && methodName != null) {
//	    		actionName += ".do";
//	    		for (MenuVO menu : menus) {
//	    	    	String menuAction = menu.getAction();
//	    	    	if (menuAction.contains(actionName))
//	    	    		return menu.getId();
//	    		}
//	    	}
//	    }
//		return -1;
//		
//	}
}
