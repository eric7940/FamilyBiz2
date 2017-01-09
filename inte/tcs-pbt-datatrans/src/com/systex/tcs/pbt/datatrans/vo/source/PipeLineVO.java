package com.systex.tcs.pbt.datatrans.vo.source;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PipeLineVO implements Serializable {

	private static final long serialVersionUID = 959592138035113823L;

	private String oin;
	private String status;
	private String creator;
	private Date createDate;
	private String modifier;
	private Date modifyDate;
	private List<PipeLineDetailVO> details = new ArrayList<PipeLineDetailVO>();
	
	public String getOin() {
		return oin;
	}
	public void setOin(String oin) {
		this.oin = oin;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public List<PipeLineDetailVO> getDetails() {
		return details;
	}
	public void setDetails(List<PipeLineDetailVO> details) {
		this.details = details;
	}
	
}
