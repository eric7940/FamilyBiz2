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
				<s:if test="%{form.custId == null}">
					<input type="text" placeholder='<s:text name="offer.action.choose_cust"/>:<s:text name="cust.field.name"/>' class="form-control cust"/>
				</s:if>
					<s:hidden name="form.custId" id="custId"/>
				</div>
				<div class="form-group form-input-line-magrin">
					<s:select name="form.deliveryUserId" list="form.deliveryUsers" headerKey="0" headerValue="%{getText('global.option.one')}" listKey="id" listValue="name" cssClass="form-control delivery_user"/>
				</div>
				
			</div>
			<div class="col-md-4 text-right">
				<s:submit key="global.action.save" cssClass="btn btn-success save" type="button" disabled="true" onclick="return save(event)" />
			</div>
		</div>

		<!-- 查詢結果 -->
		<h4><s:text name="offer.message.master"/></h4>
		<div class="div-result">
		<table id="master" class="table table-striped table-hover table-list break-table">
			<tbody>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.name" /></th><td class="col-md-3 cust_name"><c:out value="${form.cust.name}"/></td>
				<th class="col-md-1"><s:text name="offer.field.cust_id" /></th><td class="col-md-3 cust_id"><c:out value="${form.custId}"/></td>
				<th class="col-md-1"><s:text name="offer.field.offer_date" /></th><td class="col-md-3"><s:textfield name="form.offerDate" theme="simple" size="10" maxlength="10" cssClass="form-control DateText offer_date"/></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.biz_no" /></th><td class="col-md-3 biz_no"><c:out value="${form.cust.bizNo}"/></td>
				<th class="col-md-1"><s:text name="cust.field.tel" /></th><td class="col-md-7 tel" colspan="3"><c:out value="${form.cust.tel}"/></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.deliver_addr" /></th><td class="col-md-7 deliver_addr" colspan="3"><c:out value="${form.cust.deliverAddr}"/></td>
				<th class="col-md-1"><s:text name="offer.field.master_id" /></th><td class="col-md-3"><c:out value="${form.masterId}"/></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.memo" /></th><td class="col-md-7 cust_memo" colspan="3"><c:out value="${form.cust.memo}"/></td>
				<th class="col-md-1"><s:text name="offer.field.invoice_nbr" /></th><td class="col-md-3"><s:textfield name="form.invoiceNbr" size="10" maxlength="10" maxcssClass="form-control form-control-fullwidth invoice_nbr"/></td>
			</tr>
			</tbody>
		</table>
		</div>

		<div class="row" style="margin-top:20px;">
			<div class="col-xs-6"><h4><s:text name="offer.message.detail"/></h4></div>
			<div class="col-xs-6 text-right"><button title="" type="button" class="btn btn-success add show_tip" disabled="disabled" data-original-title='<s:text name="global.action.add"/>'><i class="fa fa-plus-square"></i></button></div>
		</div>
		
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
					<td data-title="<s:text name="offer.field.seq" />"><span class="form-control-static detail_seq">${idx.count}</span> <button title="" type="button" class="btn btn-danger remove show_tip" data-original-title="<s:text name="global.action.remove"/>"><i class="fa fa-trash-o"></i></button></td>
					<td data-title="<s:text name="prod.field.name"/>"><input name="prodId" type="hidden" class="detail_prodId" value="<c:out value='${detail.prodId}'/>"/><input name="prod" type="text" value="<c:out value='${detail.prod.name}'/>" class="form-control form-control-fullwidth detail_prod" /></td>
					<td data-title="<s:text name="offer.field.qty" />"><input name="qty" type="text" value="<c:out value='${detail.qty}'/>"  class="form-control form-control-fullwidth detail_qty" maxlength="6"/></td>
					<td data-title="<s:text name="prod.field.unit"/>"><p class="form-control-static detail_unit"><c:out value="${detail.prod.unit}"/></p></td>
					<td data-title="<s:text name="prod.field.price"/>"><input name="price" type="text" value="<c:out value='${detail.amt / detail.qty}'/>" class="form-control form-control-fullwidth detail_price" maxlength="6"/><input type="hidden" class="detail_price_orig" value="<c:out value='${detail.amt / detail.qty}'/>"/><input type="hidden" name="cost" class="detail_cost" value="<c:out value='${detail.prod.cost}'/>"/></td>
					<td data-title="<s:text name="offer.field.detail_amt"/>"><p class="form-control-static detail_amt"><c:out value="${detail.amt}"/></p></td>
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
				<th class="col-md-1"><s:text name="offer.field.total" /></th><td class="col-md-3 amt"></td>
				<th class="col-md-1"><s:text name="offer.field.discount" /></th><td class="col-md-3"><s:textfield name="form.discount" value="0.00" cssClass="form-control form-control-fullwidth discount"/></td>
				<th class="col-md-1"><s:text name="offer.field.amt" /></th><td class="col-md-3 total"></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="offer.field.memo" /></th><td class="col-md-11" colspan="5">
					<s:textfield name="form.memo" cssClass="form-control form-control-fullwidth memo"/>
				</td>
			</tr>
			</tbody>
		</table>
		</div>

	</div>
	<!-- /content -->
