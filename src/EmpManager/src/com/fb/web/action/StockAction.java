package com.fb.web.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.fb.service.ProductService;
import com.fb.service.StockService;
import com.fb.util.ConstUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.ProdStockQtyVO;
import com.fb.web.form.StockForm;
import com.fb.web.form.element.PageElement;

public class StockAction extends BaseAction {

	private static final long serialVersionUID = 8864761224054444721L;

	private static Logger logger = Logger.getLogger(StockAction.class);

	private StockForm form;
	
	public String execute() throws Exception {
		logger.debug("execute start");

		if ("1".equals(request.getParameter("redirect")) == false)
			this.clearErrorsAndMessages();

		try {

			StockService service = (StockService) this.getServiceFactory().getService("stock");
			form.setStocks(service.getStocks());

			Integer stockId = form.getStockId();
			
			if (stockId != null) {
				
				if (StringUtils.isEmpty(request.getParameter("form.pageElement.currentPage")))
					form.setPageElement(null);
				
				int totalRecord = service.getProdsQtyCount(stockId);
				int page = (form.getPageElement() == null) ? 1 : form.getPageElement().getCurrentPage();
	//			PageElement pageElement = new PageElement(totalRecord, page, 1);
				PageElement pageElement = new PageElement(totalRecord, page, ConstUtil.QUERY_PAGE_SIZE);
	
				List<ProdStockQtyVO> records = service.getProdsQty(stockId, pageElement.getStart(), pageElement.getPageSize());
				pageElement.setRecords(records);
				form.setPageElement(pageElement);
				
			}
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return SUCCESS;
	}
	
	public String initAdjust() throws Exception {
	
		logger.info("initAdjust start");
		
		try {

			this.clearErrorsAndMessages();
			form.reset();
			
			StockService service1 = (StockService) this.getServiceFactory().getService("stock");
			ProductService service2 = (ProductService) this.getServiceFactory().getService("product");
			
			form.setProds(service2.getProds());
			form.setStocks(service1.getStocks());
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return EDIT;
	}	

	public String adjust() throws Exception {

		logger.info("adjust start");

		try {
			Integer stockId = form.getStockId();
			
			StockService service = (StockService) this.getServiceFactory().getService("stock");
			
			String[] prodIdArr = request.getParameterValues("prodId");
			String[] qtyArr = request.getParameterValues("qty");

			List<ProdStockQtyVO> details = new ArrayList<ProdStockQtyVO>();
			for (int i = 0; i < prodIdArr.length; i++) {
				String prodId = prodIdArr[i];
				if (StringUtils.isEmpty(prodId)) continue;
				
				String qty = qtyArr[i];
				
				ProdStockQtyVO detail = new ProdStockQtyVO();
				detail.setProdId(Integer.parseInt(prodId));
				detail.setQty(Double.parseDouble(qty));
				details.add(detail);
				i++;
			}
			
			service.adjustQty(stockId, details);
			
			addLocalizationActionSuccess("adjust");

		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return DEFAULT;
	}

	public StockForm getForm() {
		return form;
	}

	public void setForm(StockForm form) {
		this.form = form;
	}
}	
