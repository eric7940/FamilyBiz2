package com.systex.tcs.pbt.datatrans.vo.source;

import java.io.Serializable;

public class PermissionSetVO implements Serializable {

	private static final long serialVersionUID = 959592138035113823L;

	private String permissionId;
	private String empId;
	private String empName;
	private String value;
	
	public String getPermissionId() {
		return permissionId;
	}
	public void setPermissionId(String permissionId) {
		this.permissionId = permissionId;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}

}
