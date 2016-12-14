package com.systex.tcs.pbt.datatrans.vo.target;

import java.io.Serializable;
import java.util.Date;

public class InternalVO implements Serializable {

	private static final long serialVersionUID = 959592138035113823L;
	
	private String formId;
	private String formType;
	private String projectId;
	private String projectName;
	private String initiatorDeptFinCode;
	private String initiatorUserId;
	private String pmDeptFinCode;
	private String pmUserId;
	private String companyCode;
	private Date modifyDate;
	
	public String getFormId() {
		return formId;
	}
	public void setFormId(String formId) {
		this.formId = formId;
	}
	public String getFormType() {
		return formType;
	}
	public void setFormType(String formType) {
		this.formType = formType;
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
	public String getInitiatorDeptFinCode() {
		return initiatorDeptFinCode;
	}
	public void setInitiatorDeptFinCode(String initiatorDeptFinCode) {
		this.initiatorDeptFinCode = initiatorDeptFinCode;
	}
	public String getInitiatorUserId() {
		return initiatorUserId;
	}
	public void setInitiatorUserId(String initiatorUserId) {
		this.initiatorUserId = initiatorUserId;
	}
	public String getPmDeptFinCode() {
		return pmDeptFinCode;
	}
	public void setPmDeptFinCode(String pmDeptFinCode) {
		this.pmDeptFinCode = pmDeptFinCode;
	}
	public String getPmUserId() {
		return pmUserId;
	}
	public void setPmUserId(String pmUserId) {
		this.pmUserId = pmUserId;
	}
	public String getCompanyCode() {
		return companyCode;
	}
	public void setCompanyCode(String companyCode) {
		this.companyCode = companyCode;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	
}
