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
					<s:textfield name="form.masterId" theme="simple" placeholder="%{getText('global.message.keywordSearch')}:%{getText('offer.field.master_id')}" cssClass="form-control"/>
				</div>
				<s:submit key="global.action.query" cssClass="btn btn-primary" />
			</div>
			<div class="col-md-4 text-right">
				<s:submit key="global.action.edit" cssClass="btn btn-success" type="button" onclick="fnInitAdd(event,'%{form.masterId}','form.masterId')" />
				<s:submit key="offer.action.print" cssClass="btn btn-success" type="button" onclick="fnInitAdd(event,'%{form.masterId}','form.masterId')" />
				<s:submit key="global.action.remove" cssClass="btn btn-success" type="button" onclick="fnInitAdd(event,'%{form.masterId}','form.masterId')" />
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="div-result">
		<table id="master" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
				<tr>
					<th class="col-md-3"><s:text name="cust.field.name" /></th><td><c:out value="${form.cust.name}"/></td>
					<th class="col-md-1"><s:text name="cust.field.id" /></th><td><c:out value="${form.cust.id}"/></td>
					<th class="col-md-1"><s:text name="offer.field.offer_date" /></th><td><c:out value="${form.offerDate}"/></td>
					<th class="col-md-4"><s:text name="cust.field.deliver_addr" /></th><td><c:out value="${form.cust.deliverAddr}"/></td>
					<th class="col-md-1"><s:text name="cust.field.tel" /></th><td><c:out value="${form.cust.tel}"/></td>
					<th class="col-md-2"><s:text name="offer.field.memo" /></th><td><c:out value="${form.memo}"/></td>
				</tr>
			
		</table>
		<table id="details" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
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
					<td data-title="<s:text name="offer.field.prod_name" />"><c:out value="${detail.prod.name}"/></td>
					<td data-title="<s:text name="offer.field.qty" />"><c:out value="${detail.qty}"/></td>
					<td data-title="<s:text name="offer.field.unit" />"><c:out value="${detail.prod.unit}"/></td>
					<td data-title="<s:text name="offer.field.price" />"><c:out value="${detail.prod.price}"/></td>
					<td data-title="<s:text name="offer.field.amt" />"><c:out value="${detail.amt}"/></td>
				</tr>
</s:iterator>
			</tbody>
		</table>
		</div>

	   	<!-- 分頁 -->
		<c:if test="${!empty form.pageElement.records}">
			<c:set var="pageElement" value="${form.pageElement}" />
			<%@include file="/commons/jsp/pagination.jsp"%>
		</c:if>

	</div>
	<!-- /content -->
</s:form>

</div>
</div>

<%@ include file="/commons/jsp/footer.jsp"%>
