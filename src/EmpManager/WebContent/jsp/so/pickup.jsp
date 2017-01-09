<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<div class="tab-content">

<s:form method="post" namespace="/so" action="pickup!getPickupProds" theme="simple" cssClass="navbar-form">

	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-5 div-search">
				<div class="form-group form-input-line-magrin">
					<s:text name="pickup.message.query"/>
					<s:textfield name="form.pickupOfferDate" size="10" maxlength="10" cssClass="form-control DateText offer_date"/>
				</div>
			</div>
			<div class="col-md-7 div-search">
				<div class="form-group form-input-line-magrin">
					<input type="button" value="<s:text name="pickup.action.query_custs"/>" class="btn btn-success" onclick="queryCusts(event)"/>
					<s:submit key="global.action.query" cssClass="btn btn-primary query" type="button" disabled="true" onclick="return queryProds(event)" />
				</div>
			</div>
		</div>
		<div class="row">
			<div id="custs" class="col-md-12 div-search">
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="div-result">
		<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
			<thead>
				<tr>
					<th class="col-md-3"><s:text name="prod.field.name" /></th>
					<th class="col-md-1"><s:text name="prod.field.unit" /></th>
					<th class="col-md-1 text-right"><s:text name="offer.field.qty" /></th>
					<th class="col-md-7 text-center hidden-sm hidden-xs"><s:text name="pickup.field.details" /></th>
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
					<td data-title="<s:text name="offer.field.qty"/>" class="text-right"><span class="form-control-static">${record.sumQty}</span></td>
					<td class="hidden-sm hidden-xs" data-title="<s:text name="pickup.field.details"/>">
					<table class="table table-hover table-condensed"><tbody>
<s:iterator value="#record.offers" var="offer" status="i">
<s:url action="main" namespace="/so" var="mainURL"><s:param name="form.keyword">${offer.masterId}</s:param></s:url>
					<tr>
						<td class="col-md-3"><span class="form-control-static">${offer.masterId}</span> <a href="<s:property value="#mainURL" />" role="button" class="btn btn-warning show_tip" data-original-title="<s:text name="offer.message.detail"/>" ><i class="fa fa-external-link"></i></a></td>
						<td class="col-md-6"><span class="form-control-static">${offer.custName}</span></td>
						<td class="col-md-3"><span class="form-control-static">${offer.qty}</span></td>
					</tr>
</s:iterator>
					</tbody></table>
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
	    				$.each(json["result"], function(k,v) {
	    					var row = '<label class="checkbox-inline"><input type="checkbox" name="custs" value="' + v.id + '" checked> ' + v.name + '</label>';
	    					$('#custs').append(row);
	    				});
	    				$('.query').removeAttr('disabled');
	    			}
	    			$('.div-result').hide();
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
