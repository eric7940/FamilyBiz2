package com.fb.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.digest.DigestUtils;

import com.fb.service.AuthenticationService;
import com.fb.util.FamilyBizException;
import com.fb.vo.MenuFuncVO;
import com.fb.vo.UserVO;

public class AuthenticationServiceImpl extends ServiceImpl implements AuthenticationService {

	@SuppressWarnings("unchecked")
	public List<MenuFuncVO> getMenuFunctions(UserVO user) throws FamilyBizException {
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("userClass", user.getGrade());
		return this.getFbDao().queryForList("selectAuthMenuFuncs", paramMap);
	}

	public UserVO login(String id, String pwd) throws FamilyBizException {
		UserVO user = new UserVO();
		user.setId(id);
		user.setPasswd(pwd);
		UserVO userProfVO = (UserVO) this.getFbDao().queryForObject("selectUser", user);
		if (userProfVO == null) {
			throw new FamilyBizException("帳號/密碼錯誤");
		}
		return userProfVO;
	}

	@SuppressWarnings("unchecked")
	public boolean auth(UserVO user, String url) throws FamilyBizException {
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("userClass", user.getGrade());
		paramMap.put("url", url + "%");
		List<MenuFuncVO> funcs = this.getFbDao().queryForList("selectAuthMenuFuncs", paramMap);
		return (funcs == null || funcs.isEmpty())? false: true;
	}


}
