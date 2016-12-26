package com.fb.web.action;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.fb.service.FactoryService;
import com.fb.util.ConstUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.FactVO;
import com.fb.web.form.FactForm;
import com.fb.web.form.element.PageElement;

public class FactAction extends BaseAction {

	private static final long serialVersionUID = 8902273376946682789L;

	private static Logger logger = Logger.getLogger(FactAction.class);
	private FactForm form;
	
	public String execute() {
		logger.debug("execute start");

		if ("1".equals(request.getParameter("redirect")) == false)
			this.clearErrorsAndMessages();

		try {

			if (StringUtils.isEmpty(request.getParameter("form.pageElement.currentPage")))
				form.setPageElement(null);
			
			FactoryService service = (FactoryService) this.getServiceFactory().getService("factory");
			
			int totalRecord = service.getFactsCount(form.getKeyword());
			int page = (form.getPageElement() == null) ? 1 : form.getPageElement().getCurrentPage();
//			PageElement pageElement = new PageElement(totalRecord, page, 1);
			PageElement pageElement = new PageElement(totalRecord, page, ConstUtil.QUERY_PAGE_SIZE);

			List<FactVO> records = service.getFacts(form.getKeyword(), pageElement.getStart(), pageElement.getPageSize());
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
			FactoryService service = (FactoryService) this.getServiceFactory().getService("factory");
			
			FactVO fact = new FactVO();
			fact.setName(form.getName());
			fact.setBizNo(form.getBizNo());
			fact.setContact(form.getContact());
			fact.setAddr(form.getAddr());
			fact.setTel(form.getTel());
			fact.setMemo(form.getMemo());
			
			service.addFact(fact);

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

			FactoryService service = (FactoryService) this.getServiceFactory().getService("factory");

			FactVO fact = service.getFact(form.getId());
			form.setName(fact.getName());
			form.setBizNo(fact.getBizNo());
			form.setContact(fact.getContact());
			form.setAddr(fact.getAddr());
			form.setTel(fact.getTel());
			form.setMemo(fact.getMemo());
			
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
			FactoryService service = (FactoryService) this.getServiceFactory().getService("factory");

			FactVO fact = new FactVO();
			fact.setId(form.getId());
			fact.setName(form.getName());
			fact.setBizNo(form.getBizNo());
			fact.setContact(form.getContact());
			fact.setAddr(form.getAddr());
			fact.setTel(form.getTel());
			fact.setMemo(form.getMemo());
			
			service.modifyFact(fact);
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
	
	public void setForm(FactForm form) {
		this.form = form;
	}

	public FactForm getForm() {
		return form;
	}

}	
