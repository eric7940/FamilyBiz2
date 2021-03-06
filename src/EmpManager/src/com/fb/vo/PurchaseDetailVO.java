package com.fb.vo;

import java.io.Serializable;

public class PurchaseDetailVO implements Serializable {
	
	private static final long serialVersionUID = -1111587598621869704L;

	private String id;
	private String masterId;
	private Integer prodId;
	private Double qty;
	private Double amt;

	private ProdVO prod;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
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
	public Double getQty() {
		return qty;
	}
	public void setQty(Double qty) {
		this.qty = qty;
	}
	public Double getAmt() {
		return amt;
	}
	public void setAmt(Double amt) {
		this.amt = amt;
	}

}
