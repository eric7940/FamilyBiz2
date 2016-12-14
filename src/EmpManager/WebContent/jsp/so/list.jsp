<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<s:url action="main" namespace="/" var="mainURL1"><s:param name="t">1</s:param></s:url>
<s:url action="main" namespace="/" var="mainURL2"><s:param name="t">2</s:param></s:url>
<s:url action="main" namespace="/" var="mainURL3"><s:param name="t">3</s:param></s:url>

<div id="exTab2" class="container-fluid">	
<ul class="nav nav-tabs">
	<li><c:if test="${form.activeTab ne 1}"><a href="<s:property value="#mainURL1" />"><s:text name="pbt.tab.1" /></a></c:if><c:if test="${form.activeTab eq 1}"><a><s:text name="pbt.tab.1" /></a></c:if></li>
	<li><c:if test="${form.activeTab ne 2}"><a href="<s:property value="#mainURL2" />"><s:text name="pbt.tab.2" /></a></c:if><c:if test="${form.activeTab eq 2}"><a><s:text name="pbt.tab.2" /></a></c:if></li>
	<li><c:if test="${form.activeTab ne 3}"><a href="<s:property value="#mainURL3" />"><s:text name="pbt.tab.3" /></a></c:if><c:if test="${form.activeTab eq 3}"><a><s:text name="pbt.tab.3" /></a></c:if></li>
	<li><a href="http://10.1.255.61/PBT/doc/PBT_manual_3.doc" target="_blank"><s:text name="pbt.tab.4" /></a></li>
</ul>

<div class="tab-content">

<c:if test="${form.activeTab == 1}">
<div class="tab-pane" id="1a">
<s:form method="post" namespace="/" action="main" theme="simple" cssClass="navbar-form">
<input type="hidden" name="t" value="${form.activeTab}" />
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
				<button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal" data-whatever="${form.activeTab}"><s:text name="pbt.action.add" /></button>
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="div-result">
		<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
			<thead>
				<tr>
					<th class="col-md-1"><s:text name="pbt.field.oin" /></th>
					<th class="col-md-3"><s:text name="pbt.field.name" /></th>
					<th class="col-md-2"><s:text name="pbt.field.pmDept" /></th>
					<th class="col-md-1"><s:text name="pbt.field.pmUser" /></th>
					<th class="col-md-2"><s:text name="pbt.field.salesDept" /></th>
					<th class="col-md-1"><s:text name="pbt.field.salesUser" /></th>
					<th class="col-md-1"><s:text name="pbt.field.totalCost" /></th>
					<th class="col-md-1"><s:text name="pbt.field.totalManday" /></th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty form.pageElement.records}">
				<tr>
					<td colspan="8" class="text-center"><s:text name="global.message.noResults"/></td>
				</tr>
</c:if>
<s:iterator value="form.pageElement.records" var="record" status="idx">
				<tr>
					<td data-title="<s:text name="pbt.field.oin" />"><a href="javascript:void(0)" onclick="viewPBT(event,'${record.projectId}');"><c:out value="${record.projectId}"/></a></td>
					<td data-title="<s:text name="pbt.field.name" />"><c:out value="${record.name}"/></td>
					<td data-title="<s:text name="pbt.field.pmDept" />"><c:out value="${record.pmDeptFinCode}"/><br/><c:out value="${record.pmDeptName}"/></td>
					<td data-title="<s:text name="pbt.field.pmUser" />"><c:out value="${record.pmUserId}"/><br/><c:out value="${record.pmUserName}"/></td>
					<td data-title="<s:text name="pbt.field.salesDept" />"><c:out value="${record.salesDeptFinCode}"/><br/><c:out value="${record.salesDeptName}"/></td>
					<td data-title="<s:text name="pbt.field.salesUser" />"><c:out value="${record.salesUserId}"/><br/><c:out value="${record.salesUserName}"/></td>
					<td data-title="<s:text name="pbt.field.totalCost" />"><fmt:formatNumber groupingUsed="true" maxFractionDigits="0" value="${record.totalCost}" /></td>
					<td data-title="<s:text name="pbt.field.totalManday" />"><fmt:formatNumber maxFractionDigits="0" value="${record.totalManday}"/></td>
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
</c:if>

