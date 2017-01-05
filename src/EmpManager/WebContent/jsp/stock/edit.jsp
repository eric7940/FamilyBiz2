<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<s:url action="qty" namespace="/stock" var="mainURL"></s:url>

<div class="container-fluid">	
<div class="tab-content">

<s:form method="post" namespace="/stock" action="qty" theme="simple" cssClass="navbar-form">
<s:hidden name="form.stockId" id="stockId"/>
	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-8 div-search">
			</div>
			<div class="col-md-4 text-right">
				<s:submit key="global.action.save" cssClass="btn btn-primary save" onclick="return save(event)" />
				<a href="<s:property value="#mainURL" />" role="button" class="btn btn-default"><s:text name="global.action.cancel" /></a>
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="row" style="margin-top:20px;">
			<div class="col-xs-6"><h4><s:text name="stock.message.detail"/></h4></div>
			<div class="col-xs-6 text-right"><button title="" type="button" class="btn btn-success add show_tip" data-original-title='<s:text name="global.action.add"/>'><i class="fa fa-plus-square"></i></button></div>
		</div>
		
		<div class="div-result">
		<table id="details" class="table table-striped table-hover table-list break-table">
			<thead>
				<tr>
					<th class="col-md-1"><s:text name="stock.field.seq" /></th>
					<th class="col-md-4"><s:text name="prod.field.name" /></th>
					<th class="col-md-2"><s:text name="stock.field.qty1" /></th>
					<th class="col-md-1"><s:text name="prod.field.unit" /></th>
					<th class="col-md-2"><s:text name="stock.field.adjust" /></th>
					<th class="col-md-2"><s:text name="stock.field.qty2" /></th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		</div>

	</div>
	<!-- /content -->
</s:form>

</div>
</div>

<script type="text/javascript">
function resetDetailNum() {
	$('table#details tbody tr').each(function(i,e) {
		$(this).find('.detail_seq').text((i + 1));
	});
}

function addDetailRow() {
	var empty = $('.detail_prodId').filter(function() { return $(this).val() == ""; });
	if (empty.length > 0) return;
	
	var len = $('table#details tbody tr').length;
	var row = '<tr>' + 
			'<td data-title="<s:text name="stock.field.seq" />"><span class="form-control-static detail_seq">' + (len + 1) + '</span> <button title="" type="button" class="btn btn-danger remove show_tip" data-original-title="<s:text name="global.action.remove"/>"><i class="fa fa-trash-o"></i></button></td>' + 
			'<td data-title="<s:text name="prod.field.name"/>"><input name="prodId" type="hidden" class="detail_prodId"/><input name="prod" type="text" class="form-control form-control-fullwidth detail_prod" /></td>' + 
			'<td data-title="<s:text name="stock.field.qty1" />"><p class="form-control-static detail_qty1"></p></td>' + 
			'<td data-title="<s:text name="prod.field.unit"/>"><p class="form-control-static detail_unit"></p></td>' + 
			'<td data-title="<s:text name="stock.field.adjust"/>"><input name="adjust" type="text" value="" class="form-control form-control-fullwidth detail_adjust" maxlength="6" onkeyup="convertNum(this)"/></td>' + 
			'<td data-title="<s:text name="stock.field.qty2"/>"><p class="form-control-static detail_qty2"></p></td>';
	row += '</tr>';
	$('table#details tbody').append(row);
}

function save(event) {
	if ($("#stockId").val() == '') {
		alert('<s:text name="stock.message.required.stock"/>');
		return false;
	}
	
	var count = 0;
	var error = false;
	$('table#details tbody tr').each(function(i,e) {
		if ($(this).find('.detail_prodId').val() == '') return; // 等於continue

		var adjust = $(this).find('.detail_adjust').val();
		var qty = $(this).find('.detail_qty').text();

		adjust = parseFloat(adjust);
		qty = parseFloat(qty);
		var result = adjust + qty;
		if (result < 0) {
			alert('<s:text name="stock.message.adjust"/>: ' + result);
			error = true;
			return false; // 等於break
		}
		count++;
	});
	if (error) {
		return false;
	}
	
	if (count <= 0) {
		alert('<s:text name="stock.message.required.detail"/>');
		$('table#details tbody tr:first').find('.detail_prod').focus();
		return false;
	}
	
	var oForm = getSelfForm(event,'adjust');	
	oForm.submit();

}

$(function () {
	addDetailRow();
	
	$(".add").on("click", addDetailRow);
	
	$("table#details").on("click", ".remove", function () {
		$(this).closest('tr').remove();
		resetDetailNum();
	});
	
	$('table#details').on('keydown.autocomplete', '.detail_prod', function() {
		$(this).autocomplete({
			minLength: 1,
			source: function(request, response) {
				$.ajax({
				    type: "POST",
				    url: '<s:url action="qty" namespace="/stock" method="getProdList"/>',
				    dataType: "json",
				    data: {a: $('#stockId').val(), b: request.term},
				    success: function(json) {
				    		if (json["errCde"] == '00') {
							response($.map(json["result"], function(v,i){
								return {
									label: v.prod.name,
									value: v.prod.id,
									unit: v.prod.unit,
									qty: v.qty
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
				$(this).val( ui.item.label );
				$(this).closest('tr').find('.detail_prodId').val(ui.item.value);
				$(this).closest('tr').find('.detail_qty1').text(ui.item.qty);
				$(this).closest('tr').find('.detail_unit').text(ui.item.unit);
				$(this).closest('tr').find('.detail_adjust').val(0);
				$(this).closest('tr').find('.detail_qty2').text(ui.item.qty);
				addDetailRow();
				
				return false;
			}
		});
	});
	
	$('table#details').on('blur', '.detail_prod', function() {
		if($(this).val() == '') {
			$(this).closest('tr').find('.detail_prodId').val('');
			$(this).closest('tr').find('.detail_qty1').text('');
			$(this).closest('tr').find('.detail_unit').text('');
			$(this).closest('tr').find('.detail_adjust').val('');
			$(this).closest('tr').find('.detail_qty2').text('');
		}
	});
	
	$('table#details').on('blur', '.detail_adjust', function() {
		var adjust = $(this).val();
		var qty = $(this).closest('tr').find('.detail_qty1').text();
		
		if (adjust == '') {
			$(this).closest('tr').find('.detail_qty2').text(qty);
		} else {
			if (!isDecimal(adjust)) {
				alert('<s:text name="stock.message.required.number"/>');
				obj.value = 0;
				return;
			}
			adjust = parseFloat(adjust);
			qty = parseFloat(qty);
			var result = adjust + qty;
			if (result < 0) {
				alert('<s:text name="stock.message.adjust"/>: ' + result);
				$(this).val(0);
				return;
			}

			$(this).closest('tr').find('.detail_qty2').text(result.toFixed(2));
		}
	});
});

</script>
<%@ include file="/commons/jsp/footer.jsp"%>
