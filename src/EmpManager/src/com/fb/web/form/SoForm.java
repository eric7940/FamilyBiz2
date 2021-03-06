package com.fb.web.form;

import java.util.List;

import com.fb.vo.CustVO;
import com.fb.vo.OfferDetailVO;
import com.fb.vo.OfferMasterVO;
import com.fb.vo.PickProdVO;
import com.fb.vo.StockVO;
import com.fb.vo.UserVO;

public class SoForm extends BaseForm {

	private static final long serialVersionUID = -3287678981329755686L;
	
	private String keyword;
	
	private String unreceivedStartDate;
	private String unreceivedEndDate;
	private String unreceivedQueryCust;
	private String unreceivedQueryCustId;

	private String pickupOfferDate;

	private List<CustVO> custs;
	private List<UserVO> deliveryUsers;
	private List<OfferMasterVO> offers;
	private List<StockVO> stocks;
	private List<OfferMasterVO> unreceivedOffers;
	private List<PickProdVO> pickupProds;
	
	private String masterId;
	private Integer custId;
	private String deliveryUserId;
	private Integer stockId;
	private String offerDate;
	private String invoiceNbr;
	private Double amt;
	private Double discount;
	private Double total;
	private Double receiveAmt;
	private String memo;

	private CustVO cust;
	private StockVO stock;
	private UserVO deliveryUser;
	private List<OfferDetailVO> details;

	public List<OfferMasterVO> getOffers() {
		return offers;
	}
	public void setOffers(List<OfferMasterVO> offers) {
		this.offers = offers;
	}
	public List<StockVO> getStocks() {
		return stocks;
	}
	public void setStocks(List<StockVO> stocks) {
		this.stocks = stocks;
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
	public List<OfferMasterVO> getUnreceivedOffers() {
		return unreceivedOffers;
	}
	public void setUnreceivedOffers(List<OfferMasterVO> unreceivedOffers) {
		this.unreceivedOffers = unreceivedOffers;
	}
	public List<PickProdVO> getPickupProds() {
		return pickupProds;
	}
	public void setPickupProds(List<PickProdVO> pickupProds) {
		this.pickupProds = pickupProds;
	}
	public CustVO getCust() {
		return cust;
	}
	public void setCust(CustVO cust) {
		this.cust = cust;
	}
	public StockVO getStock() {
		return stock;
	}
	public void setStock(StockVO stock) {
		this.stock = stock;
	}
	public UserVO getDeliveryUser() {
		return deliveryUser;
	}
	public void setDeliveryUser(UserVO deliveryUser) {
		this.deliveryUser = deliveryUser;
	}
	public void setDetails(List<OfferDetailVO> details) {
		this.details = details;
	}
	public List<OfferDetailVO> getDetails() {
		return details;
	}
	public String getMasterId() {
		return masterId;
	}
	public void setMasterId(String masterId) {
		this.masterId = masterId;
	}
	public Integer getCustId() {
		return custId;
	}
	public void setCustId(Integer custId) {
		this.custId = custId;
	}
	public String getOfferDate() {
		return offerDate;
	}
	public void setOfferDate(String offerDate) {
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
	public Integer getStockId() {
		return stockId;
	}
	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getUnreceivedStartDate() {
		return unreceivedStartDate;
	}
	public void setUnreceivedStartDate(String unreceivedStartDate) {
		this.unreceivedStartDate = unreceivedStartDate;
	}
	public String getUnreceivedEndDate() {
		return unreceivedEndDate;
	}
	public void setUnreceivedEndDate(String unreceivedEndDate) {
		this.unreceivedEndDate = unreceivedEndDate;
	}
	public String getUnreceivedQueryCust() {
		return unreceivedQueryCust;
	}
	public void setUnreceivedQueryCust(String unreceivedQueryCust) {
		this.unreceivedQueryCust = unreceivedQueryCust;
	}
	public String getUnreceivedQueryCustId() {
		return unreceivedQueryCustId;
	}
	public void setUnreceivedQueryCustId(String unreceivedQueryCustId) {
		this.unreceivedQueryCustId = unreceivedQueryCustId;
	}
	public String getPickupOfferDate() {
		return pickupOfferDate;
	}
	public void setPickupOfferDate(String pickupOfferDate) {
		this.pickupOfferDate = pickupOfferDate;
	}
	
	@Override
	public void reset() {
		this.masterId = null;
		this.custId = null;
		this.deliveryUserId = null;
		this.stockId = null;
		this.offerDate = null;
		this.invoiceNbr = null;
		this.amt = null;
		this.discount = null;
		this.total = null;
		this.memo = null;
		this.cust = null;
		this.details = null;
	}

}
