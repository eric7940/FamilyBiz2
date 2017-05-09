package com.fb.web.action;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.fb.service.CommonService;
import com.fb.service.ProductService;
import com.fb.util.ConstUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.LookupVO;
import com.fb.vo.ProdVO;
import com.fb.web.form.ProdForm;
import com.fb.web.form.element.PageElement;

public class ProdAction extends BaseAction {

	private static final long serialVersionUID = 8902273376946682789L;

	private static Logger logger = Logger.getLogger(ProdAction.class);
	private ProdForm form;
	
	public String execute() {
		logger.debug("execute start");

		if ("1".equals(request.getParameter("redirect")) == false)
			this.clearErrorsAndMessages();

		try {

			if (StringUtils.isEmpty(request.getParameter("form.pageElement.currentPage")))
				form.setPageElement(null);
			
			ProductService service = (ProductService) this.getServiceFactory().getService("product");
			
			int totalRecord = service.getCount(form.getKeyword());
			int page = (form.getPageElement() == null) ? 1 : form.getPageElement().getCurrentPage();
//			PageElement pageElement = new PageElement(totalRecord, page, 1);
			PageElement pageElement = new PageElement(totalRecord, page, ConstUtil.QUERY_PAGE_SIZE);

			List<ProdVO> records = service.getList(form.getKeyword(), pageElement.getStart(), pageElement.getPageSize());
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
		
		try {
			this.clearErrorsAndMessages();
			form.reset();
			
			CommonService service = (CommonService) this.getServiceFactory().getService("common");
			List<LookupVO> units = service.getUnits();
			form.setUnits(units);
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}
		
		return EDIT;
	}	

	public String add() throws Exception {

		logger.info("add start");
		
		try {
			ProductService service = (ProductService) this.getServiceFactory().getService("product");
			
			ProdVO prod = new ProdVO();
			prod.setName(form.getName());
			prod.setUnit(form.getUnit());
			prod.setPrice(form.getPrice());
			prod.setCost(new Double(0));
			prod.setSaveQty(form.getSaveQty());
			prod.setUstamp(this.getUserInfo());
			
			service.add(prod);

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

			ProductService service = (ProductService) this.getServiceFactory().getService("product");
			CommonService service1 = (CommonService) this.getServiceFactory().getService("common");
			
			ProdVO prod = service.get(form.getId());
			form.setName(prod.getName());
			form.setUnit(prod.getUnit());
			form.setPrice(prod.getPrice());
			form.setCost(prod.getCost());
			form.setSaveQty(prod.getSaveQty());

			List<LookupVO> units = service1.getUnits();
			form.setUnits(units);

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
			ProductService service = (ProductService) this.getServiceFactory().getService("product");
			
			ProdVO prod = new ProdVO();
			prod.setId(form.getId());
			prod.setName(form.getName());
			prod.setUnit(form.getUnit());
			prod.setPrice(form.getPrice());
			prod.setCost(form.getCost());
			prod.setSaveQty(form.getSaveQty());
			prod.setUstamp(this.getUserInfo());
			
			service.modify(prod);
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
			ProductService service = (ProductService) this.getServiceFactory().getService("product");
			
			service.remove(form.getId());
			addLocalizationActionSuccess("remove");
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}
		
		return DEFAULT;
	}

	public void setForm(ProdForm form) {
		this.form = form;
	}

	public ProdForm getForm() {
		return form;
	}

}	
