<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	

<s:url action="main" namespace="/" var="mainURL"><s:param name="t">${form.activeTab}</s:param></s:url>
<s:url action="main" namespace="/" method="view" var="viewURL"><s:param name="t">${form.activeTab}</s:param><s:param name="id">${form.bean.projectId}</s:param></s:url>

<s:form method="post" namespace="/" action="main" theme="simple" cssClass="navbar-form">
<input type="hidden" name="t" value="${form.activeTab}" />
<input type="hidden" name="notify"/>

	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
				<a href="<s:property value="#mainURL" />" role="button" class="btn btn-primary"><s:text name="global.action.cancel" /></a>
				<button type="button" class="btn btn-success" onclick="savePBT(event, true);"><s:text name="global.action.draft.save" /></button>
				<button type="button" class="btn btn-success" onclick="savePBT(event, false);"><s:text name="global.action.save" /></button>
				<c:if test="${attr.modify == 'y'}"><span class="hidden-sm-x hidden-xs"><a href="<s:property value="#viewURL" escapeHtml="false" />" role="button" class="btn btn-primary"><s:text name="global.action.back" /></a></span></c:if>
			</div>

			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 text-right text-nowrap">
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
			<div class="col-xs-6 text-right"><button title="" type="button" class="btn btn-success add show_tip" data-original-title='<s:text name="global.action.add"/>'><i class="fa fa-plus-square"></i></button></div>
		</div>
		<div class="div-result">
		<table id="queryResult2" class="table table-striped table-hover table-break-all table-list break-table">
			<thead>
				<tr>
					<th><s:text name="pbt.field.pbt.num"/></th>
					<th><s:text name="pbt.field.pbt.dept"/></th>
					<th><s:text name="pbt.field.pbt.role"/></th>
					<th><s:text name="pbt.field.pbt.grade"/></th>
					<th><s:text name="pbt.field.pbt.headcount"/></th>
					<th><s:text name="pbt.field.pbt.costrate"/></th>
					<th><s:text name="pbt.field.pbt.manday"/></th>
					<th><s:text name="pbt.field.pbt.cost"/></th>
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

