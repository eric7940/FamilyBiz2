package com.fb.service;

import java.util.List;

import com.fb.util.FamilyBizException;
import com.fb.vo.LookupVO;

public interface CommonService extends Service {

	public List<LookupVO> getUnits() throws FamilyBizException;
	
	public void modifyUnits(List<String> units) throws FamilyBizException;

	public String getOfferDefaultMemo() throws FamilyBizException;
	
	public void modifyOfferDefaultMemo(String memo) throws FamilyBizException;
	
}
