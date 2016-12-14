package com.systex.emp.manager.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class PBTVO implements Serializable {

	private static final long serialVersionUID = 959592138035113823L;

	private String projectId;
	private String stage;
	private String version;
	private double totalCost;
	private double totalManday;
	private Date startDate;
	private Date endDate;
	private String createUser;
	private Date createDate;
	private String modifyUser;
	private Date modifyDate;
	
	private String name;
	private String salesDeptFinCode;
	private String salesDeptName;
	private String salesUserId;
	private String salesUserName;
	private String pmDeptFinCode;
	private String pmDeptName;
	private String pmUserId;
	private String pmUserName;
	
	private List<PBTDetailVO> details;
	
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
	public double getTotalCost() {
		return totalCost;
	}
	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}
	public double getTotalManday() {
		return totalManday;
	}
	public void setTotalManday(double totalManday) {
		this.totalManday = totalManday;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSalesDeptFinCode() {
		return salesDeptFinCode;
	}
	public void setSalesDeptFinCode(String salesDeptFinCode) {
		this.salesDeptFinCode = salesDeptFinCode;
	}
	public String getSalesDeptName() {
		return salesDeptName;
	}
	public void setSalesDeptName(String salesDeptName) {
		this.salesDeptName = salesDeptName;
	}
	public String getSalesUserId() {
		return salesUserId;
	}
	public void setSalesUserId(String salesUserId) {
		this.salesUserId = salesUserId;
	}
	public String getSalesUserName() {
		return salesUserName;
	}
	public void setSalesUserName(String salesUserName) {
		this.salesUserName = salesUserName;
	}
	public String getPmDeptFinCode() {
		return pmDeptFinCode;
	}
	public void setPmDeptFinCode(String pmDeptFinCode) {
		this.pmDeptFinCode = pmDeptFinCode;
	}
	public String getPmDeptName() {
		return pmDeptName;
	}
	public void setPmDeptName(String pmDeptName) {
		this.pmDeptName = pmDeptName;
	}
	public String getPmUserId() {
		return pmUserId;
	}
	public void setPmUserId(String pmUserId) {
		this.pmUserId = pmUserId;
	}
	public String getPmUserName() {
		return pmUserName;
	}
	public void setPmUserName(String pmUserName) {
		this.pmUserName = pmUserName;
	}
	public List<PBTDetailVO> getDetails() {
		return details;
	}
	public void setDetails(List<PBTDetailVO> details) {
		this.details = details;
	}
	
}
