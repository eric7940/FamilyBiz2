package com.fb.web.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.fb.service.ProductService;
import com.fb.service.StockService;
import com.fb.util.ConstUtil;
import com.fb.util.FamilyBizException;
import com.fb.vo.ProdStockQtyVO;
import com.fb.web.form.StockForm;
import com.fb.web.form.element.PageElement;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

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
			String keyword = form.getKeyword();
			
			if (stockId != null) {
				
				if (StringUtils.isEmpty(request.getParameter("form.pageElement.currentPage")))
					form.setPageElement(null);
				
				int totalRecord = service.getProdsQtyCount(stockId, keyword);
				int page = (form.getPageElement() == null) ? 1 : form.getPageElement().getCurrentPage();
	//			PageElement pageElement = new PageElement(totalRecord, page, 1);
				PageElement pageElement = new PageElement(totalRecord, page, ConstUtil.QUERY_PAGE_SIZE);
	
				List<ProdStockQtyVO> records = service.getProdsQty(stockId, keyword, pageElement.getStart(), pageElement.getPageSize());
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
			String[] adjustArr = request.getParameterValues("adjust");

			List<ProdStockQtyVO> details = new ArrayList<ProdStockQtyVO>();
			for (int i = 0; i < prodIdArr.length; i++) {
				String prodId = prodIdArr[i];
				if (StringUtils.isEmpty(prodId)) continue;
				
				String qty = adjustArr[i];
				
				ProdStockQtyVO detail = new ProdStockQtyVO();
				detail.setProdId(Integer.parseInt(prodId));
				detail.setQty(Double.parseDouble(qty));
				details.add(detail);
				i++;
			}
			
			service.adjustQty(stockId, details);
			
			addLocalizationActionSuccess("save");

		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return DEFAULT;
	}
	
	public String getProdList() {
		logger.debug("getProdList start");

		try {

			String stockId = request.getParameter("a");
			String keyword = request.getParameter("b");

			logger.info("param: stockId=" + stockId);
			logger.info("param: keyword=" + keyword);
			
			StockService service = (StockService) this.getServiceFactory().getService("stock");
			List<ProdStockQtyVO> list = service.getProdQty(Integer.valueOf(stockId), keyword);
						
			JsonConfig cfg = new JsonConfig();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("errCde", "00");
			map.put("result", list);
			
			JSONObject jsonObject = JSONObject.fromObject(map, cfg);
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

	public StockForm getForm() {
		return form;
	}

	public void setForm(StockForm form) {
		this.form = form;
	}
}	