</s:form>

</div>
</div>

<script>
var modify = '${modify}';

var custs = [<s:iterator value="form.custs" var="cust" status="idx">
{id:"<c:out value="${cust.id}"/>",name:"<c:out value="${cust.name}"/>",biz_no:"<c:out value="${cust.bizNo}"/>",tel:"<c:out value="${cust.tel}"/>",addr:"<c:out value="${cust.deliverAddr}"/>",memo:"<c:out value="${cust.memo}"/>"},
</s:iterator>];

function addDetailRow() {
	var empty = $('.detail_prodId').filter(function() { return $(this).val() == ""; });
	if (empty.length > 0) return;
	
	var len = $('table#details tbody tr').length;
	var row = '<tr>' + 
			'<td data-title="<s:text name="offer.field.seq" />"><span class="form-control-static detail_seq">' + (len + 1) + '</span> <button title="" type="button" class="btn btn-danger remove show_tip" data-original-title="<s:text name="global.action.remove"/>"><i class="fa fa-trash-o"></i></button></td>' + 
			'<td data-title="<s:text name="prod.field.name"/>"><input name="prodId" type="hidden" class="detail_prodId"/><input name="prod" type="text" class="form-control form-control-fullwidth detail_prod" /></td>' + 
			'<td data-title="<s:text name="offer.field.qty" />"><input name="qty" type="text" value="1" class="form-control form-control-fullwidth detail_qty" maxlength="6"/></td>' + 
			'<td data-title="<s:text name="prod.field.unit"/>"><p class="form-control-static detail_unit"></p></td>' + 
			'<td data-title="<s:text name="prod.field.price"/>"><input name="price" type="text" value="" class="form-control form-control-fullwidth detail_price" maxlength="6"/><input type="hidden" class="detail_price_orig"/><input type="hidden" name="cost" class="detail_cost"/></td>' + 
			'<td data-title="<s:text name="offer.field.detail_amt"/>"><p class="form-control-static detail_amt"></p></td>';
	row += '</tr>';
	$('table#details tbody').append(row);
}

function computePrice() {
	var amt = 0;
	$('table#details tbody tr').each(function(i,e) {
		var detailAmt = $(this).find('.detail_amt').text();
		if (detailAmt != '' && isDecimal(detailAmt)) {
			detailAmt = parseFloat(detailAmt);
		} else {
			detailAmt = 0;
		}
		amt += detailAmt;
	});
	
	$('.amt').text(parseFloat(amt).toFixed(2));

	var discount = $('.discount').val();
	if (discount != '' && isDecimal(discount)) {
		discount = parseFloat(discount);
	} else {
		discount = 0;
		$('.discount').val(discount.toFixed(2));
	}
	
	var total = amt - discount;
	$('.total').text(parseFloat(total).toFixed(2)); 
}

function save(event) {
	if ($('.delivery_user').val() == '0') {
		alert('<s:text name="offer.message.required.delivery_user"/>');
		$("#deliveryUserId").focus();
		return false;
	}
	if ($("#custId").val() == '') {
		alert('<s:text name="offer.message.required.cust"/>');
		$(".cust").focus();
		return false;
	}
	
	var count = 0;
	var error = false;
	$('table#details tbody tr').each(function(i,e) {
		if ($(this).find('.detail_prodId').val() == '') return; // 等於continue
		
		var price = $(this).find('.detail_price').val();
		var cost = $(this).find('.detail_cost').val();
		
		if (price == '' || !isDecimal(price) || parseFloat(price) < 0) {
			alert('<s:text name="offer.message.required.number"/>');
			error = true;
			return false; // 等於break
		}
				
		if (parseFloat(price) < parseFloat(cost)) {
			alert('<s:text name="offer.message.lost_money"/>: ' + cost);
			error = true;
			return false; // 等於break
		}
		count++;
	});
	if (error) {
		return false;
	}
	
	if (count <= 0) {
		alert('<s:text name="offer.message.required.detail"/>');
		$('table#details tbody tr:first').find('.detail_prod').focus();
		return false;
	}
	
	computePrice();

	if (!confirm('<s:text name="offer.message.confirm.add"/>'))
		return false;
	
	if (modify === 'y')
		fnModify(event);
	else
		fnAdd(event);
}

