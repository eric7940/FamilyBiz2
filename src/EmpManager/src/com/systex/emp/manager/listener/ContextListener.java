package com.systex.emp.manager.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.systex.emp.base.service.ServiceFactory;

public class ContextListener implements ServletContextListener {

	private static final Logger logger = Logger.getLogger(ContextListener.class);

	public void contextInitialized(ServletContextEvent sce) {

		try {

			logger.info("contextInitialized.....");

			ServletContext sc = sce.getServletContext();
			  
			com.systex.emp.manager.util.ConstUtil.WEB_APP_CONTEXT_PATH = sc.getRealPath("/");
			logger.debug("web context path:" + com.systex.emp.manager.util.ConstUtil.WEB_APP_CONTEXT_PATH);

			WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
			ServiceFactory serviceFactory = (ServiceFactory) context.getBean("serviceFactory");

			String apTitle = sc.getInitParameter("webAppPageTitle");
			sc.setAttribute(com.systex.emp.manager.util.ConstUtil.WEB_APP_TITLE, apTitle);
			logger.info("WEB_APP_TITLE: " + apTitle);
			
//			CommonService commonService = (CommonService) serviceFactory.getService("commonService");
//			Map<String, Map<String, String>> localeMessages = commonService.getLocaleMessages();
//			sce.getServletContext().setAttribute(ConstUtil.CONTEXT_ATTR_LOCALE_MESSAGE, localeMessages);
//			logger.info("LocaleMessages: " + localeMessages);
//
//			List<LocaleVO> mappings = commonService.getLocaleMapping();
//			LocaleConverter.resetLocaleMapping(mappings);
//
//			LocaleService localeService = (LocaleService) serviceFactory.getService("localeService");
//			List<LocaleVO> locales = localeService.getLocales();
//			sce.getServletContext().setAttribute(ConstUtil.CONTEXT_ATTR_LOCALES, locales);
//			logger.info("Locales: " + locales);

		} catch (Exception e) {
			logger.error("contextInitialized Fail", e);
		}
	}

	public void contextDestroyed(ServletContextEvent arg0) {
		logger.debug("contextDestroyed.....");
	}

}
