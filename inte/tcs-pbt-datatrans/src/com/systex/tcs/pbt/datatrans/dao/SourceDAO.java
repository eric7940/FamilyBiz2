package com.systex.tcs.pbt.datatrans.dao;

import java.util.List;

import com.systex.tcs.pbt.datatrans.vo.source.BacklogVO;
import com.systex.tcs.pbt.datatrans.vo.source.OpportunityVO;
import com.systex.tcs.pbt.datatrans.vo.source.PermissionSetVO;
import com.systex.tcs.pbt.datatrans.vo.source.PipeLineVO;
import com.systex.tcs.pbt.datatrans.vo.source.RoleVO;

public interface SourceDAO {

	public List<PipeLineVO> selectPipeLines();
	public List<BacklogVO> selectBacklogs();
	public List<BacklogVO> selectDraftBacklogs();
	public List<BacklogVO> selectInternals();
	public List<PermissionSetVO> selectPermissionSets();
	public List<RoleVO> selectRoles();
	public List<OpportunityVO> selectInternalOpportunities();

}