package com.fb.web.action;

import java.util.Arrays;
import java.util.List;

import org.apache.log4j.Logger;

import com.fb.service.CommonService;
import com.fb.util.FamilyBizException;
import com.fb.vo.LookupVO;
import com.fb.web.form.ConfigForm;

public class ConfigAction extends BaseAction {

	private static final long serialVersionUID = 6680330366690089408L;

	private static Logger logger = Logger.getLogger(ConfigAction.class);

	private ConfigForm form;
	
	public String initConfig() throws Exception {
	
		logger.info("initConfig start");

		if ("1".equals(request.getParameter("redirect")) == false)
			this.clearErrorsAndMessages();

		try {
			CommonService service = (CommonService) this.getServiceFactory().getService("common");
			
			List<LookupVO> units = service.getUnits();
			form.setUnits(units);
			
			String offerMemo = service.getOfferDefaultMemo();
			form.setOfferMemo(offerMemo);

		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return SUCCESS;
	}	

	public String modifyUnits() throws Exception {

		logger.info("modifyUnits start");
		this.clearErrorsAndMessages();
		
		try {
			CommonService service = (CommonService) this.getServiceFactory().getService("common");
			
			String[] labels = request.getParameterValues("unit_label");
			List<String> units = Arrays.asList(labels);
			
			service.modifyUnits(units);

			addLocalizationActionSuccess("save");
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return DEFAULT;
	}

	public String modifyOfferMemo() throws Exception {

		logger.info("modifyOfferMemo start");
		this.clearErrorsAndMessages();
		
		try {
			CommonService service = (CommonService) this.getServiceFactory().getService("common");
			
			service.modifyOfferDefaultMemo(form.getOfferMemo());
			addLocalizationActionSuccess("save");
			
		} catch (FamilyBizException e) {
			logger.error("action fail.", e);
			this.addActionError(e);
		}

		return DEFAULT;
	}

	public ConfigForm getForm() {
		return form;
	}

	public void setForm(ConfigForm form) {
		this.form = form;
	}
	
	
}	
