<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<ul class="nav nav-tabs">
	<li class="nav-item active"><a data-toggle="tab" href="#queryPrice" class="nav-link active"><s:text name="query.tab.price"/></a></li>
	<li class="nav-item"><a data-toggle="tab" href="#queryOffers" class="nav-link"><s:text name="query.tab.offers"/></a></li>
	<li class="nav-item"><a data-toggle="tab" href="#querySales" class="nav-link"><s:text name="query.tab.sales"/></a></li>
	<li class="nav-item"><a data-toggle="tab" href="#queryDelivery" class="nav-link"><s:text name="query.tab.delivery"/></a></li>
	<li class="nav-item"><a data-toggle="tab" href="#queryToday" class="nav-link"><s:text name="query.tab.today"/></a></li>
	<li class="nav-item"><a data-toggle="tab" href="#queryDiscount" class="nav-link"><s:text name="query.tab.discount"/></a></li>
</ul>

<div class="tab-content">
	<div id="queryPrice" class="tab-pane fade in active">
		<h3><s:text name="query.tab.price"/></h3>
		<form class="navbar-form">
			<div role="main" class="container-fluid">
				<div class="row">
					<div class="col-md-4 div-search">
						<div class="form-group">
							<label for="cust"><s:text name="cust.field.name"/></label>
							<input type="text" name="cust" class="form-control cust" placeholder='<s:text name="global.message.keywordSearch"/>' />
							<input type="hidden" id="custId"/>
						</div>
					</div>
					<div class="col-md-4 div-search">
						<div class="form-group">
							<label for="prod"><s:text name="prod.field.name"/></label>
							<input type="text" name="prod" class="form-control prod" placeholder='<s:text name="global.message.keywordSearch"/>'/>
							<input type="hidden" id="prodId"/>
						</div>
					</div>
					<div class="col-md-4 div-search text-right">
						<button type="button" class="btn btn-primary query"><s:text name="global.action.query"/></button>
						<button type="reset" class="btn btn-primary reset"><s:text name="global.action.reset"/></button>
					</div>
				</div>
				<div class="div-result">
				<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
					<thead>
						<tr>
							<th class="col-md-1"><s:text name="prod.field.id" /></th>
							<th class="col-md-3"><s:text name="prod.field.name" /></th>
							<th class="col-md-2"><s:text name="offer.field.master_id" /></th>
							<th class="col-md-2"><s:text name="offer.field.offer_date" /></th>
							<th class="col-md-4"><s:text name="prod.field.price" /></th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				</div>
			</div>
		</form>
	</div>
	<div id="queryOffers" class="tab-pane fade">
		<h3><s:text name="query.tab.offers"/></h3>
		<form class="navbar-form">
			<div role="main" class="container-fluid">
				<div class="row">
					<div class="col-md-4 div-search">
						<div class="form-group">
							<label for="cust"><s:text name="cust.field.name"/></label>
							<input type="text" name="cust" class="form-control cust" placeholder='<s:text name="global.message.keywordSearch"/>' />
							<input type="hidden" id="custId"/>
						</div>
					</div>
					<div class="col-md-4 div-search">
						<div class="form-group">
							<label for="prod"><s:text name="prod.field.name"/></label>
							<input type="text" name="prod" class="form-control prod" placeholder='<s:text name="global.message.keywordSearch"/>'/>
							<input type="hidden" id="prodId"/>
						</div>
					</div>
					<div class="col-md-4 div-search text-right">
						<button type="button" class="btn btn-primary query"><s:text name="global.action.query"/></button>
						<button type="reset" class="btn btn-primary reset"><s:text name="global.action.reset"/></button>
					</div>
				</div>
				<div class="div-result">
				<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
					<thead>
						<tr>
							<th class="col-md-2"><s:text name="offer.field.master_id" /></th>
							<th class="col-md-1"><s:text name="offer.field.offer_date" /></th>
							<th class="col-md-3"><s:text name="prod.field.name" /></th>
							<th class="col-md-1"><s:text name="prod.field.unit" /></th>
							<th class="col-md-1"><s:text name="offer.field.qty" /></th>
							<th class="col-md-2"><s:text name="prod.field.price" /></th>
							<th class="col-md-2"><s:text name="offer.field.detail_amt" /></th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				</div>
			</div>
		</form>
	</div>
	
	<div id="queryToday" class="tab-pane fade">
		<h3><s:text name="query.tab.today"/></h3>
		<form class="navbar-form">
			<div role="main" class="container-fluid">
				<div class="row">
					<div class="col-md-4 div-search">
						<div class="form-group">
							<label for="startDate"><s:text name="offer.field.offer_date"/></label>
							<input type="text" name="startDate" size="10" maxlength="10" class="form-control DateText start_date"/> ～
							<input type="text" name="endDate" size="10" maxlength="10" class="form-control DateText end_date"/>
						</div>
					</div>
					<div class="col-md-4 div-search">
						<div class="form-group">
							<label for="delivery_user"><s:text name="offer.field.delivery_user"/></label>
							<s:select name="form.deliveryUserId" list="form.deliveryUsers" headerKey="0" headerValue="%{getText('global.option.one',new java.lang.String[]{getText('offer.field.delivery_user')})}" listKey="id" listValue="name" cssClass="form-control delivery_user"/>
						</div>
					</div>
					<div class="col-md-4 div-search text-right">
						<button type="button" class="btn btn-primary query"><s:text name="global.action.query"/></button>
						<button type="reset" class="btn btn-primary reset"><s:text name="global.action.reset"/></button>
					</div>
				</div>
				<div class="div-result">
				<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
					<thead>
						<tr>
							<th class="col-md-1"><s:text name="prod.field.id" /></th>
							<th class="col-md-3"><s:text name="prod.field.name" /></th>
							<th class="col-md-2"><s:text name="offer.field.master_id" /></th>
							<th class="col-md-2"><s:text name="offer.field.offer_date" /></th>
							<th class="col-md-4"><s:text name="prod.field.price" /></th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				</div>
			</div>
		</form>
	</div>
