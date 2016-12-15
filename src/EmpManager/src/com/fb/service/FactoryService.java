package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.FactVO;

public interface FactoryService extends Service {

	public FactVO getFact(int factId) throws FamilyBizException;
	
	public List<FactVO> getFacts() throws FamilyBizException;
	
	public List<FactVO> getFacts(String factNme) throws FamilyBizException;
	
	public void addFact(FactVO fact) throws FamilyBizException;

	public void modifyFact(FactVO fact) throws FamilyBizException;
	
	public int removeFact(int factId) throws FamilyBizException;
	
	@SuppressWarnings("unchecked")
	public int removeFacts(List factIds) throws FamilyBizException;
}
