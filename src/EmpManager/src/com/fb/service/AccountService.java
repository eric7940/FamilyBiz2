package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.LookupVO;
import com.fb.vo.MenuFuncVO;

public interface AccountService extends Service {

	public List<LookupVO> getUserClasses() throws FamilyBizException;
	
	public List<MenuFuncVO> getAuthFunctions(String userClass) throws FamilyBizException;

	public void modifyAuthFunctions(String userClass, List<String> funcIds) throws FamilyBizException;
	
}
