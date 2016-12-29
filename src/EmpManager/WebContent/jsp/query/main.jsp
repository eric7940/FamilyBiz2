<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<ul class="nav nav-tabs">
	<li class="nav-item active"><a data-toggle="tab" href="#queryProdPrice" class="nav-link active"><s:text name="query.tab.prod_price"/></a></li>
	<li class="nav-item"><a data-toggle="tab" href="#queryOffers" class="nav-link"><s:text name="query.tab.offers"/></a></li>
</ul>

<div class="tab-content">
	<div id="queryProdPrice" class="tab-pane fade in active">
		<h3><s:text name="config.tab.memo"/></h3>
		<s:form method="post" namespace="/query" action="main" theme="simple" cssClass="navbar-form">
			<div role="main" class="container-fluid">
				<div class="form-group">
					<label for="cust"><s:text name="config.field.memo"/></label>
					<input type="text" name="cust" class="form-control cust" placeholder='%{getText("global.message.keywordSearch")}:%{getText("cust.field.name")}'/>
					<input type="hidden" name="custId" id="custId"/>
				</div>
				<div class="form-group">
					<label for="prod"><s:text name="config.field.memo"/></label>
					<input type="text" name="prod" class="form-control prod" placeholder='%{getText("global.message.keywordSearch")}:%{getText("prod.field.name")}'/>
					<input type="hidden" name="prodId" id="custId"/>
				</div>
				<s:submit key="global.action.query" cssClass="btn btn-primary query" />
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
