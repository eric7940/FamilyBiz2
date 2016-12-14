package com.systex.emp.manager.service.impl;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.http.client.utils.DateUtils;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.tools.generic.DateTool;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.systex.emp.base.dao.rdbms.RowBounds;
import com.systex.emp.manager.exception.EmpManagerException;
import com.systex.emp.manager.service.CommonService;
import com.systex.emp.manager.service.SoService;
import com.systex.emp.manager.util.ConstUtil;
import com.systex.emp.manager.vo.DeptVO;
import com.systex.emp.manager.vo.LookupCodeVO;
import com.systex.emp.manager.vo.PBTDetailVO;
import com.systex.emp.manager.vo.PBTNotifyVO;
import com.systex.emp.manager.vo.PBTVO;
import com.systex.emp.manager.vo.PBTVersionComparsionVO;
import com.systex.emp.manager.vo.PBTVersionVO;
import com.systex.emp.manager.vo.UserVO;

public class SoServiceImpl extends ServiceImpl implements SoService {



}