package com.systex.emp.manager.web.form;

import com.systex.emp.base.web.form.BaseForm;

public class LoginForm extends BaseForm {
	
	private static final long serialVersionUID = -8616937140487037846L;
	
	private String userId;
	private String password;
	
	public void reset() {
		userId = null;
		password = null;
	}
	
	public LoginForm() {
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
