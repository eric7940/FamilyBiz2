package com.fb.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.fb.service.CustomerService;
import com.fb.util.CommonUtil;
import com.fb.util.FamilyBizException;
import com.fb.util.RowBounds;
import com.fb.vo.CustVO;

public class CustomerServiceImpl extends ServiceImpl implements CustomerService {

	public CustVO get(int id) throws FamilyBizException {
		CustVO cust = new CustVO();
		cust.setId(id);
		return (CustVO) this.getFbDao().queryForObject("selectCust", cust);
	}
	
	public List<CustVO> getList() throws FamilyBizException {
		return getList(null, -1, -1);
	}

	public int getCount(String keyword) throws FamilyBizException {
		keyword = (StringUtils.isNotEmpty(keyword))? keyword.trim(): null;

		CustVO cust = new CustVO();
		if (keyword != null) {
			cust.setName("%" + keyword + "%");
		}
		return (int) this.getFbDao().queryForObject("selectCustCount", cust);
	}

	@SuppressWarnings("unchecked")
	public List<CustVO> getList(String keyword, int offset, int limit) throws FamilyBizException {
		keyword = (StringUtils.isNotEmpty(keyword))? keyword.trim(): null;

		CustVO cust = new CustVO();
		if (keyword != null) {
			cust.setName("%" + keyword + "%");
		}
		if (limit < 0)
			return this.getFbDao().queryForList("selectCust", cust);
		else
			return this.getFbDao().queryForList("selectCust", cust, new RowBounds(offset, limit));
	}

	public void add(CustVO cust) throws FamilyBizException {
		this.getFbDao().insert("insertCust", cust);
	}

	public void modify(CustVO cust) throws FamilyBizException {
		this.getFbDao().update("updateCust", cust);
	}

	public int remove(int id) throws FamilyBizException {
		return this.getFbDao().update("deleteCust", Integer.valueOf(id));
	}

	@SuppressWarnings("rawtypes")
	public int remove(List custIds) throws FamilyBizException {
		String s = CommonUtil.convertListToString(custIds, ",", true);
		return this.getFbDao().update("deleteCusts", s);
	}
}
