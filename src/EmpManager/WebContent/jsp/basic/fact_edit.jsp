<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<s:url action="fact" namespace="/basic" var="mainURL"/>

<div class="container-fluid">	

<s:form method="post" namespace="/basic" action="fact" theme="simple">
<s:hidden name="form.id"/>
	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-12">
				<a href="<s:property value="#mainURL" />" role="button" class="btn btn-primary"><s:text name="global.action.cancel" /></a>
				<s:submit key="global.action.save" cssClass="btn btn-success" type="button" onclick="save(event)" />
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="row">
			<div class="col-md-4">
				<div class="form-group">
					<label for="name"><s:text name="fact.field.name"/></label>
					<s:textfield name="form.name" id="name" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label for="biz_no"><s:text name="fact.field.biz_no"/></label>
					<s:textfield name="form.bizNo" id="biz_no" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label for="contact"><s:text name="fact.field.contact"/></label>
					<s:textfield name="form.contact" id="contact" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label for="tel"><s:text name="fact.field.tel"/></label>
					<s:textfield name="form.tel" id="tel" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label for="addr"><s:text name="fact.field.addr"/></label>
					<s:textfield name="form.addr" id="addr" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label for="memo"><s:text name="fact.field.memo"/></label>
					<s:textfield name="form.memo" id="memo" cssClass="form-control"/>
				</div>
			</div>
		</div>

	</div>
</s:form>
</div>

<script type='text/javascript'>
var modify = '${attr.modify}';
function save(event) {
	if (modify === 'y') {
		fnModify(event);
	} else {
		fnAdd(event);
	}
}

</script>

<%@ include file="/commons/jsp/footer.jsp"%>
