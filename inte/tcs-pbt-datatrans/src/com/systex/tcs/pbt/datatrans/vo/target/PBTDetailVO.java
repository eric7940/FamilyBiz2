package com.systex.tcs.pbt.datatrans.vo.target;

import java.io.Serializable;
import java.util.Date;

public class PBTDetailVO implements Serializable {

	private static final long serialVersionUID = 959592138035113823L;

	private String id;
	private String projectId;
	private String stage;
	private String version;
	private String deptId;
	private String deptName;
	private String userId;
	private String userName;
	private String role;
	private int grade;
	private double costRate;
	private double manday;
	private int headCount;
	private String mandayDetails;
	private String state;
	private String createUser;
	private Date createDate;
	private String modifyUser;
	private Date modifyDate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getStage() {
		return stage;
	}
	public void setStage(String stage) {
		this.stage = stage;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public double getCostRate() {
		return costRate;
	}
	public void setCostRate(double costRate) {
		this.costRate = costRate;
	}
	public double getManday() {
		return manday;
	}
	public void setManday(double manday) {
		this.manday = manday;
	}
	public int getHeadCount() {
		return headCount;
	}
	public void setHeadCount(int headCount) {
		this.headCount = headCount;
	}
	public String getMandayDetails() {
		return mandayDetails;
	}
	public void setMandayDetails(String mandayDetails) {
		this.mandayDetails = mandayDetails;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getModifyUser() {
		return modifyUser;
	}
	public void setModifyUser(String modifyUser) {
		this.modifyUser = modifyUser;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	
}
