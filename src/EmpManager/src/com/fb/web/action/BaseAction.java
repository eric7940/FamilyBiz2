package com.fb.web.action;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.util.ServletContextAware;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.fb.service.ServiceFactory;
import com.fb.util.ConstUtil;
import com.fb.vo.LookupCodeVO;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

public class BaseAction extends ActionSupport implements ServletContextAware, ServletRequestAware, ServletResponseAware, Preparable {

	private static final long serialVersionUID = -2393079713297439505L;

	private static final Logger logger = Logger.getLogger(BaseAction.class);

	protected ServletContext context;
	private ServiceFactory serviceFactory;

	protected HttpServletRequest request;
	protected HttpServletResponse response;

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	@Override
	public void setServletContext(ServletContext context) {
		this.context = context;
	}

	protected ServiceFactory getServiceFactory() {
		return this.serviceFactory;
	}

	@Override
	public void prepare() throws Exception {
		if (this.serviceFactory == null) {
			logger.info("Struts Action prepare");
			WebApplicationContext cxt = WebApplicationContextUtils.getWebApplicationContext(context);
			this.serviceFactory = (ServiceFactory) cxt.getBean("serviceFactory");
		}
	}
	
	public String getUserInfo() {
		return (String) this.request.getSession().getAttribute(ConstUtil.SESSION_ATTR_USER);
	}
	
	protected void addLocalizationActionSuccess(String actionKey) {
		this.addActionMessage(this.getText("global.message.success", new String[]{this.getText("global.action." + actionKey)}));
	}
	
	protected void addLocalizationActionMessage(String key) {
		this.addLocalizationActionMessage(key, null);
	}

	protected void addLocalizationActionMessage(String key, String[] args) {
		if (args == null) {
			this.addActionMessage(this.getText(key));
		} else {
			this.addActionMessage(this.getText(key, args));
		}
	}
	
	protected void addLocalizationActionError(String key) {
		this.addLocalizationActionError(key, null);
	}

	protected void addLocalizationActionError(String key, String[] args) {
		if (args == null) {
			this.addActionError(this.getText("global.error", new String[]{this.getText(key)}));
		} else {
			this.addActionError(this.getText("global.error", new String[]{this.getText(key, args)}));
		}
	}

	protected void addActionError(Throwable t) {
		this.addActionError(this.getText("global.error", new String[]{this.getText("global.error.system")}));
	}

	@Override
	public boolean hasErrors() {
		// always return false for struts validation disabled
		// don't call this method to decide anything
		return false;
	}

//	public abstract String execute();	
//
//	public abstract String initAdd();
//
//	public abstract String initModify();
//	
//	public abstract String add();
//
//	public abstract String modify();
//	
//	public abstract String remove();

	public Locale getLocale() {
		return (Locale) request.getSession().getAttribute(ConstUtil.SESSION_ATTR_LOCALE);
	}

	@SuppressWarnings("unchecked")
	protected String getLocaleMessage(String resourceKey) {
		Map<String, Map<String, String>> localeMessages = (Map<String, Map<String, String>>) context.getAttribute(ConstUtil.CONTEXT_ATTR_LOCALE_MESSAGE);
		if (localeMessages != null && localeMessages.size() > 0) {
			Map<String, String> map = localeMessages.get(resourceKey);
			Locale locale = this.getLocale();
			if (map != null && locale != null) {
				return map.get(locale.toString());
			}
		}
		return null;
	}

//	protected List<OptionElement> list(BaseCodeType codeType) {
//		return this.list(codeType, null);
//	}
//
//	protected List<OptionElement> list(BaseCodeType codeType, ResourceKey.Option option) {
//		List<OptionElement> list = new ArrayList<OptionElement>();
//		if (option != null) {
//			list.add(this.getOptionElement(option));
//		}
//		if (EnumUtil.getEnum(codeType) != null) {
//			for (ConstEnumerable e : EnumUtil.getEnum(codeType)) {
//				if (e != null) {
//					list.add(new OptionElement(e.toString(), this.getText(e.getResourceKey())));
//				}
//			}
//		}
//		return list;
//	}
//
//	protected OptionElement getOptionElement(ResourceKey.Option option) {
//
//		OptionElement optionElement = null;
//		if (option != null) {
//			switch (option) {
//			case all:
//				optionElement = (new OptionElement("*", this.getText(option.toString())));
//				break;
//
//			case one:
//				optionElement = (new OptionElement("", this.getText(option.toString())));
//				break;
//
//			default:
//				break;
//			}
//		}
//		return optionElement;
//	}
//
//	protected static List<OptionElement> convertToOptionElement(List<LookupCodeVO> list) {
//		List<OptionElement> result = new ArrayList<OptionElement>();
//		for (LookupCodeVO vo : list) {
//			result.add(new OptionElement(vo.getCode(), vo.getLabel()));
//		}
//		return result;
//	}
	
	protected void writeResponseJson(String result) throws IOException {
		response.setContentType("text/html");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Content-Type", "text/html; charset=utf-8");

		PrintWriter pw = response.getWriter();
		pw.write(result);
		pw.close();
	}
	
}
