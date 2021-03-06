package com.systex.tcs.pbt.datatrans.vo.target;

import java.io.Serializable;

public class UserVO implements Serializable {

	private static final long serialVersionUID = 1539423595084507072L;

	private String id;
	private String name;
	private int jobLevel;
	private double costRate;
	private String deptId;
	
	public UserVO() {}

	public UserVO(String id, String name) {
		this.id = id;
		this.name = name;
	}
	
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

	public int getJobLevel() {
		return jobLevel;
	}

	public void setJobLevel(int jobLevel) {
		this.jobLevel = jobLevel;
	}

	public double getCostRate() {
		return costRate;
	}

	public void setCostRate(double costRate) {
		this.costRate = costRate;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

}