<c:if test="${form.activeTab == 2}">
<div class="tab-pane" id="2a">
<s:form method="post" namespace="/" action="main" theme="simple" cssClass="navbar-form">
<input type="hidden" name="t" value="${form.activeTab}" />
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
				<button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal" data-whatever="${form.activeTab}"><s:text name="pbt.action.add" /></button>
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="div-result">
		<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
			<thead>
				<tr>
					<th class="col-md-1"><s:text name="pbt.field.oin" /></th>
					<th class="col-md-3"><s:text name="pbt.field.name" /></th>
					<th class="col-md-1"><s:text name="pbt.field.pmDept" /></th>
					<th class="col-md-1"><s:text name="pbt.field.pmUser" /></th>
					<th class="col-md-1"><s:text name="pbt.field.salesDept" /></th>
					<th class="col-md-1"><s:text name="pbt.field.salesUser" /></th>
					<th class="col-md-1"><s:text name="pbt.field.totalCost" /></th>
					<th class="col-md-1"><s:text name="pbt.field.totalManday" /></th>
					<th class="col-md-1"><s:text name="pbt.field.startDate" /></th>
					<th class="col-md-1"><s:text name="pbt.field.endDate" /></th>
				</tr>
			</thead>
			<tbody>

<c:if test="${empty form.pageElement.records}">
				<tr>
					<td colspan="10" class="text-center"><s:text name="global.message.noResults"/></td>
				</tr>
</c:if>
<s:iterator value="form.pageElement.records" var="record" status="idx">
				<tr>
					<td data-title="<s:text name="pbt.field.oin" />"><a href="javascript:void(0)" onclick="viewPBT(event,'${record.projectId}');"><c:out value="${record.projectId}"/></a></td>
					<td data-title="<s:text name="pbt.field.name" />"><c:out value="${record.name}"/></td>
					<td data-title="<s:text name="pbt.field.pmDept" />"><c:out value="${record.pmDeptFinCode}"/><br/><c:out value="${record.pmDeptName}"/></td>
					<td data-title="<s:text name="pbt.field.pmUser" />"><c:out value="${record.pmUserId}"/><br/><c:out value="${record.pmUserName}"/></td>
					<td data-title="<s:text name="pbt.field.salesDept" />"><c:out value="${record.salesDeptFinCode}"/><br/><c:out value="${record.salesDeptName}"/></td>
					<td data-title="<s:text name="pbt.field.salesUser" />"><c:out value="${record.salesUserId}"/><br/><c:out value="${record.salesUserName}"/></td>
					<td data-title="<s:text name="pbt.field.totalCost" />"><fmt:formatNumber groupingUsed="true" maxFractionDigits="0" value="${record.totalCost}" /></td>
					<td data-title="<s:text name="pbt.field.totalManday" />"><fmt:formatNumber maxFractionDigits="0" value="${record.totalManday}"/></td>
					<td data-title="<s:text name="pbt.field.startDate" />"><fmt:formatDate pattern="yyyy/MM/dd" value="${record.startDate}" /></td>
					<td data-title="<s:text name="pbt.field.endDate" />"><fmt:formatDate pattern="yyyy/MM/dd" value="${record.endDate}" /></td>
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
</c:if>

<c:if test="${form.activeTab == 3}">
<div class="tab-pane" id="3a">
<s:form method="post" namespace="/" action="main" theme="simple" cssClass="navbar-form">
<input type="hidden" name="t" value="${form.activeTab}" />
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
				
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="div-result">
		<table id="queryResult" class="table table-striped table-hover table-break-all table-list break-table table-condensed">
			<thead>
				<tr>
					<th class="col-md-1"><s:text name="pbt.field.projectCode" /></th>
					<th class="col-md-3"><s:text name="pbt.field.name" /></th>
					<th class="col-md-1"><s:text name="pbt.field.pmDept" /></th>
					<th class="col-md-1"><s:text name="pbt.field.pmUser" /></th>
					<th class="col-md-1"><s:text name="pbt.field.salesDept" /></th>
					<th class="col-md-1"><s:text name="pbt.field.salesUser" /></th>
					<th class="col-md-1"><s:text name="pbt.field.totalCost" /></th>
					<th class="col-md-1"><s:text name="pbt.field.totalManday" /></th>
					<th class="col-md-1"><s:text name="pbt.field.startDate" /></th>
					<th class="col-md-1"><s:text name="pbt.field.endDate" /></th>
				</tr>
			</thead>
			<tbody>
