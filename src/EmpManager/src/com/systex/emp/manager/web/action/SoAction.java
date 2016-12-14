package com.systex.emp.manager.web.action;

import org.apache.log4j.Logger;

import com.systex.emp.manager.web.form.SoForm;

public class SoAction extends EmpManagerAction {

	private static final long serialVersionUID = -1652087647900558254L;

	private static final Logger logger = Logger.getLogger(SoAction.class);

	private SoForm form;

	public String execute() {
		logger.debug("execute start");

		if ("1".equals(request.getParameter("redirect")) == false)
			this.clearErrorsAndMessages();

		return SUCCESS;
	}

	public String reload() {
		form.setKeyword(null);
		return DEFAULT;
	}
	
	@Override
	public String initAdd() {
		logger.debug("initAdd start");

		this.clearErrorsAndMessages();

		return EDIT;
	}

	@Override
	public String add() {
		return "";
	}


	@Override
	public String modify() {

		return "";
	}

	public void setForm(SoForm form) {
		this.form = form;
	}

	public SoForm getForm() {
		return form;
	}

	@Override
	public String initModify() {
		logger.debug("initModify start");

		this.clearErrorsAndMessages();

		return EDIT;
	}

	@Override
	public String remove() {
		return null;
	}

}
