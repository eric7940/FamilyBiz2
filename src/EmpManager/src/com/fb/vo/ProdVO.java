package com.fb.vo;

import java.io.Serializable;

public class ProdVO implements Serializable{

	private static final long serialVersionUID = -2256320739753652965L;

	private Integer id;
	private String name;
	private String unit;
	private Double price;
	private Double cost;
	private Integer saveQty;
	
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
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getCost() {
		return cost;
	}
	public void setCost(Double cost) {
		this.cost = cost;
	}
	public Integer getSaveQty() {
		return saveQty;
	}
	public void setSaveQty(Integer saveQty) {
		this.saveQty = saveQty;
	}
}
