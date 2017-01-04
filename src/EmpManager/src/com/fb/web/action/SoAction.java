package com.fb.web.action;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.fb.service.CommonService;
import com.fb.service.CustomerService;
import com.fb.service.OfferService;
import com.fb.service.ProductService;
import com.fb.service.QryPriceService;
import com.fb.service.StockService;
import com.fb.util.CommonUtil;
import com.fb.util.DateUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.CustVO;
import com.fb.vo.OfferDetailVO;
import com.fb.vo.OfferMasterVO;
import com.fb.vo.PickProdVO;
import com.fb.vo.ProdVO;
import com.fb.web.form.SoForm;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class SoAction extends BaseAction {

	private static final long serialVersionUID = -1652087647900558254L;

	private static final Logger logger = Logger.getLogger(SoAction.class);

	private SoForm form;

	public String execute() {
		logger.debug("execute start");
		
		if ("1".equals(request.getParameter("redirect")) == false)
			this.clearErrorsAndMessages();
		
		try {
			String masterId = form.getKeyword();
				
			if (StringUtils.isNotEmpty(masterId)) {
				OfferService service = (OfferService) this.getServiceFactory().getService("offer");
				OfferMasterVO master = service.getOffer(masterId);
				if (master != null) {
					form.setMasterId(masterId);
					form.setDeliveryUserId(master.getDeliveryUserId());
					form.setDeliveryUser(master.getDeliveryUser());
					form.setCustId(master.getCustId());
					form.setCust(master.getCust());
					form.setStockId(master.getStockId());
					form.setStock(master.getStock());
					form.setDetails(master.getDetails());
					form.setAmt(master.getAmt());
					form.setDiscount(master.getDiscount());
					form.setInvoiceNbr(master.getInvoiceNbr());
					form.setMemo(master.getMemo());
					form.setOfferDate(DateUtil.getDateString(master.getOfferDate(), "yyyy-MM-dd"));
					form.setReceiveAmt(master.getReceiveAmt());
					form.setTotal(master.getTotal());
					
					if (master.getUstamp().equals(this.getUserInfo())) {
						request.setAttribute("editmode", "y");
					}
				}
			}
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addLocalizationActionError(e.getMessage());
		}

		return VIEW;
	}

	public String initAdd() throws Exception {
		logger.debug("initAdd start");
		
		try {
			this.clearErrorsAndMessages();
			form.reset();
			
			CustomerService service1 = (CustomerService) this.getServiceFactory().getService("customer");
			CommonService service2 = (CommonService) this.getServiceFactory().getService("common");
			OfferService service3 = (OfferService) this.getServiceFactory().getService("offer");
			StockService service4 = (StockService) this.getServiceFactory().getService("stock");
			
			form.setCusts(service1.getList());
			form.setDeliveryUsers(service3.getDeliveryUsers());
			form.setStocks(service4.getStocks());

			form.setDiscount(new Double(0));
			form.setMemo(service2.getOfferDefaultMemo());
			form.setInvoiceNbr("");
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addLocalizationActionError(e.getMessage());
		}
		
		return EDIT;
	}	

	public String add() throws Exception {

		logger.info("add start");
		
		try {
			OfferService service = (OfferService) this.getServiceFactory().getService("offer");
			
			logger.info("custId:" + form.getCustId());

			String[] prodIdArr = request.getParameterValues("prodId");
			String[] qtyArr = request.getParameterValues("qty");
			String[] priceArr = request.getParameterValues("price");
			String[] costArr = request.getParameterValues("cost");

			double sum = 0;
			double total = 0;
			double totalCost = 0;
			double discount = CommonUtil.round(form.getDiscount().doubleValue());
			
			OfferMasterVO master = new OfferMasterVO();
			master.setOfferDate(DateUtil.getDateObject(form.getOfferDate(), "yyyy-MM-dd"));
			master.setCustId(form.getCustId());
			master.setDeliveryUserId(form.getDeliveryUserId());
			master.setStockId(form.getStockId());
			master.setInvoiceNbr(form.getInvoiceNbr());
			master.setDiscount(form.getDiscount());
			master.setMemo(form.getMemo());
			master.setBack(null);
			
			List<OfferDetailVO> details = new ArrayList<OfferDetailVO>();
			for (int i = 0; i < prodIdArr.length; i++) {
				String prodId = prodIdArr[i];
				if (StringUtils.isEmpty(prodId)) continue;

				logger.debug(i + ",prodId:" + prodId);

				String price = priceArr[i];
				String cost = costArr[i];
				String qty = qtyArr[i];
				BigDecimal a = BigDecimal.valueOf(Double.parseDouble(price));
				BigDecimal b = BigDecimal.valueOf(Double.parseDouble(qty));
				BigDecimal c = BigDecimal.valueOf(Double.parseDouble(cost));
				BigDecimal x = a.multiply(b);
				BigDecimal y = c.multiply(b);
				double amt = CommonUtil.round(x.doubleValue());
				double amtCost = CommonUtil.round(y.doubleValue());
				
				OfferDetailVO detail = new OfferDetailVO();
				detail.setProdId(Integer.parseInt(prodId));
				detail.setQty(Double.parseDouble(qty));
				detail.setAmt(amt);
			
				sum += amt;
				totalCost += amtCost;
				
				details.add(detail);
			}

			total = sum - discount;
			
			master.setAmt(sum);
			master.setTotal(total);
			master.setCost(totalCost);
			master.setReceiveAmt(new Double(0));
			master.setUstamp(this.getUserInfo());
			
			String masterId = service.addOffer(master, details, false);
			
			form.setMasterId(masterId);
			
			addLocalizationActionSuccess("add");

		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addLocalizationActionError(e.getMessage());
		}

		return DEFAULT;
	}
	
	public String initModify() throws Exception {

		logger.info("initModify start");

		try {
			this.clearErrorsAndMessages();

			OfferService service = (OfferService) this.getServiceFactory().getService("offer");
			StockService service4 = (StockService) this.getServiceFactory().getService("stock");
			
			form.setStocks(service4.getStocks());
			form.setDeliveryUsers(service.getDeliveryUsers());
			
			logger.info("masterId" + form.getMasterId());
			logger.info("custId" + form.getCustId());
			
			request.setAttribute("modify", "y");
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addLocalizationActionError(e.getMessage());
		}
		
		return EDIT;
	}
	
	public String modify() throws Exception {

		logger.info("modify start");

		try {
			OfferService service = (OfferService) this.getServiceFactory().getService("offer");
			
			String masterId = form.getMasterId();
			Integer custId = form.getCustId();
			Integer stockId = form.getStockId();
			logger.info("masterId:" + masterId);
			logger.info("custId:" + custId);
			logger.info("stockId:" + stockId);

            String[] prodIdArr = request.getParameterValues("prodId");
            String[] qtyArr = request.getParameterValues("qty");
            String[] priceArr = request.getParameterValues("price");
            String[] costArr = request.getParameterValues("cost");

			double sum = 0;
			double total = 0;
			double totalCost = 0;
			double discount = CommonUtil.round(form.getDiscount().doubleValue());
			
			OfferMasterVO master = new OfferMasterVO();
			master.setId(masterId);
			master.setCustId(custId);
			master.setDeliveryUserId(form.getDeliveryUserId());
			master.setStockId(stockId);
			master.setOfferDate(DateUtil.getDateObject(form.getOfferDate(), "yyyy-MM-dd"));
			master.setInvoiceNbr(form.getInvoiceNbr());
			master.setDiscount(form.getDiscount());
			master.setMemo(form.getMemo());
			
			List<OfferDetailVO> details = new ArrayList<OfferDetailVO>();
			for (int i = 0; i < prodIdArr.length; i++) {
				String prodId = prodIdArr[i];
				if (StringUtils.isEmpty(prodId)) continue;
				
				logger.debug(i + ",prodId:" + prodId);
				
                String price = priceArr[i];
                String cost = costArr[i];
                String qty = qtyArr[i];
				BigDecimal a = BigDecimal.valueOf(Double.parseDouble(price));
				BigDecimal b = BigDecimal.valueOf(Double.parseDouble(qty));
				BigDecimal c = BigDecimal.valueOf(Double.parseDouble(cost));
				BigDecimal x = a.multiply(b);
				BigDecimal y = c.multiply(b);
				double amt = CommonUtil.round(x.doubleValue());
				double amtCost = CommonUtil.round(y.doubleValue());
				
				OfferDetailVO detail = new OfferDetailVO();
				detail.setProdId(Integer.parseInt(prodId));
				detail.setQty(Double.parseDouble(qty));
				detail.setAmt(amt);
			
				sum += amt;
				totalCost += amtCost;

				details.add(detail);
			}

			total = sum - discount;
			
			master.setAmt(sum);
			master.setTotal(total);
			master.setCost(totalCost);
			master.setReceiveAmt(new Double(0));
			master.setUstamp(this.getUserInfo());
			
			service.modifyOffer(master, details);
			
			addLocalizationActionSuccess("modify");
			
		} catch (FamilyBizException e) {
            logger.error("action fail.", e);
            this.addLocalizationActionError(e.getMessage());
        }

        return DEFAULT;
	}
	
	public String remove() throws Exception {

		logger.info("remove start");
		
		try {
			this.clearErrorsAndMessages();
			
			OfferService service = (OfferService) getServiceFactory().getService("offer");
			
			OfferMasterVO master = new OfferMasterVO();
			master.setId(form.getMasterId());
			master.setUstamp(this.getUserInfo());
			
			service.removeOffer(master, false);
			form.reset();

			addLocalizationActionSuccess("remove");
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addLocalizationActionError(e.getMessage());
		}
		
		return DEFAULT;
	}

	public String saveas() throws Exception {

		logger.info("saveas start");
		
		try {
			String fromId = form.getMasterId();
			String saveasCustId = request.getParameter("saveasCustId");
			
			if (StringUtils.isEmpty(fromId) || StringUtils.isEmpty(saveasCustId)) {
				throw new FamilyBizException("offer.message.required.saveas");
			}

			logger.info("save as from masterId:" + fromId);
			logger.info("save as custId:" + saveasCustId);
			
			Date d = new Date();
			Date today = DateUtil.getDateObject(DateUtil.getDateString(d, "yyyy-MM-dd"), "yyyy-MM-dd");
			
			OfferService service = (OfferService) this.getServiceFactory().getService("offer");
			OfferMasterVO master = service.getOffer(fromId);
			master.setOfferDate(today);
			master.setCustId(Integer.valueOf(saveasCustId));
			master.setUstamp(this.getUserInfo());
			
			String masterId = service.copyOffer(master);
			
			form.setMasterId(masterId);
			
			addLocalizationActionSuccess("save");

		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addLocalizationActionError(e.getMessage());
		}

		return DEFAULT;
	}
	
	public String getProdList() {
		logger.debug("getProdList start");

		try {

			String custId = request.getParameter("a");
			String keyword = request.getParameter("b");

			logger.info("param: custId=" + custId);
			logger.info("param: keyword=" + keyword);
			
			ProductService service1 = (ProductService) this.getServiceFactory().getService("product");
			QryPriceService service2 = (QryPriceService) this.getServiceFactory().getService("qryPrice");
			
			//TODO: 整合SERVICE
			List<OfferDetailVO> list = new ArrayList<OfferDetailVO>();
			
			List<ProdVO> prods = service1.getList(keyword);
			if (prods != null && prods.size() > 0) {
				Iterator<ProdVO> it = prods.iterator();
				while(it.hasNext()) {
					ProdVO prod = it.next();
					double price = service2.getCustProdPrice(Integer.parseInt(custId), prod.getId());
					OfferDetailVO vo = new OfferDetailVO();
					vo.setProd(prod);
					vo.setAmt(price);
					list.add(vo);
//					sb.append(prod.getProdId() + "|" + prod.getProdNme() + "|" + df.format(price) + "|" + prod.getUnit() + "|" + df.format(prod.getCost()) + "\n");
				}
			}
			
			JsonConfig cfg = new JsonConfig();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("errCde", "00");
			map.put("result", list);
			
			JSONObject jsonObject = JSONObject.fromObject(map, cfg);
			logger.debug(jsonObject.toString());
			
			this.writeResponseJson(jsonObject.toString());
			
		} catch (Exception e) {
			logger.error("fail", e);

			JsonConfig cfg = new JsonConfig();

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("errCde", "01");
			map.put("errMsg", e.getMessage());

			JSONObject jsonObject  = JSONObject.fromObject(map, cfg);
			logger.debug(jsonObject.toString());
			
			try {
				this.writeResponseJson(jsonObject.toString());
			} catch (IOException e1) {
				logger.error("fail", e1);
			}
		}
		
		return null;
	}
	
	public String unreceived() {
		logger.debug("unreceived start");
		
		try {
			this.clearErrorsAndMessages();
			
			CustomerService service1 = (CustomerService) this.getServiceFactory().getService("customer");
			form.setCusts(service1.getList());
			
			form.setUnreceivedOffers(null);
			
			String d1 = form.getUnreceivedStartDate();
			String d2 = form.getUnreceivedEndDate();
			
			if (StringUtils.isNotEmpty(d1) && StringUtils.isNotEmpty(d2)) {
				
				Date startDate = null;
				Date endDate = null;
				try {
					startDate = DateUtil.getDateObject(d1, "yyyy-MM-dd");
					endDate = DateUtil.getDateObject(d2, "yyyy-MM-dd");
				} catch (ParseException e) {
					startDate = new Date();
					endDate = new Date();
				}
				
				Integer custId = null;
				try {
					custId = new Integer(form.getUnreceivedQueryCustId());
				} catch (NumberFormatException e) {
					custId = null;
				}
				
				OfferService service = (OfferService) getServiceFactory().getService("offer");
				List<OfferMasterVO> unreceivedOffers = service.getUnReceivedOffers(custId, startDate, endDate, false);
				form.setUnreceivedOffers(unreceivedOffers);
				
				request.setAttribute("query", "y");
			}	
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addLocalizationActionError(e.getMessage());
		}

		return SUCCESS;
	}

	public String pickup() {
		logger.debug("pickup start");
		
		this.clearErrorsAndMessages();
		form.setPickupOfferDate(DateUtil.getDateString(new Date(), "yyyy-MM-dd"));

		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public String getPickupCusts() throws Exception {

		logger.info("getPickupCusts start");

		try {
			String offerDate = request.getParameter("a");
	
			OfferService service = (OfferService) getServiceFactory().getService("offer");
			List<CustVO> custs = service.getCustByOfferDate(DateUtil.getDateObject(offerDate, "yyyy-MM-dd"));
			
			JsonConfig cfg = new JsonConfig();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("errCde", "00");
			map.put("result", custs);
			
			JSONObject jsonObject = JSONObject.fromObject(map, cfg);
			logger.debug(jsonObject.toString());
			
			this.writeResponseJson(jsonObject.toString());
			
		} catch (Exception e) {
			logger.error("fail", e);

			JsonConfig cfg = new JsonConfig();

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("errCde", "01");
			map.put("errMsg", e.getMessage());

			JSONObject jsonObject  = JSONObject.fromObject(map, cfg);
			logger.debug(jsonObject.toString());
			
			try {
				this.writeResponseJson(jsonObject.toString());
			} catch (IOException e1) {
				logger.error("fail", e1);
			}
		}
		
		return null;
	}

	@SuppressWarnings("unchecked")
	public String getPickupProds() {
		logger.info("getPickupProds start");
		
		try {
			String offerDate = form.getPickupOfferDate();
			String[] custs = request.getParameterValues("custs");
			if (custs.length > 0) {
				OfferService service = (OfferService) getServiceFactory().getService("offer");
				List<PickProdVO> prods = service.getProdQty(DateUtil.getDateObject(offerDate, "yyyy-MM-dd"), Arrays.asList(custs));
				form.setPickupProds(prods);
			} else {
				form.setPickupProds(new ArrayList<PickProdVO>());
			}
			
			request.setAttribute("query", "y");
	
		} catch (FamilyBizException | ParseException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return SUCCESS;
	}
	
	public void setForm(SoForm form) {
		this.form = form;
	}

	public SoForm getForm() {
		return form;
	}

}
