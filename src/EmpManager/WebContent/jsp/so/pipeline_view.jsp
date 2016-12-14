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
			<div class="col-xs-12 col-sm-8">
				<button type="button" class="btn btn-success" onclick="editPBT(event);" <c:if test="${attr.readOnly == 'y'}">disabled</c:if>><s:text name="global.action.edit" /></button>
				<a href="<s:property value="#mainURL" />" role="button" class="btn btn-primary"><s:text name="global.action.back" /></a>
			</div>

			<div class="col-xs-12 col-sm-4 text-right text-nowrap">
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
					<th style="width:260px;"><s:text name="pbt.field.name"/></th>
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
		<table id="queryResult2" class="table table-striped table-hover table-break-all table-list break-table" style="table-layout: fixed;">
			<thead>
				<tr class="text-center">
					<th style="width:54px;"><s:text name="pbt.field.pbt.num"/></th>
					<th style="width:309px;"><s:text name="pbt.field.pbt.dept"/></th>
					<th style="width:102px;"><s:text name="pbt.field.pbt.role"/></th>
					<th style="width:102px;"><s:text name="pbt.field.pbt.grade"/></th>
					<th style="width:102px;"><s:text name="pbt.field.pbt.headcount"/></th>
					<th style="width:102px;"><s:text name="pbt.field.pbt.costrate"/></th>
					<th style="width:102px;"><s:text name="pbt.field.pbt.manday"/></th>
					<th style="width:102px;"><s:text name="pbt.field.pbt.cost"/></th>
				</tr>
			</thead>
			<tbody>
<s:iterator value="form.bean.details" var="record" status="idx">
				<tr class="text-right">
					<td data-title="<s:text name="pbt.field.pbt.num"/>"><p class="form-control-static text-left dept_num"><c:out value="${idx.count}"/></p></td>
					<td data-title="<s:text name="pbt.field.pbt.dept"/>"><p class="form-control-static text-left dept_dept"><c:out value="${record.deptName}"/>(<c:out value="${record.deptId}"/>)</p></td>
					<td data-title="<s:text name="pbt.field.pbt.role"/>"><p class="form-control-static text-left dept_role"><c:out value="${record.role}"/></p></td>
					<td data-title="<s:text name="pbt.field.pbt.grade"/>"><p class="form-control-static dept_grade"><c:out value="${record.grade}"/></p></td>
					<td data-title="<s:text name="pbt.field.pbt.headcount"/>"><p class="form-control-static dept_headcount"><c:out value="${record.headCount}"/></p></td>
					<td data-title="<s:text name="pbt.field.pbt.costrate.short"/>"><p class="form-control-static dept_costrate"><fmt:formatNumber groupingUsed="true" maxFractionDigits="0" value="${record.costRate}" /></p></td>
					<td data-title="<s:text name="pbt.field.pbt.manday.short"/>"><p class="form-control-static dept_manday"><fmt:formatNumber groupingUsed="false" maxFractionDigits="2" value="${record.manday}" /></p></td>
					<td data-title="<s:text name="pbt.field.pbt.cost.short"/>"><p class="form-control-static dept_cost"></p></td>
				</tr>
</s:iterator>
			</tbody>
		</table>
		</div>
		<p class="form-control-static text-danger"><s:text name="pbt.message.draft.notice"/></p>
		</div></div>
	</div>
	<!-- /content -->
</s:form>
</div>

<script type='text/javascript'>

function editPBT(event) {
	var oForm = getSelfForm(event, 'initModify');	
	oForm.submit();
}

function removeComma(selector) {
	return selector.text().replace(/,/g, '');
}

function numberWithCommas(number) {
	return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

$(function () {
var total = 0;
var dept = '';
var deptSum = 0;
$("table#queryResult2 tr").each(function () {
	if( $(this).find(".dept_cost").length ) {
		var headcount = $(this).find('.dept_headcount').text();
		var manday = parseFloat($(this).find('.dept_manday').text());
		var costrate = parseInt(removeComma($(this).find('.dept_costrate')), 10);
		var cost = parseInt(headcount * manday * costrate, 10);
		$(this).find('.dept_cost').text(numberWithCommas(cost));
		total += cost;
		
		if (dept == '')
			dept = $(this).find('.dept_dept').text();
		
		if ($(this).find('.dept_dept').text() != dept) {
			$(this).before('<tr class="text-right dept_subtotal">' + 
				'<td colspan="7"><p class="form-control-static dept_subtotal_dept">' + dept + '<span class="hidden-sm-x hidden-xs"> <s:text name="pbt.message.subtotal"/></span></p></td>' + 
				'<td data-title="<s:text name="pbt.message.subtotal"/>"><p class="form-control-static dept_subtotal_total">' + numberWithCommas(deptSum) + '</p></td>' + 
				'</tr>');
			
			dept = $(this).find('.dept_dept').text();
			deptSum = 0;
		}	
		deptSum += cost;
	}
});
if (dept != '') {
	$('table#queryResult2 tr:last').after('<tr class="text-right dept_subtotal">' + 
		'<td colspan="7"><p class="form-control-static dept_subtotal_dept">' + dept + '<span class="hidden-sm-x hidden-xs"> <s:text name="pbt.message.subtotal"/></span></p></td>' + 
		'<td data-title="<s:text name="pbt.message.subtotal"/>"><p class="form-control-static dept_subtotal_total">' + numberWithCommas(deptSum) + '</p></td>' + 
		'</tr>');
}
$('#total').text('<s:text name="global.message.sum"/>: $' + numberWithCommas(total));
});
var isDraft = ${isDraft};
if (isDraft === 1) {
	$("table#queryResult2 tbody tr td").addClass('text-danger');
}
</script>

<%@ include file="/commons/jsp/footer.jsp"%>
