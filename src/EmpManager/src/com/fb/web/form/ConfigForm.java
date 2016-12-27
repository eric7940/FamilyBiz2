package com.fb.web.form;

import java.util.List;

import com.fb.vo.LookupVO;

public class ConfigForm extends BaseForm {

	private static final long serialVersionUID = 4475144758992576653L;

	private List<LookupVO> units;
	private String offerMemo;
	
	private String unitCde;
	private String unitNme;
	
	public List<LookupVO> getUnits() {
		return units;
	}
	public void setUnits(List<LookupVO> units) {
		this.units = units;
	}
	public String getUnitCde() {
		return unitCde;
	}
	public void setUnitCde(String unitCde) {
		this.unitCde = unitCde;
	}
	public String getUnitNme() {
		return unitNme;
	}
	public void setUnitNme(String unitNme) {
		this.unitNme = unitNme;
	}
	public String getOfferMemo() {
		return offerMemo;
	}
	public void setOfferMemo(String offerMemo) {
		this.offerMemo = offerMemo;
	}
	
	@Override
	public void reset() {
		
	}
}
