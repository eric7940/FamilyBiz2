package com.systex.emp.manager.service;

import java.util.List;
//import java.util.Map;

import com.systex.emp.manager.exception.EmpManagerException;
//import com.systex.emp.manager.exception.EmpManagerException;
//import com.systex.emp.manager.vo.DeptVO;
//import com.systex.emp.manager.vo.LocaleVO;
//import com.systex.emp.manager.vo.UserVO;
import com.systex.emp.manager.vo.LookupCodeVO;
import com.systex.emp.manager.vo.UserVO;

public interface CommonService extends Service {

//	public Map<String, Map<String, String>> getLocaleMessages() throws EmpManagerException;
//
//	public List<LocaleVO> getLocaleMapping();
//
//	public List<UserVO> getUsers(String keywordSearch, boolean isOnline, int offset, int limit) throws EmpManagerException;
//	
//	public List<DeptVO> getDepts(String keywordSearch, boolean isOnline, int offset, int limit) throws EmpManagerException;
//	
//	public List<UserVO> getUsersByGroupIsOnline(List<String> groupIds) throws EmpManagerException;
	
	public String getLookupCodeValue(String module, String type, String code) throws EmpManagerException;
	public LookupCodeVO getLookupCode(String module, String type, String code) throws EmpManagerException;
	public List<LookupCodeVO> getLookupCodes(String module, String type) throws EmpManagerException;
	public UserVO getUser(String userId) throws EmpManagerException;
}