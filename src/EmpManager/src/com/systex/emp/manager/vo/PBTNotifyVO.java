package com.systex.emp.manager.vo;

import java.io.Serializable;
import java.util.Date;

import com.systex.emp.manager.util.ConstUtil;

public class PBTNotifyVO implements Serializable {

	private static final long serialVersionUID = 959592138035113823L;

	private String salesUserId;
	private String salesUserName;
	private String salesEmail;
	private String pmUserId;
	private String pmUserName;
	private String pmEmail;
	private String stage;
	private Date createDate;
	private String projectId;
	private String projectName;
	private String link;
	private double totalCost;
	
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
	public String getSalesEmail() {
		return salesEmail;
	}
	public void setSalesEmail(String salesEmail) {
		this.salesEmail = salesEmail;
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
	public String getPmEmail() {
		return pmEmail;
	}
	public void setPmEmail(String pmEmail) {
		this.pmEmail = pmEmail;
	}
	public String getStage() {
		return stage;
	}
	public void setStage(String stage) {
		switch (stage) {
			case ConstUtil.STAGE_PIPELINE:
				this.stage = "Pipeline立案階段"; break;
			case ConstUtil.STAGE_BACKLOG:
				this.stage = "Backlog立案階段"; break;
			case ConstUtil.STAGE_INTERNAL:
				this.stage = "內部專案立案"; break;
		}
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public double getTotalCost() {
		return totalCost;
	}
	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}

}
