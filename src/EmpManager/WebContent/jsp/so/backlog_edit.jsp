<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	

<s:url action="main" namespace="/" var="mainURL"><s:param name="t">${form.activeTab}</s:param></s:url>
<s:url action="main" namespace="/" method="view" var="viewURL"><s:param name="t">${form.activeTab}</s:param><s:param name="id">${form.bean.projectId}</s:param></s:url>

<s:form method="post" namespace="/" action="main" theme="simple" cssClass="navbar-form">
<input type="hidden" name="t" value="${form.activeTab}" />
<input type="hidden" name="desc"/>
<input type="hidden" name="notify"/>

	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-sm-12 col-md-6 col-lg-5">
				<a href="<s:property value="#mainURL" />" role="button" class="btn btn-primary"><s:text name="global.action.cancel" /></a>
				<button type="button" class="btn btn-success draft" onclick="savePBT(event, true);"><s:text name="global.action.draft.save"/></button>
				<input type="button" class="btn btn-success save" value='<s:text name="global.action.save"/>' data-toggle="modal" data-target="#checkinModal" />
				<c:if test="${attr.modify == 'y'}"><input type="button" class="btn btn-warning revision" value='<s:text name="pbt.action.revision"/>' data-toggle="modal" data-target="#revisionModal" /></c:if>
				<c:if test="${attr.modify == 'y'}"><span class="hidden-sm-x hidden-xs"><a href="<s:property value="#viewURL" escapeHtml="false" />" role="button" class="btn btn-primary"><s:text name="global.action.back" /></a></span></c:if>
			</div>
			<div class="col-sm-8 col-md-6 col-lg-5">
				<s:text name="pbt.message.monthly"/>:
				<input type="text" name="period_start" class="form-control DateText period_start" size="10"/>
				～
				<input type="text" name="period_end" class="form-control DateText period_end" size="10"/>
				<input type="button" class="btn btn-success period" value="<s:text name="global.action.modify" />" />
			</div>
			<div class="col-xs-12 col-sm-4 col-md-12 col-lg-2 text-right text-nowrap">
				<h4 id="total"><s:text name="global.message.sum"/>: $<fmt:formatNumber groupingUsed="true" maxFractionDigits="0" value="${form.bean.totalCost}" /></h4>
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="row" style="margin-top:10px;"><div class="col-sm-12">
		<div class="div-result">
		<table id="queryResult1" class="table table-striped table-hover table-break-all table-list break-table">
			<thead>
				<tr>
					<th><s:text name="pbt.field.oin"/></th>
					<th><s:text name="pbt.field.name"/></th>
					<th><s:text name="pbt.field.pmDept"/></th>
					<th><s:text name="pbt.field.pmUser"/></th>
					<th><s:text name="pbt.field.salesDept"/></th>
					<th><s:text name="pbt.field.salesUser"/></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td data-title="<s:text name="pbt.field.oin"/>"><c:out value="${form.bean.projectId}"/></td>
					<td data-title="<s:text name="pbt.field.name"/>"><c:out value="${form.bean.name}"/></td>
					<td data-title="<s:text name="pbt.field.pmDept"/>"><c:out value="${form.bean.pmDeptFinCode}"/>-<c:out value="${form.bean.pmDeptName}"/></td>
					<td data-title="<s:text name="pbt.field.pmUser"/>"><c:out value="${form.bean.pmUserId}"/>-<c:out value="${form.bean.pmUserName}"/></td>
					<td data-title="<s:text name="pbt.field.salesDept"/>"><c:out value="${form.bean.salesDeptFinCode}"/>-<c:out value="${form.bean.salesDeptName}"/></td>
					<td data-title="<s:text name="pbt.field.salesUser"/>"><c:out value="${form.bean.salesUserId}"/>-<c:out value="${form.bean.salesUserName}"/></td>
				</tr>
			</tbody>
		</table>
		</div>

		<div class="row" style="margin-top:20px;">
			<div class="col-xs-6"><h4><s:text name="pbt.field.pbt.dept"/></h4></div>
			<div class="col-xs-6 text-right"><button title="" type="button" class="btn btn-success add show_tip" disabled="disabled" data-original-title='<s:text name="global.action.add"/>'><i class="fa fa-plus-square"></i></button></div>
		</div>
		<div class="div-result" style="overflow-x: auto;">
		<table id="queryResult2" class="table table-striped table-hover table-break-all table-list break-table table-condensed" style="table-layout: fixed;">
			<thead>
				<tr>
					<th style="width:70px;" rowspan="2"><s:text name="pbt.field.pbt.num"/></th>
					<th style="width:250px;" rowspan="2"><s:text name="pbt.field.pbt.dept"/></th>
					<th style="width:157px;" rowspan="2"><s:text name="pbt.field.pbt.user"/></th>
					<th style="width:104px;" rowspan="2"><s:text name="pbt.field.pbt.role"/></th>
					<th style="width:70px;" rowspan="2"><s:text name="pbt.field.pbt.grade"/></th>
					<th style="width:87px;" rowspan="2"><s:text name="pbt.field.pbt.costrate"/></th>
					<th style="width:120px;" rowspan="2"><s:text name="pbt.field.pbt.manday"/></th>
					<th style="width:97px;" rowspan="2"><s:text name="pbt.field.pbt.cost"/></th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		</div>
		</div></div>
	</div>
	<!-- /content -->
</s:form>
</div>

