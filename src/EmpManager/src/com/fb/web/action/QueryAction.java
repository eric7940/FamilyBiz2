package com.fb.web.action;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.log4j.Logger;

import com.fb.service.CustomerService;
import com.fb.service.OfferService;
import com.fb.service.ProductService;
import com.fb.util.FamilyBizException;
import com.fb.vo.OfferMasterVO;
import com.fb.vo.ProdVO;
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
			form.setCusts(service.getList());
			
			ProductService service2 = (ProductService) this.getServiceFactory().getService("product");
			form.setProds(service2.getList());
			
			OfferService service3 = (OfferService) this.getServiceFactory().getService("offer");
			form.setDeliveryUsers(service3.getDeliveryUsers());
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return SUCCESS;
	}	

	public String queryPrice() throws Exception {
		logger.info("queryPrice start");

		try {

			String custId = request.getParameter("a");
			String prodId = request.getParameter("b");

			logger.info("param: custId=" + custId);
			logger.info("param: prodId=" + prodId);
			
			ProductService service = (ProductService) this.getServiceFactory().getService("product");
			List<ProdVO> prods = service.getPriceHistory(Integer.parseInt(custId), Integer.parseInt(prodId));
			
			JsonConfig cfg = new JsonConfig();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("errCde", "00");
			map.put("result", prods);
			
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
	
	public String queryOffers() throws Exception {
		logger.info("queryOffers start");

		try {

			String custId = request.getParameter("a");
			String prodId = request.getParameter("b");

			logger.info("param: custId=" + custId);
			logger.info("param: prodId=" + prodId);
			
			Calendar c = Calendar.getInstance();
			Date today = c.getTime();
			c.set(Calendar.MONTH, -6);
			Date startDate = c.getTime();
			
			OfferService service = (OfferService) this.getServiceFactory().getService("offer");
			List<OfferMasterVO> offers = service.getOffers(Integer.parseInt(custId), prodId, startDate, today, false);
			
			JsonConfig cfg = new JsonConfig();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("errCde", "00");
			map.put("result", offers);
			
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
	
	public String getProdList() throws Exception {
		try {

			String keyword = request.getParameter("a");
			
			logger.info("param: keyword=" + keyword);
			
			ProductService service = (ProductService) this.getServiceFactory().getService("product");
			List<ProdVO> prods = service.getList(keyword);
			
			JsonConfig cfg = new JsonConfig();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("errCde", "00");
			map.put("result", prods);
			
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
	
	public QueryForm getForm() {
		return form;
	}

	public void setForm(QueryForm form) {
		this.form = form;
	}
	
	
}	
