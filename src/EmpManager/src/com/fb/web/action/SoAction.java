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

import com.fb.service.CommonService;
import com.fb.service.CustomerService;
import com.fb.service.OfferService;
import com.fb.service.ProductService;
import com.fb.service.QryPriceService;
import com.fb.util.CommonUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.OfferDetailVO;
import com.fb.vo.OfferMasterVO;
import com.fb.vo.ProdVO;
import com.fb.web.form.SoForm;

public class SoAction extends BaseAction {

	private static final long serialVersionUID = -1652087647900558254L;

	private static final Logger logger = Logger.getLogger(SoAction.class);

	private SoForm form;

	public String execute() {
		logger.debug("execute start");
		
		try {
			int masterId = (form.getMasterId() == null? 0: form.getMasterId().intValue());
			
			if (masterId > 0) {
				OfferService service = (OfferService) this.getServiceFactory().getService("offer");
				OfferMasterVO master = service.getOffer(masterId);
				if (master != null) {
					form.setCust(master.getCust());
					form.setDetails(master.getDetails());
					form.setAmt(master.getAmt());
					form.setDiscount(master.getDiscount());
					form.setInvoiceNbr(master.getInvoiceNbr());
					form.setMemo(master.getMemo());
					form.setOfferDate(master.getOfferDate());
					form.setReceiveAmt(master.getReceiveAmt());
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
			
			CustomerService service1 = (CustomerService) this.getServiceFactory().getService("customer");
			CommonService service2 = (CommonService) this.getServiceFactory().getService("common");
			OfferService service3 = (OfferService) this.getServiceFactory().getService("offer");
			
			form.setCusts(service1.getCusts());
			form.setDeliveryUsers(service3.getDeliveryUsers());

			form.setDiscount(new Double(0));
			form.setMemo(service2.getOfferDefaultMemo());
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
			master.setOfferDate(form.getOfferDate());
			master.setCustId(form.getCustId());
			master.setDeliveryUserId(form.getDeliveryUserId());
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
				i++;
			}

			total = sum - discount;
			
			master.setAmt(sum);
			master.setTotal(total);
			master.setCost(totalCost);
			master.setReceiveAmt(new Double(0));
			
			String masterId = service.addOffer(master, details, false);
			
			form.setMasterId(Integer.parseInt(masterId));
			
			addLocalizationActionSuccess("save");

		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return VIEW;
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
			
			List<ProdVO> prods = service1.getProds(keyword);
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
			
			JSONObject jsonObject  = JSONObject.fromObject(map, cfg);
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
	
	public void setForm(SoForm form) {
		this.form = form;
	}

	public SoForm getForm() {
		return form;
	}


}
