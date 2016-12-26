package com.fb.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.fb.service.FactoryService;
import com.fb.util.CommonUtil;
import com.fb.util.FamilyBizException;
import com.fb.util.RowBounds;
import com.fb.vo.CustVO;
import com.fb.vo.FactVO;

public class FactoryServiceImpl extends ServiceImpl implements FactoryService {

	public FactVO getFact(int factId) throws FamilyBizException {
		FactVO fact = new FactVO();
		fact.setId(Integer.valueOf(factId));
		return (FactVO) this.getFbDao().queryForObject("selectFact", fact);
	}
	
	public int getFactsCount(String keyword) throws FamilyBizException {
		keyword = (StringUtils.isNotEmpty(keyword))? keyword.trim(): null;

		FactVO fact = new FactVO();
		if (keyword != null) {
			fact.setName("%" + keyword + "%");
		}
		return (int) this.getFbDao().queryForObject("selectFactCount", fact);
	}

	public List<FactVO> getFacts() throws FamilyBizException {
		return getFacts(null, -1, -1);
	}

	@SuppressWarnings("unchecked")
	public List<FactVO> getFacts(String keyword, int offset, int limit) throws FamilyBizException {
		keyword = (StringUtils.isNotEmpty(keyword))? keyword.trim(): null;

		FactVO fact = new FactVO();
		if (keyword != null) {
			fact.setName("%" + keyword + "%");
		}
		if (limit < 0)
			return this.getFbDao().queryForList("selectFact", fact);
		else
			return this.getFbDao().queryForList("selectFact", fact, new RowBounds(offset, limit));
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
