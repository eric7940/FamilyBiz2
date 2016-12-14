package com.systex.emp.manager.web.filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.systex.emp.base.util.ConstUtil;
import com.systex.emp.manager.exception.EmpManagerException;
import com.systex.emp.manager.service.AuthenticateService;
import com.systex.emp.manager.service.CommonService;
import com.systex.emp.manager.vo.UserVO;

public class AuthenticateFilter extends EmpManagerFilter {

	private static final Logger logger = Logger.getLogger(AuthenticateFilter.class);

	private final Set<String> excludePatterns;
	private final Set<String> postPatterns;

	public AuthenticateFilter() {
		this.excludePatterns = new HashSet<String>();
		this.postPatterns = new HashSet<String>();
	}
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		super.init(config);
		
		String initParam = config.getInitParameter("excludePatterns");
		if(initParam!=null) {
			String[] values = initParam.split(",");
			for (String value : values) {
				this.excludePatterns.add(value.trim());
			}
		}
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		
		String requestURL = request.getRequestURI().toString();
		logger.debug("request URL: " + requestURL);
//		String requestedPage = getRequestedPage(request);
		
		String guid = null;
		String userId = null;
		AuthenticateService as = null;

		if (requestURL.equals(request.getContextPath() + "/")) {
			logger.debug("redirect to index");
			response.sendRedirect(request.getContextPath() + "/index.do");
			return;
		}
		
		if (matchExcludePatterns(requestURL)) {
			logger.debug("match exclude pattern, so skip. (" + requestURL + ")");
		    chain.doFilter(request, response);
		    return;
		}
		
		if (request.getSession().getAttribute(ConstUtil.SESSION_ATTR_USER) == null) {
			logger.debug("redirect to login");
			response.sendRedirect(request.getContextPath() + "/loginform.do");
			return;
		}

		chain.doFilter(req, res);

	}

	private boolean matchExcludePatterns(String requestURL) {
		//所有的action(除了exclude名單)都要過filter >> return false
		//非action的一律都跳過filter >> return true
		
		//非action的一律都跳過filter >> return true
		if (StringUtils.endsWith(requestURL, ".do") == false) {
			return true;
		}
		
//		Pattern p = Pattern.compile("(\\w+)!?(\\w+)?\\.do");
//	    Matcher m = p.matcher(requestURL);
//	    if (m.matches()) {
//	    	logger.debug("that's Struts Action! (actionName=" + m.group(0) + ",method=" + m.group(1) + ")");
//	    	return true;
//	    }

		//所有的action(除了exclude名單)都要過filter >> return false
		for (String excludePattern : excludePatterns) {
			if (StringUtils.contains(requestURL, excludePattern)) {
				logger.debug("the requestURL:" + requestURL + " match exclude pattern:" + excludePattern + " , not need to verify");
				return true;
			}
		}
		return false;
	}
	
}
