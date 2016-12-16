package com.fb.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fb.service.ProductService;
import com.fb.util.CommonUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.ProdVO;
import com.fb.vo.ProdStockQtyVO;

public class ProductServiceImpl extends ServiceImpl implements ProductService {

	public ProdVO getProd(int prodId) throws FamilyBizException {
		ProdVO prod = new ProdVO();
		prod.setId(prodId);
		return (ProdVO) this.getFbDao().queryForObject("selectProdProf", prod);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getProds() throws FamilyBizException {
		return getProds(null);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getProds(String prodNme) throws FamilyBizException {
		ProdVO prod = new ProdVO();
		if (prodNme != null) {
			prod.setName("%" + prodNme + "%");
		}
		return this.getFbDao().queryForList("selectProdProf", prod);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getProds(int custId) throws FamilyBizException {
		return getProds(custId, null);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getProds(int custId, String prodNme) throws FamilyBizException {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("custId", new Integer(custId));
		if (prodNme != null) {
			paramMap.put("prodNme", "%" + prodNme + "%");
		}
		return this.getFbDao().queryForList("selectProdByCust", paramMap);
	}

	@SuppressWarnings("rawtypes")
	public List getOffers(int custId, String prodNme) throws FamilyBizException {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("custId", new Integer(custId));
		if (prodNme != null) {
			paramMap.put("prodNme", "%" + prodNme + "%");
		}
		return this.getFbDao().queryForList("selectOfferByCustAndProd", paramMap);
	}

	public void addProd(ProdVO prod) throws FamilyBizException {
		this.getFbDao().insert("insertProd", prod);

		ProdStockQtyVO qty = new ProdStockQtyVO();
		qty.setStockId(new Integer(1)); //todo:
		qty.setQty(new Double(0));
		this.getFbDao().insert("insertProdStockQty", qty);
	}	

	public void modifyProd(ProdVO prod) throws FamilyBizException {
		this.getFbDao().update("updateProd", prod);
	}

	public int removeProd(int prodId) throws FamilyBizException {
		return this.getFbDao().update("deleteProd", Integer.valueOf(prodId));
	}

	@SuppressWarnings("rawtypes")
	public int removeProds(List prodIds) throws FamilyBizException {
		String s = CommonUtil.convertListToString(prodIds, ",", true);
		return this.getFbDao().update("deleteProds", s);
	}
}
