<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<div id="exTab2" class="container-fluid">	
<div class="tab-content">

<s:form method="post" namespace="/basic" action="cust" theme="simple" cssClass="navbar-form">
<input type="hidden" name="id"/>
	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-8 div-search">
				<div class="form-group form-input-line-magrin">
					<s:textfield name="form.keyword" theme="simple" placeholder="%{getText('global.message.keywordSearch')}" cssClass="form-control RESET_ITEM"/>
				</div>

				<s:submit key="global.action.query" cssClass="btn btn-primary" />
				<s:submit key="global.action.reset" cssClass="btn btn-primary" type="button" onclick="fnReload(event)" />
			</div>
			<div class="col-md-4 text-right">
				<button type="button" class="btn btn-success"><s:text name="pbt.action.add" /></button>
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="div-result">
		<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
			<thead>
				<tr>
					<th class="col-md-1"><s:text name="cust.field.id" /></th>
					<th class="col-md-3"><s:text name="cust.field.name" /></th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty form.pageElement.records}">
				<tr>
					<td colspan="2" class="text-center"><s:text name="global.message.noResults"/></td>
				</tr>
</c:if>
<s:iterator value="form.pageElement.records" var="record" status="idx">
				<tr>
					<td data-title="<s:text name="cust.field.id" />"><a href="javascript:void(0)" onclick="viewPBT(event,'${record.id}');"><c:out value="${record.id}"/></a></td>
					<td data-title="<s:text name="cust.field.name" />"><c:out value="${record.name}"/></td>
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