</div>
</div>

<script type='text/javascript'>

var custs = [<s:iterator value="form.custs" var="cust" status="idx">{id:"<c:out value="${cust.id}"/>",name:"<c:out value="${cust.name}"/>"},</s:iterator>];

$(function () {
	$('#queryPrice').on('keydown.autocomplete', '.cust', function() {
		$(this).autocomplete({
			minLength: 1,
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
				$('#queryPrice').find('#custId').val(ui.item.value);
				return false;
			}
		});
	});

	$('#queryPrice').on('keydown.autocomplete', '.prod', function() {
		$(this).autocomplete({
			minLength: 1,
			source: function(request, response) {
				$.ajax({
				    type: "POST",
				    url: '<s:url action="main" namespace="/query" method="getProdList"/>',
				    dataType: "json",
				    data: {a: request.term},
				    success: function(json) {
				    		if (json["errCde"] == '00') {
							response($.map(json["result"], function(v,i){
								return {
									label: v.name + '(<s:text name="prod.field.unit"/>:' + v.unit + ')',
									value: v.id
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
				$('#queryPrice').find('#prodId').val(ui.item.value);
				return false;
			}
		});
	});
	$('#queryPrice').on('click', '.query', function() {
		$.ajax({
		    type: "POST",
		    url: '<s:url action="main" namespace="/query" method="queryPrice"/>',
		    dataType: "json",
		    data: {a: $('#queryPrice').find('#custId').val(), b: $('#queryPrice').find('#prodId').val()},
		    success: function(json) {
		    		if (json["errCde"] == '00') {
					var result = json["result"];
					$('#queryPrice').find('table#queryResult tbody').empty();
					$.each(result, function(i,v) {
						var row = '<tr>' + 
							'<td data-title="<s:text name="prod.field.id" />"><span class="form-control-static">' + v.prod_id + '</span></td>' + 
							'<td data-title="<s:text name="prod.field.name" />"><span class="form-control-static">' + v.prod_name + '</span></td>' + 
							'<td data-title="<s:text name="offer.field.master_id" />"><span class="form-control-static">' + v.offer_id + '</span></td>' + 
							'<td data-title="<s:text name="offer.field.offer_date" />"><span class="form-control-static">' + v.offer_date + '</span></td>' + 
							'<td data-title="<s:text name="prod.field.price" />"><span class="form-control-static">' + v.price + '</span></td>';
						row += '</tr>';
						$('#queryPrice').find('table#queryResult tbody').append(row);
					});
				} else {
					alert(json["errMsg"]);
				} 
		    },
		    error: function (xhr, textStatus, errorThrown) {
		    		alert(xhr.responseText);
		    }
		});
	});
	$('#queryPrice').on('reset', function() {
		$('#queryPrice').find('table#queryResult tbody').empty();
	});
	
	$('#queryOffers').on('keydown.autocomplete', '.cust', function() {
		$(this).autocomplete({
			minLength: 1,
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
				$('#queryOffers').find('#custId').val(ui.item.value);
				return false;
			}
		});
	});

	$('#queryOffers').on('keydown.autocomplete', '.prod', function() {
		$(this).autocomplete({
			minLength: 1,
			source: function(request, response) {
				$.ajax({
				    type: "POST",
				    url: '<s:url action="main" namespace="/query" method="getProdList"/>',
				    dataType: "json",
				    data: {a: request.term},
				    success: function(json) {
				    		if (json["errCde"] == '00') {
							response($.map(json["result"], function(v,i){
								return {
									label: v.name + '(<s:text name="prod.field.unit"/>:' + v.unit + ')',
									value: v.id
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
				$('#queryOffers').find('#prodId').val(ui.item.value);
				return false;
			}
		});
	});
	$('#queryOffers').on('click', '.query', function() {
		$.ajax({
		    type: "POST",
		    url: '<s:url action="main" namespace="/query" method="queryOffers"/>',
		    dataType: "json",
		    data: {a: $('#queryOffers').find('#custId').val(), b: $('#queryOffers').find('#prodId').val()},
		    success: function(json) {
		    		if (json["errCde"] == '00') {
					var result = json["result"];
					$('#queryOffers').find('table#queryResult tbody').empty();
					$.each(result, function(i,v) {
						var d = v.details[0];
						var dd = new Date();
						dd.setTime(v.offerDate.time);
						
						var row = '<tr>' + 
							'<td data-title="<s:text name="offer.field.master_id"/>"><span class="form-control-static">' + v.id + '</span></td>' + 
							'<td data-title="<s:text name="offer.field.offer_date"/>"><span class="form-control-static">' + $.datepicker.formatDate('yy-mm-dd', dd) + '</span></td>' + 
							'<td data-title="<s:text name="prod.field.name"/>"><span class="form-control-static">' + d.prod.name + '</span></td>' + 
							'<td data-title="<s:text name="prod.field.unit"/>"><span class="form-control-static">' + d.prod.unit + '</span></td>' + 
							'<td data-title="<s:text name="offer.field.qty"/>" class="text-right"><span class="form-control-static">' + parseFloat(d.qty).toFixed(2) + '</span></td>' + 
							'<td data-title="<s:text name="prod.field.price"/>" class="text-right"><span class="form-control-static">' + parseFloat(d.amt / d.qty).toFixed(2) + '</span></td>' + 
							'<td data-title="<s:text name="offer.field.detail_amt"/>" class="text-right"><span class="form-control-static">' + parseFloat(d.amt).toFixed(2) + '</span></td>';
						row += '</tr>';
						$('#queryOffers').find('table#queryResult tbody').append(row);
					});
				} else {
					alert(json["errMsg"]);
				} 
		    },
		    error: function (xhr, textStatus, errorThrown) {
		    		alert(xhr.responseText);
		    }
		});
	});
	$('#queryOffers').on('reset', function() {
		$('#queryOffers').find('table#queryResult tbody').empty();
	});
});

</script>

<%@ include file="/commons/jsp/footer.jsp"%>
