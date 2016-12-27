package com.fb.web.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.fb.service.CommonService;
import com.fb.util.CommonUtil;
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
		
		try {
			CommonService service = (CommonService) this.getServiceFactory().getService("common");
			
			String[] labels = request.getParameterValues("label");
			String[] idx = request.getParameterValues("unitDeleteIdx");

			String deleteIdx = "";
			if (idx != null)
				deleteIdx = "," + CommonUtil.convertListToString(idx, ",", false) + ",";

			List<String> units = new ArrayList<String>();
			for(int i = 0; i < labels.length; i++) {
				if (labels[i] == null || "".equals(labels[i])) continue;

				if (i < form.getUnits().size()) {
					//屬於原有的資料
					
					//刪除的不予理會
					if (deleteIdx.indexOf("," + String.valueOf(i) + ",") != -1) continue; 
					
					units.add(labels[i]);
				} else {
					//屬於新增的資料
					units.add(labels[i]);
				}
			}
			
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
