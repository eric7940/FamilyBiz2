package com.systex.tcs.pbt.datatrans;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.systex.tcs.pbt.datatrans.dao.SourceDAOImpl;
import com.systex.tcs.pbt.datatrans.dao.TargetDAOImpl;
import com.systex.tcs.pbt.datatrans.vo.source.BacklogDetailVO;
import com.systex.tcs.pbt.datatrans.vo.source.BacklogVO;
import com.systex.tcs.pbt.datatrans.vo.source.OpportunityVO;
import com.systex.tcs.pbt.datatrans.vo.source.PermissionSetVO;
import com.systex.tcs.pbt.datatrans.vo.source.PipeLineDetailVO;
import com.systex.tcs.pbt.datatrans.vo.source.PipeLineVO;
import com.systex.tcs.pbt.datatrans.vo.source.RoleVO;
import com.systex.tcs.pbt.datatrans.vo.target.InternalVO;
import com.systex.tcs.pbt.datatrans.vo.target.LookupCodeVO;
import com.systex.tcs.pbt.datatrans.vo.target.PBTDetailVO;
import com.systex.tcs.pbt.datatrans.vo.target.PBTVO;
import com.systex.tcs.pbt.datatrans.vo.target.PBTVersionVO;

public class DataTrans {

	private static final Logger logger = Logger.getLogger(DataTrans.class);

	private static final String STAGE_PIPELINE = "P";
	private static final String STAGE_BACKLOG = "B";
	private static final String STAGE_INTERNAL = "I";
	
	private static final String VERSION_DRAFT = "9999";
	private static final String VERSION_PIPELINE = "0001";

	private static final String STATUS_DRAFT = "Draft";
	
	private static final Map<String,String> PIPELINE_STATUS_MAP = new HashMap<String,String>();
	static {
		PIPELINE_STATUS_MAP.put("Frozen", "LOCK");
		PIPELINE_STATUS_MAP.put("Approved", "APPROVED");
		PIPELINE_STATUS_MAP.put("Saved", null);
		PIPELINE_STATUS_MAP.put("Draft", null);
	}

	private static final Map<String,String> BACKLOG_STATUS_MAP = new HashMap<String,String>();
	static {
		BACKLOG_STATUS_MAP.put("Apply", "APPLY");
		BACKLOG_STATUS_MAP.put("Modify", "APPLY");
		BACKLOG_STATUS_MAP.put("Approved", "APPROVED");
		BACKLOG_STATUS_MAP.put("Modified", "APPROVED");
		BACKLOG_STATUS_MAP.put("Disapproved", "REJECT");
		BACKLOG_STATUS_MAP.put("Draft", null);
	}

	private static final Map<String,String> PIPELINE_STATE_MAP = new HashMap<String,String>();
	static {
		PIPELINE_STATE_MAP.put("Apply", "APPLY");
		PIPELINE_STATE_MAP.put("Approved", "APPLY");
		PIPELINE_STATE_MAP.put("Disapproved", "APPLY");
	}

	private static final Map<String,String> BACKLOG_STATE_MAP = new HashMap<String,String>();
	static {
		BACKLOG_STATE_MAP.put("Apply", "APPLY");
		BACKLOG_STATE_MAP.put("Modify", "APPLY");
		BACKLOG_STATE_MAP.put("Approved", "APPLY");
		BACKLOG_STATE_MAP.put("Modified", "APPLY");
		BACKLOG_STATE_MAP.put("Disapproved", "APPLY");
		BACKLOG_STATE_MAP.put("Draft", null);
	}

	private static final String MODULE_TCS = "TCS";
	private static final String MODULE_PBT = "PBT";

	private static final String LOOKUP_CODE_TYPE_ROLE = "ROLE";
	private static final Map<String,String> LOOKUP_CODE_TYPE_PERMS = new HashMap<String,String>();
	static {
		LOOKUP_CODE_TYPE_PERMS.put("SystemAdmin", "DATA_PERMS_SYS");
		LOOKUP_CODE_TYPE_PERMS.put("CpnyAdmin", "DATA_PERMS_CPNY");
		LOOKUP_CODE_TYPE_PERMS.put("DepMgr", "DATA_PERMS_DEPT");
		LOOKUP_CODE_TYPE_PERMS.put("DepAst", "DATA_PERMS_DEPT");
	}
	
