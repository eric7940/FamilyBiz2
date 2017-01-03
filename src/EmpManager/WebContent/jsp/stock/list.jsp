<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<div class="tab-content">

<s:form method="post" namespace="/stock" action="qty" theme="simple" cssClass="navbar-form">

	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-8 div-search">
				<div class="form-group form-input-line-magrin">
					<s:select list="form.stocks" name="form.stockId" listKey="id" listValue="name" headerKey="0" headerValue="%{getText('global.option.one',new java.lang.String[]{getText('stock')})}" cssClass="form-control stock"/>
					<s:textfield name="form.keyword" theme="simple" placeholder="%{getText('global.message.keywordSearch')}:%{getText('prod.field.name')}" cssClass="form-control"/>
				</div>

				<s:submit key="global.action.query" cssClass="btn btn-primary" />
			</div>
			<div class="col-md-4 text-right">
				<s:submit key="stock.action.adjust" cssClass="btn btn-success" onclick="return initAdjust(event)" />
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="div-result">
		<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
			<thead>
				<tr>
					<th class="col-md-5"><s:text name="prod.field.name" /></th>
					<th class="col-md-3"><s:text name="stock.field.qty1" /></th>
					<th class="col-md-3"><s:text name="prod.field.save_qty" /></th>
					<th class="col-md-1"><s:text name="prod.field.unit" /></th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty form.pageElement.records}">
				<tr>
					<td colspan="4" class="text-center"><s:text name="global.message.noResults"/></td>
				</tr>
</c:if>
<s:iterator value="form.pageElement.records" var="record" status="idx">
				<tr>
					<td data-title="<s:text name="prod.field.name" />"><c:out value="${record.prod.name}"/></td>
					<td data-title="<s:text name="stock.field.qty1" />"><c:out value="${record.qty}"/></td>
					<td data-title="<s:text name="prod.field.save_qty" />"><c:out value="${record.prod.saveQty}"/></td>
					<td data-title="<s:text name="prod.field.unit" />"><c:out value="${record.prod.unit}"/></td>
				</tr>
</s:iterator>
			</tbody>
		</table>
		</div>

	   	<!-- 分頁 -->
		<c:if test="${!empty form.pageElement.records}">
			<c:set var="pageElement" value="${form.pageElement}" />
			<%@include file="/commons/jsp/pagination.jsp"%>
		</c:if>

	</div>
	<!-- /content -->
</s:form>

</div>
</div>

<script type="text/javascript">
function initAdjust(event) {
	if ($('.stock').val() == '0') {
		alert('<s:text name="stock.message.required.stock"/>');
		$(".stock").focus();
		return false;
	}

	var oForm = getSelfForm(event,'initAdjust');	
	oForm.submit();
}

</script>

<%@ include file="/commons/jsp/footer.jsp"%>
