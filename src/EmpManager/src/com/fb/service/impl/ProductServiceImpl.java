package com.fb.service.impl;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.fb.service.ProductService;
import com.fb.util.CommonUtil;
import com.fb.util.FamilyBizException;
import com.fb.util.RowBounds;
import com.fb.vo.CustProdHisVO;
import com.fb.vo.ProdStockQtyVO;
import com.fb.vo.ProdVO;

public class ProductServiceImpl extends ServiceImpl implements ProductService {

	public ProdVO get(int id) throws FamilyBizException {
		ProdVO prod = new ProdVO();
		prod.setId(id);
		return (ProdVO) this.getFbDao().queryForObject("selectProd", prod);
	}

	public int getCount(String keyword) throws FamilyBizException {
		keyword = (keyword != null)? keyword.trim(): null;

		ProdVO cust = new ProdVO();
		if (keyword != null) {
			cust.setName("%" + keyword + "%");
		}
		return (int) this.getFbDao().queryForObject("selectProdCount", cust);
	}

	public List<ProdVO> getList() throws FamilyBizException {
		return getList(null, -1, -1);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getList(String keyword) throws FamilyBizException {
		return getList(keyword, -1, -1);
	}

	@SuppressWarnings("unchecked")
	public List<ProdVO> getList(String keyword, int offset, int limit) throws FamilyBizException {
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
	public List getPriceHistory(int custId, int prodId) throws FamilyBizException {
		CustProdHisVO vo = new CustProdHisVO();
		vo.setCustId(custId);
		vo.setProdId(prodId);
		return this.getFbDao().queryForList("selectPriceHistory", vo);
	}

	public void add(ProdVO prod) throws FamilyBizException {
		this.getFbDao().insert("insertProd", prod);

		ProdStockQtyVO qty = new ProdStockQtyVO();
		qty.setQty(new Double(0));
		this.getFbDao().insert("insertProdStockQty", qty);
	}	

	public void modify(ProdVO prod) throws FamilyBizException {
		this.getFbDao().update("updateProd", prod);
	}

	public int remove(int id) throws FamilyBizException {
		return this.getFbDao().update("deleteProd", Integer.valueOf(id));
	}

	@SuppressWarnings("rawtypes")
	public int remove(List prodIds) throws FamilyBizException {
		String s = CommonUtil.convertListToString(prodIds, ",", true);
		return this.getFbDao().update("deleteProds", s);
	}
}
