package com.fb.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fb.service.StockService;
import com.fb.util.FamilyBizException;
import com.fb.util.RowBounds;
import com.fb.vo.ProdStockQtyVO;
import com.fb.vo.StockVO;

public class StockServiceImpl extends ServiceImpl implements StockService {

	@SuppressWarnings("unchecked")
	public List<StockVO> getStocks() throws FamilyBizException {
		return this.getFbDao().queryForList("selectStocks", null);
	}	

	public int getProdsQtyCount(int stockId, String keyword) throws FamilyBizException {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("stockId", stockId);

		if (keyword != null) {
			paramMap.put("prodId", keyword);
			paramMap.put("keyword", "%" + keyword + "%");
		}

		return (int) this.getFbDao().queryForObject("selectProdStockQtyCount", paramMap);
	}	

	public List<ProdStockQtyVO> getProdsQty(int stockId, String keyword, int offset, int limit) throws FamilyBizException {
		return getProdQty(stockId, keyword, offset, limit);
	}	

	public List<ProdStockQtyVO> getProdQty(int stockId, String keyword) throws FamilyBizException {
		return getProdQty(stockId, keyword, -1, -1);
	}

	@SuppressWarnings("unchecked")
	private List<ProdStockQtyVO> getProdQty(int stockId, String keyword, int offset, int limit) throws FamilyBizException {
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("stockId", stockId);

		if (keyword != null) {
			paramMap.put("prodId", keyword);
			paramMap.put("keyword", "%" + keyword + "%");
		}

		if (limit < 0)
			return this.getFbDao().queryForList("selectProdStockQty", paramMap);
		else
			return this.getFbDao().queryForList("selectProdStockQty", paramMap, new RowBounds(offset, limit));

	}

	public void adjustQty(int stockId, List<ProdStockQtyVO> details) throws FamilyBizException {
		for (int i = 0; i < details.size(); i++) {
			ProdStockQtyVO qty = details.get(i);
			qty.setStockId(stockId);
			this.getFbDao().update("updateProdStockQty", qty);
		}
	}

}
