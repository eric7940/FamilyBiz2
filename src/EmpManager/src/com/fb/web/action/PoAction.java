package com.fb.web.action;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.fb.service.FactoryService;
import com.fb.service.ProductService;
import com.fb.service.PurchaseService;
import com.fb.service.StockService;
import com.fb.util.CommonUtil;
import com.fb.util.DateUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.ProdVO;
import com.fb.vo.PurchaseDetailVO;
import com.fb.vo.PurchaseMasterVO;
import com.fb.web.form.PoForm;

public class PoAction extends BaseAction {

	private static final long serialVersionUID = -1652087647900558254L;

	private static final Logger logger = Logger.getLogger(PoAction.class);

	private PoForm form;

	public String execute() {
		logger.debug("execute start");
		
		if ("1".equals(request.getParameter("redirect")) == false)
			this.clearErrorsAndMessages();
		
		try {
			FactoryService service1 = (FactoryService) this.getServiceFactory().getService("factory");
			form.setFacts(service1.getList());

			String masterId = form.getKeyword();
				
			if (StringUtils.isNotEmpty(masterId)) {
				PurchaseService service = (PurchaseService) this.getServiceFactory().getService("purchase");
				PurchaseMasterVO master = service.getPurchase(masterId);
				if (master != null) {
					form.setMasterId(masterId);
					form.setFactId(master.getFactId());
					form.setFact(master.getFact());
					form.setStockId(master.getStockId());
					form.setStock(master.getStock());
					form.setDetails(master.getDetails());
					form.setAmt(master.getAmt());
					form.setDiscount(master.getDiscount());
					form.setInvoiceNbr(master.getInvoiceNbr());
					form.setMemo(master.getMemo());
					form.setPurchaseDate(DateUtil.getDateString(master.getPurchaseDate(), "yyyy-MM-dd"));
					form.setTotal(master.getTotal());
				}
			}
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return VIEW;
	}

	public String initAdd() throws Exception {
		logger.debug("initAdd start");
		
		try {
			this.clearErrorsAndMessages();
			form.reset();
			
			FactoryService service1 = (FactoryService) this.getServiceFactory().getService("factory");
			StockService service4 = (StockService) this.getServiceFactory().getService("stock");
			
			form.setFacts(service1.getList());
			form.setStocks(service4.getStocks());

			form.setDiscount(new Double(0));
			form.setInvoiceNbr("");
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}
		
		return EDIT;
	}	

	public String add() throws Exception {

		logger.info("add start");
		
		try {
			PurchaseService service = (PurchaseService) this.getServiceFactory().getService("purchase");
			
			logger.info("factId:" + form.getFactId());

			String[] prodIdArr = request.getParameterValues("prodId");
			String[] qtyArr = request.getParameterValues("qty");
			String[] priceArr = request.getParameterValues("price");

			double sum = 0;
			double total = 0;
			double discount = CommonUtil.round(form.getDiscount().doubleValue());
			
			PurchaseMasterVO master = new PurchaseMasterVO();
			master.setPurchaseDate(DateUtil.getDateObject(form.getPurchaseDate(), "yyyy-MM-dd"));
			master.setFactId(form.getFactId());
			master.setStockId(form.getStockId());
			master.setInvoiceNbr(form.getInvoiceNbr());
			master.setDiscount(form.getDiscount());
			master.setMemo(form.getMemo());
			master.setBack(null);
			
			List<PurchaseDetailVO> details = new ArrayList<PurchaseDetailVO>();
			for (int i = 0; i < prodIdArr.length; i++) {
				String prodId = prodIdArr[i];
				if (StringUtils.isEmpty(prodId)) continue;

				logger.debug(i + ",prodId:" + prodId);

				String price = priceArr[i];
				String qty = qtyArr[i];
				BigDecimal a = BigDecimal.valueOf(Double.parseDouble(price));
				BigDecimal b = BigDecimal.valueOf(Double.parseDouble(qty));
				BigDecimal x = a.multiply(b);
				double amt = CommonUtil.round(x.doubleValue());
				
				PurchaseDetailVO detail = new PurchaseDetailVO();
				detail.setProdId(Integer.parseInt(prodId));
				detail.setQty(Double.parseDouble(qty));
				detail.setAmt(amt);
			
				sum += amt;
				
				details.add(detail);
			}

			total = sum - discount;
			
			master.setAmt(sum);
			master.setTotal(total);
			master.setUstamp(this.getUserInfo());
			
			String masterId = service.addPurchase(master, details, false);
			
			form.setMasterId(masterId);
			
			addLocalizationActionSuccess("add");

		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return DEFAULT;
	}
	
	public String remove() throws Exception {

		logger.info("remove start");
		
		try {
			this.clearErrorsAndMessages();
			
			PurchaseService service = (PurchaseService) getServiceFactory().getService("purchase");
			
			PurchaseMasterVO master = new PurchaseMasterVO();
			master.setId(form.getMasterId());
			master.setUstamp(this.getUserInfo());
			
			service.removePurchase(master, false);
			form.reset();

			addLocalizationActionSuccess("remove");
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addLocalizationActionError(e.getMessage());
		}
		
		return DEFAULT;
	}

	public String getPurchaseList() throws Exception {

		logger.info("getPurchaseList start");

		try {
			String factId = request.getParameter("a");
	
			PurchaseService service = (PurchaseService) getServiceFactory().getService("purchase");
			List<PurchaseMasterVO> list = service.getPurchases(Integer.parseInt(factId), false);
			
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
	
	public String getProdList() {
		logger.debug("getProdList start");

		try {

			String factId = request.getParameter("a");
			String keyword = request.getParameter("b");

			logger.info("param: factId=" + factId);
			logger.info("param: keyword=" + keyword);
			
			ProductService service1 = (ProductService) this.getServiceFactory().getService("product");

			List<PurchaseDetailVO> list = new ArrayList<PurchaseDetailVO>();

			List<ProdVO> prods = service1.getList(keyword);
			if (prods != null && prods.size() > 0) {
				Iterator<ProdVO> it = prods.iterator();
				while(it.hasNext()) {
					ProdVO prod = it.next();
					PurchaseDetailVO vo = new PurchaseDetailVO();
					vo.setProd(prod);
					list.add(vo);
//					sb.append(prod.getProdId() + "|" + prod.getProdNme() + "|" + df.format(prod.getCost()) + "|" + prod.getUnit() + "\n");
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
	
	public void setForm(PoForm form) {
		this.form = form;
	}

	public PoForm getForm() {
		return form;
	}

}