<script type='text/javascript'>

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
	$('table#queryResult2 tbody tr').each(function(i,e) {
		if ($(this).find('.dept_deptId').val() == '') return; // 等於continue
		deptIds += ',' + $(this).find('.dept_deptId').val();
		var num = $(this).find('.dept_num').text();
		if ($(this).find('.dept_role').val() == '') {
			alert('No.' + num + ': ' + '<s:text name="pbt.error.required.role"/>');
			$(this).find('.dept_role').focus();
			error = true;
			return false; // 等於break
		}
		var manday = parseFloat($(this).find('.dept_manday').val());
		if (isNaN(manday) || manday <= 0) {
			alert('No.' + num + ': ' + '<s:text name="pbt.error.required.manday"/>');
			$(this).find('.dept_manday').focus();
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

	if (statusChange === true) {
		alert('<s:text name="pbt.error.details.status_change"/>');
		return;
	}

	if (is_draft === false && confirm('<s:text name="pbt.message.notify"/>'))
		$('input:hidden[name=notify]').val('y');
		
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

function removeComma(selector) {
	return selector.text().replace(/,/g, '');
}

function numberWithCommas(number) {
	return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//[連動]
//刪除：總計
//職等：每人天成本
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

function resetDeptNum() {
	$('table#queryResult2 tbody tr').each(function(i,e) {
		$(this).find('.dept_num').text((i + 1));
	});
}

function addDeptRow() {
	var len = $('table#queryResult2 tbody tr').length;
	$('table#queryResult2 tbody').append('<tr class="text-right">' + 
			'<td data-title="<s:text name="pbt.field.pbt.num"/>" class="text-left"><span class="form-control-static dept_num">' + (len + 1) + '</span> <button title="" type="button" class="btn btn-danger remove show_tip" data-original-title="<s:text name="global.action.remove"/>"><i class="fa fa-trash-o"></i></button></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.dept"/>"><input name="deptId" type="hidden" class="dept_deptId"/><input name="dept" type="text" value="" class="form-control form-control-fullwidth dept_dept" /></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.role"/>">' + 
			'	<select name="role" class="form-control form-control-fullwidth dept_role">' + 
			'		<option value=""></option>' + 
			'	</select>' + 
			'</td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.grade"/>"><select name="grade" class="form-control form-control-fullwidth dept_grade" disabled="disabled"></select></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.headcount"/>"><select name="headcount" class="form-control form-control-fullwidth dept_headcount"></select></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.costrate.short"/>"><p class="form-control-static dept_costrate">0</p></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.manday.short"/>"><input name="manday" type="text" value="0" class="form-control form-control-fullwidth dept_manday NumDecText" maxlength="6"/></td>' + 
			'<td data-title="<s:text name="pbt.field.pbt.cost.short"/>"><p class="form-control-static dept_cost">0</p></td>' + 
			'</tr>');

	$.each(data2, function(i,e) { 
		$('table#queryResult2 tbody tr:last').find(".dept_role").append($("<option />", {value: e.roleId, text: e.roleName})); 
	});
	$.each(data3, function(n){
		$('table#queryResult2 tbody tr:last').find(".dept_grade").append($("<option />", {value: n, text: n})); 
	});
	$.each(data4, function(n){
		$('table#queryResult2 tbody tr:last').find(".dept_headcount").append($("<option />", {value: (n + 1), text: (n + 1)})); 
	});
}

var modify = '${attr.modify}';
function setDeptRows() {
	var data0 = [
		<s:iterator value="form.bean.details" var="record" status="idx">{deptId:"<c:out value="${record.deptId}"/>",deptName:"<c:out value="${record.deptName}"/>",
			role:"<c:out value="${record.role}"/>",grade:"<c:out value="${record.grade}"/>",costRate:"<c:out value="${record.costRate}"/>",manday:"<c:out value="${record.manday}"/>",
			headCount:"<c:out value="${record.headCount}"/>"},
		</s:iterator>];

	$.each(data0, function(ii,e) {
		$('table#queryResult2 tbody').append('<tr class="text-right">' + 
				'<td data-title="<s:text name="pbt.field.pbt.num"/>" class="text-left"><span class="form-control-static dept_num">' + (ii + 1) + '</span> <button title="" type="button" class="btn btn-danger remove show_tip" data-original-title="<s:text name="global.action.remove"/>"><i class="fa fa-trash-o"></i></button></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.dept"/>"><input name="deptId" type="hidden" class="dept_deptId"/><input name="dept" type="text" value="" class="form-control form-control-fullwidth dept_dept" /></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.role"/>">' + 
				'	<select name="role" class="form-control form-control-fullwidth dept_role">' + 
				'		<option value=""></option>' + 
				'	</select>' + 
				'</td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.grade"/>"><select name="grade" class="form-control form-control-fullwidth dept_grade"></select></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.headcount"/>"><select name="headcount" class="form-control form-control-fullwidth dept_headcount"></select></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.costrate.short"/>"><p class="form-control-static dept_costrate">0</p></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.manday.short"/>"><input name="manday" type="text" value="0" class="form-control form-control-fullwidth dept_manday NumDecText" maxlength="6"/></td>' + 
				'<td data-title="<s:text name="pbt.field.pbt.cost.short"/>"><p class="form-control-static dept_cost">0</p></td>' + 
				'</tr>');

		$.each(data2, function(i,e) { 
			$('table#queryResult2 tbody tr:last').find(".dept_role").append($("<option />", {value: e.roleId, text: e.roleName})); 
		});
		$.each(data3, function(n){
			$('table#queryResult2 tbody tr:last').find(".dept_grade").append($("<option />", {value: n, text: n})); 
		});
		$.each(data4, function(n){
			$('table#queryResult2 tbody tr:last').find(".dept_headcount").append($("<option />", {value: (n + 1), text: (n + 1)})); 
		});

		var tr = $('table#queryResult2 tbody tr:last');
		$(tr).find(".dept_deptId").val(e.deptId);
		$(tr).find(".dept_dept").val(e.deptName + '(' + e.deptId + ')');
		$(tr).find(".dept_role").val(e.role);
		$(tr).find(".dept_grade").val(e.grade);
		$(tr).find(".dept_headcount").val(e.headCount);
		$(tr).find(".dept_costrate").text(numberWithCommas(formatInt(e.costRate)));
		$(tr).find(".dept_manday").val(formatFloat(e.manday));
		
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
if (modify === 'y')
	setDeptRows();
	var invalid = '${attr.invalid}';
	if (invalid.length > 0) {
		$.each(invalid.split(','), function(i, e) {
			$('.dept_deptId[value=' + e + ']').closest('tr').find('.dept_dept').css('color','#b94a48');
		});
		alert('<s:text name="pbt.error.details.status_change"/>');
	}
else
	$(".add").trigger("click");

});

var data1 = [<s:iterator value="form.deptList" var="dept" status="idx">{deptId:"<c:out value="${dept.id}"/>",deptName:"<c:out value="${dept.name}"/>",deptFinCode:"<c:out value="${dept.finCode}"/>"},</s:iterator>];
var data2 = [<s:iterator value="form.roleList" var="role" status="idx">{roleId:"<c:out value="${role.code}"/>",roleName:"<c:out value="${role.label}"/>"},</s:iterator>];
var data3 = new Array(<s:property value="form.maxGrade"/> + 1);
var data4 = new Array(10);

var checkNumDec = function() {
	$(this).val($(this).val().replace(/[^0-9.]/g, ''));
};

$(function () {
	
$('table#queryResult2').on('keyup', '.NumDecText', checkNumDec);
$('table#queryResult2').on('paste', '.NumDecText', checkNumDec);
$('table#queryResult2').find('.NumDecText').each(function() {
	$(this).css("ime-mode", "disabled");
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
			$(this).closest('tr').find('.dept_grade').removeAttr('disabled');
			return false;
		}
	});
});
$('table#queryResult2').on('change', '.dept_grade', function() {
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
			var headcount = $(this).find('.dept_headcount').val();
			var manday = parseFloat($(this).find('.dept_manday').val());
			if (isNaN(manday)) manday = 0;
			if ($(this).find('.dept_manday').val().length > 0)
				$(this).find('.dept_manday').val(manday);
			var costrate = parseInt(removeComma($(this).find('.dept_costrate')), 10);
			var cost = parseInt(headcount * manday * costrate, 10);
			$(this).find('.dept_cost').text(numberWithCommas(cost));
			total += cost;
		}
	});
	$('#total').text('<s:text name="global.message.sum"/>: $' + numberWithCommas(total));
}, 1000);

});
</script>

<%@ include file="/commons/jsp/footer.jsp"%>
