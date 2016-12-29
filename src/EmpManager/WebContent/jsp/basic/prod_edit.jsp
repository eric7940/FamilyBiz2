<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/header.jsp"%>

<s:url action="prod" namespace="/basic" var="mainURL"/>

<div class="container-fluid">	

<s:form method="post" namespace="/basic" action="prod" theme="simple" onsubmit="return save(event)">
<s:hidden name="form.id"/>
	<div role="main" class="container-fluid">

		<div class="row">
			<!-- 查詢條件 -->
			<div class="col-md-12">
				<a href="<s:property value="#mainURL" />" role="button" class="btn btn-primary"><s:text name="global.action.cancel" /></a>
				<s:submit key="global.action.save" cssClass="btn btn-success"/>
			</div>
		</div>

		<!-- 查詢結果 -->
		<div class="row">
			<div class="col-md-5">
				<div class="form-group">
					<label for="name"><s:text name="prod.field.name"/></label>
					<s:textfield name="form.name" id="name" cssClass="form-control name" onkeyup="convertNum(this)"/>
				</div>
			</div>
			<div class="col-md-1">
				<div class="form-group">
					<label for="unit"><s:text name="prod.field.unit"/></label>
					<s:select list="form.units" name="form.unit" cssClass="form-control unit" listKey="value" listValue="value"></s:select>
				</div>
			</div>
			<div class="col-md-2">
				<div class="form-group">
					<label for="price"><s:text name="prod.field.price"/></label>
					<s:textfield name="form.price" id="price" cssClass="form-control price" onkeyup="convertNum(this);processPrice(this);"/>
				</div>
			</div>
			<div class="col-md-2">
				<div class="form-group">
					<label for="save_qty"><s:text name="prod.field.save_qty"/></label>
					<s:textfield name="form.saveQty" id="save_qty" cssClass="form-control save_qty" onkeyup="convertNum(this);processSaveQty(this);"/>
				</div>
			</div>
		</div>

	</div>
</s:form>
</div>

<script type='text/javascript'>
var modify = '${attr.modify}';
function save(event) {
	if ($('.name').val().trim() == '') {
		alert('請輸入品名/規格');
		$('.name').focus();
		return false;
	}
	
	if ($('.price').val() != '' && (!isDecimal($('.price').val()) || parseFloat($('.price').val()) < 0)) {
		alert('請輸入數字，且不可為負數');
		$('.price').val(0);
		$('.price').focus();
		return false;
	}
	$('.price').val(parseFloat($('.price').val()).toFixed(2));
	
	if ($('.save_qty').val() != '' && (!isInt($('.save_qty').val()) || parseInt($('.save_qty').val(), 10) < 0)) {
		alert('請輸入數字，且不可為負數');
		$('.save_qty').val(0);
		$('.save_qty').focus();
		return false;
	}
	$('.save_qty').val(parseInt($('.save_qty').val(), 10));

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

</script>

<%@ include file="/commons/jsp/footer.jsp"%>
