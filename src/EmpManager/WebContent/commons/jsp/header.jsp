<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/commons/jsp/taglibs.jsp"%>
<%
com.opensymphony.xwork2.ActionContext.getContext().setLocale((java.util.Locale)session.getAttribute(com.fb.util.ConstUtil.SESSION_ATTR_LOCALE));
%>
<c:set var="request_locale" value="${sessionScope.LOCALE}"/>
<s:set var="global_message_confirm" value="%{getText('global.message.confirm')}"/>
<s:set var="global_error_required_checkbox" value="%{getText('global.error.required.checkbox')}"/>

<!-- request_locale = ${request_locale} -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>${WEB_APP_TITLE} <%=java.net.InetAddress.getLocalHost() %></title>
	<link rel="icon" type="image/gif" href="<s:url value="/commons/images/favicon.ico"/>" />
	
	<!-- Styles-->
	<link href='<s:url value="/commons/css/jquery-ui-1.11.1/jquery-ui.min.css"/>' rel="stylesheet"/>
    <link href='<s:url value="/commons/css/plugins/theme/bootstrap-cerulean.min.css"/>' rel="stylesheet" id="bs-css" />
	<link href='<s:url value="/commons/css/metisMenu.min.css"/>' rel="stylesheet"/>
	<link href='<s:url value="/commons/css/font-awesome-4.1.0/css/font-awesome.min.css"/>' rel="stylesheet" type="text/css" />
	<link href='<s:url value="/commons/css/plugins/charisma/charisma-app.css"/>' rel="stylesheet"/>
	<link href='<s:url value="/commons/css/plugins/charisma/animate.min.css"/>' rel="stylesheet"/>
	<link href='<s:url value="/commons/css/table.css"/>' rel="stylesheet"/>
	<link href='<s:url value="/commons/css/style.css"/>' rel="stylesheet"/>

	<!-- JavaScript -->
	<script src='<s:url value="/commons/js/jquery-1.11.1.js"/>'></script>
	<script src='<s:url value="/commons/js/jquery-ui-1.11.1/jquery-ui.min.js"/>'></script>
	<script src='<s:url value="/commons/js/plugins/jquery.cookie.js"/>'></script>
    <script src='<s:url value="/commons/js/bootstrap.min.js"/>'></script>
	<script src='<s:url value="/commons/js/metisMenu.min.js"/>'></script>
	<script src='<s:url value="/commons/js/sb-admin-2.js"/>'></script>
	
	<!-- timepicker -->	
	<!--link href='<s:url value="/commons/css/plugins/jquery.datetimepicker.css"/>' rel="stylesheet" /-->
	<!--script type="text/javascript" src='<s:url value="/commons/js/plugins/jquery.datetimepicker.js"/>'></script-->
	
	<!--script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/bower_components/moment/min/moment.min.js"/>"></script-->
	<!--script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/bower_components/fullcalendar/fullcalendar.min.js"/>"></script-->
	<!--script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/bower_components/chosen/chosen.jquery.min.js"/>"></script-->
	<!--script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/bower_components/colorbox/jquery.colorbox-min.js"/>"></script-->
	<!--script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/bower_components/bootstrap-tour/bootstrap-tour.min.js"/>"></script-->
	<!--script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/jquery.dataTables.min.js"/>"></script-->
	<!--script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/jquery.noty.js"/>"></script-->
	<!--script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/jquery.raty.min.js"/>"></script-->
	<script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/jquery.iphone.toggle.js"/>"></script>
	<script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/jquery.autogrow-textarea.js"/>"></script>
	<!--script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/jquery.uploadify-3.1.min.js"/>"></script-->
	<script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/jquery.history.js"/>"></script>
	<script type="text/javascript" src="<s:url value="/commons/js/plugins/charisma/charisma.js"/>"></script>
	  
	<script type="text/javascript" src="<s:url value="/commons/js/util.js"/>"></script>
	
</head>
<body>

<%@ include file="/commons/jsp/top.jsp" %>

<div id="page-wrapper" class="ch-container">
<div class="row">
<div class="col-lg-2 col-sm-4">
<div class="sidebar-nav">
	<div class="nav-canvas" >
	<%@ include file="/commons/jsp/menu.jsp" %>
	</div>
</div>
</div>
<div id="content" class="col-lg-10 col-sm-8">
<div class="row">
<div class="col-md-12">
<div class="box-inner">
<div class="box-header well" data-original-title="">
	<h2>
	<i class="fa fa-thumb-tack" aria-hidden="true"></i> 
		${FUNC_TITLE}
	</h2>
</div>
<div class="box-content">

<s:if test="hasActionErrors()">
<div class="alert alert-danger"><s:actionerror/></div>
</s:if>

<s:if test="hasActionMessages()">
<div class="alert alert-success"><s:actionmessage/></div>
</s:if>
        
<!-- Message -->
<input type="hidden" id="temp_notNullMsg" name="temp_notNullMsg" value="<s:text name="global.error.notEmpty" />" />
<input type="hidden" id="temp_dateExceedMsg" name="temp_dateExceedMsg" value="<s:text name="global.error.date.exceed" />" />

