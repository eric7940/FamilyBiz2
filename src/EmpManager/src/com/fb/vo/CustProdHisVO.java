package com.fb.vo;

import java.io.Serializable;

public class CustProdHisVO implements Serializable {

	private static final long serialVersionUID = 6713630479715436371L;

	private Integer custId;
	private Integer prodId;
	private Double price;
	private String offerId;

	private CustVO cust;
	private ProdVO prod;

	public Integer getCustId() {
		return custId;
	}
	public void setCustId(Integer custId) {
		this.custId = custId;
	}
	public CustVO getCust() {
		return cust;
	}
	public void setCust(CustVO cust) {
		this.cust = cust;
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
	public String getOfferId() {
		return offerId;
	}
	public void setOfferId(String offerId) {
		this.offerId = offerId;
	}
}