<c:if test="${empty form.pageElement.records}">
				<tr>
					<td colspan="10" class="text-center"><s:text name="global.message.noResults"/></td>
				</tr>
</c:if>
<s:iterator value="form.pageElement.records" var="record" status="idx">
				<tr>
					<td data-title="<s:text name="pbt.field.projectCode" />"><a href="javascript:void(0)" onclick="viewPBT(event,'${record.projectId}');"><c:out value="${record.projectId}"/></a></td>
					<td data-title="<s:text name="pbt.field.name" />"><c:out value="${record.name}"/></td>
					<td data-title="<s:text name="pbt.field.pmDept" />"><c:out value="${record.pmDeptFinCode}"/><br/><c:out value="${record.pmDeptName}"/></td>
					<td data-title="<s:text name="pbt.field.pmUser" />"><c:out value="${record.pmUserId}"/><br/><c:out value="${record.pmUserName}"/></td>
					<td data-title="<s:text name="pbt.field.salesDept" />"><c:out value="${record.salesDeptFinCode}"/><br/><c:out value="${record.salesDeptName}"/></td>
					<td data-title="<s:text name="pbt.field.salesUser" />"><c:out value="${record.salesUserId}"/><br/><c:out value="${record.salesUserName}"/></td>
					<td data-title="<s:text name="pbt.field.totalCost" />"><fmt:formatNumber groupingUsed="true" maxFractionDigits="0" value="${record.totalCost}" /></td>
					<td data-title="<s:text name="pbt.field.totalManday" />"><fmt:formatNumber maxFractionDigits="0" value="${record.totalManday}"/></td>
					<td data-title="<s:text name="pbt.field.startDate" />"><fmt:formatDate pattern="yyyy/MM/dd" value="${record.startDate}" /></td>
					<td data-title="<s:text name="pbt.field.endDate" />"><fmt:formatDate pattern="yyyy/MM/dd" value="${record.endDate}" /></td>
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
</c:if>

<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <s:form method="post" namespace="/" action="main!initAdd" theme="simple" role="form">
      <input type="hidden" name="t" value="${form.activeTab}">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="exampleModalLabel"><s:text name="pbt.action.add"/></h4>
      </div>
      <div class="modal-body">
          <div class="form-group">
            <label for="oin-code" class="control-label"><s:text name="pbt.message.input.oin"/></label>
            <s:textfield name="form.oin" theme="simple" placeholder="%{getText('pbt.field.oin')}" id="oin-code" cssClass="form-control oin"/>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal"><s:text name="global.action.close"/></button>
        <button type="button" class="btn btn-primary add"><s:text name="global.action.add"/></button>
      </div>
      </s:form>
    </div>
  </div>
</div>

</div>
  </div>


<script>
function viewPBT(event, id) {
	$('input:hidden[name=id]').val(id);
	var oForm = getSelfForm(event, 'view');	
	oForm.submit();
}
$('#addModal').on('show.bs.modal', function (event) {
	var button = $(event.relatedTarget);
	var recipient = button.data('whatever');
	var title = '';
	switch (recipient) {
		case 1: title = '<s:text name="pbt.tab.1"/>'; break;
		case 2: title = '<s:text name="pbt.tab.2"/>'; break;
	}
	var modal = $(this);
	modal.find('.modal-title').text(title + '－' + '<s:text name="pbt.action.add"/>');
	modal.find('.oin').val('');
});
$(function() {
	var activeTab = ${form.activeTab};
	$("#exTab2 ul.nav-tabs li:nth-child(" + activeTab + ")").addClass("active");
	$("#" + activeTab + "a").addClass("active");
});
$("#addModal").on("click", ".add", function (e) {
	if (!$("#addModal").find('.oin').val()) {
		alert('<s:text name="pbt.message.input.oin"/>');
		e.preventDefault();
        return false; 
	} else {
		var oin = $("#addModal").find('.oin').val();
		var t = $("#addModal").find('input:hidden[name=t]').val();
		$.post('<s:url action="main" namespace="/" method="checkOIN"/>',{oin: oin, t: t}, function(result){
			if (result["errCde"] == '00') {
				//$('#addModal').modal('toggle');
				var form = $("#addModal").find('form');
				form.submit();
			} else {
				alert(result["errMsg"]);
				e.preventDefault();
		        return false; 
			} 
		}, 'json');
	}
});
</script>

<%@ include file="/commons/jsp/footer.jsp"%>
