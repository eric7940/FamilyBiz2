<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<div class="tab-content">

<s:form method="post" namespace="/so" action="pickup!getPickupProds" theme="simple" cssClass="navbar-form">

	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-12 div-search">
				<div class="form-group form-input-line-magrin">
					<s:text name="pickup.message.query"/>
					<s:textfield name="form.pickupOfferDate" size="10" maxlength="10" cssClass="form-control DateText offer_date"/>
					<input type="button" value="<s:text name="pickup.action.query_custs"/>" class="btn btn-primary" onclick="queryCusts(event)"/>
				</div>
			</div>
		</div>
		<div class="row">
			<div id="custs" class="col-md-12 div-search">
			</div>
			<div class="col-md-12 div-search">
				<s:submit key="global.action.query" cssClass="btn btn-success query" type="button" onclick="return queryProds(event)" />
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="div-result">
		<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
			<thead>
				<tr>
					<th class="col-md-3"><s:text name="prod.field.name" /></th>
					<th class="col-md-1"><s:text name="prod.field.unit" /></th>
					<th class="col-md-2"><s:text name="offer.field.qty" /></th>
					<th class="col-md-5"><s:text name="pickup.field.details" /></th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty form.pickupProds}">
				<tr>
					<td colspan="4" class="text-center"><s:text name="global.message.noResults"/></td>
				</tr>
</c:if>
<s:iterator value="form.pickupProds" var="record" status="idx">
				<tr>
					<td data-title="<s:text name="prod.field.name"/>"><span class="form-control-static">${record.prodName}</span></td>
					<td data-title="<s:text name="prod.field.unit"/>"><span class="form-control-static">${record.unit}</span></td>
					<td data-title="<s:text name="offer.field.qty"/>"><span class="form-control-static">${record.sumQty}</span></td>
					<td data-title="<s:text name="pickup.field.details"/>">
					<table class="table table-hover table-break-all table-list break-table table-condensed">
					<thead>
						<tr>
							<th class="col-md-3"><s:text name="offer.field.master_id" /></th>
							<th class="col-md-6"><s:text name="cust.field.name" /></th>
							<th class="col-md-3"><s:text name="offer.field.qty" /></th>
						</tr>
					</thead>
<s:iterator value="#record.offers" var="offer" status="i">
					<tr>
						<td data-title="<s:text name="offer.field.master_id"/>"><span class="form-control-static">${offer.masterId}</span></td>
						<td data-title="<s:text name="cust.field.name"/>"><span class="form-control-static">${offer.custName}</span></td>
						<td data-title="<s:text name="offer.field.qty"/>"><span class="form-control-static">${offer.qty}</span></td>
					</tr>
</s:iterator>
					</table>
					</td>
				</tr>
</s:iterator>
			</tbody>
		</table>
		</div>

	</div>
	<!-- /content -->
</s:form>

</div>
</div>

<script type="text/javascript">

function queryCusts() {
	$.ajax({
	    type: "POST",
	    url: '<s:url action="pickup" namespace="/so" method="getPickupCusts"/>',
	    dataType: "json",
	    data: {a: $(".offer_date").val()},
	    success: function(json) {
	    		if (json["errCde"] == '00') {
	    			$('#custs').empty();
	    			if (json["result"].length == 0) {
    					var row = '<s:text name="global.message.noResults"/>';
    					$('#custs').append(row);
	    			} else {
	    				$('#custs').empty();
	    				$.each(json["result"], function(k,v) {
	    					var row = '<label class="checkbox-inline"><input type="checkbox" name="custs" value="' + v.id + '" checked> ' + v.name + '</label>';
	    					$('#custs').append(row);
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
}

var query = '${attr.query}';
$(function () {
	if (query === '') {
		$('.div-result').hide();
	}
});

</script>

<%@ include file="/commons/jsp/footer.jsp"%>
