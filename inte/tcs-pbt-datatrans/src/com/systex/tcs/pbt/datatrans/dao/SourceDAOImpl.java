package com.systex.tcs.pbt.datatrans.dao;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.systex.tcs.pbt.datatrans.vo.source.BacklogVO;
import com.systex.tcs.pbt.datatrans.vo.source.OpportunityVO;
import com.systex.tcs.pbt.datatrans.vo.source.PermissionSetVO;
import com.systex.tcs.pbt.datatrans.vo.source.PipeLineVO;
import com.systex.tcs.pbt.datatrans.vo.source.RoleVO;

public class SourceDAOImpl extends SqlMapClientDaoSupport implements SourceDAO {
	
	private static final String NAMESPACE = "source" + ".";
	
	@SuppressWarnings("unchecked")
	@Override
	public List<PipeLineVO> selectPipeLines() {
		return getSqlMapClientTemplate().queryForList(NAMESPACE + "selectPipeLines");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<BacklogVO> selectBacklogs() {
		return getSqlMapClientTemplate().queryForList(NAMESPACE + "selectBacklogs");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<BacklogVO> selectDraftBacklogs() {
		return getSqlMapClientTemplate().queryForList(NAMESPACE + "selectDraftBacklogs");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<BacklogVO> selectInternals() {
		return getSqlMapClientTemplate().queryForList(NAMESPACE + "selectInternals");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PermissionSetVO> selectPermissionSets() {
		return getSqlMapClientTemplate().queryForList(NAMESPACE + "selectPermissionSet");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<RoleVO> selectRoles() {
		return getSqlMapClientTemplate().queryForList(NAMESPACE + "selectRoles");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OpportunityVO> selectInternalOpportunities() {
		return getSqlMapClientTemplate().queryForList(NAMESPACE + "selectInternalOpportunities");
	}

}
