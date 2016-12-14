package com.systex.emp.manager.dao.rdbms;

import com.systex.emp.base.dao.rdbms.BaseDAOImpl;

public class MainDAOImpl extends BaseDAOImpl implements MainDAO {

	private static String NAMESPACE = "undefined" + ".";

	public void setNamespace(String namespace) {
		NAMESPACE = namespace + ".";
	}
	public String getNamespace() {
		return NAMESPACE;
	}
}
