package com.systex.tcs.pbt.datatrans.vo.source;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.util.List;

public class BacklogDetailVO implements Serializable {

	private static final long serialVersionUID = 959592138035113823L;
	
	private String version;
	private String oin;
	private String ou;
	private String empId;
	private String roleId;
	private int jobLevel;
	private double manDayCost;
	private double manDay;
	private String confirmType;
	private List<Double> days;
	
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getOin() {
		return oin;
	}
	public void setOin(String oin) {
		this.oin = oin;
	}
	public String getOu() {
		return ou;
	}
	public void setOu(String ou) {
		this.ou = ou;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public double getManDayCost() {
		return manDayCost;
	}
	public void setManDayCost(double manDayCost) {
		this.manDayCost = manDayCost;
	}
	public double getManDay() {
		return manDay;
	}
	public void setManDay(double manDay) {
		this.manDay = manDay;
	}
	public int getJobLevel() {
		return jobLevel;
	}
	public void setJobLevel(int jobLevel) {
		this.jobLevel = jobLevel;
	}
	public String getConfirmType() {
		return confirmType;
	}
	public void setConfirmType(String confirmType) {
		this.confirmType = confirmType;
	}
	public List<Double> getDays() {
		return days;
	}
	public void setDays(List<Double> days) {
		this.days = days;
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
