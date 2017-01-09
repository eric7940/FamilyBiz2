package com.fb.web.form;

import java.util.List;

import com.fb.vo.FactVO;
import com.fb.vo.PurchaseDetailVO;
import com.fb.vo.PurchaseMasterVO;
import com.fb.vo.StockVO;

public class PoForm extends BaseForm {

	private static final long serialVersionUID = -3287678981329755686L;
	
	private String keyword;
	
	private List<FactVO> facts;
	private List<StockVO> stocks;
	private List<PurchaseMasterVO> purchases;

	private String masterId;
	private Integer factId;
	private Integer stockId;
	private String purchaseDate;
	private String invoiceNbr;
	private Double amt;
	private Double discount;
	private Double total;
	private String memo;

	private FactVO fact;
	private StockVO stock;
	private List<PurchaseDetailVO> details;

	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public List<FactVO> getFacts() {
		return facts;
	}
	public void setFacts(List<FactVO> facts) {
		this.facts = facts;
	}
	public List<StockVO> getStocks() {
		return stocks;
	}
	public void setStocks(List<StockVO> stocks) {
		this.stocks = stocks;
	}
	public List<PurchaseMasterVO> getPurchases() {
		return purchases;
	}
	public void setPurchases(List<PurchaseMasterVO> purchases) {
		this.purchases = purchases;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	public Integer getFactId() {
		return factId;
	}
	public void setFactId(Integer factId) {
		this.factId = factId;
	}
	public Integer getStockId() {
		return stockId;
	}
	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}
	public String getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(String purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	public String getInvoiceNbr() {
		return invoiceNbr;
	}
	public void setInvoiceNbr(String invoiceNbr) {
		this.invoiceNbr = invoiceNbr;
	}
	public Double getAmt() {
		return amt;
	}
	public void setAmt(Double amt) {
		this.amt = amt;
	}
	public Double getDiscount() {
		return discount;
	}
	public void setDiscount(Double discount) {
		this.discount = discount;
	}
	public Double getTotal() {
		return total;
	}
	public void setTotal(Double total) {
		this.total = total;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public FactVO getFact() {
		return fact;
	}
	public void setFact(FactVO fact) {
		this.fact = fact;
	}
	public StockVO getStock() {
		return stock;
	}
	public void setStock(StockVO stock) {
		this.stock = stock;
	}
	public List<PurchaseDetailVO> getDetails() {
		return details;
	}
	public void setDetails(List<PurchaseDetailVO> details) {
		this.details = details;
	}

	@Override
	public void reset() {
		this.masterId = null;
		this.factId = null;
		this.purchaseDate = null;
		this.invoiceNbr = null;
		this.amt = null;
		this.discount = null;
		this.total = null;
		this.memo = null;
		this.fact = null;
		this.details = null;
	}

}
