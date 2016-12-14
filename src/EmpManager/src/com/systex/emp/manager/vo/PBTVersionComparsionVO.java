package com.systex.emp.manager.vo;

import java.io.Serializable;

public class PBTVersionComparsionVO implements Serializable {

	private static final long serialVersionUID = 959592138035113823L;

	private String op;
	private PBTDetailVO detail1;
	private PBTDetailVO detail2;
	
	public String getOp() {
		return op;
	}
	public void setOp(String op) {
		this.op = op;
	}
	public PBTDetailVO getDetail1() {
		return detail1;
	}
	public void setDetail1(PBTDetailVO detail1) {
		this.detail1 = detail1;
	}
	public PBTDetailVO getDetail2() {
		return detail2;
	}
	public void setDetail2(PBTDetailVO detail2) {
		this.detail2 = detail2;
	}
	
}
