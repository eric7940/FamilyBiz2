<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<ul class="nav nav-tabs">
	<li class="nav-item active"><a data-toggle="tab" href="#memo" class="nav-link active"><s:text name="config.tab.memo"/></a></li>
	<li class="nav-item"><a data-toggle="tab" href="#unit" class="nav-link"><s:text name="config.tab.unit"/></a></li>
</ul>

<div class="tab-content">
	<div id="memo" class="tab-pane fade in active">
		<h3><s:text name="config.tab.memo"/></h3>
		<s:form method="post" namespace="/admin" action="config!modifyOfferMemo.do" theme="simple" cssClass="navbar-form">
			<div role="main" class="container-fluid">
				<div class="form-group">
					<label for="memo"><s:text name="config.field.memo"/></label>
					<s:textfield name="form.offerMemo" id="memo" cssClass="form-control"></s:textfield>
				</div>
				<s:submit key="global.action.save" cssClass="btn btn-primary" />
			</div>
		</s:form>
	</div>
	<div id="unit" class="tab-pane fade">
		<h3><s:text name="config.tab.unit"/></h3>
		<s:form method="post" namespace="/admin" action="config!modifyUnits.do" theme="simple" cssClass="navbar-form">
			<div role="main" class="container-fluid">
			<div class="row">
				<div class="col-md-12 div-search text-right">
					<button title="" type="button" class="btn btn-success add show_tip" data-original-title='<s:text name="global.action.add"/>'><i class="fa fa-plus-square"></i></button>
					<s:submit key="global.action.save" cssClass="btn btn-primary" />
				</div>
			</div>

			<div class="div-result">
			<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table">
				<thead>
					<tr>
						<th class="col-md-2"><s:text name="global.action.remove"/></th>
						<th class="col-md-5"><s:text name="config.field.unit_code"/></th>
						<th class="col-md-5"><s:text name="config.field.unit_label"/></th>
					</tr>
					</thead>
					<tbody>
<s:iterator value="form.units" var="record" status="idx">
					<tr>
						<td data-title="<s:text name="global.action.remove" />"><button title="" type="button" class="btn btn-danger remove show_tip" data-original-title="<s:text name="global.action.remove"/>"><i class="fa fa-trash-o"></i></button></td>
						<td data-title="<s:text name="config.field.unit_code" />"><c:out value="${record.code}"/></td>
						<td data-title="<s:text name="config.field.unit_label" />"><input name="unit_label" value="${record.value}" type="text" maxlength="1" class="form-control form-control-fullwidth unit_label" /></td>
					</tr>
</s:iterator>					
					</tbody>
				</table>
			</div>
			</div>
		</s:form>
	</div>
</div>
</div>

<script type='text/javascript'>

function addUnitRow() {
	var len = $('table#queryResult tbody tr').length;
	var row = '<tr>' + 
			'<td data-title="<s:text name="global.action.remove"/>"><button title="" type="button" class="btn btn-danger remove show_tip" data-original-title="<s:text name="global.action.remove"/>"><i class="fa fa-trash-o"></i></button></td>' + 
			'<td data-title="<s:text name="config.field.unit_code"/>">&nbsp;</td>' + 
			'<td data-title="<s:text name="config.field.unit_label"/>"><input name="unit_label" type="text" maxlength="1" class="form-control form-control-fullwidth unit_label" /></td>' + 
			'</tr>';
	$('table#queryResult tbody').append(row);
}

$(function () {
	$(".add").on("click", addUnitRow);

	$("table#queryResult").on("click", ".remove", function () {
		$(this).closest('tr').remove();
	});

});

</script>

<%@ include file="/commons/jsp/footer.jsp"%>
