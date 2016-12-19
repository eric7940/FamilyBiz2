package com.fb.web.form;

import java.io.Serializable;

import com.fb.web.form.element.PageElement;

public abstract class BaseForm implements Serializable {

	private static final long serialVersionUID = 6676379620576127090L;
	
	private String menuId;
	private PageElement pageElement;
	
	public abstract void reset();

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public PageElement getPageElement() {
		return pageElement;
	}

	public void setPageElement(PageElement pageElement) {
		this.pageElement = pageElement;
	}
	
}
