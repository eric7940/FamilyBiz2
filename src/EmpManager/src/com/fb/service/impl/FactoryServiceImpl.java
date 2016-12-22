package com.fb.service.impl;

import java.util.List;

import com.fb.service.FactoryService;
import com.fb.util.CommonUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.FactVO;

public class FactoryServiceImpl extends ServiceImpl implements FactoryService {

	public FactVO getFact(int factId) throws FamilyBizException {
		FactVO fact = new FactVO();
		fact.setId(Integer.valueOf(factId));
		return (FactVO) this.getFbDao().queryForObject("selectFact", fact);
	}
	
	public List<FactVO> getFacts() throws FamilyBizException {
		return getFacts(null);
	}

	@SuppressWarnings("unchecked")
	public List<FactVO> getFacts(String factNme) throws FamilyBizException {
		FactVO fact = new FactVO();
		if (factNme != null) {
			fact.setName(factNme + "%");
		}
		return this.getFbDao().queryForList("selectFact", fact);
	}

	public void addFact(FactVO fact) throws FamilyBizException {
		this.getFbDao().insert("insertFact", fact);
	}

	public void modifyFact(FactVO fact) throws FamilyBizException {
		this.getFbDao().update("updateFact", fact);
	}

	public int removeFact(int factId) throws FamilyBizException {
		return this.getFbDao().update("deleteFact", Integer.valueOf(factId));
	}

	@SuppressWarnings("rawtypes")
	public int removeFacts(List factIds) throws FamilyBizException {
		String s = CommonUtil.convertListToString(factIds, ",", true);
		return this.getFbDao().update("deleteFacts", s);
	}
}
