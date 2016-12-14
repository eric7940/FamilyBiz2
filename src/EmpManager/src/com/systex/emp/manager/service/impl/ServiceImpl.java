package com.systex.emp.manager.service.impl;

import com.systex.emp.base.service.impl.BaseServiceImpl;
import com.systex.emp.manager.dao.rdbms.MainDAO;
import com.systex.emp.manager.service.Service;

public abstract class ServiceImpl extends BaseServiceImpl implements Service {

	private MainDAO mainDAO;

	public MainDAO getMainDAO() {
		return this.mainDAO;
	}
	
	public void setMainDAO(MainDAO mainDAO) {
		this.mainDAO = mainDAO;
	}
	
}
