package com.fb.web.action;

import org.apache.log4j.Logger;

import com.fb.service.OfferService;
import com.fb.util.FamilyBizException;
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

	public void setForm(SoForm form) {
		this.form = form;
	}

	public SoForm getForm() {
		return form;
	}


}
