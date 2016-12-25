package com.fb.service.impl;

import java.util.List;

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

	public int getProdsQtyCount(int stockId) throws FamilyBizException {
		ProdStockQtyVO vo = new ProdStockQtyVO();
		vo.setStockId(stockId);
		return (int) this.getFbDao().queryForObject("selectProdStockQtyCount", vo);
	}	

	@SuppressWarnings("unchecked")
	public List<ProdStockQtyVO> getProdsQty(int stockId, int offset, int limit) throws FamilyBizException {
		ProdStockQtyVO vo = new ProdStockQtyVO();
		vo.setStockId(stockId);
		return this.getFbDao().queryForList("selectProdStockQty", vo, new RowBounds(offset, limit));
	}	

	@SuppressWarnings("unchecked")
	public List<ProdStockQtyVO> getProdQty(int stockId, int prodId) throws FamilyBizException {
		ProdStockQtyVO vo = new ProdStockQtyVO();
		vo.setStockId(stockId);
		vo.setProdId(prodId);
		return this.getFbDao().queryForList("selectProdStockQty", vo);
	}

	public void adjustQty(int stockId, List<ProdStockQtyVO> details) throws FamilyBizException {
		for (int i = 0; i < details.size(); i++) {
			ProdStockQtyVO qty = details.get(i);
			qty.setStockId(stockId);
			this.getFbDao().update("updateProdStockQty", qty);
		}
	}

}
