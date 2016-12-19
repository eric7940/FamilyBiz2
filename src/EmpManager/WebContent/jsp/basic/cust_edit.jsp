<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<s:url action="cust" namespace="/basic" var="mainURL"/>

<div class="container-fluid">	

<s:form method="post" namespace="/basic" action="cust!add" theme="simple">

	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-12">
				<a href="<s:property value="#mainURL" />" role="button" class="btn btn-primary"><s:text name="global.action.cancel" /></a>
				<button type="button" class="btn btn-success" onclick="savePBT(event, false);"><s:text name="global.action.save" /></button>
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="row">
			<div class="col-md-4">
				<div class="form-group">
					<label for="name"><s:text name="cust.field.name"/></label>
					<s:textfield name="form.name" id="name" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label for="biz_no"><s:text name="cust.field.biz_no"/></label>
					<s:textfield name="form.bizNo" id="biz_no" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label for="tel"><s:text name="cust.field.tel"/></label>
					<s:textfield name="form.tel" id="tel" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label for="deliver_addr"><s:text name="cust.field.deliver_addr"/></label>
					<s:textfield name="form.deliverAddr" id="deliver_addr" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label for="memo"><s:text name="cust.field.memo"/></label>
					<s:textfield name="form.memo" id="memo" cssClass="form-control"/>
				</div>
			</div>

		</div>
		
		<%-- <form class="form-horizontal">
		<div class="row">
		<div class="col-md-6">
			<div class="form-group">
				<label for="name"></label>
				
			</div>
		</div>
		<div class="col-md-6">
			<div class="form-group">
				<label for="biz_no"></label>
				>
			</div>
		</div>
		</div></form> --%>
		
	</div>
	
</s:form>
</div>

<script type='text/javascript'>


</script>

<%@ include file="/commons/jsp/footer.jsp"%>
