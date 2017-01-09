package com.fb.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class OfferMasterVO implements Serializable {
	
	private static final long serialVersionUID = -2797817211546266526L;

	private String id;
	private Date offerDate;
	private Integer custId;
	private String deliveryUserId;
	private String invoiceNbr;
	private Integer stockId;
	private Double amt;
	private Double discount;
	private Double total;
	private Double cost;
	private Double receiveAmt;
	private String memo;
	private String back;
	private String status;
	private String ustamp;
	
	private CustVO cust;
	private UserVO deliveryUser;
	private StockVO stock;
	private List<OfferDetailVO> details;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getOfferDate() {
		return offerDate;
	}
	public void setOfferDate(Date offerDate) {
		this.offerDate = offerDate;
	}
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
	public Double getCost() {
		return cost;
	}
	public void setCost(Double cost) {
		this.cost = cost;
	}
	public Double getReceiveAmt() {
		return receiveAmt;
	}
	public void setReceiveAmt(Double receiveAmt) {
		this.receiveAmt = receiveAmt;
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
	public List<OfferDetailVO> getDetails() {
		return details;
	}
	public void setDetails(List<OfferDetailVO> details) {
		this.details = details;
	}
	public String getDeliveryUserId() {
		return deliveryUserId;
	}
	public void setDeliveryUserId(String deliveryUserId) {
		this.deliveryUserId = deliveryUserId;
	}
	public UserVO getDeliveryUser() {
		return deliveryUser;
	}
	public void setDeliveryUser(UserVO deliveryUser) {
		this.deliveryUser = deliveryUser;
	}

}
