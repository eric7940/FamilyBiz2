<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<s:url action="prod" namespace="/basic" var="mainURL"/>

<div class="container-fluid">	

<s:form method="post" namespace="/basic" action="prod" theme="simple">
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
					<label for="name"><s:text name="prod.field.name"/></label>
					<s:textfield name="form.name" id="name" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label for="unit"><s:text name="prod.field.unit"/></label>
					<s:select list="form.units" name="form.unit" cssClass="form-control" listKey="value" listValue="value"></s:select>
				</div>
			</div>
			<div class="col-md-4">
				<div class="form-group">
					<label for="price"><s:text name="prod.field.price"/></label>
					<s:textfield name="form.price" id="price" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label for="cost"><s:text name="prod.field.cost"/></label>
					<s:textfield name="form.cost" id="cost" cssClass="form-control"/>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label for="save_qty"><s:text name="prod.field.save_qty"/></label>
					<s:textfield name="form.saveQty" id="save_qty" cssClass="form-control"/>
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

function processPrice(obj) {
	if (!isDecimal(obj.value) || parseFloat(obj.value) < 0) {
		alert('請輸入數字，且不可為負數');
		obj.value = 0;
		return;
	}
	if(obj.value.indexOf('.') == obj.value.length - 1) {
		obj.value = parseFloat(obj.value) + '.';
	} else {
		obj.value = parseFloat(obj.value);
	}
}

function processSaveQty(obj) {
	if (!isInt(obj.value) || parseInt(obj.value, 10) < 0) {
		alert('請輸入數字，且不可為負數');
		obj.value = 0;
		return;
	}
}

function go(fm) {
	if (fm.prodNme.value.trim() == '') {
		alert('請輸入品名/規格');
		fm.prodNme.focus();
		return false;
	}
	
	var priceObj = fm.price;
	if (priceObj.value != '' && (!isDecimal(priceObj.value) || parseFloat(priceObj.value) < 0)) {
		alert('請輸入數字，且不可為負數');
		priceObj.value = 0;
		priceObj.focus();
		return;
	}
	priceObj.value = parseFloat(priceObj.value).toFixed(2);
	
	var saveQtyObj = fm.saveQty;
	if (saveQtyObj.value != '' && (!isInt(saveQtyObj.value) || parseInt(saveQtyObj.value, 10) < 0)) {
		alert('請輸入數字，且不可為負數');
		saveQtyObj.value = 0;
		saveQtyObj.focus();
		return;
	}
	saveQtyObj.value = parseInt(saveQtyObj.value, 10);
	
	return true;
}

</script>

<%@ include file="/commons/jsp/footer.jsp"%>
