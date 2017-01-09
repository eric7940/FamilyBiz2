package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.CustVO;

public interface CustomerService extends Service {

	public CustVO get(int id) throws FamilyBizException;

	public List<CustVO> getList() throws FamilyBizException;

	public int getCount(String keyword) throws FamilyBizException;

	public List<CustVO> getList(String keyword, int offset, int limit) throws FamilyBizException;
	
	public void add(CustVO cust) throws FamilyBizException;

	public void modify(CustVO cust) throws FamilyBizException;
	
	public int remove(int id) throws FamilyBizException;
	
	@SuppressWarnings({ "rawtypes" })
	public int remove(List custIds) throws FamilyBizException;
}
