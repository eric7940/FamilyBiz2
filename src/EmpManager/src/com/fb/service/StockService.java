package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.ProdStockQtyVO;
import com.fb.vo.StockVO;

public interface StockService extends Service {

	public List<StockVO> getStocks() throws FamilyBizException;

	public int getProdsQtyCount(int stockId) throws FamilyBizException;

	public List<ProdStockQtyVO> getProdsQty(int stockId, int offset, int limit) throws FamilyBizException;

	public List<ProdStockQtyVO> getProdQty(int stockId, int prodId) throws FamilyBizException;

	public void adjustQty(int stockId, List<ProdStockQtyVO> details) throws FamilyBizException;
}
