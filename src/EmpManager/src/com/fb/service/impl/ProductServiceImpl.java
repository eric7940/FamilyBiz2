package com.fb.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.fb.service.ProductService;
import com.fb.util.CommonUtil;
import com.fb.util.FamilyBizException;
import com.fb.util.RowBounds;
import com.fb.vo.ProdStockQtyVO;
import com.fb.vo.ProdVO;

public class ProductServiceImpl extends ServiceImpl implements ProductService {

	public ProdVO getProd(int prodId) throws FamilyBizException {
		ProdVO prod = new ProdVO();
		prod.setId(prodId);
		return (ProdVO) this.getFbDao().queryForObject("selectProd", prod);
	}

	public int getProdsCount(String keyword) throws FamilyBizException {
		keyword = (keyword != null)? keyword.trim(): null;

		ProdVO cust = new ProdVO();
		if (keyword != null) {
			cust.setName("%" + keyword + "%");
		}
		return (int) this.getFbDao().queryForObject("selectProdCount", cust);
	}

	public List<ProdVO> getProds() throws FamilyBizException {
		return getProds(null, -1, -1);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getProds(String prodNme) throws FamilyBizException {
		return getProds(prodNme, -1, -1);
	}

	@SuppressWarnings("unchecked")
	public List<ProdVO> getProds(String keyword, int offset, int limit) throws FamilyBizException {
		keyword = (StringUtils.isNotEmpty(keyword))? keyword.trim(): null;

		ProdVO prod = new ProdVO();
		if (keyword != null) {
			prod.setName("%" + keyword + "%");
		}
		if (limit < 0)
			return this.getFbDao().queryForList("selectProd", prod);
		else
			return this.getFbDao().queryForList("selectProd", prod, new RowBounds(offset, limit));
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getProds(int custId) throws FamilyBizException {
		return getProds(custId, null);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getProds(int custId, String prodName) throws FamilyBizException {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("custId", new Integer(custId));
		if (prodName != null) {
			paramMap.put("prodName", "%" + prodName + "%");
		}
		return this.getFbDao().queryForList("selectProdByCust", paramMap);
	}

	@SuppressWarnings("rawtypes")
	public List getOffers(int custId, String prodName) throws FamilyBizException {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("custId", new Integer(custId));
		if (prodName != null) {
			paramMap.put("prodName", "%" + prodName + "%");
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