<div class="modal fade" id="revisionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="exampleModalLabel"><s:text name="pbt.modal.revision.title"/></h4>
      </div>
      <div class="modal-body">
        <s:form method="post" namespace="/" action="main!initModify" theme="simple" role="form">
        <input type="hidden" name="t" value="${form.activeTab}">
        <s:hidden name="form.bean.projectId" />
		<table id="queryResult3" class="table table-striped table-hover table-break-all table-list break-table table-condensed small">
			<thead>
				<tr>
					<th></th>
					<th><s:text name="pbt.modal.revision.field.version"/></th>
					<th><s:text name="pbt.modal.revision.field.desc"/></th>
					<th><s:text name="pbt.modal.revision.field.state"/></th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		</s:form>

		<div style="overflow: auto;">
		<table id="queryResult4" class="table table-striped table-hover table-break-all table-list break-table table-condensed small" style="table-layout: fixed;">
		</table>
		</div>
		<div class="text-center diff_rev">
			<ul class="list-inline">
				<li class="text-success diff_rev1"></li><li class="diff_rev_splitor"></li><li class="text-danger diff_rev2"></li>
			</ul>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><s:text name="global.action.close"/></button>
        <button type="button" class="btn btn-primary diff"><s:text name="pbt.action.diff"/></button>
        <button type="button" class="btn btn-primary import"><s:text name="pbt.action.import"/></button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="checkinModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="exampleModalLabel"><s:text name="pbt.modal.checkin.title"/></h4>
      </div>
      <div class="modal-body">
        <form role="form">
        <div class="checkbox">
          <label>
            <input type="checkbox" class="checkin_notify" value="y"> <s:text name="pbt.message.notify"/>
          </label>
        </div>
		<table id="queryResult5" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
			<thead>
				<tr>
					<th><s:text name="pbt.modal.revision.field.version"/></th>
					<th><s:text name="pbt.modal.revision.field.desc"/></th>
					<th><s:text name="pbt.modal.revision.field.state"/></th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		</form>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary checkin"><s:text name="global.action.submit"/></button>
        <button type="button" class="btn btn-default" data-dismiss="modal"><s:text name="global.action.cancel"/></button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="assistModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="exampleModalLabel"><s:text name="pbt.modal.assist.title"/></h4>
      </div>
      <div class="modal-body">
      	<p>No. <span class="assist_idx"></span>：<span class="assist_title"></span></p>
        <form class="form-inline">
        <div>
          <table id="queryResult6" class="table table-striped">
            <tbody>
              <tr>
                <td><input type="radio" name="assist" value="option1" class="form-control"></td>
                <td><s:text name="pbt.modal.assist.option.1.monthly"/> <input name="assist_days" type="text" class="form-control assist_days NumDecText" size="2"/> <s:text name="pbt.modal.assist.option.1.manday"/>
                </td>
              </tr>
              <tr>
                <td><input type="radio" name="assist" value="option2" class="form-control"></td>
                <td>
                  <s:text name="pbt.modal.assist.option.2.direct"/> <select name="assist_shift" class="form-control assist_shift"><option value="f"><s:text name="pbt.modal.assist.option.2.forward"/></option><option value="b" selected><s:text name="pbt.modal.assist.option.2.backward"/></option></select>
                  <s:text name="pbt.modal.assist.option.2.shift"/> <input name="assist_shift_num" type="text" class="form-control assist_shift_num NumText" size="2" maxlength="2"/> <s:text name="pbt.modal.assist.option.2.months"/>
                </td>
              </tr>
              <tr>
                <td><input type="radio" name="assist" value="option3" class="form-control"></td>
                <td><s:text name="pbt.modal.assist.option.3.copy"/> <input name="assist_copy_num" type="text" value="" class="form-control assist_copy_num NumText" size="2" maxlength="2"/> <s:text name="pbt.modal.assist.option.3.nth"/></td>
              </tr>
              <tr>
                <td><input type="radio" name="assist" value="option4" class="form-control"></td>
                <td><p class="form-control-static"><s:text name="pbt.modal.assist.option.4.clear"/></p></td>
              </tr>
              <tr><td colspan="2"/></tr>
            </tbody>
          </table>
        </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary assist"><s:text name="global.action.submit"/></button>
        <button type="button" class="btn btn-default" data-dismiss="modal"><s:text name="global.action.cancel"/></button>
      </div>
    </div>
  </div>
</div>

<script type='text/javascript'>

var user_tobe_define = '<s:text name="pbt.message.user.undefined"/>';
String.prototype.format = function() {
	var str = this;
	for (var i = 0; i < arguments.length; i++) {       
		var reg = new RegExp("\\{" + i + "\\}", "gm");             
		str = str.replace(reg, arguments[i]);
	}
	return str;
}

function savePBT(event, is_draft) {
	var count = 0;
	var error = false;
	var deptIds = '';
	var userIds = '';
	$('table#queryResult2 tbody tr').each(function(i,e) {
		if ($(this).find('.dept_deptId').val() == '') return; // 等於continue
		deptIds += ',' + $(this).find('.dept_deptId').val();
		userIds += ',' + $(this).find('.dept_userId').val();
		var num = $(this).find('.dept_num').text();
		if ($(this).find('.dept_role').val() == '') {
			alert('No.' + num + ': ' + '<s:text name="pbt.error.required.role"/>');
			$(this).find('.dept_role').focus();
			error = true;
			return false; // 等於break
		}
		
		var sumDays = 0;
		$(this).find('.dept_days').each(function () {
			var days = parseFloat($(this).val());
			if (isNaN(days)) days = 0;
			if ($(this).val().length > 0)
				$(this).val(days);
			sumDays += days;
		});
		$(this).find('.dept_manday').text(formatFloat(sumDays));
		
		var manday = parseFloat($(this).find('.dept_manday').text());
		if (isNaN(manday) || manday <= 0) {
			alert('No.' + num + ': ' + '<s:text name="pbt.error.required.days"/>');
			$(this).find('.dept_days:eq(0)').focus();
			error = true;
			return false; // 等於break
		}
		count++;
	});
	if (error) {
		return;
	}
	
	if (count <= 0) {
		alert('<s:text name="pbt.error.required.dept"/>');
		$('table#queryResult2 tbody tr:first').find('.dept_dept').focus();
		return;
	}
	
	var statusChange = false;
	$.ajax({
		type: 'POST',
		url: '<s:url action="main" namespace="/" method="checkDeptStatus"/>',
		data: {list: deptIds.substring(1)},
		success: function(result) {
			if (result["errCde"] == '00') {
				$('.dept_dept').css('color','');
				var invalid = result["invalid"];
				if (invalid.length > 0) {
					$.each(invalid.split(','), function(i, e) {
						$('.dept_deptId[value=' + e + ']').closest('tr').find('.dept_dept').css('color','#b94a48');
					});
					statusChange = true;
				}
			} else {
				alert(result["errMsg"]);
			}
		},
		dataType: 'json',
		async:false
	});

	$.ajax({
		type: 'POST',
		url: '<s:url action="main" namespace="/" method="checkUserStatus"/>',
		data: {list1: userIds.substring(1), list2: deptIds.substring(1)},
		success: function(result) {
			if (result["errCde"] == '00') {
				$('.dept_user').css('color','');
				var invalid = result["invalid"];
				if (invalid.length > 0) {
					$.each(invalid.split(','), function(i, e) {
						$('.dept_userId[value=' + e + ']').closest('tr').find('.dept_user').css('color','#b94a48');
					});
					statusChange = true;
				}
			} else {
				alert(result["errMsg"]);
			} 
		},
		dataType: 'json',
		async:false
	});

	if (statusChange === true) {
		alert('<s:text name="pbt.error.details.status_change"/>');
		return;
	}
	
	$('.period_start').removeAttr('disabled');
	$('.period_end').removeAttr('disabled');
	
	var method = (is_draft? 'draft': 'add');
	if (modify === 'y') method = (is_draft? 'draftModify': 'modify');
	
	var oForm = getSelfForm(event, method);	
	oForm.submit();
}

