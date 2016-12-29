package com.fb.web.action;

import java.text.DecimalFormat;

import org.apache.log4j.Logger;

import com.fb.service.CustomerService;
import com.fb.service.OfferService;
import com.fb.service.ProductService;
import com.fb.util.FamilyBizException;
import com.fb.web.form.QueryForm;

public class QueryAction extends BaseAction {

	private static final long serialVersionUID = 6680330366690089408L;

	private static Logger logger = Logger.getLogger(QueryAction.class);

	private static DecimalFormat df = new DecimalFormat("#0.00");
	private static DecimalFormat df2 = new DecimalFormat("$#,##0.00");

	private QueryForm form;
	
	public String execute() throws Exception {
	
		logger.info("execute start");

		if ("1".equals(request.getParameter("redirect")) == false)
			this.clearErrorsAndMessages();

		try {
			CustomerService service = (CustomerService) this.getServiceFactory().getService("customer");
			form.setCusts(service.getCusts());
			
			ProductService service2 = (ProductService) this.getServiceFactory().getService("product");
			form.setProds(service2.getProds());
			
			OfferService service3 = (OfferService) this.getServiceFactory().getService("offer");
			form.setDeliveryUsers(service3.getDeliveryUsers());
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return SUCCESS;
	}	

//	public ActionForward qryPrice(ActionMapping mapping,
//			ActionForm form,
//			HttpServletRequest request,
//			HttpServletResponse response) throws Exception {
//
//		logger.info("qryPrice start");
//		StringBuffer sb = new StringBuffer();
//		try {
//			String custId = request.getParameter("custId");
//			//String prodNme = request.getParameter("q");
//			String prodNme = new String(request.getParameter("q").getBytes("ISO8859_1"), "UTF-8");
//			
//			logger.info("param: custId=" + custId);
//			logger.info("param: prodNme=" + prodNme);
//			
//			if (prodNme != null && ("".equals(prodNme.trim()) || "　".equals(prodNme.trim()))) prodNme = null;
//	
//			ProductService service = (ProductService) this.getServiceFactory().getService("Product");
//			List<ProdProfVO> prods = service.getProds(Integer.parseInt(custId), prodNme);
//			
//			if (prods != null && prods.size() > 0) {
//				Iterator<ProdProfVO> it = prods.iterator();
//				while(it.hasNext()) {
//					ProdProfVO prod = it.next();
//					sb.append(prod.getProdId() + "|" + prod.getProdNme() + "|" + df.format(prod.getPrice()) + "\n");
//				}
//			}
//		} catch (FamilyBizException sce) {
//			logger.error("", sce);
//			sb.append(sce.getMessage());
//		} catch (Exception e) {
//			logger.error("", e);
//			MessageResources mr = this.getResources(request);
//			sb.append(mr.getMessage("all.msg.1"));
//		}
//		
//		logger.info("qryPrice end");
//		return this.sendAjaxResponse(response, sb.toString());
//	}
	
	public QueryForm getForm() {
		return form;
	}

	public void setForm(QueryForm form) {
		this.form = form;
	}
	
	
}	