	private static SourceDAOImpl dao1;
	private static TargetDAOImpl dao2;
	static {
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		dao1 = (SourceDAOImpl) context.getBean("sourceDAO");
		dao2 = (TargetDAOImpl) context.getBean("targetDAO");
	}
	
	private JsonConfig cfg = new JsonConfig();

	public void startTransfer() {
		
		logger.info("startTransfer .. start");
		cfg.setExcludes(new String[]{"handler","hibernateLazyInitializer"});

		// Pipeline
		logger.info("SOURCE-Pipeline: begin");
		List<PipeLineVO> pipelines = dao1.selectPipeLines();
		for (PipeLineVO pipeline : pipelines) {
			try {
				if (StringUtils.isEmpty(pipeline.getOin())) {
					logger.error("SOURCE-Pipeline: ERROR: oin is empty");
					continue;
				}
				logger.info("SOURCE-Pipeline: " + pipeline.getOin() + "," + pipeline.getStatus());
//				logger.info(pipeline);
				PBTVO pbt = buildPBTVO(pipeline, STAGE_PIPELINE);
				PBTVersionVO version = buildPBTVersionVO(pbt, pipeline);
				
				if (pbt.getDetails().isEmpty()) {
					logger.error("SOURCE-Pipeline: ERROR: detail is empty " + pipeline.getOin() + "," + pipeline.getStatus());
					continue;
				}
				
				dao2.insertPBT(pbt);
				dao2.insertPBTVersion(version);
				dao2.insertPBTDetails(pbt.getDetails());
			} catch (Exception e) {
				logger.error("SOURCE-Pipeline: ERROR " + pipeline.getOin() + "," + pipeline.getStatus(), e);
				continue;
			}
		}
		dao2.updatePBTComputingFields(STAGE_PIPELINE);
		logger.info("SOURCE-Pipeline: end");

		// Backlog
		logger.info("SOURCE-Backlog: begin");
		List<BacklogVO> backlogs = dao1.selectBacklogs();
		for (BacklogVO backlog : backlogs) {
			try {
				if (StringUtils.isEmpty(backlog.getOin())) {
					logger.error("SOURCE-Backlog: ERROR: oin is empty");
					continue;
				}
				if (StringUtils.isEmpty(backlog.getVersion())) {
					logger.error("SOURCE-Backlog: ERROR: version is empty " + backlog.getOin() + "," + backlog.getVersion());
					continue;
				}
				logger.info("SOURCE-Backlog: " + backlog.getOin() + "," + backlog.getVersion());
//				logger.info(backlog);
				PBTVO pbt = buildPBTVO(backlog, STAGE_BACKLOG);
				PBTVersionVO version = buildPBTVersionVO(pbt, backlog);
				
				if (pbt.getDetails().isEmpty()) {
					logger.error("SOURCE-Backlog: ERROR: detail is empty " + backlog.getOin() + "," + backlog.getVersion());
					continue;
				}
				
				dao2.insertPBT(pbt);
				dao2.insertPBTVersion(version);
				dao2.insertPBTDetails(pbt.getDetails());
			} catch (Exception e) {
				logger.error("SOURCE-Backlog: ERROR " + backlog.getOin() + "," + backlog.getVersion(), e);
				continue;
			}
		}
		dao2.updatePBTComputingFields(STAGE_BACKLOG);
		logger.info("SOURCE-Backlog: end");
		
		logger.info("SOURCE-DraftBacklog: begin");
		List<BacklogVO> draftbacklogs = dao1.selectDraftBacklogs();
		for (BacklogVO backlog : draftbacklogs) {
			try {
				if (StringUtils.isEmpty(backlog.getOin())) {
					logger.error("SOURCE-DraftBacklog: ERROR: oin is empty");
					continue;
				}
				if (StringUtils.isEmpty(backlog.getVersion())) {
					logger.error("SOURCE-DraftBacklog: ERROR: version is empty " + backlog.getOin() + "," + backlog.getVersion());
					continue;
				}
				logger.info("SOURCE-DraftBacklog: " + backlog.getOin() + "," + backlog.getVersion());
//				logger.info(backlog);
				PBTVO pbt = buildPBTVO(backlog, STAGE_BACKLOG);
				PBTVersionVO version = buildPBTVersionVO(pbt, backlog);
				
				if (pbt.getDetails().isEmpty()) {
					logger.error("SOURCE-DraftBacklog: ERROR: detail is empty " + backlog.getOin() + "," + backlog.getVersion());
					continue;
				}
				
				dao2.insertPBT(pbt);
				dao2.insertPBTVersion(version);
				dao2.insertPBTDetails(pbt.getDetails());
			} catch (Exception e) {
				logger.error("SOURCE-DraftBacklog: ERROR " + backlog.getOin() + "," + backlog.getVersion(), e);
				continue;
			}
		}
		dao2.updatePBTComputingFields(STAGE_BACKLOG);
		logger.info("SOURCE-DraftBacklog: end");
		
		// Internal
		logger.info("SOURCE-Internal: begin");
		List<BacklogVO> internals = dao1.selectInternals();
		for (BacklogVO internal : internals) {
			try {
				if (StringUtils.isEmpty(internal.getOin())) {
					logger.error("SOURCE-Internal: ERROR: oin is empty");
					continue;
				}
				if (StringUtils.isEmpty(internal.getVersion())) {
					logger.error("SOURCE-Internal: ERROR: version is empty " + internal.getOin() + "," + internal.getVersion());
					continue;
				}
				logger.info("SOURCE-Internal: " + internal.getOin() + "," + internal.getVersion());
//				logger.info(internal);
				PBTVO pbt = buildPBTVO(internal, STAGE_INTERNAL);
				PBTVersionVO version = buildPBTVersionVO(pbt, internal);
				
				if (pbt.getDetails().isEmpty()) {
					logger.error("SOURCE-Internal: ERROR: detail is empty " + internal.getOin() + "," + internal.getVersion());
					continue;
				}

				dao2.insertPBT(pbt);
				dao2.insertPBTVersion(version);
				dao2.insertPBTDetails(pbt.getDetails());
			} catch (Exception e) {
				logger.error("SOURCE-Internal: ERROR " + internal.getOin() + "," + internal.getVersion(), e);
				continue;
			}
		}
		dao2.updatePBTComputingFields(STAGE_INTERNAL);
		logger.info("SOURCE-Internal: end");
		
		logger.info("SOURCE-PermissionSet: begin");
		List<LookupCodeVO> permissions = new ArrayList<LookupCodeVO>();
		List<PermissionSetVO> perms = dao1.selectPermissionSets();
		for (PermissionSetVO perm: perms) {
			LookupCodeVO permission = new LookupCodeVO();
			permission.setModule(MODULE_PBT);
			permission.setType(LOOKUP_CODE_TYPE_PERMS.get(perm.getPermissionId()));
			permission.setCode(perm.getEmpId());
			permission.setValue(StringUtils.isEmpty(perm.getValue())? null: perm.getValue());
			permission.setMemo(perm.getEmpName());
			permissions.add(permission);
		}
		dao2.insertLookupCodes(permissions);
		logger.info("SOURCE-PermissionSet: end");
	
		logger.info("SOURCE-Role: begin");
		List<LookupCodeVO> roles = new ArrayList<LookupCodeVO>();
		List<RoleVO> rs = dao1.selectRoles();
		int i = 1;
		for (RoleVO r: rs) {
			LookupCodeVO role = new LookupCodeVO();
			role.setModule(MODULE_TCS);
			role.setType(LOOKUP_CODE_TYPE_ROLE);
			role.setCode(r.getRoleId());
			role.setDisplayOrder(i++);
			role.setLabel(r.getRoleName());
			roles.add(role);
		}
		dao2.insertLookupCodes(roles);
		logger.info("SOURCE-Role: end");

		logger.info("SOURCE-Opportunities: begin");
		List<OpportunityVO> opps = dao1.selectInternalOpportunities();
		for (OpportunityVO opp: opps) {
			InternalVO vo = new InternalVO();
			vo.setFormId(opp.getFormId());
			vo.setFormType(opp.getFormType());
			vo.setProjectId(opp.getOin());
			vo.setProjectName(opp.getName());
			vo.setInitiatorDeptFinCode(opp.getAssignedDeptCode());
			vo.setInitiatorUserId(opp.getAssignedEmployeeId());
			vo.setPmDeptFinCode(opp.getPmDeptCode());
			vo.setPmUserId(opp.getPmEmployeeId());
			vo.setCompanyCode(opp.getCompanyGroupId());
			vo.setModifyDate(opp.getDateModified());
			
			dao2.insertInternalOpportunity(vo);
		}
		logger.info("SOURCE-Opportunities: end");

		logger.info("startTransfer .. finished");
		
	}
	
