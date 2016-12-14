package com.fb.util;

public class FamilyBizException extends Exception {

	private static final long serialVersionUID = -1891916801430103620L;

	private MsgType msgType = MsgType.Error;
	private String[] params = null; 

	public FamilyBizException(String message, MsgType msgType, Exception cause, String[] params) {
		super(message, cause);
		this.msgType = msgType;
		this.params = params;
	}

	public FamilyBizException(String message, MsgType msgType, Exception cause) {
		super(message, cause);
		this.msgType = msgType;
	}

	public FamilyBizException(String message, Exception cause) {
		super(message, cause);
	}

	public FamilyBizException(String message) {
		super(message);
	}

	public FamilyBizException(String message, String[] params) {
		super(message);
		this.params = params;
	}
	
	public FamilyBizException(String message, MsgType msgType) {
		super(message);
		this.msgType = msgType;
	}

	public MsgType getMsgType() {
		return this.msgType;
	}

	public void setMsgType(MsgType msgType) {
		this.msgType = msgType;
	}

	public String[] getParams() {
		return this.params;
	}

	public void setParams(String[] params) {
		this.params = params;
	}

	public enum MsgType {
		Error,
		Message,
		Confirm;
	}
}


