package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.FactVO;

public interface FactoryService extends Service {

	public FactVO get(int id) throws FamilyBizException;
	
	public int getCount(String keyword) throws FamilyBizException;
	
	public List<FactVO> getList() throws FamilyBizException;
	
	public List<FactVO> getList(String keyword, int offset, int limit) throws FamilyBizException;
	
	public void add(FactVO fact) throws FamilyBizException;

	public void modify(FactVO fact) throws FamilyBizException;
	
	public int remove(int id) throws FamilyBizException;
	
	@SuppressWarnings({ "rawtypes" })
	public int remove(List factIds) throws FamilyBizException;
}
