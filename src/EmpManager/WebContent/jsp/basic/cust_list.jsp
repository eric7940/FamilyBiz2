<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div class="container-fluid">	
<div class="tab-content">

<s:form method="post" namespace="/basic" action="cust" theme="simple" cssClass="navbar-form">
<s:hidden name="form.id"/>
	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-8 div-search">
				<div class="form-group form-input-line-magrin">
					<s:textfield name="form.keyword" theme="simple" placeholder="%{getText('global.message.keywordSearch')}" cssClass="form-control"/>
				</div>

				<s:submit key="global.action.query" cssClass="btn btn-success" />
				<s:submit key="global.action.reset" cssClass="btn btn-success" type="button" onclick="fnReload(event)" />
			</div>
			<div class="col-md-4 text-right">
				<s:submit key="global.action.add" cssClass="btn btn-primary" type="button" onclick="fnInitAdd(event,'','form.id')" />
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="div-result">
		<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
			<thead>
				<tr>
					<th class="col-md-1"><s:text name="cust.field.id" /></th>
					<th class="col-md-3"><s:text name="cust.field.name" /></th>
					<th class="col-md-1"><s:text name="cust.field.biz_no" /></th>
					<th class="col-md-3"><s:text name="cust.field.deliver_addr" /></th>
					<th class="col-md-1"><s:text name="cust.field.tel" /></th>
					<th class="col-md-3"><s:text name="cust.field.memo" /></th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty form.pageElement.records}">
				<tr>
					<td colspan="6" class="text-center"><s:text name="global.message.noResults"/></td>
				</tr>
</c:if>
<s:iterator value="form.pageElement.records" var="record" status="idx">
				<tr>
					<td data-title="<s:text name="cust.field.id" />"><a href="javascript:void(0)" onclick="fnInitModify(event, '${record.id}', 'form.id');"><c:out value="${record.id}"/></a></td>
					<td data-title="<s:text name="cust.field.name" />"><c:out value="${record.name}"/></td>
					<td data-title="<s:text name="cust.field.biz_no" />"><c:out value="${record.bizNo}"/></td>
					<td data-title="<s:text name="cust.field.deliver_addr" />"><c:out value="${record.deliverAddr}"/></td>
					<td data-title="<s:text name="cust.field.tel" />"><c:out value="${record.tel}"/></td>
					<td data-title="<s:text name="cust.field.memo" />"><c:out value="${record.memo}"/></td>
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
