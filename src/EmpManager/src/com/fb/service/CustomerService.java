package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.CustVO;

public interface CustomerService extends Service {

	public CustVO getCust(int custId) throws FamilyBizException;
	
	public int getCustsCount(String keyword) throws FamilyBizException;

	public List<CustVO> getCusts() throws FamilyBizException;

	public List<CustVO> getCusts(String keyword, int offset, int limit) throws FamilyBizException;
	
	public void addCust(CustVO cust) throws FamilyBizException;

	public void modifyCust(CustVO cust) throws FamilyBizException;
	
	public int removeCust(int custId) throws FamilyBizException;
	
	@SuppressWarnings("unchecked")
	public int removeCusts(List custIds) throws FamilyBizException;
}
