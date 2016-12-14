package com.systex.emp.manager.web.filter;

import javax.servlet.Filter;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.systex.emp.base.service.ServiceFactory;

public abstract class EmpManagerFilter implements Filter {

	private ServiceFactory serviceFactory;

	@Override
	public void init(FilterConfig config) throws ServletException {
		ServletContext servletContext = config.getServletContext();
		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
		this.serviceFactory = (ServiceFactory) wac.getBean("serviceFactory");
	}

	@Override
	public void destroy() {
	}
	
	protected ServiceFactory getServiceFactory() {
		return this.serviceFactory;
	}
}
