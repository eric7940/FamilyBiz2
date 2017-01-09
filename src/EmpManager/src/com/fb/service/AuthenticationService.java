package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.MenuFuncVO;
import com.fb.vo.UserVO;

public interface AuthenticationService extends Service {

	public UserVO login(String id, String pwd) throws FamilyBizException;
	
	public boolean auth(UserVO user, String url) throws FamilyBizException;

	public List<MenuFuncVO> getMenuFunctions(UserVO user) throws FamilyBizException;
	
}
