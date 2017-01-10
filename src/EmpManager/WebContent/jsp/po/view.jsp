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
				<s:submit key="global.action.query" cssClass="btn btn-success" />
				<input type="button" class="btn btn-warning" value='<s:text name="purchase.action.query"/>' data-toggle="modal" data-target="#queryModal" />
			</div>
			<div class="col-md-4 text-right">
				<button type="button" class="btn btn-danger remove" disabled="disabled" onclick="fnRemove(event,'<s:text name="purchase.message.confirm.remove"/>')"><s:text name="global.action.remove"/></button>
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

<div class="modal fade" id="queryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <s:form method="post" namespace="/po" action="main" theme="simple" cssClass="query_form">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="exampleModalLabel"><s:text name="purchase.modal.query.title"/></h4>
      </div>
      <div class="modal-body">
		<div class="row">
			<div class="col-md-8 div-search">
				<input type="text" placeholder='<s:text name="purchase.action.choose_fact"/>:<s:text name="fact.field.name"/>' class="form-control fact"/>
				<input type="hidden" name="queryFactId" id="queryFactId"/>
			</div>
			<div class="col-md-4">
				<input type="button" value="<s:text name="global.action.query"/>" disabled="true" class="btn btn-warning query"/>
			</div>
		</div>
  		<div style="overflow: auto;">
		<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table" style="table-layout: fixed;">
			<thead>
				<tr>
					<th><s:text name="purchase.field.master_id"/></th>
					<th><s:text name="purchase.field.purchase_date"/></th>
					<th><s:text name="purchase.field.total"/></th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		</div>
      </div>
      <div class="modal-footer">
        <s:submit key="global.action.submit" cssClass="btn btn-warning submit" type="button" disabled="true" />
        <button type="button" class="btn btn-default" data-dismiss="modal"><s:text name="global.action.cancel"/></button>
      </div>
      </s:form>
    </div>
  </div>
</div>

<script type="text/javascript">

var facts = [<s:iterator value="form.facts" var="fact" status="idx">{id:"<c:out value="${fact.id}"/>",name:"<c:out value="${fact.name}"/>"},</s:iterator>];

function printPurchase() {
	var printWin = openWindow('/fb2/purchase.sheet?id=' + $(".master_id").text(), 'printPurchase', 793, 529);
}

$(function () {
	if ($('.master_id').text() !== '') {
		$('.remove').removeAttr('disabled');
	}

	$('#queryModal').find('table#queryResult').on("click", "tr", function (e) {
		if (e.target.type !== 'radio') {
			$(':radio', this).trigger('click');
		}
	});
	$('#queryModal').on('show.bs.modal', function (event) {
		$('#queryModal').find('.fact').val('');
		$('#queryModal').find('#queryFactId').val('');
		$('#queryModal').find('table#queryResult tbody').empty();
		$('#queryModal').find('.query').attr('disabled','disabled');
		$('#queryModal').find('.submit').attr('disabled','disabled');
	});
	$("#queryModal").on('keydown.autocomplete', '.fact', function() {
		$(this).autocomplete({
			minLength: 1,
			appendTo: ".query_form",
			source: function(request, response) {
				response($.map(facts, function(v,i){
					if (v.id === request.term || v.name.indexOf(request.term.toUpperCase()) >= 0) {
						return {
							label: v.name,
							value: v.id
						}
					};
				}));
			},
			focus: function( event, ui ) {
				return false;
			},
			select: function( event, ui ) {
				$(this).val( ui.item.label );
				$('#queryFactId').val(ui.item.value);
				$('.query').removeAttr('disabled');
				return false;
			}
		});
	});
	$('#queryModal').on('click', '.query', function() {
		if ($('#queryModal').find('#queryFactId').val() == '') {
			alert('<s:text name="purchase.message.required.fact"/>');
			return;
		}
		$.ajax({
		    type: "POST",
		    url: '<s:url action="main" namespace="/po" method="getPurchaseList"/>',
		    dataType: "json",
		    data: {a: $('#queryModal').find('#queryFactId').val()},
		    success: function(json) {
		    		if (json["errCde"] == '00') {
					var result = json["result"];
					$('#queryModal').find('table#queryResult tbody').empty();
					if (result.length == 0) {
						var row = '<tr><td colspan="3" class="text-center"><s:text name="purchase.message.result.empty"/></td></tr>';
						$('#queryModal').find('table#queryResult tbody').append(row);
					} else {
						$.each(result, function(i,v) {
							var dd = new Date();
							dd.setTime(v.purchaseDate.time);
							
							var row = '<tr>' +
								'<td><input type="radio" name="form.keyword" value="' + v.id + '"/> ' + v.id + '</td>' +
								'<td>' + $.datepicker.formatDate('yy-mm-dd', dd) + '</td>' +
								'<td>' + v.total + '</td></tr>';
							$('#queryModal').find('table#queryResult tbody').append(row);
						});
					}
				} else {
					alert(json["errMsg"]);
				} 
		    },
		    error: function (xhr, textStatus, errorThrown) {
		    		alert(xhr.responseText);
		    }
		});
	});
	$('#queryModal').on('click', 'input:radio', function() {
		$('#queryModal').find('.submit').removeAttr('disabled');
	});

});
</script>

<%@ include file="/commons/jsp/footer.jsp"%>
