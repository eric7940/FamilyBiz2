package com.fb.web.action;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.fb.service.CustomerService;
import com.fb.util.ConstUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.CustVO;
import com.fb.web.form.CustForm;
import com.fb.web.form.element.PageElement;

public class CustAction extends BaseAction {

	private static final long serialVersionUID = 8902273376946682789L;

	private static Logger logger = Logger.getLogger(CustAction.class);
	private CustForm form;
	
	public String execute() {
		logger.debug("execute start");

		if ("1".equals(request.getParameter("redirect")) == false)
			this.clearErrorsAndMessages();

		try {

			if (StringUtils.isEmpty(request.getParameter("form.pageElement.currentPage")))
				form.setPageElement(null);
			
			CustomerService service = (CustomerService) this.getServiceFactory().getService("customer");
			
			int totalRecord = service.getCount(form.getKeyword());
			int page = (form.getPageElement() == null) ? 1 : form.getPageElement().getCurrentPage();
//			PageElement pageElement = new PageElement(totalRecord, page, 1);
			PageElement pageElement = new PageElement(totalRecord, page, ConstUtil.QUERY_PAGE_SIZE);

			List<CustVO> records = service.getList(form.getKeyword(), pageElement.getStart(), pageElement.getPageSize());
			pageElement.setRecords(records);
			form.setPageElement(pageElement);
		
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return SUCCESS;
	}
	
	public String reload() {
		form.setKeyword(null);
		return DEFAULT;
	}
	
	public String initAdd() throws Exception {
		logger.debug("initAdd start");
		this.clearErrorsAndMessages();
		form.reset();
		return EDIT;
	}	

	public String add() throws Exception {

		logger.info("add start");
		
		try {
			CustomerService service = (CustomerService) this.getServiceFactory().getService("customer");
			
			CustVO cust = new CustVO();
			cust.setName(form.getName());
			cust.setBizNo(form.getBizNo());
			cust.setDeliverAddr(form.getDeliverAddr());
			cust.setTel(form.getTel());
			cust.setMemo(form.getMemo());
			cust.setUstamp(this.getUserInfo());
			
			service.add(cust);

			addLocalizationActionSuccess("save");

		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return DEFAULT;
	}

	public String initModify() throws Exception {
	
		logger.info("initModify start");
		
		try {
			this.clearErrorsAndMessages();

			CustomerService service = (CustomerService) this.getServiceFactory().getService("customer");

			CustVO cust = service.get(form.getId());
			form.setName(cust.getName());
			form.setBizNo(cust.getBizNo());
			form.setDeliverAddr(cust.getDeliverAddr());
			form.setTel(cust.getTel());
			form.setMemo(cust.getMemo());
			
			request.setAttribute("modify", "y");
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return EDIT;
	}
	
	public String modify() throws Exception {

		logger.info("modify start");
		
		try {
			CustomerService service = (CustomerService) this.getServiceFactory().getService("customer");
			
			CustVO cust = new CustVO();
			cust.setId(form.getId());
			cust.setName(form.getName());
			cust.setBizNo(form.getBizNo());
			cust.setDeliverAddr(form.getDeliverAddr());
			cust.setTel(form.getTel());
			cust.setMemo(form.getMemo());
			cust.setUstamp(this.getUserInfo());
			
			service.modify(cust);
			addLocalizationActionSuccess("save");
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}
		
		return DEFAULT;
	}

	public String remove() throws Exception {

		logger.info("remove start");
		
		try {
			CustomerService service = (CustomerService) this.getServiceFactory().getService("customer");
			
			service.remove(form.getId());
			addLocalizationActionSuccess("remove");
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}
		
		return DEFAULT;
	}
	
	public void setForm(CustForm form) {
		this.form = form;
	}

	public CustForm getForm() {
		return form;
	}

}	
