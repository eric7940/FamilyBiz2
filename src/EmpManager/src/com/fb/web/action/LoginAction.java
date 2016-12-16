package com.fb.web.action;

import org.apache.log4j.Logger;

import com.fb.service.AuthenticationService;
import com.fb.util.ConstUtil;
import com.fb.vo.UserVO;

public class LoginAction extends BaseAction {

	private static final long serialVersionUID = -4225192769241250325L;

	private static final Logger logger = Logger.getLogger(LoginAction.class);

	private String userId;
	private String password;

	private Boolean error;

	public String execute() {
		error = false;
		if (userId.equals("")) {
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
			AuthenticationService service = (AuthenticationService) this.getServiceFactory().getService("authentication");
			UserVO user = service.login(userId, password);
			if (user == null) {
				addLocalizationActionError("login.error.invalid");
				error = true;
			} else {	
				logger.debug("login success: " + user.getId() + ", " + user.getName());
				request.getSession().setAttribute(ConstUtil.SESSION_ATTR_USER, user.getId());
				request.getSession().setAttribute(ConstUtil.SESSION_ATTR_USER_INFO, user);
				
				logger.debug("locale: " + request.getLocale());
				request.getSession().setAttribute(ConstUtil.SESSION_ATTR_LOCALE, request.getLocale());
			}
			
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
