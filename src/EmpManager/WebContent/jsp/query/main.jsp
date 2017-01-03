<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<ul class="nav nav-tabs">
	<li class="nav-item active"><a data-toggle="tab" href="#queryPrice" class="nav-link active"><s:text name="query.tab.price"/></a></li>
	<li class="nav-item"><a data-toggle="tab" href="#queryOffers" class="nav-link"><s:text name="query.tab.offers"/></a></li>
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
	<div id="unit" class="tab-pane fade">
		<h3><s:text name="config.tab.unit"/></h3>
		<s:form method="post" namespace="/admin" action="config!modifyUnits.do" theme="simple" cssClass="navbar-form">
			<div role="main" class="container-fluid">
			<div class="row">
				<div class="col-md-12 div-search text-right">
					<button title="" type="button" class="btn btn-success add show_tip" data-original-title='<s:text name="global.action.add"/>'><i class="fa fa-plus-square"></i></button>
					<s:submit key="global.action.save" cssClass="btn btn-primary" />
				</div>
			</div>

			<div class="div-result">
			<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table">
				<thead>
					<tr>
						<th class="col-md-2"><s:text name="global.action.remove"/></th>
						<th class="col-md-5"><s:text name="config.field.unit_code"/></th>
						<th class="col-md-5"><s:text name="config.field.unit_label"/></th>
					</tr>
					</thead>
					<tbody>
<s:iterator value="form.units" var="record" status="idx">
					<tr>
						<td data-title="<s:text name="global.action.remove" />"><button title="" type="button" class="btn btn-danger remove show_tip" data-original-title="<s:text name="global.action.remove"/>"><i class="fa fa-trash-o"></i></button></td>
						<td data-title="<s:text name="config.field.unit_code" />"><c:out value="${record.code}"/></td>
						<td data-title="<s:text name="config.field.unit_label" />"><input name="unit_label" value="${record.value}" type="text" maxlength="1" class="form-control form-control-fullwidth unit_label" /></td>
					</tr>
</s:iterator>					
					</tbody>
				</table>
			</div>
			</div>
		</s:form>
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
							'<td data-title="<s:text name="offer.field.master_id" />"><span class="form-control-static">' + v.prod_id + '</span></td>' + 
							'<td data-title="<s:text name="prod.field.name" />"><span class="form-control-static">' + v.prod_name + '</span></td>' + 
							'<td data-title="<s:text name="offer.field.id" />"><span class="form-control-static">' + v.offer_id + '</span></td>' + 
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
});

</script>

<%@ include file="/commons/jsp/footer.jsp"%>
