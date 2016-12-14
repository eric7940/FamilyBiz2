package com.systex.emp.manager.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.systex.emp.manager.exception.EmpManagerException;
import com.systex.emp.manager.service.CommonService;
//import com.systex.emp.manager.vo.DeptVO;
//import com.systex.emp.manager.vo.LocaleMessageVO;
//import com.systex.emp.manager.vo.LocaleVO;
//import com.systex.emp.manager.vo.UserVO;
import com.systex.emp.manager.vo.LookupCodeVO;
import com.systex.emp.manager.vo.UserVO;

public class CommonServiceImpl extends ServiceImpl implements CommonService {

	private static final Logger logger = Logger.getLogger(CommonServiceImpl.class);
	
	@Override
	public String getLookupCodeValue(String module, String type, String code) throws EmpManagerException {
		LookupCodeVO vo = this.getLookupCode(module, type, code);
		return (vo==null ? null : vo.getValue());
	}
	
	@Override
	public LookupCodeVO getLookupCode(String module, String type, String code) throws EmpManagerException {
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("module", module);
		paramMap.put("type", type);
		paramMap.put("code", code);
		return (LookupCodeVO) this.getMainDAO().queryForObject("selectLookupCode", paramMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<LookupCodeVO> getLookupCodes(String module, String type) throws EmpManagerException {
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("module", module);
		paramMap.put("type", type);
		return this.getMainDAO().queryForList("selectLookupCode", paramMap);
	}
	
	@Override
	public UserVO getUser(String userId) throws EmpManagerException {
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("userId", userId);

		return (UserVO) this.getMainDAO().queryForObject("selectUser", paramMap);
	}
	
}