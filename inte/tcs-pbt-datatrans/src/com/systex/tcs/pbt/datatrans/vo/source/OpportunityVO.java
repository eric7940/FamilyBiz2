package com.systex.tcs.pbt.datatrans.vo.source;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.util.Date;
import java.util.List;

public class OpportunityVO implements Serializable {

	private static final long serialVersionUID = 959592138035113823L;
	
	private String formId;
	private String formType;
	private String oin;
	private String name;
	private String assignedDeptCode;
	private String assignedEmployeeId;
	private String pmDeptCode;
	private String pmEmployeeId;
	private String companyGroupId;
	private Date dateModified;
	
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

	public String getOin() {
		return oin;
	}

	public void setOin(String oin) {
		this.oin = oin;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAssignedDeptCode() {
		return assignedDeptCode;
	}

	public void setAssignedDeptCode(String assignedDeptCode) {
		this.assignedDeptCode = assignedDeptCode;
	}

	public String getAssignedEmployeeId() {
		return assignedEmployeeId;
	}

	public void setAssignedEmployeeId(String assignedEmployeeId) {
		this.assignedEmployeeId = assignedEmployeeId;
	}

	public String getPmDeptCode() {
		return pmDeptCode;
	}

	public void setPmDeptCode(String pmDeptCode) {
		this.pmDeptCode = pmDeptCode;
	}

	public String getPmEmployeeId() {
		return pmEmployeeId;
	}

	public void setPmEmployeeId(String pmEmployeeId) {
		this.pmEmployeeId = pmEmployeeId;
	}

	public String getCompanyGroupId() {
		return companyGroupId;
	}

	public void setCompanyGroupId(String companyGroupId) {
		this.companyGroupId = companyGroupId;
	}

	public Date getDateModified() {
		return dateModified;
	}

	public void setDateModified(Date dateModified) {
		this.dateModified = dateModified;
	}

	public String toString() {
		StringBuilder result = new StringBuilder();
		String newLine = System.getProperty("line.separator");

		result.append(this.getClass().getName());
		result.append(" Object {");
		result.append(newLine);

		// determine fields declared in this class only (no fields of
		// superclass)
		Field[] fields = this.getClass().getDeclaredFields();

		// print field names paired with their values
		for (Field field : fields) {
			result.append("  ");
			try {
				result.append(field.getName());
				result.append(": ");
				// requires access to private field:
				result.append(field.get(this));
			} catch (IllegalAccessException ex) {
				System.out.println(ex);
			}
			result.append(newLine);
		}
		result.append("}");

		return result.toString();
	}	
}