	private PBTVO buildPBTVO(PipeLineVO pipeline, String stage) {
		
		String version = STATUS_DRAFT.equals(pipeline.getStatus())? VERSION_DRAFT: VERSION_PIPELINE;
		PBTVO vo = new PBTVO();
		vo.setProjectId(pipeline.getOin());
		vo.setStage(stage);
		vo.setVersion(version);
		vo.setStartDate(null);
		vo.setEndDate(null);
		vo.setTotalCost(-1d); // TODO: temporary
		vo.setTotalManday(-1d); // TODO: temporary
		vo.setCreateUser(pipeline.getCreator());
		vo.setCreateDate(pipeline.getCreateDate());
		vo.setModifyUser(pipeline.getCreator());
		vo.setModifyDate(pipeline.getCreateDate());

		List<PBTDetailVO> list = new ArrayList<PBTDetailVO>();
		int idx = 0;
		for (PipeLineDetailVO detail: pipeline.getDetails()) {
			if (StringUtils.isEmpty(detail.getOu())) continue;
			PBTDetailVO d = new PBTDetailVO();
			d.setProjectId(vo.getProjectId());
			d.setVersion(vo.getVersion());
			d.setStage(vo.getStage());
			d.setDeptId(detail.getOu());
			d.setUserId("-");
			d.setRole(detail.getRoleId());
			d.setGrade(detail.getJobLevel());
			d.setCostRate(detail.getManDayCost());
			d.setHeadCount(detail.getHeadCount());
			d.setState(PIPELINE_STATE_MAP.get(detail.getConfirmType()));
			logger.debug(detail.getConfirmType() + " >> " + d.getState() + " " + pipeline.getOin());
			d.setCreateUser(vo.getCreateUser());
			d.setCreateDate(vo.getCreateDate());
			d.setModifyUser(vo.getModifyUser());
			d.setModifyDate(vo.getModifyDate());
			d.setId(d.getProjectId() + d.getStage() + d.getVersion() + String.format("%04d", ++idx));

			d.setMandayDetails(null);
			d.setManday(detail.getManDay());

			list.add(d);
		}
		vo.setDetails(list);
		return vo;
	}

