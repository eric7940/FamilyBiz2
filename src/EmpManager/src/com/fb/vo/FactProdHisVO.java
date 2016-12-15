package com.fb.vo;

import java.io.Serializable;

public class FactProdHisVO implements Serializable {

	private static final long serialVersionUID = -4319792409036669614L;

	private Integer factId;
	private Integer prodId;
	private Double price;
	private String purchaseId;

	private FactVO fact;
	private ProdVO prod;

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
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public String getPurchaseId() {
		return purchaseId;
	}
	public void setPurchaseId(String purchaseId) {
		this.purchaseId = purchaseId;
	}
	
}
