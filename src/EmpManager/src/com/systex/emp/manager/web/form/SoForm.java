package com.systex.emp.manager.web.form;

import java.util.List;

import com.systex.emp.base.web.form.BaseForm;
import com.systex.emp.base.web.form.element.PageElement;
import com.systex.emp.manager.vo.DeptVO;
import com.systex.emp.manager.vo.LookupCodeVO;
import com.systex.emp.manager.vo.PBTVO;

public class SoForm extends BaseForm {

	private static final long serialVersionUID = -3287678981329755686L;

	private int activeTab = 1;
	private String stage;
	private String keyword;
	
	private String oin;
	private List<DeptVO> deptList;
	private List<LookupCodeVO> roleList;
	private int maxGrade;
	private PBTVO bean;
	
	public int getActiveTab() {
		return activeTab;
	}

	public void setActiveTab(int activeTab) {
		this.activeTab = activeTab;
	}

	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getOin() {
		return oin;
	}

	public void setOin(String oin) {
		this.oin = oin;
	}

	public PBTVO getBean() {
		return bean;
	}

	public void setBean(PBTVO bean) {
		this.bean = bean;
	}

	public List<DeptVO> getDeptList() {
		return deptList;
	}

	public void setDeptList(List<DeptVO> deptList) {
		this.deptList = deptList;
	}

	public List<LookupCodeVO> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<LookupCodeVO> roleList) {
		this.roleList = roleList;
	}

	public int getMaxGrade() {
		return maxGrade;
	}

	public void setMaxGrade(int maxGrade) {
		this.maxGrade = maxGrade;
	}

	@Override
	public void reset() {
		this.setPageElement(new PageElement());
	}

}