	private PBTVO buildPBTVO(BacklogVO backlog, String stage) {
		
		Calendar c1 = Calendar.getInstance();
		c1.setTime(backlog.getStartDate());
		Calendar c2 = Calendar.getInstance();
		c2.setTime(backlog.getEndDate());
		int diffMonth = (c2.get(Calendar.YEAR) - c1.get(Calendar.YEAR)) * 12 + c2.get(Calendar.MONTH) - c1.get(Calendar.MONTH) + 1;
		logger.info("diffMonth:" + diffMonth);
		
		PBTVO vo = new PBTVO();
		vo.setProjectId(backlog.getOin());
		vo.setStage(stage);
		vo.setVersion(backlog.getVersion());
		vo.setStartDate(backlog.getStartDate());
		vo.setEndDate(backlog.getEndDate());
		vo.setTotalCost(-1d); // TODO: temporary
		vo.setTotalManday(-1d); // TODO: temporary
		vo.setCreateUser(backlog.getCreator());
		vo.setCreateDate(backlog.getModifyDate());
		vo.setModifyUser(backlog.getCreator());
		vo.setModifyDate(backlog.getModifyDate());

		List<PBTDetailVO> list = new ArrayList<PBTDetailVO>();
		int idx = 0;
		for (BacklogDetailVO detail: backlog.getDetails()) {
			if (StringUtils.isEmpty(detail.getOu())) continue;
			PBTDetailVO d = new PBTDetailVO();
			d.setProjectId(vo.getProjectId());
			d.setVersion(vo.getVersion());
			d.setStage(vo.getStage());
			d.setDeptId(detail.getOu());
			d.setUserId(detail.getEmpId().startsWith(detail.getOu())? "-": detail.getEmpId());
			d.setRole(detail.getRoleId());
			d.setGrade(detail.getJobLevel());
			d.setCostRate(detail.getManDayCost());
			d.setHeadCount(1);
			d.setState(BACKLOG_STATE_MAP.get(detail.getConfirmType())); //TODO: set state
			logger.debug(detail.getConfirmType() + " >> " + d.getState() + " " + backlog.getOin() + " " + backlog.getVersion());
			d.setCreateUser(vo.getCreateUser());
			d.setCreateDate(vo.getCreateDate());
			d.setModifyUser(vo.getModifyUser());
			d.setModifyDate(vo.getModifyDate());
			d.setId(d.getProjectId() + d.getStage() + d.getVersion() + String.format("%04d", ++idx));
			
			List<Double> days = detail.getDays();
//			logger.info("days size:" + days.size());
			int daysIdx = 0;
			double manday = 0d;
			Map<String,Double> mandayDetails = new HashMap<String,Double>();
			for (int m = 0; m < diffMonth; m++) {
//				logger.info("diffMonth:" + diffMonth + " m:" + m + " daysIdx:" + daysIdx);
				String dateStr = DateFormatUtils.format(DateUtils.addMonths(c1.getTime(), m), "yyyyMM");
				double day = days.get(daysIdx).doubleValue();
				double sumDay = 0d;
				manday += day;
				if (mandayDetails.containsKey(dateStr))
					sumDay = mandayDetails.get(dateStr);
				sumDay += day;
				mandayDetails.put(dateStr, sumDay);
				
				if (daysIdx == days.size() - 1) break;
				if ((m == diffMonth - 1) && (daysIdx + 1) % days.size() == 0)
					m = -1;
				
				daysIdx++;
			}
			
			JSONObject json = JSONObject.fromObject(mandayDetails, cfg);
			d.setMandayDetails(json.toString());
			d.setManday(manday);
			
			list.add(d);
		}
		vo.setDetails(list);
		return vo;
	}

