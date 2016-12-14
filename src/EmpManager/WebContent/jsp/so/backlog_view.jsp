<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	

<s:url action="main" namespace="/" var="mainURL"><s:param name="t">${form.activeTab}</s:param></s:url>

<s:form method="post" namespace="/" action="main" theme="simple" cssClass="navbar-form">
<input type="hidden" name="t" value="${form.activeTab}" />
<s:hidden name="form.bean.projectId" />
	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-sm-12 col-md-6 col-lg-5">
				<button type="button" class="btn btn-success" onclick="editPBT(event);" <c:if test="${attr.readOnly == 'y'}">disabled</c:if>><s:text name="global.action.draft.edit"/></button>
				<input type="button" class="btn btn-warning revision" value='<s:text name="pbt.action.revision"/>' data-toggle="modal" data-target="#revisionModal" />
				<span class="hidden-sm-x hidden-xs"><a href="<s:property value="#mainURL" />" role="button" class="btn btn-primary"><s:text name="global.action.back" /></a></span>
			</div>
			<div class="col-sm-8 col-md-6 col-lg-5"><h4>
				<s:text name="pbt.message.monthly"/>:
				<span class="period_start"><fmt:formatDate pattern="yyyy-MM-dd" value="${form.bean.startDate}" /></span>
				～
				<span class="period_end"><fmt:formatDate pattern="yyyy-MM-dd" value="${form.bean.endDate}" /></span></h4>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-12 col-lg-2 text-right text-nowrap">
				<h4 id="total"><s:text name="global.message.sum"/>: $<fmt:formatNumber groupingUsed="true" maxFractionDigits="0" value="${form.bean.totalCost}" /></h4>
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="row" style="margin-top:10px;"><div class="col-sm-12">
		<div class="div-result" style="overflow-x: auto;">
		<table id="queryResult1" class="table table-striped table-hover table-break-all table-list break-table" style="table-layout: fixed;">
			<thead>
				<tr>
					<th style="width:183px;"><s:text name="pbt.field.oin"/></th>
					<th style="width:183px;"><s:text name="pbt.field.name"/></th>
					<th style="width:183px;"><s:text name="pbt.field.pmDept"/></th>
					<th style="width:183px;"><s:text name="pbt.field.pmUser"/></th>
					<th style="width:183px;"><s:text name="pbt.field.salesDept"/></th>
					<th style="width:183px;"><s:text name="pbt.field.salesUser"/></th>
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
		</div>
		<div class="div-result" style="overflow-x: auto;">
		<table id="queryResult2" class="table table-striped table-hover table-break-all table-list break-table table-condensed" style="table-layout: fixed;">
			<thead>
				<tr>
					<th style="width:70px;" rowspan="2"><s:text name="pbt.field.pbt.num"/></th>
					<th style="width:190px;" rowspan="2"><s:text name="pbt.field.pbt.dept"/></th>
					<th style="width:157px;" rowspan="2"><s:text name="pbt.field.pbt.user"/></th>
					<th style="width:104px;" rowspan="2"><s:text name="pbt.field.pbt.role"/></th>
					<th style="width:70px;" rowspan="2"><s:text name="pbt.field.pbt.grade"/></th>
					<th style="width:87px;" rowspan="2"><s:text name="pbt.field.pbt.costrate"/></th>
					<th style="width:120px;" rowspan="2"><s:text name="pbt.field.pbt.manday"/></th>
					<th style="width:122px;" rowspan="2"><s:text name="pbt.field.pbt.cost"/></th>
				</tr>
			</thead>
			<tbody>
