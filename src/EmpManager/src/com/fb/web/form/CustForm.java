package com.fb.web.form;

import java.util.List;

import com.fb.vo.CustVO;

public class CustForm extends BaseForm {

	private static final long serialVersionUID = -3724120956037035599L;

	private String keyword;
	private List<CustVO> custs;
	
	private Integer id;
	private String name;
	private String bizNo;
	private String deliverAddr;
	private String tel;
	private String memo;
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public List<CustVO> getCusts() {
		return custs;
	}
	public void setCusts(List<CustVO> custs) {
		this.custs = custs;
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
	public String getBizNo() {
		return bizNo;
	}
	public void setBizNo(String bizNo) {
		this.bizNo = bizNo;
	}
	public String getDeliverAddr() {
		return deliverAddr;
	}
	public void setDeliverAddr(String deliverAddr) {
		this.deliverAddr = deliverAddr;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	@Override
	public void reset() {
	}

}
