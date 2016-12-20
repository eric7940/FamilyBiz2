package com.fb.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.fb.service.CustomerService;
import com.fb.util.CommonUtil;
import com.fb.util.FamilyBizException;
import com.fb.util.RowBounds;
import com.fb.vo.CustVO;

public class CustomerServiceImpl extends ServiceImpl implements CustomerService {

	public CustVO getCust(int custId) throws FamilyBizException {
		CustVO cust = new CustVO();
		cust.setId(custId);
		return (CustVO) this.getFbDao().queryForObject("selectCust", cust);
	}
	
	public int getCustsCount(String keyword) throws FamilyBizException {
		keyword = (keyword != null)? keyword.trim(): null;

		CustVO cust = new CustVO();
		if (keyword != null) {
			cust.setName(keyword + "%");
		}
		return (int) this.getFbDao().queryForObject("selectCustCount", cust);
	}

	public List<CustVO> getCusts() throws FamilyBizException {
		return getCusts(null, -1, -1);
	}

	@SuppressWarnings("unchecked")
	public List<CustVO> getCusts(String keyword, int offset, int limit) throws FamilyBizException {
		keyword = (StringUtils.isNotEmpty(keyword))? keyword.trim(): null;

		CustVO cust = new CustVO();
		if (keyword != null) {
			cust.setName(keyword + "%");
		}
		if (limit < 0)
			return this.getFbDao().queryForList("selectCust", cust);
		else
			return this.getFbDao().queryForList("selectCust", cust, new RowBounds(offset, limit));

	}

	public void addCust(CustVO cust) throws FamilyBizException {
		this.getFbDao().insert("insertCust", cust);
	}

	public void modifyCust(CustVO cust) throws FamilyBizException {
		this.getFbDao().update("updateCust", cust);
	}

	public int removeCust(int custId) throws FamilyBizException {
		return this.getFbDao().update("deleteCust", Integer.valueOf(custId));
	}

	@SuppressWarnings("rawtypes")
	public int removeCusts(List custIds) throws FamilyBizException {
		String s = CommonUtil.convertListToString(custIds, ",", true);
		return this.getFbDao().update("deleteCusts", s);
	}
}
