package com.fb.vo;

import java.io.Serializable;

public class StockVO implements Serializable{

	private static final long serialVersionUID = 4580876424488415246L;

	private Integer id;
	private String name;
	private String addr;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
}
