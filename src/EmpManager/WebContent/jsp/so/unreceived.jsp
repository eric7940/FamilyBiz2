<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<div class="tab-content">

<s:form method="post" namespace="/so" action="unreceived" theme="simple" cssClass="navbar-form">

	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-12 div-search">
				<div class="form-group form-input-line-magrin">
					<s:text name="unreceived.message.required.period"/>
					<s:textfield name="form.unreceivedStartDate" size="10" maxlength="10" cssClass="form-control DateText start_date"/> ～
					<s:textfield name="form.unreceivedEndDate" size="10" maxlength="10" cssClass="form-control DateText end_date"/>
				</div>
			</div>
			<div class="col-sm-7 div-search">
				<div class="form-group form-input-line-magrin">
					<s:text name="cust.field.name"/>
					<s:textfield name="form.unreceivedQueryCust" cssClass="form-control cust" placeholder='%{getText("global.message.keywordSearch")}'/>
					<s:hidden name="form.unreceivedQueryCustId" id="custId"/>
				</div>
			</div>
			<div class="col-sm-5 text-right">
				<s:submit key="global.action.query" cssClass="btn btn-primary" onclick="return query(event)"/>
				<s:submit key="unreceived.action.print" cssClass="btn btn-primary" type="button" onclick="printUnreceived()" />
				<input type="button" value="<s:text name="global.action.reset"/>" class="btn btn-primary" onclick="init()"/>
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="div-result">
		<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
			<thead>
				<tr>
					<th class="col-md-1"><s:text name="offer.field.seq" /></th>
					<th class="col-md-2"><s:text name="offer.field.offer_date" /></th>
					<th class="col-md-4"><s:text name="cust.field.name" /></th>
					<th class="col-md-2"><s:text name="offer.field.master_id" /></th>
					<th class="col-md-1"><s:text name="offer.field.total" /></th>
					<th class="col-md-1"><s:text name="offer.field.receive_amt" /></th>
					<th class="col-md-1"><s:text name="offer.field.cost" /></th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty form.unreceivedOffers}">
				<tr>
					<td colspan="6" class="text-center"><s:text name="global.message.noResults"/></td>
				</tr>
</c:if>
<s:iterator value="form.unreceivedOffers" var="record" status="idx">
<s:url action="main" namespace="/so" var="mainURL"><s:param name="form.keyword">${record.id}</s:param></s:url>
				<tr>
					<td data-title="<s:text name="offer.field.seq"/>"><span class="form-control-static detail_seq">${idx.count}</span></td>
					<td data-title="<s:text name="offer.field.offer_date"/>"><span class="form-control-static detail_date"><fmt:formatDate value="${record.offerDate}" pattern="yyyy-MM-dd"/></span></td>
					<td data-title="<s:text name="cust.field.name"/>"><span class="form-control-static detail_cust"><c:out value="${record.cust.name}"/></span></td>
					<td data-title="<s:text name="offer.field.master_id"/>"><span class="form-control-static detail_id"><c:out value="${record.id}"/> <a href="<s:property value="#mainURL" />" role="button" class="btn btn-warning show_tip" data-original-title="<s:text name="offer.message.detail"/>" ><i class="fa fa-external-link"></i></a></span></td>
					<td data-title="<s:text name="offer.field.total"/>" class="text-right"><span class="form-control-static detail_total"><c:out value="${record.total}"/></span></td>
					<td data-title="<s:text name="offer.field.receive_amt"/>" class="text-right"><span class="form-control-static text-right detail_received"><c:out value="${record.receiveAmt}"/></span></td>
					<td data-title="<s:text name="offer.field.cost"/>" class="text-right"><span class="form-control-static detail_cost"><c:out value="${record.cost}"/></span></td>
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

var custs = [<s:iterator value="form.custs" var="cust" status="idx">{id:"<c:out value="${cust.id}"/>",name:"<c:out value="${cust.name}"/>"},</s:iterator>];

