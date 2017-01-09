package com.fb.web.form;

import java.util.List;

import com.fb.vo.FactVO;

public class FactForm extends BaseForm {

	private static final long serialVersionUID = -3724120956037035599L;

	private String keyword;
	private List<FactVO> facts;
	
	private Integer id;
	private String name;
	private String bizNo;
	private String contact;
	private String addr;
	private String tel;
	private String memo;
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public List<FactVO> getFacts() {
		return facts;
	}
	public void setFacts(List<FactVO> facts) {
		this.facts = facts;
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
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
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
		this.id = null;
		this.name = null;
		this.bizNo = null;
		this.contact = null;
		this.addr = null;
		this.tel = null;
		this.memo = null;
	}

}
