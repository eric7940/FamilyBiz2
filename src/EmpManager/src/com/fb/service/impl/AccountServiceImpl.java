package com.fb.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fb.service.AccountService;
import com.fb.util.FamilyBizException;
import com.fb.vo.LookupVO;
import com.fb.vo.MenuFuncVO;

public class AccountServiceImpl extends ServiceImpl implements AccountService {

	@SuppressWarnings("unchecked")
	public List<MenuFuncVO> getAuthFunctions(String userClass)
			throws FamilyBizException {
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("userClass", userClass);
		return this.getFbDao().queryForList("selectAuthMenuFuncs", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<LookupVO> getUserClasses() throws FamilyBizException {
		LookupVO lookup = new LookupVO();
		lookup.setType("UCLS");
		lookup.setDisplay(true);
		return this.getFbDao().queryForList("selectLookup", lookup);
	}

	public void modifyAuthFunctions(String userClass, List<String> funcIds) throws FamilyBizException {
		this.getFbDao().delete("deleteFuncAuth", userClass);

		for (String funcId: funcIds) {
			Map<String,String> paramMap = new HashMap<String,String>();
			paramMap.put("userClass", userClass);
			paramMap.put("funcId", funcId);
			this.getFbDao().insert("insertFuncAuth", paramMap);
		}
	}


}