function getDate1() {
	var date = new Date();
	var year = new String(date.getFullYear());
	var month = new String(date.getMonth() + 1);
	var day = new String(date.getDate());
	if(month.length < 2){
		month = "0" + month;
	}
	if(day.length < 2){
		day = "0" + day;
	}
	var date1 = year + "-" + month + "-01";
	var date2 = year + "-" + month + "-" + day;
	return [date1, date2];
}

function init() {
	var d = getDate1();
	$('.start_date').val(d[0]);
	$('.end_date').val(d[1]);
	
	$('.cust').val('');
	$('#custId').val('');
	
}
function query(event) {
	if ($('.start_date').val() == '') {
		alert('<s:text name="unreceived.message.required.period"/>');
		$('.start_date').focus();
		return false;
	}
	if ($('.end_date').val() == '') {
		alert('<s:text name="unreceived.message.required.period"/>');
		$('.end_date').focus();
		return false;
	}
	if ($('.cust').val() == '')
		$('#custId').val('');
}

function printUnreceived() {
	var id = "";
	var before = "";
	$('table#queryResult tbody tr').each(function(i,e) {
		var masterId = $(this).find('.detail_id').text();
		id += "," + masterId;
	});

	var printWin = openWindow('/fb2/unreceived.sheet?id=' + id + '&before=' + before, 'printUnReceived', 793, 529);
}

$(function () {
	var d = getDate1();
	if ($('.start_date').val() == '')
		$('.start_date').val(d[0]);
	if ($('.end_date').val() == '')
		$('.end_date').val(d[1]);
	
	var total = 0;
	var rec = 0;
	var cost = 0;
	$('table#queryResult tbody tr').each(function(i,e) {
		var t = $(this).find('.detail_total').text();
		var r = $(this).find('.detail_received').text();
		var c = $(this).find('.detail_cost').text();
		$(this).find('.detail_total').text(parseFloat(t).toFixed(2));
		$(this).find('.detail_received').text(parseFloat(r).toFixed(2));
		$(this).find('.detail_cost').text(parseFloat(c).toFixed(2));
		
		total += parseFloat(t);
		rec += parseFloat(r);
		cost += parseFloat(c);
	});
	
	var profit = total - cost;
	var row1 = '<tr>' + 
		'<td>&nbsp;</td>' + 
		'<td>&nbsp;</td>' + 
		'<td>&nbsp;</td>' + 
		'<td><h4 class="text-primary"><s:text name="unreceived.field.total"/></h4></td>' + 
		'<td class="text-right"><h4 class="text-primary">' + parseFloat(total).toFixed(2) + '</h4></td>' + 
		'<td class="text-right"><h4 class="text-primary">' + parseFloat(rec).toFixed(2) + '</h4></td>' + 
		'<td class="text-right"><h4 class="text-primary">' + parseFloat(cost).toFixed(2) + '</h4></td></tr>';

	var row2 = '<tr>' + 
		'<td>&nbsp;</td>' + 
		'<td>&nbsp;</td>' + 
		'<td>&nbsp;</td>' + 
		'<td>' + ((profit > 0)? '<h4 class="text-success"><s:text name="unreceived.field.profile"/></h4>': '<h4 class="text-danger"><s:text name="unreceived.field.loss"/></h4>') + '</td>' + 
		'<td>&nbsp;</td>' + 
		'<td>&nbsp;</td>' + 
		'<td class="text-right">' + ((profit > 0)? '<h4 class="text-success">+': '<h4 class="text-danger">-') + profit.toFixed(2) + '</h4></td></tr>';
	$('table#queryResult tbody').append(row1);
	$('table#queryResult tbody').append(row2);

	$(".cust").on('keydown.autocomplete', function() {
		$(this).autocomplete({
			minLength: 2,
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
				$('#custId').val(ui.item.value);
				return false;
			}
		});
	});
	
});

</script>

<%@ include file="/commons/jsp/footer.jsp"%>
