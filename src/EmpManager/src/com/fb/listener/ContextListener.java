package com.fb.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.fb.service.ServiceFactory;
import com.fb.util.ConstUtil;

public class ContextListener implements ServletContextListener {

	private static final Logger logger = Logger.getLogger(ContextListener.class);

	public void contextInitialized(ServletContextEvent sce) {

		try {

			logger.info("contextInitialized.....");

			ServletContext sc = sce.getServletContext();
			  
			ConstUtil.WEB_APP_CONTEXT_PATH = sc.getRealPath("/");
			logger.debug("web context path:" + ConstUtil.WEB_APP_CONTEXT_PATH);

			WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
			ServiceFactory serviceFactory = (ServiceFactory) context.getBean("serviceFactory");

			String apTitle = sc.getInitParameter("webAppPageTitle");
			sc.setAttribute(ConstUtil.WEB_APP_TITLE, apTitle);
			logger.info("WEB_APP_TITLE: " + apTitle);
			

		} catch (Exception e) {
			logger.error("contextInitialized Fail", e);
		}
	}

	public void contextDestroyed(ServletContextEvent arg0) {
		logger.debug("contextDestroyed.....");
	}

}
