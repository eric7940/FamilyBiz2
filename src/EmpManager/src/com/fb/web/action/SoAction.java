package com.fb.web.action;

import org.apache.log4j.Logger;

import com.fb.web.form.SoForm;

public class SoAction extends BaseAction {

	private static final long serialVersionUID = -1652087647900558254L;

	private static final Logger logger = Logger.getLogger(SoAction.class);

	private SoForm form;

	public String execute() {
		logger.debug("execute start");

		if ("1".equals(request.getParameter("redirect")) == false)
			this.clearErrorsAndMessages();

		return SUCCESS;
	}

	public void setForm(SoForm form) {
		this.form = form;
	}

	public SoForm getForm() {
		return form;
	}


}
