package com.systex.emp.manager.service;

import com.systex.emp.manager.vo.UserVO;

public interface AuthenticateService extends Service {

	public String validateGuid(String userId, String guid);
	public UserVO validatePassword(String userId, String password);
	
}