$(function () {
	if (modify === 'y') {
		$('.add').removeAttr('disabled');
		$('.save').removeAttr('disabled');
	}
	
	$(".add").on("click", addDetailRow);
	
	$(".cust").on('keydown.autocomplete', function() {
		$(this).autocomplete({
			minLength: 2,
			source: function(request, response) {
				response($.map(custs, function(v,i){
					if (v.id === request.term || v.name.indexOf(request.term.toUpperCase()) >= 0) {
						return {
							label: v.name,
							value: v.id,
							addr: v.addr,
							biz_no: v.biz_no,
							tel: v.tel,
							memo: v.memo
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
				$('#custId').val(ui.item.value);
				$('.cust_name').text(ui.item.label);
				$('.cust_id').text(ui.item.value);
				$('.biz_no').text(ui.item.biz_no);
				$('.deliver_addr').text(ui.item.addr);
				$('.tel').text(ui.item.tel);
				$('.cust_memo').text(ui.item.memo);

				var d = new Date();
				var month = d.getMonth() + 1;
				var day = d.getDate();
				var today = d.getFullYear() + '-' + (month < 10 ? '0' : '') + month + '-' + (day < 10 ? '0' : '') + day;
				$(".offer_date").val(today);
				
				$('.add').removeAttr('disabled');
				$('.save').removeAttr('disabled');
				addDetailRow();
				
				return false;
			}
		});
	});
	
	$('table#details').on('keydown.autocomplete', '.detail_prod', function() {
		$(this).autocomplete({
			minLength: 2,
			source: function(request, response) {
				$.ajax({
				    type: "POST",
				    url: '<s:url action="main" namespace="/so" method="getProdList"/>',
				    dataType: "json",
				    data: {a: $('#custId').val(), b: request.term},
				    success: function(json) {
				    		if (json["errCde"] == '00') {
							response($.map(json["result"], function(v,i){
								return {
									label: v.prod.name + '(<s:text name="prod.field.unit"/>:' + v.prod.unit + ')',
									value: v.prod.id,
									unit: v.prod.unit,
									cost: v.prod.cost,
									price: v.amt
								};
							}));
						} else {
							alert(json["errMsg"]);
						} 
				    },
				    error: function (xhr, textStatus, errorThrown) {
				    		alert(xhr.responseText);
				    }
				});
			},
			focus: function( event, ui ) {
				$(this).val( ui.item.label );
				return false;
			},
			select: function( event, ui ) {
				var qty = 1;
				$(this).val( ui.item.label );
				$(this).closest('tr').find('.detail_prodId').val(ui.item.value);
				$(this).closest('tr').find('.detail_qty').val(qty);
				$(this).closest('tr').find('.detail_unit').text(ui.item.unit);
				$(this).closest('tr').find('.detail_cost').val(ui.item.cost);
				$(this).closest('tr').find('.detail_price').val(ui.item.price);
				$(this).closest('tr').find('.detail_price_orig').val(ui.item.price);
				$(this).closest('tr').find('.detail_amt').text(qty * ui.item.price);

				addDetailRow();
				computePrice();
				
				return false;
			}
		});
	});
	
	$('table#details').on('blur', '.detail_prod', function() {
		if($(this).val() == '') {
			$(this).closest('tr').find('.detail_prodId').val('');
			$(this).closest('tr').find('.detail_qty').val(1);
			$(this).closest('tr').find('.detail_unit').text('');
			$(this).closest('tr').find('.detail_cost').val('');
			$(this).closest('tr').find('.detail_price').val('');
			$(this).closest('tr').find('.detail_price_orig').val('');
			$(this).closest('tr').find('.detail_amt').text('');
			computePrice();
		}
	});
	
	$('table#details').on('blur', '.detail_qty, .detail_price', function() {
		var qty = $(this).closest('tr').find('.detail_qty').val();
		var price = $(this).closest('tr').find('.detail_price').val();
		var price_orig = $(this).closest('tr').find('.detail_price_orig').val();
		var cost = $(this).closest('tr').find('.detail_cost').val();
		
		if (qty == '' || price == '') {
			$(this).closest('tr').find('.detail_amt').text('');
		} else {
			if (!isDecimal(price) || parseFloat(price) < 0) {
				alert('<s:text name="offer.message.required.number"/>');
				$(this).closest('tr').find('.detail_price').val(price_orig);
				return;
			}
			if (!isDecimal(qty)) {
				alert('<s:text name="offer.message.required.integer"/>');
				$(this).closest('tr').find('.detail_qty').val(1);
				return;
			}
			
			// TODO: BUG if price is 0 on qty blur
			if (parseFloat(price) > 0 && parseFloat(price) < parseFloat(cost)) {
				alert('<s:text name="offer.message.lost_money"/>: ' + cost);
			}
			
			qty = parseFloat(qty);
			price = parseFloat(price);
			
			$(this).closest('tr').find('.detail_price').val(price.toFixed(2));
			$(this).closest('tr').find('.detail_amt').text(parseFloat(price * qty).toFixed(2));
		}

		computePrice();
	});
});


</script>
<%@ include file="/commons/jsp/footer.jsp"%>