	private PBTVersionVO buildPBTVersionVO(PBTVO pbt, PipeLineVO pipeline) {
		
		PBTVersionVO vo = new PBTVersionVO();
		vo.setProjectId(pbt.getProjectId());
		vo.setStage(pbt.getStage());
		vo.setVersion(pbt.getVersion());
		vo.setStatus(PIPELINE_STATUS_MAP.get(pipeline.getStatus()));
		logger.debug(pipeline.getStatus() + " > " + vo.getStatus() + " " + pipeline.getOin());
		vo.setFormId(null); // TODO: set FormId (Pipeline)
		vo.setCreateUser(pbt.getCreateUser());
		vo.setCreateDate(pbt.getCreateDate());
		vo.setModifyUser(pipeline.getModifier());
		vo.setModifyDate((pipeline.getModifyDate() == null? pbt.getCreateDate(): pipeline.getModifyDate()));
		return vo;
	}

	private PBTVersionVO buildPBTVersionVO(PBTVO pbt, BacklogVO backlog) {
		
		PBTVersionVO vo = new PBTVersionVO();
		vo.setProjectId(pbt.getProjectId());
		vo.setStage(pbt.getStage());
		vo.setVersion(pbt.getVersion());
		vo.setDescription(backlog.getDescription());
		vo.setStatus(BACKLOG_STATUS_MAP.get(backlog.getStatus()));
		logger.debug(backlog.getStatus() + " > " + vo.getStatus() + " " + backlog.getOin() + " " + backlog.getVersion());
		
		vo.setFormId(backlog.getFormId()); // TODO: set FormId (Backlog)
		if (STAGE_INTERNAL.equals(pbt.getStage()) && vo.getStatus() == null) {
			vo.setFormId(null);
		}
		 
		vo.setCreateUser(pbt.getCreateUser());
		vo.setCreateDate(pbt.getCreateDate());
		vo.setModifyUser(pbt.getModifyUser());
		vo.setModifyDate((backlog.getConfirmDate() == null? pbt.getCreateDate(): backlog.getConfirmDate()));
		return vo;
	}
	
	public static void main(String[] args) {
		DataTrans trans = new DataTrans();
		trans.startTransfer();
	}

}