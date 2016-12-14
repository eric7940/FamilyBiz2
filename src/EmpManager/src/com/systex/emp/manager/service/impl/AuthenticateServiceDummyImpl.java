package com.systex.emp.manager.service.impl;

import com.systex.emp.manager.service.AuthenticateService;
import com.systex.emp.manager.service.CommonService;
import com.systex.emp.manager.util.MD5Util;
import com.systex.emp.manager.vo.LookupCodeVO;
import com.systex.emp.manager.vo.UserVO;

public class AuthenticateServiceDummyImpl extends ServiceImpl implements AuthenticateService {

	@Override
	public String validateGuid(String userId, String guid) {
		return null;
	}

	@Override
	public UserVO validatePassword(String userId, String password) {
		try {
			CommonService service = (CommonService) this.getServiceFactory().getService("commonService");
			UserVO user = service.getUser(userId);
			if (user == null)
				return null;
			
			LookupCodeVO vo = service.getLookupCode("PBT", "DUMMY_LOGIN", "PASSWORD");
			return (vo == null || vo.getValue().equals(MD5Util.md5hash(password)) == false)? null: user;
		} catch (Exception e) {
			return null;
		}
	}

}
