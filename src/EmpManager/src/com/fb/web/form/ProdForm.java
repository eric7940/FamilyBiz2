package com.fb.web.form;

import java.util.List;

import com.fb.vo.LookupVO;
import com.fb.vo.ProdVO;

public class ProdForm extends BaseForm {

	private static final long serialVersionUID = -3724120956037035599L;

	private List<ProdVO> prods;
	private List<LookupVO> units;

	private String keyword;
	
	private Integer id;
	private String name;
	private String unit;
	private Double price;
	private Double cost;
	private Integer saveQty;

	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public List<ProdVO> getProds() {
		return prods;
	}
	public void setProds(List<ProdVO> prods) {
		this.prods = prods;
	}
	public List<LookupVO> getUnits() {
		return units;
	}
	public void setUnits(List<LookupVO> units) {
		this.units = units;
	}
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

	@Override
	public void reset() {
		this.id = null;
		this.name = null;
		this.unit = null;
		this.price = null;
		this.cost = null;
		this.saveQty = null;
	}

}
