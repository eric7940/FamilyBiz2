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
					<input type="text" placeholder='<s:text name="offer.action.choose_cust"/>:<s:text name="cust.field.name"/>' class="form-control cust"/>
					<s:hidden name="form.custId" id="custId"/>
				</div>
			</div>
			<div class="col-md-4 text-right">
				<s:submit key="global.action.save" cssClass="btn btn-success" type="button" onclick="fnAdd(event)" />
			</div>
		</div>

		<!-- 查詢結果 -->
		<div>
		<h4><s:text name="offer.message.master"/></h4>
		<table id="master" class="table table-striped table-hover table-list break-table">
			<tbody>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.name" /></th><td class="col-md-3 cust_name"></td>
				<th class="col-md-1"><s:text name="offer.field.cust_id" /></th><td class="col-md-3 cust_id"></td>
				<th class="col-md-1"><s:text name="offer.field.offer_date" /></th><td class="col-md-3 offer_date"></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.biz_no" /></th><td class="col-md-3 biz_no"></td>
				<th class="col-md-1"><s:text name="cust.field.tel" /></th><td class="col-md-7 tel" colspan="3"></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="cust.field.deliver_addr" /></th><td class="col-md-7 deliver_addr" colspan="3"></td>
				<th class="col-md-1"><s:text name="offer.field.master_id" /></th><td class="col-md-3">&nbsp;</td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="offer.field.total" /></th><td class="col-md-3 total"></td>
				<th class="col-md-1"><s:text name="offer.field.discount" /></th><td class="col-md-3">0.0</td>
				<th class="col-md-1"><s:text name="offer.field.amt" /></th><td class="col-md-3 amt"></td>
			</tr>
			<tr>
				<th class="col-md-1"><s:text name="offer.field.memo" /></th><td class="col-md-11 memo" colspan="5"></td>
			</tr>
			</tbody>
		</table>
		</div>

		<div class="row" style="margin-top:20px;">
			<div class="col-xs-6"><h4><s:text name="offer.message.detail"/></h4></div>
			<div class="col-xs-6 text-right"><button title="" type="button" class="btn btn-success add show_tip" disabled="disabled" data-original-title='<s:text name="global.action.add"/>'><i class="fa fa-plus-square"></i></button></div>
		</div>
		
		<div>
		<table id="details" class="table table-striped table-hover table-list break-table">
			<thead>
				<tr>
					<th class="col-md-1"><s:text name="offer.field.seq" /></th>
					<th class="col-md-3"><s:text name="prod.field.name" /></th>
					<th class="col-md-1"><s:text name="offer.field.qty" /></th>
					<th class="col-md-1"><s:text name="prod.field.unit" /></th>
					<th class="col-md-3"><s:text name="prod.field.price" /></th>
					<th class="col-md-3"><s:text name="offer.field.amt" /></th>
				</tr>
			</thead>
			<tbody>
<s:iterator value="form.details" var="detail" status="idx">
				<tr>
					<td data-title="<s:text name="offer.field.seq" />">${idx.count}</td>
					<td data-title="<s:text name="prod.field.name" />"><c:out value="${detail.prod.name}"/></td>
					<td data-title="<s:text name="offer.field.qty" />"><c:out value="${detail.qty}"/></td>
					<td data-title="<s:text name="prod.field.unit" />"><c:out value="${detail.prod.unit}"/></td>
					<td data-title="<s:text name="prod.field.price" />"><c:out value="${detail.prod.price}"/></td>
					<td data-title="<s:text name="offer.field.amt" />"><c:out value="${detail.amt}"/></td>
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

<script>
var custs = [<s:iterator value="form.custs" var="cust" status="idx">{id:"<c:out value="${cust.id}"/>",name:"<c:out value="${cust.name}"/>",biz_no:"<c:out value="${cust.bizNo}"/>",tel:"<c:out value="${cust.tel}"/>",addr:"<c:out value="${cust.deliverAddr}"/>"},</s:iterator>];

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
						tel: v.tel
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

			return false;
		}
	});
});

</script>
<%@ include file="/commons/jsp/footer.jsp"%>
