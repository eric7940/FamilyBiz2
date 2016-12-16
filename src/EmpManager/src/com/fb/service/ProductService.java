package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.ProdVO;

public interface ProductService extends Service {

	public ProdVO getProd(int prodId) throws FamilyBizException;
	
	public List<ProdVO> getProds() throws FamilyBizException;
	
	public List<ProdVO> getProds(String prodNme) throws FamilyBizException;

	public List<ProdVO> getProds(int custId) throws FamilyBizException;

	public List<ProdVO> getProds(int custId, String prodNme) throws FamilyBizException;

	public void addProd(ProdVO prod) throws FamilyBizException;

	public void modifyProd(ProdVO prod) throws FamilyBizException;
	
	public int removeProd(int prodId) throws FamilyBizException;
	
	@SuppressWarnings("rawtypes")
	public int removeProds(List prodIds) throws FamilyBizException;
}
