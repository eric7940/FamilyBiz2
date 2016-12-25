<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<div class="tab-content">

<s:form method="post" namespace="/po" action="main" theme="simple" cssClass="navbar-form">

	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-8 div-search">
				<div class="form-group form-input-line-magrin">
					<s:textfield name="form.keyword" theme="simple" placeholder="%{getText('global.message.keywordSearch')}:%{getText('purchase.field.master_id')}" cssClass="form-control"/>
				</div>
				<s:submit key="global.action.query" cssClass="btn btn-primary" />
			</div>
			<div class="col-md-4 text-right">
				<button type="button" class="btn btn-success remove" disabled="disabled" onclick="fnRemove(event,'<s:text name="purchase.message.confirm.remove"/>')"><s:text name="global.action.remove"/></button>
			</div>
		</div>

		<!-- 查詢結果 -->
		<h4><s:text name="purchase.message.master"/></h4>
		<div class="div-result">
		<table id="master" class="table table-striped table-hover table-list break-table">
			<tbody>
			<tr>
				<th class="col-md-1"><s:text name="fact.field.name" /></th><td class="col-md-3"><c:out value="${form.fact.name}"/></td>
				<th class="col-md-1"><s:text name="purchase.field.fact_id" /></th><td class="col-md-1"><c:out value="${form.fact.id}"/></td>
				<th class="col-md-1"><s:text name="purchase.field.purchase_date" /></th><td class="col-md-2"><c:out value="${form.purchaseDate}" /></td>
				<th class="col-md-1"><s:text name="purchase.field.stock" /></th><td class="col-md-2"><c:out value="${form.stock.name}"/></td>	
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="fact.field.biz_no" /></th><td class="col-md-3"><c:out value="${form.fact.bizNo}"/></td>
				<th class="col-md-1"><s:text name="fact.field.tel" /></th><td class="col-md-3" colspan="3"><c:out value="${form.fact.tel}"/></td>
				<th class="col-md-1"><s:text name="purchase.field.master_id" /></th><td class="col-md-3 master_id"><c:out value="${form.masterId}"/></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="fact.field.memo" /></th><td class="col-md-7" colspan="5"><c:out value="${form.fact.memo}"/></td>
				<th class="col-md-1"><s:text name="purchase.field.invoice_nbr" /></th><td class="col-md-3"><c:out value="${form.invoiceNbr}"/></td>
			</tr>
			</tbody>
		</table>
		</div>
		
		<h4><s:text name="purchase.message.detail"/></h4>
		<div class="div-result">
		<table id="details" class="table table-striped table-hover table-list break-table">
			<thead>
				<tr>
					<th class="col-md-1"><s:text name="purchase.field.seq" /></th>
					<th class="col-md-4"><s:text name="prod.field.name" /></th>
					<th class="col-md-1"><s:text name="purchase.field.qty" /></th>
					<th class="col-md-1"><s:text name="prod.field.unit" /></th>
					<th class="col-md-2"><s:text name="prod.field.price" /></th>
					<th class="col-md-3"><s:text name="purchase.field.detail_amt" /></th>
				</tr>
			</thead>
			<tbody>
<s:iterator value="form.details" var="detail" status="idx">
				<tr>
					<td data-title="<s:text name="purchase.field.seq" />">${idx.count}</td>
					<td data-title="<s:text name="prod.field.name" />"><c:out value="${detail.prod.name}"/></td>
					<td data-title="<s:text name="purchase.field.qty" />"><c:out value="${detail.qty}"/></td>
					<td data-title="<s:text name="prod.field.unit" />"><c:out value="${detail.prod.unit}"/></td>
					<td data-title="<s:text name="prod.field.price" />"><c:out value="${detail.amt / detail.qty}"/></td>
					<td data-title="<s:text name="purchase.field.detail_amt" />"><c:out value="${detail.amt}"/></td>
				</tr>
</s:iterator>
			</tbody>
		</table>
		</div>
		
		<h4><s:text name="purchase.message.footer"/></h4>
		<div class="div-result">
		<table id="footer" class="table table-striped table-hover table-list break-table">
			<tbody>
			<tr>
				<th class="col-md-1"><s:text name="purchase.field.amt" /></th><td class="col-md-3"><c:out value="${form.amt}"/></td>
				<th class="col-md-1"><s:text name="purchase.field.discount" /></th><td class="col-md-3"><c:out value="${form.discount}"/></td>
				<th class="col-md-1"><s:text name="purchase.field.total" /></th><td class="col-md-3"><c:out value="${form.total}"/></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="purchase.field.memo" /></th><td class="col-md-11" colspan="5"><c:out value="${form.memo}"/></td>
			</tr>
			</tbody>
		</table>
		</div>

	</div>
	<!-- /content -->
</s:form>

</div>
</div>

<script type="text/javascript">
function printPurchase() {
	var printWin = openWindow('/fb2/purchase.sheet?id=' + $(".master_id").text(), 'printPurchase', 793, 529);
}

$(function () {
	if ($('.master_id').text() !== '') {
		$('.remove').removeAttr('disabled');
	}
});
</script>

<%@ include file="/commons/jsp/footer.jsp"%>
