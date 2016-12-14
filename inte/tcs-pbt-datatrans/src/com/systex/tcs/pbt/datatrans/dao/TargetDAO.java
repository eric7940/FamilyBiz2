package com.systex.tcs.pbt.datatrans.dao;

import java.util.List;

import com.systex.tcs.pbt.datatrans.vo.target.InternalVO;
import com.systex.tcs.pbt.datatrans.vo.target.LookupCodeVO;
import com.systex.tcs.pbt.datatrans.vo.target.PBTDetailVO;
import com.systex.tcs.pbt.datatrans.vo.target.PBTVO;
import com.systex.tcs.pbt.datatrans.vo.target.PBTVersionVO;

public interface TargetDAO {

	public void insertPBT(PBTVO vo);
	public void insertPBTVersion(PBTVersionVO vo);
	public void insertPBTDetails(List<PBTDetailVO> details);
	public void updatePBTComputingFields(String stage);
	public void insertLookupCodes(List<LookupCodeVO> codes);
	public void insertInternalOpportunity(InternalVO vo);
}