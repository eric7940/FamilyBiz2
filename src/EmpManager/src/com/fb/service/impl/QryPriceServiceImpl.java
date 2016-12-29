package com.fb.service.impl;

import com.fb.service.QryPriceService;
import com.fb.util.FamilyBizException;
import com.fb.vo.CustProdHisVO;
import com.fb.vo.ProdVO;

public class QryPriceServiceImpl extends ServiceImpl implements QryPriceService {

	public double getCustProdPrice(int custId, int prodId) throws FamilyBizException {
		CustProdHisVO param1VO = new CustProdHisVO();
		param1VO.setCustId(new Integer(custId));
		param1VO.setProdId(new Integer(prodId));
		CustProdHisVO hisVO = (CustProdHisVO) this.getFbDao().queryForObject("selectCustProdHis", param1VO);

		if (hisVO == null) {
			ProdVO param2VO = new ProdVO();
			param2VO.setId(new Integer(prodId));
			ProdVO prodVO = (ProdVO) this.getFbDao().queryForObject("selectProd", param2VO);
			
			if (prodVO == null) {
				throw new FamilyBizException("query.error.prod.notfound");
			}
			return prodVO.getPrice().doubleValue();
		}
		return hisVO.getPrice().doubleValue();
	}

}