<s:iterator value="form.bean.details" var="record" status="idx">
				<tr class="text-right">
					<td data-title="<s:text name="pbt.field.pbt.num"/>"><p class="form-control-static text-left dept_num"><c:out value="${idx.count}"/></p></td>
					<td data-title="<s:text name="pbt.field.pbt.dept"/>"><p class="form-control-static text-left dept_dept"><c:out value="${record.deptName}"/>(<c:out value="${record.deptId}"/>)</p></td>
					<td data-title="<s:text name="pbt.field.pbt.user"/>"><p class="form-control-static text-left dept_user">
						<c:choose>
							<c:when test="${record.userId == '-'}"><s:text name="pbt.message.user.undefined"/></c:when>
							<c:otherwise><c:out value="${record.userName}"/>(<c:out value="${record.userId}"/>)</c:otherwise>
						</c:choose>
					</p></td>
					<td data-title="<s:text name="pbt.field.pbt.role"/>"><p class="form-control-static text-left dept_role"><c:out value="${record.role}"/></p></td>
					<td data-title="<s:text name="pbt.field.pbt.grade"/>"><p class="form-control-static dept_grade"><c:out value="${record.grade}"/></p></td>
					<td data-title="<s:text name="pbt.field.pbt.costrate.short"/>"><p class="form-control-static dept_costrate"><fmt:formatNumber groupingUsed="true" maxFractionDigits="0" value="${record.costRate}" /></p></td>
					<td data-title="<s:text name="pbt.field.pbt.manday.short"/>">
						<p class="form-control-static dept_manday"><fmt:formatNumber groupingUsed="false" maxFractionDigits="2" value="${record.manday}" /></p>
						<input type="hidden" class="dept_manday_details" value='${record.mandayDetails}'/>
					</td>
					<td data-title="<s:text name="pbt.field.pbt.cost.short"/>"><p class="form-control-static dept_cost"></p></td>
				</tr>
</s:iterator>
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
        <button type="button" class="btn btn-primary import" <c:if test="${attr.readOnly == 'y'}">disabled</c:if>><s:text name="pbt.action.import"/></button>
      </div>
    </div>
  </div>
</div>

<script type='text/javascript'>

var user_tobe_define = '<s:text name="pbt.message.user.undefined"/>';
function editPBT(event) {
	var oForm = getSelfForm(event, 'initModify');	
	oForm.submit();
}

function ps(days) {
	return (days == undefined)? '': days;	
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

function highlightDiff(d1, d2, compareDays) {
	if (compareDays == undefined) compareDays = false;
	if (compareDays) {
		return ((d1 != '' && d1 != '0' || d2 != '' && d2 != '0') && (d1 !== d2))? 'class="diff_highlight"': '';
	} else {
		return (d1 !== d2)? 'class="diff_highlight"': '';
	}
}

var years = {};
var months = new Array();
function setDeptDaysColumns() {
	var date1 = new Date($('.period_start').text());
	var date2 = new Date($('.period_end').text());
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
	$.each(years, function(y,colspan) {
		$('table#queryResult2 thead tr').find('th:last').after('<th style="width:' + (colspan * 50) + 'px;" colspan="' + colspan + '" class="text-center">' + y + '</th>');
	});
	$('table#queryResult2 thead').append(mon);
}

$(function () {

setDeptDaysColumns();
	
var total = 0;
$("table#queryResult2 tr").each(function () {
	if( $(this).find(".dept_cost").length ) {
		var details = JSON.parse($(this).find('.dept_manday_details').val());
		
		var row = '';
		$.each(months, function(i,ym) {
			row += '<td data-title="' + ym + '"><p class="form-control-static dept_days">' + details[ym.replace('/','')] + '</td>'; 
		});
		$(this).find('td:last').after(row)
		
		var manday = parseFloat($(this).find('.dept_manday').text());
		var costrate = parseInt(removeComma($(this).find('.dept_costrate')), 10);
		var cost = parseInt(manday * costrate, 10);
		$(this).find('.dept_cost').text(numberWithCommas(cost));
		total += cost;
	}
});
$('#total').text('<s:text name="global.message.sum"/>: $' + numberWithCommas(total));

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
							html += '<td data-title="' + year + '/' + period + '">' + ps(days[year + period]) + '</td>';
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
							var diff_days = [ps(days1[year + period]), ps(days2[year + period])];
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
							html += '<td data-title="' + year + '/' + period + '">' + ps(days[year + period]) + '</td>';
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

});
</script>

<%@ include file="/commons/jsp/footer.jsp"%>
