package com.fb.vo;

import java.io.Serializable;
import java.util.Date;

public class KioskVO implements Serializable {

	private static final long serialVersionUID = 1539423595084507072L;

	private String app;
	private String principal;
	private String token;
	private String status;
	private String timeToLife;
	private String api;
	private String input;
	private String output;
	private int errorCode;
	private String errorMessage;
	private String createUser;
	private Date createDate;
	
	public KioskVO(String app, String principal) {
		this.app = app;
		this.principal = principal;
	}
	
	public String getApp() {
		return app;
	}
	public void setApp(String app) {
		this.app = app;
	}
	public String getPrincipal() {
		return principal;
	}
	public void setPrincipal(String principal) {
		this.principal = principal;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTimeToLife() {
		return timeToLife;
	}
	public void setTimeToLife(String timeToLife) {
		this.timeToLife = timeToLife;
	}
	public String getApi() {
		return api;
	}
	public void setApi(String api) {
		this.api = api;
	}
	public String getInput() {
		return input;
	}
	public void setInput(String input) {
		this.input = input;
	}
	public String getOutput() {
		return output;
	}
	public void setOutput(String output) {
		this.output = output;
	}
	public int getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
}