function formatFloat(f) {
	return (f == undefined)? '': parseFloat(parseFloat(f).toFixed(2));	
}

function formatInt(i) {
	return parseInt(i, 10);
}

function escapeHTML(text) {
	return $("<div>").text(text).html();	
}

function removeComma(selector) {
	return selector.text().replace(/,/g, '');
}

function numberWithCommas(number) {
	return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function paddingLeft(s, c, n) {
	s = s.toString();
	if (! s || ! c || s.length >= n) {
		return s;
	}
	var max = (n - s.length)/c.length;
	for (var i = 0; i < max; i++) {
		s = c + s;
	}
	return s;
}

function highlightDiff(d1, d2, compareDays) {
	if (compareDays == undefined) compareDays = false;
	if (compareDays) {
		return ((d1 != '' && d1 != '0' || d2 != '' && d2 != '0') && (d1 !== d2))? 'class="diff_highlight"': '';
	} else {
		return (d1 !== d2)? 'class="diff_highlight"': '';
	}
}

//[連動]
//刪除：總計
//部門：姓名
//角色／職等：每人天成本
//每月預估人天：總預估工時
//每人天成本／總預估工時：總成本／總計
function sumTotalCost() {
	var total = 0;
	$('table#queryResult2 tr').each(function() {
		if( $(this).find(".dept_cost").length ) {
			total += parseInt(removeComma($(this).find(".dept_cost")), 10);
		}
	});
	return total;
}

function setDatePeriod(start, end) {
	var period_start = $(start).val();
	var period_end = $(end).val();
	if (new Date(period_start) > new Date(period_end)) {
		var tmp = period_start;
		$(start).val(period_end);
		$(end).val(tmp);
	}
}

var years = {};
var months = new Array();
function setDeptDaysColumns() {
	years = {};
	months = new Array();
	var date1 = new Date($('.period_start').val());
	var date2 = new Date($('.period_end').val());
	var diff_months = parseInt((date2.getFullYear() * 12 + date2.getMonth()) - (date1.getFullYear() * 12 + date1.getMonth()), 10);
	var m = date1.getMonth() + 1;
	var y = date1.getFullYear();
	$.each(new Array(diff_months + 1), function(n){
		if (m > 12) {
			y++;
			m = 1;
		}
		years[y] = (y in years)? years[y] + 1: 1;
		months.push(y + '/' + (m < 10? '0': '') + m);
		m++;
	});
	var mon = '<tr>';
	$.each(months, function(i,m) {
		mon += '<th class="text-center">' + m.slice(-2) + '</th>'; 
	});
	mon += '</tr>';
	
	$('table#queryResult2 thead tr:nth-child(1)').find('th:gt(7)').remove();
	$('table#queryResult2 thead tr:nth-child(2)').remove();
	
	$.each(years, function(y,colspan) {
		$('table#queryResult2 thead tr:first').find('th:last').after('<th style="width:' + (colspan * 65) + 'px;" colspan="' + colspan + '" class="text-center">' + y + '</th>');
	});
	$('table#queryResult2 thead').append(mon);
}

function resetDeptNum() {
	$('table#queryResult2 tbody tr').each(function(i,e) {
		$(this).find('.dept_num').text((i + 1));
	});
}

function addDeptRow() {
	var len = $('table#queryResult2 tbody tr').length;
	var row = '<tr class="text-right">' + 
			'<td data-title="<s:text name="pbt.field.pbt.num"/>" class="text-left"><span class="form-control-static dept_num">' + (len + 1) + '</span> <button title="" type="button" class="btn btn-danger remove show_tip" data-original-title="<s:text name="global.action.remove"/>"><i class="fa fa-trash-o"></i></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.dept"/>"><input name="deptId" type="hidden" class="dept_deptId"/><input name="dept" type="text" class="form-control form-control-fullwidth dept_dept" /></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.user"/>"><input name="userId" type="hidden" class="dept_userId"/><select name="user" class="form-control form-control-fullwidth dept_user"></select></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.role"/>">' + 
			'	<select name="role" class="form-control form-control-fullwidth dept_role">' + 
			'		<option value=""></option>' + 
			'	</select>' + 
			'</td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.grade"/>"><select name="grade" class="form-control form-control-fullwidth dept_grade" disabled="disabled"></select></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.costrate.short"/>"><p class="form-control-static dept_costrate">0</p></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.manday.short"/>"><div class="pull-right" style="padding-left:8px;"><button title="" type="button" class="btn btn-warning wizard show_tip" data-original-title="<s:text name="pbt.message.assistant"/>" data-toggle="modal" data-target="#assistModal" data-dept-idx="' + (len + 1) + '" data-dept-dept="" data-dept-user=""><i class="fa fa-cog"></i></button></div><p class="form-control-static dept_manday">0</p></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.cost.short"/>"><p class="form-control-static dept_cost">0</p></td>';
	$.each(months, function(i,ym) {
		row += '<td data-title="' + ym + '"><input name="days_' + (i + 1) + '" type="text" value="" class="form-control form-control-fullwidth dept_days NumDecText" maxlength="6" style="width:40px;"/></td>'; 
	});
	row += '</tr>';
	$('table#queryResult2 tbody').append(row);

	$.each(data2, function(i,e) { 
		$('table#queryResult2 tbody tr:last').find(".dept_role").append($("<option />", {value: e.roleId, text: e.roleName})); 
	});
	$.each(data3, function(n) {
		$('table#queryResult2 tbody tr:last').find(".dept_grade").append($("<option />", {value: n, text: n}));
	});
}

var modify = '${attr.modify}';
var pipeline_exists = '${attr.pipelinePBTExists}';
var add_from_pipeline = '';
function setDeptRows() {
	var data0 = [
		<s:iterator value="form.bean.details" var="record" status="idx">{deptId:"<c:out value="${record.deptId}"/>",deptName:"<c:out value="${record.deptName}"/>",userId:"<c:out value="${record.userId}"/>",userName:"<c:out value="${record.userName}"/>",
			role:"<c:out value="${record.role}"/>",grade:"<c:out value="${record.grade}"/>",costRate:"<c:out value="${record.costRate}"/>",manday:"<c:out value="${record.manday}"/>",
			days:'<c:out value="${record.mandayDetails}" escapeXml="false"/>'},
		</s:iterator>];

	$.each(data0, function(ii,e) {
		var row = '<tr class="text-right">' + 
				'<td data-title="<s:text name="pbt.field.pbt.num"/>" class="text-left"><span class="form-control-static dept_num">' + (ii + 1) + '</span> <button title="" type="button" class="btn btn-danger remove show_tip" data-original-title="<s:text name="global.action.remove"/>"><i class="fa fa-trash-o"></i></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.dept"/>"><input name="deptId" type="hidden" class="dept_deptId"/><input name="dept" type="text" class="form-control form-control-fullwidth dept_dept" /></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.user"/>"><input name="userId" type="hidden" class="dept_userId"/><select name="user" class="form-control form-control-fullwidth dept_user"></select></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.role"/>">' + 
				'	<select name="role" class="form-control form-control-fullwidth dept_role">' + 
				'		<option value=""></option>' + 
				'	</select>' + 
				'</td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.grade"/>">' +
				((e.userId == '-')? '<select name="grade" class="form-control form-control-fullwidth dept_grade"></select>': '<p class="form-control-static dept_grade_static"></p><input type="hidden" name="grade" class="dept_grade"/>') +
				'</td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.costrate.short"/>"><p class="form-control-static dept_costrate">0</p></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.manday.short"/>"><div class="pull-right" style="padding-left:8px;"><button title="" type="button" class="btn btn-warning wizard show_tip" data-original-title="<s:text name="pbt.message.assistant"/>" data-toggle="modal" data-target="#assistModal" data-dept-idx="' + (ii + 1) + '" data-dept-dept="" data-dept-user=""><i class="fa fa-cog"></i></button></div><p class="form-control-static dept_manday">0</p></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.cost.short"/>"><p class="form-control-static dept_cost">0</p></td>';
		
		$.each(months, function(i,ym) {
			row += '<td data-title="' + ym + '"><input name="days_' + (i + 1) + '" type="text" value="" class="form-control form-control-fullwidth dept_days NumDecText" maxlength="6" style="width:40px;"/></td>'; 
		});
		row += '</tr>';
		$('table#queryResult2 tbody').append(row);
		
		$.each(data2, function(i,e) { 
			$('table#queryResult2 tbody tr:last').find(".dept_role").append($("<option />", {value: e.roleId, text: e.roleName})); 
		});
		if (e.userId == '-') {
			$.each(data3, function(n) {
				$('table#queryResult2 tbody tr:last').find(".dept_grade").append($("<option />", {value: n, text: n}));
			});
		}

		var tr = $('table#queryResult2 tbody tr:last');
		$(tr).find(".dept_deptId").val(e.deptId);
		$(tr).find(".dept_dept").val(e.deptName + '(' + e.deptId + ')');
		$(tr).find(".dept_userId").val(e.userId);
		$(tr).find(".dept_user").append((e.userId == '-')? $("<option />", {value: e.userId, text: user_tobe_define}): $("<option />", {value: e.userId + "," + e.grade + "," + e.costRate, text: e.userName + "(" + e.userId + ")"}));
		$(tr).find(".dept_role").val(e.role);
		$(tr).find(".dept_grade").val(e.grade);
		if (e.userId != '-') {
			$(tr).find(".dept_grade_static").text(e.grade);
		}
		$(tr).find(".dept_costrate").text(numberWithCommas(formatInt(e.costRate)));
		$(tr).find(".dept_manday").text(formatFloat(e.manday));
		$(tr).find('.wizard').attr('data-dept-dept', e.deptName + '(' + e.deptId + ')');
		$(tr).find('.wizard').attr('data-dept-user', (e.userId == '-'? user_tobe_define: e.userName + '(' + e.userId + ')'));

		if (add_from_pipeline === 'y') {
			$(tr).find(".dept_days:first").val(formatFloat(e.manday));
		} else {
			var days = JSON.parse(e.days);
			$(tr).find(".dept_days").each(function() {
				var ym = $(this).closest('td').data('title');
				$(this).val(formatFloat(days[ym.replace('/','')]));
			});
			
		}
	});
}

$(window).load(function(){
$(function () {
	$("table#queryResult2").on("click", ".remove", function () {
		$(this).closest('tr').remove();
		resetDeptNum();
		$('#total').text('<s:text name="global.message.sum"/>: $' + numberWithCommas(sumTotalCost()));
	});
});
$(function () {
	$(".add").on("click", addDeptRow);
	$(".period").on("click", function() {
		setDeptDaysColumns();
		var len = $('table#queryResult2 tbody tr').length;
		if (len > 0) {
			var days = '';
			$.each(months, function(i,ym) {
				days += '<td data-title="' + ym + '"><input name="days_' + (i + 1) + '" type="text" value="" class="form-control form-control-fullwidth dept_days NumDecText" maxlength="6" style="width:40px;"/></td>'; 
			});
			$('table#queryResult2 tbody tr').each(function(i,e) {
				var manday = parseFloat($(this).find('.dept_manday').text());
				$(this).find('td:gt(7)').remove();
				$(this).find('td:last').after(days);
				$(this).find('.dept_days:first').val(manday);
			});
		} else {
			addDeptRow();
		}
		$('.add').removeAttr('disabled');
		$('.save').removeAttr('disabled');
		$('.draft').removeAttr('disabled');
	});
	
	if (pipeline_exists === 'y') {
		add_from_pipeline = (confirm('<s:text name="pbt.message.import.pipeline"><s:param>${form.bean.projectId}</s:param></s:text>')? 'y': '');
	}
	
	if (modify === 'y' || add_from_pipeline === 'y') {
		$(".add").removeAttr('disabled');
		if (add_from_pipeline === 'y') {
			var d = new Date();
			var month = d.getMonth() + 1;
			var day = d.getDate();
			var today = d.getFullYear() + '-' + (month < 10 ? '0' : '') + month + '-01';
			$(".period_start").val(today);
			$(".period_end").val(today);
		} else {
			$(".period_start").val('<fmt:formatDate pattern="yyyy-MM-dd" value="${form.bean.startDate}" />');
			$(".period_end").val('<fmt:formatDate pattern="yyyy-MM-dd" value="${form.bean.endDate}" />');
		}
		setDeptDaysColumns();
		setDeptRows();
		
		var invalid = '${attr.invalid}';
		if (invalid.length > 0) {
			$.each(invalid.split(','), function(i, e) {
				$('.dept_deptId[value=' + e + ']').closest('tr').find('.dept_dept').css('color','#b94a48');
				$('.dept_userId[value=' + e + ']').closest('tr').find('.dept_user').css('color','#b94a48');
			});
			alert('<s:text name="pbt.error.details.status_change"/>');
		}
		
	} else {
		var d = new Date();
		var month = d.getMonth() + 1;
		var day = d.getDate();
		var today = d.getFullYear() + '-' + (month < 10 ? '0' : '') + month + '-01';
		$(".period_start").val(today);
		$(".period_end").val(today);
		$('.draft').attr('disabled','disabled');
		$('.save').attr('disabled','disabled');
	}
});
$(document).on('blur', '.dept_days', function() {
	var sumDays = 0;
	$(this).closest('tr').find('.dept_days').each(function () {
		var days = parseFloat($(this).val());
		if (isNaN(days)) days = 0;
		if ($(this).val().length > 0)
			$(this).val(days);
		sumDays += days;
	});
	$(this).closest('tr').find('.dept_manday').text(formatFloat(sumDays));
});
$(function () {
	$(".show_tip").tooltip({
		container: 'body'
	});
});
$(document).click(function () {
	$('.tooltip').remove();
	$('[title]').tooltip();
});
});

var data1 = [<s:iterator value="form.deptList" var="dept" status="idx">{deptId:"<c:out value="${dept.id}"/>",deptName:"<c:out value="${dept.name}"/>",deptFinCode:"<c:out value="${dept.finCode}"/>"},</s:iterator>];
var data2 = [<s:iterator value="form.roleList" var="role" status="idx">{roleId:"<c:out value="${role.code}"/>",roleName:"<c:out value="${role.label}"/>"},</s:iterator>];
var data3 = new Array(<s:property value="form.maxGrade"/> + 1);

var checkNumDec = function() {
	$(this).val($(this).val().replace(/[^0-9.]/g, ''));
};

$(function () {

$('table#queryResult2').on('keyup', '.NumDecText', checkNumDec);
$('table#queryResult2').on('paste', '.NumDecText', checkNumDec);
$('table#queryResult2').find('.NumDecText').each(function() {
	$(this).css("ime-mode", "disabled");
});

$('.period_start').on('change', function (e) {
	$(this).val($(this).val().replace(/\d{2}$/, "01"));
	setDatePeriod($(this), $('.period_end'));

});
$('.period_end').on('change', function (e) {
	$(this).val($(this).val().replace(/\d{2}$/, "01"));
	setDatePeriod($('.period_start'), $(this));
});

$('table#queryResult2').on('keydown.autocomplete', '.dept_dept', function() {
	$(this).autocomplete({
		minLength: 2,
		source: function(request, response) {
			response($.map(data1, function(v,i){
				if (v.deptFinCode.indexOf(request.term) >= 0 || v.deptName.indexOf(request.term) >= 0) {
					return {
						label: v.deptName + '(' + v.deptId + ')',
						value: v.deptId
					}
				};
			}));
		},
		focus: function( event, ui ) {
			$(this).val( ui.item.label );
			return false;
		},
		select: function( event, ui ) {
			$(this).val( ui.item.label );
			$(this).closest('tr').find('.dept_deptId').val(ui.item.value);
			$(this).closest('tr').find('.wizard').attr('data-dept-dept', ui.item.label);
			$(this).closest('tr').find('.wizard').attr('data-dept-user', user_tobe_define);
			$(this).closest('tr').find('.dept_grade').removeAttr('disabled');
			
			if ($(this).closest('tr').find('.dept_grade').is('select') === false) {
				$(this).closest('tr').find('.dept_grade_static').remove();
				$(this).closest('tr').find('.dept_grade').remove();
				
				var s = $('<select name="grade" class="form-control form-control-fullwidth dept_grade"></select>');
				$.each(data3, function(n){
					$("<option />", {value: n, text: n}).appendTo(s);
				});
				s.appendTo($(this).closest('tr').find('td:nth-child(5)'));
				$(this).closest('tr').find('.dept_costrate').text('0');
			}
			$(this).closest('tr').find('.dept_grade').val('0');
			
			var user = $(this).closest('tr').find('.dept_user');
			var userId = $(this).closest('tr').find('.dept_userId');
			var data2 = null;
			$.post('<s:url action="main" namespace="/" method="getUserList"/>',{d: ui.item.value}, function(result) {
				if (result["errCde"] == '00') {
					data2 = result["users"];
					$(user).empty();
					$(user).append('<option value="-">' + user_tobe_define + '</option>');
					$(data2).each(function(i) { 
						$(user).append("<option value='" + data2[i].id + "," + data2[i].jobLevel + "," + data2[i].costRate + "'>" + data2[i].name + "(" + data2[i].id + ")</option>");
					});
					$(userId).val("-");
				} else {
					alert(result["errMsg"]);
				} 
			}, 'json');

			return false;
		}
	});
});
$('table#queryResult2').on('change', '.dept_user', function() {
	var user = $(this).val();
	$(this).closest('tr').find('.wizard').attr('data-dept-user', $(this).children("option:selected").text());
	if (user == '-') {
		if ($(this).closest('tr').find('.dept_grade').is('select') === false) {
			$(this).closest('tr').find('.dept_grade_static').remove();
			$(this).closest('tr').find('.dept_grade').remove();
			
			var s = $('<select name="grade" class="form-control form-control-fullwidth dept_grade"></select>');
			$.each(data3, function(n){
				$("<option />", {value: n, text: n}).appendTo(s);
			});
			s.appendTo($(this).closest('tr').find('td:nth-child(5)'));  
		}
		$(this).closest('tr').find('.dept_userId').val(user);
		$(this).closest('tr').find('.dept_costrate').text('0');
	} else {
		if ($(this).closest('tr').find('.dept_grade').is('select') === true) {
			$(this).closest('tr').find('.dept_grade').remove();
			$(this).closest('tr').find('td:nth-child(5)').append('<p class="form-control-static dept_grade_static"></p><input type="hidden" name="grade" class="dept_grade"/>');
		}
		var u = user.split(',');
		$(this).closest('tr').find('.dept_userId').val(u[0]);
		$(this).closest('tr').find('.dept_grade_static').text(u[1]);
		$(this).closest('tr').find('.dept_grade').val(u[1]);
		$(this).closest('tr').find('.dept_costrate').text(numberWithCommas(formatInt(u[2])));
	}
});
$('table#queryResult2').on('change', '.dept_grade', function() {
	if ($(this).is('select') === false) return;
	var grade = $(this).val();
	var dept = $(this).closest('tr').find('.dept_deptId').val();
	var cr = $(this).closest('tr').find('.dept_costrate');
	$(cr).text("0");
	if (grade.length > 0) {
		if ($.isNumeric(grade) && grade > 0) {
			$.post('<s:url action="main" namespace="/" method="getCostRate"/>',{dept: dept, grade: grade}, function(result) {
				if (result["errCde"] == '00') {
					$(cr).text(numberWithCommas(formatInt(result["costrate"])));
				} else {
					alert(result["errMsg"]);
				} 
			}, 'json');
		}
	}
});

setInterval(function () {
	var total = 0;
	$("table#queryResult2 tr").each(function () {
		if( $(this).find(".dept_cost").length ) {
			var manday = parseFloat($(this).find('.dept_manday').text());
			var costrate = parseInt(removeComma($(this).find('.dept_costrate')), 10);
			var cost = parseInt(manday * costrate, 10);
			$(this).find('.dept_cost').text(numberWithCommas(cost));
			total += cost;
		}

	});
	$('#total').text('<s:text name="global.message.sum"/>: $' + numberWithCommas(total));
}, 1000);

$("table#queryResult3").on("click", "tr", function (e) {
	if (e.target.type !== 'checkbox') {
		$(':checkbox', this).trigger('click');
	}
});
$('#revisionModal').on('show.bs.modal', function (event) {
	var revision = $('table#queryResult3 tbody');

	var p = '${form.bean.projectId}';
	var t = $('input:hidden[name=t]').val();
	$.post('<s:url action="main" namespace="/" method="getVersionList"/>',{p: p, t: t, filter: '0'}, function(result){
		if (result["errCde"] == '00') {
			var draftVersion = '<s:text name="pbt.modal.revision.draft.version"/>';
			var draftDesc = '<s:text name="pbt.modal.revision.draft"/>';
			var draftState = '';
			
			var versions = result["versions"];
			var maxVersion = 0;
			$(revision).html('');
			$(versions).each(function(i) {
				var isDraft = (versions[i].version == 'draft')? true: false;
				$(revision).prepend('<tr>' + 
					'<td data-title=""><input type="checkbox" name="r" value="' + (isDraft? draftVersion: versions[i].version) + '" class="revision"></td>' + 
					'<td data-title="<s:text name="pbt.modal.revision.field.version"/>">' + (isDraft? draftVersion: versions[i].version) + '</td>' + 
					'<td data-title="<s:text name="pbt.modal.revision.field.desc"/>">' + (isDraft? draftDesc: escapeHTML(versions[i].description)) + '</td>' + 
					'<td data-title="<s:text name="pbt.modal.revision.field.state"/>">' + (isDraft? draftState: versions[i].status + ' ' + versions[i].formId) + '</td>' + 
					'</tr>');
			});
		} else {
			alert(result["errMsg"]);
		} 
	}, 'json');
});
$("#revisionModal").on("click", ".diff", function () {
	var n = $("#revisionModal").find('.revision:checked').length;
	if (n != 2)
		alert('<s:text name="pbt.error.required.checked.diff"/>');
	else {

		var p = '${form.bean.projectId}';
		var t = $('input:hidden[name=t]').val();
		var v = $("#revisionModal").find('.revision:checked');
		$.post('<s:url action="main" namespace="/" method="compareVersions"/>',{p: p, t: t, v1: v[0].value, v2: v[1].value}, function(result){
			if (result["errCde"] == '00') {

				$("#queryResult4").hide();
				$("#revisionModal").find('div.diff_rev').hide();
				$("#queryResult4").html('');
				$("li.diff_rev1").text('');
				$("li.diff_rev2").text('');
				$("li.diff_rev_splitor").text('');

				var plans = result["period"];
				var diff1 = result["diff1"];
				var diff2 = result["diff2"];
				var diff3 = result["diff3"];
				
				var html = '';
				
				html += '<thead><tr><th style="width:30px;" rowspan="2"><s:text name="pbt.field.pbt.num"/></th><th style="width:250px;" rowspan="2"><s:text name="pbt.field.pbt.dept"/></th><th style="width:150px;" rowspan="2"><s:text name="pbt.field.pbt.user"/></th><th style="width:70px;" rowspan="2"><s:text name="pbt.field.pbt.role"/></th><th style="width:50px;" rowspan="2"><s:text name="pbt.field.pbt.grade"/></th><th style="width:100px;" rowspan="2"><s:text name="pbt.field.pbt.costrate"/></th><th style="width:70px;" rowspan="2"><s:text name="pbt.field.pbt.manday"/></th><th style="width:100px;" rowspan="2"><s:text name="pbt.field.pbt.cost"/></th>';
				$.each(plans, function (year, periods) {
					html += '<th style="width:' + (periods.length * 50) + 'px;" colspan="' + periods.length + '" class="text-center">' + year + '</th>';
				});
				html += '</tr><tr>';
				$.each(plans, function (year, periods) {
					$.each(periods, function (i, period) {
						html += '<th>' + period + '</th>';
					});
				});
				html += '</tr></thead>';
				
				var idx = 0;
				html += '<tbody>';
				$.each(diff1, function(i,e) {
					html += '<tr class="text-danger"><td data-title="<s:text name="pbt.field.pbt.num"/>">' + (++idx) + '</td><td data-title="<s:text name="pbt.field.pbt.dept"/>">' + e.deptName + '(' + e.deptId + ')</td><td data-title="<s:text name="pbt.field.pbt.user"/>">' + (e.userId == '-'? user_tobe_define: e.userName + '(' + e.userId + ')') + '</td><td data-title="<s:text name="pbt.field.pbt.role"/>">' + e.role + '</td>';
					html += '<td data-title="<s:text name="pbt.field.pbt.grade"/>">' + e.grade + '</td><td data-title="<s:text name="pbt.field.pbt.costrate.short"/>">' + e.costRate + '</td><td data-title="<s:text name="pbt.field.pbt.manday.short"/>">' + e.manday + '</td><td data-title="<s:text name="pbt.field.pbt.cost.short"/>">' + parseInt(e.manday * e.costRate, 10) + '</td>';
					var days = JSON.parse(e.mandayDetails);
					$.each(plans, function (year, periods) {
						$.each(periods, function (i, period) {
							html += '<td data-title="' + year + '/' + period + '">' + formatFloat(days[year + period]) + '</td>';
						});
					});
					html += '</tr>';
				});
				$.each(diff3, function(i,e) {
					var diff_dept = [e[0].deptName + '(' + e[0].deptId + ')', e[1].deptName + '(' + e[1].deptId + ')'];
					var diff_user = [(e[0].userId == '-'? user_tobe_define: e[0].userName + '(' + e[0].userId + ')'), (e[1].userId == '-'? user_tobe_define: e[1].userName + '(' + e[1].userId + ')')];
					var diff_role = [e[0].role, e[1].role];
					var diff_grade = [e[0].grade, e[1].grade];
					var diff_costrate = [e[0].costRate, e[1].costRate];
					var diff_manday = [e[0].manday, e[1].manday];
					var diff_cost = [parseInt(e[0].manday * e[0].costRate, 10), parseInt(e[1].manday * e[1].costRate, 10)];

					html += '<tr>';
					html += '<td data-title="<s:text name="pbt.field.pbt.num"/>">' + (++idx) + '</td>';
					html += '<td data-title="<s:text name="pbt.field.pbt.dept"/>" ' + highlightDiff(diff_dept[0],diff_dept[1]) + '><span class="text-success">' + diff_dept[0] + '</span><br/><span class="text-danger">' + diff_dept[1] + '</span></td>';
					html += '<td data-title="<s:text name="pbt.field.pbt.user"/>" ' + highlightDiff(diff_user[0],diff_user[1]) + '><span class="text-success">' + diff_user[0] + '</span><br/><span class="text-danger">' + diff_user[1] + '</span></td>';
					html += '<td data-title="<s:text name="pbt.field.pbt.role"/>" ' + highlightDiff(diff_role[0],diff_role[1]) + '><span class="text-success">' + diff_role[0] + '</span><br/><span class="text-danger">' + diff_role[1] + '</span></td>';
					html += '<td data-title="<s:text name="pbt.field.pbt.grade"/>" ' + highlightDiff(diff_grade[0],diff_grade[1]) + '><span class="text-success">' + diff_grade[0] + '</span><br/><span class="text-danger">' + diff_grade[1] + '</span></td>';
					html += '<td data-title="<s:text name="pbt.field.pbt.costrate.short"/>" ' + highlightDiff(diff_costrate[0],diff_costrate[1]) + '><span class="text-success">' + diff_costrate[0] + '</span><br/><span class="text-danger">' + diff_costrate[1] + '</span></td>';
					html += '<td data-title="<s:text name="pbt.field.pbt.manday.short"/>" ' + highlightDiff(diff_manday[0],diff_manday[1]) + '><span class="text-success">' + diff_manday[0] + '</span><br/><span class="text-danger">' + diff_manday[1] + '</span></td>';
					html += '<td data-title="<s:text name="pbt.field.pbt.cost.short"/>" ' + highlightDiff(diff_cost[0],diff_cost[1]) + '><span class="text-success">' + diff_cost[0] + '</span><br/><span class="text-danger">' + diff_cost[1] + '</span></td>';
					var days1 = JSON.parse(e[0].mandayDetails);
					var days2 = JSON.parse(e[1].mandayDetails);
					$.each(plans, function (year, periods) {
						$.each(periods, function (ii, period) {
							var diff_days = [formatFloat(days1[year + period]), formatFloat(days2[year + period])];
							html += '<td data-title="' + year + '/' + period + '" ' + highlightDiff(diff_days[0],diff_days[1],true) + '><span class="text-success">' + diff_days[0] + '</span><br/><span class="text-danger">' + diff_days[1] + '</span></td>';
						});
					});
					html += '</tr>';
				});
				$.each(diff2, function(i,e) {
					html += '<tr class="text-success"><td data-title="<s:text name="pbt.field.pbt.num"/>">' + (++idx) + '</td><td data-title="<s:text name="pbt.field.pbt.dept"/>">' + e.deptName + '(' + e.deptId + ')</td><td data-title="<s:text name="pbt.field.pbt.user"/>">' + (e.userId == '-'? user_tobe_define: e.userName + '(' + e.userId + ')') + '</td><td data-title="<s:text name="pbt.field.pbt.role"/>">' + e.role + '</td>';
					html += '<td data-title="<s:text name="pbt.field.pbt.grade"/>">' + e.grade + '</td><td data-title="<s:text name="pbt.field.pbt.costrate.short"/>">' + e.costRate + '</td><td data-title="<s:text name="pbt.field.pbt.manday.short"/>">' + e.manday + '</td><td data-title="<s:text name="pbt.field.pbt.cost.short"/>">' + parseInt(e.manday * e.costRate, 10) + '</td>';
					var days = JSON.parse(e.mandayDetails);
					$.each(plans, function (year, periods) {
						$.each(periods, function (ii, period) {
							html += '<td data-title="' + year + '/' + period + '">' + formatFloat(days[year + period]) + '</td>';
						});
					});
					html += '</tr>';
				});
				html += '</tbody>';

				$("#queryResult4").html(html);
				$("li.diff_rev1").text(p + '_' + v[0].value);
				$("li.diff_rev2").text(p + '_' + v[1].value);
				$("li.diff_rev_splitor").text('/');
				
				$("#queryResult4").fadeIn(500);
				$("#revisionModal").find('div.diff_rev').fadeIn(500);

			} else {
				alert(result["errMsg"]);
			} 
		}, 'json');
	}
});
$("#revisionModal").on("click", ".import", function () {
	var n = $("#revisionModal").find('.revision:checked').length;
	if (n != 1)
		alert('<s:text name="pbt.error.required.checked.import"/>');
	else {
		var form = $("#revisionModal").find('form');
		form.submit();
	}
});
$("#revisionModal").on("hidden.bs.modal", function () {
	$("#queryResult4").html('');
	$("li.diff_rev1").text('');
	$("li.diff_rev2").text('');
	$(this).find('input:checkbox').removeAttr('checked');
});

$('#checkinModal').on('show.bs.modal', function (event) {
	var revision = $('table#queryResult5 tbody');

	var p = '${form.bean.projectId}';
	var t = $('input:hidden[name=t]').val();
	$.post('<s:url action="main" namespace="/" method="getVersionList"/>',{p: p, t: t, filter: '1'}, function(result){
		if (result["errCde"] == '00') {
			var versions = result["versions"];
			var maxVersion = 0;
			$(revision).html('');
			$(versions).each(function(i) {
				$(revision).prepend('<tr>' + 
					'<td data-title="<s:text name="pbt.modal.revision.field.version"/>">' + versions[i].version + '</td>' + 
					'<td data-title="<s:text name="pbt.modal.revision.field.desc"/>">' + escapeHTML(versions[i].description) + '</td>' + 
					'<td data-title="<s:text name="pbt.modal.revision.field.state"/>">' + versions[i].status + ' ' + versions[i].formId + '</td>' + 
					'</tr>');
				maxVersion = parseInt(versions[i].version, 10);
			});

			$(revision).prepend('<tr>' +
				'<td data-title="<s:text name="pbt.modal.revision.field.version"/>">' +  paddingLeft((maxVersion + 1), '0', 4) + '</td>' + 
				'<td data-title="<s:text name="pbt.modal.revision.field.desc"/>"><input type="text" class="form-control checkin_desc" value=""></td>' + 
				'<td data-title="<s:text name="pbt.modal.revision.field.state"/>"></td>' + 
				'</tr>');
		} else {
			alert(result["errMsg"]);

			$(revision).prepend('<tr>' +
				'<td data-title="<s:text name="pbt.modal.revision.field.version"/>">Latest</td>' + 
				'<td data-title="<s:text name="pbt.modal.revision.field.desc"/>"><input type="text" class="form-control checkin_desc" value=""></td>' + 
				'<td data-title="<s:text name="pbt.modal.revision.field.state"/>"></td>' + 
				'</tr>');
		} 
	}, 'json');
});
$("#checkinModal").on("click", ".checkin", function () {
	$('input:hidden[name=desc]').val($('#checkinModal').find('.checkin_desc').val());
	$('input:hidden[name=notify]').val($('#checkinModal').find('.checkin_notify:checked').val());
	savePBT(event, false);
});

$("table#queryResult6").on("click", "tr", function (e) {
	if (e.target.type !== 'radio') {
		$(':radio', this).trigger('click');
	}
});
$('#assistModal').on('show.bs.modal', function (event) {
	var button = $(event.relatedTarget);
	var idx = button.attr('data-dept-idx');
	var dept = button.attr('data-dept-dept');
	var user = button.attr('data-dept-user');
	$(this).find('.modal-body .assist_idx').text(idx);
	$(this).find('.modal-body .assist_title').text(dept + ((dept != '' && user != '')?'／':'') + user);
});
$("#assistModal").on("click", ".assist", function () {
	var n = $("#assistModal").find('input[name=assist]:checked').val();
	if (!n)
		alert('<s:text name="pbt.error.required.checked.assist"/>');
	else {
		var idx = $('#assistModal').find('.modal-body .assist_idx').text();
		var target = $('#queryResult2 tr:nth-child(' + idx + ')');
		if (n == 'option1') {
			var d = $('#assistModal').find('.assist_days').val();
			if (d == '' || $.isNumeric(d) === false) d = 0;
			$(target).find('.dept_days').val(formatFloat(d));
		} else if (n == 'option2') {
			var shift = $('#assistModal').find('.assist_shift').val();
			var num = parseInt($('#assistModal').find('.assist_shift_num').val(), 10);
			if (num == '' || $.isNumeric(num) === false) num = 0;
			var len = $(target).find('.dept_days').length;
			var arr = [];
			$(target).find('.dept_days').each(function(i,e) {
				arr.push($(e).val());
			});
			if (shift == 'f') {
				$(target).find('.dept_days').each(function(i,e) {
					$(target).find('.dept_days:eq(' + i + ')').val((i < len - num)?arr[i + num]: '0');
				});
			} else if (shift == 'b') {
				$(target).find('.dept_days').each(function(i,e) {
					$(target).find('.dept_days:eq(' + i + ')').val((i < num)?'0':arr[i - num]);
				});
			}
		} else if (n == 'option3') {
			var from = parseInt($('#assistModal').find('.assist_copy_num').val(), 10);
			if (from == '' || $.isNumeric(from) === false) from = idx;
			var source = $('#queryResult2 tr:nth-child(' + from + ')');
			$(source).find('.dept_days').each(function(i,e) {
				$(target).find('.dept_days:eq(' + i + ')').val($(e).val());
			});
		} else if (n == 'option4') {
			$(target).find('.dept_days').val('0');
		}
		var days = 0;
		$(target).find('.dept_days').each(function(i,e) {
			days += parseFloat($(this).val());
		});
		$(target).find('.dept_manday').text(formatFloat(days));
		$('#assistModal').modal('hide');
	}
});

});
</script>

<%@ include file="/commons/jsp/footer.jsp"%>
