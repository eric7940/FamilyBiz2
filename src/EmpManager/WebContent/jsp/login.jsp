<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
com.opensymphony.xwork2.ActionContext.getContext().setLocale((java.util.Locale)session.getAttribute(com.fb.util.ConstUtil.SESSION_ATTR_LOCALE));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${WEB_APP_TITLE}</title>
<link rel="icon" type="image/gif" href="commons/images/favicon.png">
<link href="commons/css/plugins/theme/bootstrap-cerulean.min.css" rel="stylesheet">
<style type="text/css">
body {
    background-color: #f8f8f8;
}
.errors {
	background-color:#FFCCCC;
	border:1px solid #CC0000;
	width:220px;
	line-height:10px;
}
.errorsli{
	list-style: none; 
}

.login-panel {
    margin-top: 15%;
}
</style>

<script type="text/javascript" src="commons/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="commons/js/plugins/jquery.cookie.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    $('form').attr('autocomplete', 'off');
});

function checkForm(obj) {
	return true;
}

</script>
</head>
<body>
	<div class="container">
        <div class="row">
            <div class="col-md-4 col-lg-5 col-md-offset-4">
                <div class="login-panel panel panel-primary">
                	<div class="panel-heading">
			            <!--<img src="<s:url value="/commons/images/logo.png"/>" style="padding: 0px; height:60px; width:200px;">-->
			            <H1 style="color: #fff;">${WEB_APP_TITLE}</H1>
			        </div>
                    <div class="panel-body">
                          <s:form action="login" method="post" theme="simple" onsubmit="return checkForm(this);" target="_parent">
                            <fieldset>
                                <div class="form-group">
                                    <s:hidden name="server" value="systex.com"/>
                                </div>
                                <div class="form-group">
                                    <s:textfield name="userId" cssClass="form-control username" placeholder="%{getText('login.field.username')}" title="%{getText('login.field.username')}" />
                                </div>
                                <div class="form-group">
                                    <s:password name="password" cssClass="form-control password" placeholder="%{getText('login.field.password')}" title="%{getText('login.field.password')}" />
                                </div>
                                <s:submit key="global.action.submit" align="center" cssClass="btn btn-lg btn-primary btn-block" />
                            </fieldset>
                        </s:form>                        
                    </div>
                    <s:if test="hasActionErrors()">
						<div id="divError" class="panel-footer alert-danger">
							<s:actionerror/>
						</div>
					</s:if>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
