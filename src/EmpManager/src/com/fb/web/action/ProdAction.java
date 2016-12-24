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
			
			int totalRecord = service.getProdsCount(form.getKeyword());
			int page = (form.getPageElement() == null) ? 1 : form.getPageElement().getCurrentPage();
//			PageElement pageElement = new PageElement(totalRecord, page, 1);
			PageElement pageElement = new PageElement(totalRecord, page, ConstUtil.QUERY_PAGE_SIZE);

			List<ProdVO> records = service.getProds(form.getKeyword(), pageElement.getStart(), pageElement.getPageSize());
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
			prod.setCost(form.getCost());
			prod.setSaveQty(form.getSaveQty());
			
			service.addProd(prod);

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
			
			ProdVO prod = service.getProd(form.getId());
			form.setName(prod.getName());
			form.setUnit(prod.getUnit());
			form.setPrice(prod.getPrice());
			form.setCost(prod.getCost());
			form.setSaveQty(prod.getSaveQty());
			
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
			
			service.modifyProd(prod);
			addLocalizationActionSuccess("save");
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}
		
		return DEFAULT;
	}
//
//	public ActionForward delete(ActionMapping mapping,
//			ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) throws Exception {
//
//		logger.info("delete start");
//		ActionMessages messages = new ActionMessages();
//
//		try {
//			CustForm formBean = (CustForm)form;
//			CustomerService service = (CustomerService) this.getServiceFactory().getService("Customer");
//			
//			int result = 0;
//			List<CustProfVO> custs = formBean.getCusts();
//			String[] selectIdx = request.getParameterValues("selectIdx");
//			if (selectIdx.length > 1) {
//				List<Integer> custIds = new ArrayList<Integer>();
//				for(int i = 0; i < selectIdx.length; i++) {
//					int idx = Integer.parseInt(selectIdx[i]);
//					CustProfVO cust = custs.get(idx);
//					custIds.add(cust.getCustId());
//				}
//				result = service.removeCusts(custIds);
//			} else {
//				int idx = Integer.parseInt(selectIdx[0]);
//				CustProfVO cust = (CustProfVO)custs.get(idx);
//				result = service.removeCust(cust.getCustId());
//			}
//			messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("basic.msg.2", result));
//			
//		} catch (FamilyBizException sce) {
//			logger.error("",sce);
//			messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("all.0", sce.getMessage()));
//			saveMessages(request, messages);
//		} catch (Exception e) {
//			logger.error("",e);
//			messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("all.msg.1"));
//			saveMessages(request, messages);
//		}
//		
//		logger.info("delete end");
//		saveMessages(request, messages);
//		
//		return new ActionForward("/cust.do?state=init", false);
//	}
	
	public void setForm(ProdForm form) {
		this.form = form;
	}

	public ProdForm getForm() {
		return form;
	}

}	
