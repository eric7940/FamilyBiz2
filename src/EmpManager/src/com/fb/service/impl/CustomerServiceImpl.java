package com.fb.service.impl;

import java.util.List;

import com.fb.service.CustomerService;
import com.fb.util.CommonUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.CustVO;

public class CustomerServiceImpl extends ServiceImpl implements CustomerService {

	public CustVO getCust(int custId) throws FamilyBizException {
		CustVO cust = new CustVO();
		cust.setId(Integer.valueOf(custId));
		return (CustVO) this.getFbDao().queryForObject("selectCustProf", cust);
	}
	
	public List<CustVO> getCusts() throws FamilyBizException {
		return getCusts(null);
	}

	@SuppressWarnings("unchecked")
	public List<CustVO> getCusts(String custNme) throws FamilyBizException {
		CustVO cust = new CustVO();
		if (custNme != null) {
			cust.setName(custNme + "%");
		}
		return this.getFbDao().queryForList("selectCustProf", cust);
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
