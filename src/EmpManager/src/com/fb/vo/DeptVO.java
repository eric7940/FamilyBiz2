package com.fb.vo;

import java.io.Serializable;

public class DeptVO implements Serializable {

	private static final long serialVersionUID = 1539423595084507072L;

	private String id;
	private String name;
	private String finCode;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFinCode() {
		return finCode;
	}
	public void setFinCode(String finCode) {
		this.finCode = finCode;
	}
	


}
