package com.fb.web.action;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.fb.service.CustomerService;
import com.fb.util.ConstUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.CustVO;
import com.fb.web.form.CustForm;
import com.fb.web.form.SoForm;
import com.fb.web.form.element.PageElement;

public class CustAction extends BaseAction {

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
			
			int totalRecord = service.getCustsCount(form.getKeyword());
			int page = (form.getPageElement() == null) ? 1 : form.getPageElement().getCurrentPage();
//			PageElement pageElement = new PageElement(totalRecord, page, 1);
			PageElement pageElement = new PageElement(totalRecord, page, ConstUtil.QUERY_PAGE_SIZE);

			List<CustVO> records = service.getCusts(form.getKeyword(), pageElement.getStart(), pageElement.getPageSize());
			pageElement.setRecords(records);
			form.setPageElement(pageElement);
		
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return SUCCESS;
	}
	
	public String initCreate() throws Exception {
	
		logger.debug("initAdd start");

		this.clearErrorsAndMessages();

		return EDIT;
	}	

	public String create() throws Exception {

		logger.info("create start");
		
		try {
			CustomerService service = (CustomerService) this.getServiceFactory().getService("customer");
			
			CustVO cust = new CustVO();
			cust.setName(form.getCustNme());
			cust.setBizNo(form.getBizNo());
			cust.setDeliverAddr(form.getDeliverAddr());
			cust.setTel(form.getTel());
			cust.setMemo(form.getMemo());
			
			service.addCust(cust);

			addLocalizationActionSuccess("save");

		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		logger.info("create end");
		return DEFAULT;
	}

//	public String initModify(ActionMapping mapping,
//			ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) throws Exception {
//	
//		logger.info("initModify start");
//		ActionMessages messages = new ActionMessages();
//		
//		try {
//			CustForm formBean = (CustForm)form;
//			CustomerService service = (CustomerService) this.getServiceFactory().getService("Customer");
//
//			CustProfVO cust = service.getCust(formBean.getCustId());
//			
//			formBean.setCustNme(cust.getCustNme());
//			formBean.setBizNo(cust.getBizNo());
//			formBean.setDeliverAddr(cust.getDeliverAddr());
//			formBean.setTel(cust.getTel());
//			formBean.setMemo(cust.getMemo());
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
//		request.setAttribute("action", "modify");
//
//		logger.info("initModify end");
//		return mapping.findForward("form");
//	}
//	
//	public String modify(ActionMapping mapping,
//			ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) throws Exception {
//
//		logger.info("modify start");
//		ActionMessages messages = new ActionMessages();
//
//		try {
//			CustForm formBean = (CustForm)form;
//			CustomerService service = (CustomerService) this.getServiceFactory().getService("Customer");
//			
//			CustProfVO cust = new CustProfVO();
//			cust.setCustId(formBean.getCustId());
//			cust.setCustNme(formBean.getCustNme());
//			cust.setBizNo(formBean.getBizNo());
//			cust.setDeliverAddr(formBean.getDeliverAddr());
//			cust.setTel(formBean.getTel());
//			cust.setMemo(formBean.getMemo());
//			
//			service.modifyCust(cust);
//			messages.add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage("basic.msg.3"));
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
//		logger.info("modify end");
//		saveMessages(request, messages);
//		
//		return new ActionForward("/cust.do?state=init", false);
//	}
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
	
	public void setForm(CustForm form) {
		this.form = form;
	}

	public CustForm getForm() {
		return form;
	}

}	
