package com.systex.tcs.pbt.datatrans.vo.source;

import java.io.Serializable;

public class RoleVO implements Serializable {

	private static final long serialVersionUID = 959592138035113823L;

	private String roleId;
	private String roleName;
	
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
}
