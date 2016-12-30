package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.ProdVO;

public interface ProductService extends Service {

	public ProdVO get(int id) throws FamilyBizException;
	
	public int getCount(String keyword) throws FamilyBizException;

	public List<ProdVO> getList() throws FamilyBizException;
	
	public List<ProdVO> getList(String keyword) throws FamilyBizException;

	public List<ProdVO> getList(String keyword, int offset, int limit) throws FamilyBizException;
	
	public List<ProdVO> getPriceHistory(int custId, int prodId) throws FamilyBizException;

	public void add(ProdVO prod) throws FamilyBizException;

	public void modify(ProdVO prod) throws FamilyBizException;
	
	public int remove(int id) throws FamilyBizException;
	
	@SuppressWarnings("rawtypes")
	public int remove(List prodIds) throws FamilyBizException;
}
