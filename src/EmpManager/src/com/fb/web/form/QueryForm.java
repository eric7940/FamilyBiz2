package com.fb.web.form;

import java.util.List;

import com.fb.vo.CustVO;
import com.fb.vo.ProdVO;
import com.fb.vo.UserVO;

public class QueryForm extends BaseForm {

	private static final long serialVersionUID = 4475144758992576653L;

	private List<CustVO> custs;
	private List<ProdVO> prods;
	private List<UserVO> deliveryUsers;
	
	public List<CustVO> getCusts() {
		return custs;
	}
	public void setCusts(List<CustVO> custs) {
		this.custs = custs;
	}
	public List<ProdVO> getProds() {
		return prods;
	}
	public void setProds(List<ProdVO> prods) {
		this.prods = prods;
	}
	public List<UserVO> getDeliveryUsers() {
		return deliveryUsers;
	}
	public void setDeliveryUsers(List<UserVO> deliveryUsers) {
		this.deliveryUsers = deliveryUsers;
	}

	@Override
	public void reset() {
		
	}
}
