package com.fb.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class PurchaseMasterVO implements Serializable {
	
	private static final long serialVersionUID = 7526484798999496723L;

	private String id;
	private Date purchaseDate;
	private Integer factId;
	private String invoiceNbr;
	private Integer stockId;
	private Double amt;
	private Double discount;
	private Double total;
	private String memo;
	private String back;
	private String status;
	private String ustamp;

	private FactVO fact;
	private StockVO stock;
	private List<PurchaseDetailVO> details;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	public Integer getFactId() {
		return factId;
	}
	public void setFactId(Integer factId) {
		this.factId = factId;
	}
	public FactVO getFact() {
		return fact;
	}
	public void setFact(FactVO fact) {
		this.fact = fact;
	}
	public String getInvoiceNbr() {
		return invoiceNbr;
	}
	public void setInvoiceNbr(String invoiceNbr) {
		this.invoiceNbr = invoiceNbr;
	}
	public Integer getStockId() {
		return stockId;
	}
	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}
	public StockVO getStock() {
		return stock;
	}
	public void setStock(StockVO stock) {
		this.stock = stock;
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
	public String getBack() {
		return back;
	}
	public void setBack(String back) {
		this.back = back;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUstamp() {
		return ustamp;
	}
	public void setUstamp(String ustamp) {
		this.ustamp = ustamp;
	}
	public List<PurchaseDetailVO> getDetails() {
		return details;
	}
	public void setDetails(List<PurchaseDetailVO> details) {
		this.details = details;
	}

}
