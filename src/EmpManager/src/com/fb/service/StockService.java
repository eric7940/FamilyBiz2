package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.ProdStockQtyVO;
import com.fb.vo.StockVO;

public interface StockService extends Service {

	public List<StockVO> getStocks() throws FamilyBizException;

	public List<ProdStockQtyVO> getProdsQty() throws FamilyBizException;

	public List<ProdStockQtyVO> getProdQty(int prodId) throws FamilyBizException;

	public void adjustQty(List<ProdStockQtyVO> details) throws FamilyBizException;
}
