package com.fb.web.form;

import java.util.List;

import com.fb.vo.ProdVO;
import com.fb.vo.StockVO;

public class StockForm extends BaseForm {

	private static final long serialVersionUID = -6816710669557416088L;

	private List<StockVO> stocks;
	private List<ProdVO> prods;

	private String keyword;

	private Integer stockId;
	private Integer prodId;
	
	private ProdVO prod;

	public List<StockVO> getStocks() {
		return stocks;
	}
	public void setStocks(List<StockVO> stocks) {
		this.stocks = stocks;
	}
	public List<ProdVO> getProds() {
		return prods;
	}
	public void setProds(List<ProdVO> prods) {
		this.prods = prods;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Integer getStockId() {
		return stockId;
	}
	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}
	public Integer getProdId() {
		return prodId;
	}
	public void setProdId(Integer prodId) {
		this.prodId = prodId;
	}
	public ProdVO getProd() {
		return prod;
	}
	public void setProd(ProdVO prod) {
		this.prod = prod;
	}
	
	@Override
	public void reset() {
		this.prodId = null;
	}
}
