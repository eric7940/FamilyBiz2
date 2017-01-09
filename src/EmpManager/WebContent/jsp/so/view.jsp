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
				<s:submit key="global.action.query" cssClass="btn btn-success" />
			</div>
			<div class="col-md-4 text-right">
<c:if test="${attr.editmode == 'y'}">
				<button type="button" class="btn btn-primary edit" disabled="disabled" onclick="fnInitModify(event,'${form.masterId}','form.keyword')"><s:text name="global.action.edit"/></button>
				<button type="button" class="btn btn-danger remove" disabled="disabled" onclick="fnRemove(event,'<s:text name="offer.message.confirm.remove"/>')"><s:text name="global.action.remove"/></button>
</c:if>
				<button type="button" class="btn btn-warning print" disabled="disabled" onclick="printOffer()"><s:text name="offer.action.print"/></button>
				<input type="button" class="btn btn-warning saveas" disabled="disabled" value='<s:text name="offer.action.saveas"/>' data-toggle="modal" data-target="#saveasModal" />
			</div>
		</div>

		<!-- 查詢結果 -->
		<h4><s:text name="offer.message.master"/></h4>
		<div class="div-result">
		<table id="master" class="table table-striped table-hover table-list break-table">
			<tbody>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.name" /></th><td class="col-md-3"><c:out value="${form.cust.name}"/></td>
				<th class="col-md-1"><s:text name="offer.field.cust_id" /></th><td class="col-md-1"><c:out value="${form.cust.id}"/></td>
				<th class="col-md-1"><s:text name="offer.field.offer_date" /></th><td class="col-md-2"><c:out value="${form.offerDate}" /></td>
				<th class="col-md-1"><s:text name="offer.field.stock" /></th><td class="col-md-2"><c:out value="${form.stock.name}" /></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.biz_no" /></th><td class="col-md-5" colspan="3"><c:out value="${form.cust.bizNo}"/></td>
				<th class="col-md-1"><s:text name="cust.field.tel" /></th><td class="col-md-2"><c:out value="${form.cust.tel}"/></td>
				<th class="col-md-1"><s:text name="offer.field.invoice_nbr" /></th><td class="col-md-2"><c:out value="${form.invoiceNbr}"/></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.deliver_addr" /></th><td class="col-md-5" colspan="3"><c:out value="${form.cust.deliverAddr}"/></td>
				<th class="col-md-1"><s:text name="offer.field.master_id" /></th><td class="col-md-2 master_id"><c:out value="${form.masterId}"/></td>
				<th class="col-md-1"><s:text name="offer.field.delivery_user" /></th><td class="col-md-2"><c:out value="${form.deliveryUser.name}"/></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.memo" /></th><td class="col-md-7" colspan="5"><c:out value="${form.cust.memo}"/></td>
				
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

<div class="modal fade" id="saveasModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <s:form method="post" namespace="/so" action="main!saveas.do" theme="simple" cssClass="saveas_form">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="exampleModalLabel"><s:text name="offer.modal.saveas.title"/></h4>
      </div>
      <div class="modal-body">
			<input type="text" placeholder='<s:text name="offer.action.choose_cust"/>:<s:text name="cust.field.name"/>' class="form-control cust"/>
			<input type="hidden" name="saveasCustId" id="saveasCustId"/>
      </div>
      <div class="modal-footer">
        <s:submit key="offer.action.saveas" cssClass="btn btn-warning saveas" type="button" disabled="true" onclick="return saveasOffer(event)" />
        <button type="button" class="btn btn-default" data-dismiss="modal"><s:text name="global.action.cancel"/></button>
      </div>
      </s:form>
    </div>
  </div>
</div>

<script type="text/javascript">

var custs = [<s:iterator value="form.custs" var="cust" status="idx">{id:"<c:out value="${cust.id}"/>",name:"<c:out value="${cust.name}"/>"},</s:iterator>];

function printOffer() {
	var printWin = openWindow('/fb2/offer.sheet?id=' + $(".master_id").text(), 'printOffer', 793, 529);
}

function saveasOffer(event) {
	if ($("#saveasCustId").val() == '') {
		alert('<s:text name="offer.message.required.cust"/>');
		return false;
	}
	
	var oForm = getSelfForm(event, 'saveas');	
	oForm.submit();
}

$(function () {
	if ($('.master_id').text() !== '') {
		$('.print').removeAttr('disabled');
		$('.saveas').removeAttr('disabled');
		$('.edit').removeAttr('disabled');
		$('.remove').removeAttr('disabled');
	}
	
	$("#saveasModal").on('keydown.autocomplete', '.cust', function() {
		$(this).autocomplete({
			minLength: 1,
			appendTo: ".saveas_form",
			source: function(request, response) {
				response($.map(custs, function(v,i){
					if (v.id === request.term || v.name.indexOf(request.term.toUpperCase()) >= 0) {
						return {
							label: v.name,
							value: v.id
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
				$('#saveasCustId').val(ui.item.value);
				$('.saveas').removeAttr('disabled');
				return false;
			}
		});
	});
});
</script>

<%@ include file="/commons/jsp/footer.jsp"%>
