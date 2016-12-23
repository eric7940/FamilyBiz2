<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<div class="tab-content">

<s:form method="post" namespace="/so" action="main" theme="simple" cssClass="navbar-form">

	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-8 div-search">
				<div class="form-group form-input-line-magrin">
					<s:textfield name="form.keyword" theme="simple" placeholder="%{getText('global.message.keywordSearch')}:%{getText('offer.field.master_id')}" cssClass="form-control"/>
				</div>
				<s:submit key="global.action.query" cssClass="btn btn-primary" />
			</div>
			<div class="col-md-4 text-right">
				<button type="button" class="btn btn-success print" disabled="disabled" onclick="printOffer()"><s:text name="offer.action.print"/></button>
				<button type="button" class="btn btn-success edit" disabled="disabled" onclick="fnInitModify(event,'${form.masterId}','form.keyword')"><s:text name="global.action.edit"/></button>
				<button type="button" class="btn btn-success remove" disabled="disabled" onclick="fnRemove(event,'<s:text name="offer.message.confirm.remove"/>')"><s:text name="global.action.remove"/></button>
			</div>
		</div>

		<!-- 查詢結果 -->
		<h4><s:text name="offer.message.master"/></h4>
		<div class="div-result">
		<table id="master" class="table table-striped table-hover table-list break-table">
			<tbody>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.name" /></th><td class="col-md-3"><c:out value="${form.cust.name}"/></td>
				<th class="col-md-1"><s:text name="offer.field.cust_id" /></th><td class="col-md-3"><c:out value="${form.cust.id}"/></td>
				<th class="col-md-1"><s:text name="offer.field.offer_date" /></th><td class="col-md-3"><c:out value="${form.offerDate}" /></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.biz_no" /></th><td class="col-md-3"><c:out value="${form.cust.bizNo}"/></td>
				<th class="col-md-1"><s:text name="cust.field.tel" /></th><td class="col-md-7" colspan="3"><c:out value="${form.cust.tel}"/></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.deliver_addr" /></th><td class="col-md-7" colspan="3"><c:out value="${form.cust.deliverAddr}"/></td>
				<th class="col-md-1"><s:text name="offer.field.master_id" /></th><td class="col-md-3 master_id"><c:out value="${form.masterId}"/></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.memo" /></th><td class="col-md-7" colspan="3"><c:out value="${form.cust.memo}"/></td>
				<th class="col-md-1"><s:text name="offer.field.invoice_nbr" /></th><td class="col-md-3"><c:out value="${form.invoiceNbr}"/></td>
			</tr>
			</tbody>
		</table>
		</div>
		
		<h4><s:text name="offer.message.detail"/></h4>
		<div class="div-result">
		<table id="details" class="table table-striped table-hover table-list break-table">
			<thead>
				<tr>
					<th class="col-md-1"><s:text name="offer.field.seq" /></th>
					<th class="col-md-4"><s:text name="prod.field.name" /></th>
					<th class="col-md-1"><s:text name="offer.field.qty" /></th>
					<th class="col-md-1"><s:text name="prod.field.unit" /></th>
					<th class="col-md-2"><s:text name="prod.field.price" /></th>
					<th class="col-md-3"><s:text name="offer.field.detail_amt" /></th>
				</tr>
			</thead>
			<tbody>
<s:iterator value="form.details" var="detail" status="idx">
				<tr>
					<td data-title="<s:text name="offer.field.seq" />">${idx.count}</td>
					<td data-title="<s:text name="prod.field.name" />"><c:out value="${detail.prod.name}"/></td>
					<td data-title="<s:text name="offer.field.qty" />"><c:out value="${detail.qty}"/></td>
					<td data-title="<s:text name="prod.field.unit" />"><c:out value="${detail.prod.unit}"/></td>
					<td data-title="<s:text name="prod.field.price" />"><c:out value="${detail.amt / detail.qty}"/></td>
					<td data-title="<s:text name="offer.field.detail_amt" />"><c:out value="${detail.amt}"/></td>
				</tr>
</s:iterator>
			</tbody>
		</table>
		</div>
		
		<h4><s:text name="offer.message.footer"/></h4>
		<div class="div-result">
		<table id="footer" class="table table-striped table-hover table-list break-table">
			<tbody>
			<tr>
				<th class="col-md-1"><s:text name="offer.field.amt" /></th><td class="col-md-3"><c:out value="${form.amt}"/></td>
				<th class="col-md-1"><s:text name="offer.field.discount" /></th><td class="col-md-3"><c:out value="${form.discount}"/></td>
				<th class="col-md-1"><s:text name="offer.field.total" /></th><td class="col-md-3"><c:out value="${form.total}"/></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="offer.field.memo" /></th><td class="col-md-11" colspan="5"><c:out value="${form.memo}"/></td>
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
function printOffer() {
	var printWin = openWindow('/fb2/offer.sheet?id=' + $(".master_id").text(), 'printOffer', 793, 529);
}

$(function () {
	if ($('.master_id').text() !== '') {
		$('.print').removeAttr('disabled');
		$('.edit').removeAttr('disabled');
		$('.remove').removeAttr('disabled');
	}
	
	//$(".print").on("click", printOffer());
});
</script>

<%@ include file="/commons/jsp/footer.jsp"%>
