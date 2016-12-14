package com.systex.tcs.pbt.datatrans.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.systex.tcs.pbt.datatrans.vo.target.InternalVO;
import com.systex.tcs.pbt.datatrans.vo.target.LookupCodeVO;
import com.systex.tcs.pbt.datatrans.vo.target.PBTDetailVO;
import com.systex.tcs.pbt.datatrans.vo.target.PBTVO;
import com.systex.tcs.pbt.datatrans.vo.target.PBTVersionVO;

public class TargetDAOImpl extends SqlMapClientDaoSupport implements TargetDAO {

	private static final String NAMESPACE = "target" + ".";

	@Override
	public void insertPBT(PBTVO vo) {
		getSqlMapClientTemplate().insert(NAMESPACE + "insertPBT", vo);
	}

	@Override
	public void insertPBTVersion(PBTVersionVO vo) {
		getSqlMapClientTemplate().insert(NAMESPACE + "insertPBTVersion", vo);
	}

	@Override
	public void insertPBTDetails(List<PBTDetailVO> details) {
		getSqlMapClientTemplate().insert(NAMESPACE + "insertPBTDetails", details);
	}

	@Override
	public void updatePBTComputingFields(String stage) {
		getSqlMapClientTemplate().update(NAMESPACE + "updatePBTComputingFields", stage);
	}

	@Override
	public void insertLookupCodes(List<LookupCodeVO> codes) {
		getSqlMapClientTemplate().insert(NAMESPACE + "insertLookupCodes", codes);
	}

	@Override
	public void insertInternalOpportunity(InternalVO vo) {
		getSqlMapClientTemplate().insert(NAMESPACE + "insertInternal", vo);
	}

}
