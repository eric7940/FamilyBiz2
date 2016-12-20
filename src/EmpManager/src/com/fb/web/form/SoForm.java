package com.fb.web.form;

import java.util.Date;
import java.util.List;

import com.fb.vo.CustVO;
import com.fb.vo.OfferDetailVO;
import com.fb.vo.OfferMasterVO;
import com.fb.vo.UserVO;

public class SoForm extends BaseForm {

	private static final long serialVersionUID = -3287678981329755686L;
	
	private List<CustVO> custs;
	private List<UserVO> deliveryUsers;
	private List<OfferMasterVO> offers;

	private Integer masterId;
	private Integer custId;
	private String deliveryUserId;
	private Date offerDate;
	private String invoiceNbr;
	private Double amt;
	private Double discount;
	private Double total;
	private Double receiveAmt;
	private String memo;

	private CustVO cust;
	private List<OfferDetailVO> details;

	public List<OfferMasterVO> getOffers() {
		return offers;
	}
	public void setOffers(List<OfferMasterVO> offers) {
		this.offers = offers;
	}
	public List<CustVO> getCusts() {
		return custs;
	}
	public void setCusts(List<CustVO> custs) {
		this.custs = custs;
	}
	public List<UserVO> getDeliveryUsers() {
		return deliveryUsers;
	}
	public void setDeliveryUsers(List<UserVO> deliveryUsers) {
		this.deliveryUsers = deliveryUsers;
	}
	public CustVO getCust() {
		return cust;
	}
	public void setCust(CustVO cust) {
		this.cust = cust;
	}
	public void setDetails(List<OfferDetailVO> details) {
		this.details = details;
	}
	public List<OfferDetailVO> getDetails() {
		return details;
	}
	public Integer getMasterId() {
		return masterId;
	}
	public void setMasterId(Integer masterId) {
		this.masterId = masterId;
	}
	public Integer getCustId() {
		return custId;
	}
	public void setCustId(Integer custId) {
		this.custId = custId;
	}
	public Date getOfferDate() {
		return offerDate;
	}
	public void setOfferDate(Date offerDate) {
		this.offerDate = offerDate;
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
	public String getDeliveryUserId() {
		return deliveryUserId;
	}
	public void setDeliveryUserId(String deliveryUserId) {
		this.deliveryUserId = deliveryUserId;
	}

	@Override
	public void reset() {
	}

}