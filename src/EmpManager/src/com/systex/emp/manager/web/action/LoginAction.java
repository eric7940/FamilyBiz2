package com.systex.emp.manager.web.action;

import org.apache.log4j.Logger;

import com.systex.emp.base.util.ConstUtil;
import com.systex.emp.base.web.action.BaseAction;
import com.systex.emp.manager.service.AuthenticateService;
import com.systex.emp.manager.vo.UserVO;

public class LoginAction extends BaseAction {

	private static final long serialVersionUID = -4225192769241250325L;

	private static final Logger logger = Logger.getLogger(LoginAction.class);

	private String userId;
	private String password;
	private String server;

	private Boolean error;

	public String execute() {
		error = false;
		if (server.equals("")) {
			addLocalizationActionError("login.error.required.server");
			error = true;
		} else if (userId.equals("")) {
			addLocalizationActionError("login.error.required.userId");
			error = true;
		} else if (password.equals("")) {
			addLocalizationActionError("login.error.required.password");
			error = true;
		} 
	
		if (error) {
			return INPUT;
		} 

		try {
			AuthenticateService service = (AuthenticateService) this.getServiceFactory().getService("authenticateDummyService");
			UserVO user = service.validatePassword(userId, password);
			if (user == null) {
				addLocalizationActionError("login.error.invalid");
				error = true;
			} else {	
				logger.debug("login success: " + user.getId() + ", " + user.getName());
				request.getSession().setAttribute(ConstUtil.SESSION_ATTR_USER, user.getId());
				request.getSession().setAttribute(com.systex.emp.manager.util.ConstUtil.SESSION_ATTR_USER_INFO, user);
				
				logger.debug("locale: " + request.getLocale());
				request.getSession().setAttribute(ConstUtil.SESSION_ATTR_LOCALE, request.getLocale());
			}
			
//		} catch (EmpManagerException e) {
//			logger.error("action fail.", e);
//			addLocalizationActionError(e.getMessage());
//			error = true;
		} catch (Exception e) {
			logger.error("action fail.", e);
			addActionError(e);
			error = true;
		}
		
		return error? INPUT: SUCCESS;
	}

	public String logout() {
		request.getSession().setAttribute(ConstUtil.SESSION_ATTR_USER, null);
		request.getSession().removeAttribute(ConstUtil.SESSION_ATTR_USER);
		return SUCCESS;
	}

	public String getServer() {
		return server;
	}

	public void setServer(String server) {
		this.server = server;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
