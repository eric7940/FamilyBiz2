package com.fb.web.action;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.fb.service.CommonService;
import com.fb.service.CustomerService;
import com.fb.service.OfferService;
import com.fb.util.CommonUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.OfferDetailVO;
import com.fb.vo.OfferMasterVO;
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
			
			int detailCount = Integer.parseInt(request.getParameter("detailCount"));
			List<OfferDetailVO> details = new ArrayList<OfferDetailVO>();
			int i = 0;
			while(i < detailCount) {
				String prodId = request.getParameter("detail-" + i + "-prodId");
				if (prodId == null || "".equals(prodId)) {
					i++;
					continue;
				}
				
				String price = request.getParameter("detail-" + i + "-price");
				String cost = request.getParameter("detail-" + i + "-cost");
				String qty = request.getParameter("detail-" + i + "-qty");
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
	
	public void setForm(SoForm form) {
		this.form = form;
	}

	public SoForm getForm() {
		return form;
	}


}
