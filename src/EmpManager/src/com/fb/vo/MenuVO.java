package com.fb.vo;

import java.io.Serializable;
import java.util.List;

public class MenuVO implements Serializable {
	
	private static final long serialVersionUID = -1890362551254939268L;

	private Integer id;
	private String label;
	private String folderFlag;
	private Integer displayOrder;
	
	private MenuVO parent;
	private List<MenuFuncVO> funcs;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getFolderFlag() {
		return folderFlag;
	}
	public void setFolderFlag(String folderFlag) {
		this.folderFlag = folderFlag;
	}
	public Integer getDisplayOrder() {
		return displayOrder;
	}
	public void setDisplayOrder(Integer displayOrder) {
		this.displayOrder = displayOrder;
	}
	public MenuVO getParent() {
		return parent;
	}
	public void setParent(MenuVO parent) {
		this.parent = parent;
	}
	public List<MenuFuncVO> getFuncs() {
		return funcs;
	}
	public void setFuncs(List<MenuFuncVO> funcs) {
		this.funcs = funcs;
	}

}
