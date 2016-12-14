<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!-- Top navbar--> 
<div class="navbar navbar-default" role="navigation" style="border:0px; background-color:#f5f5f5; background-image: -webkit-linear-gradient(#f5f5f5, #c9e8fa 60%, #97d2f4);">
<div class="navbar-inner" style="${TOP_DISPLAY_NONE}">

	<!-- Menu icon --><!--
	<button type="button" class="navbar-toggle pull-left animated flip" data-toggle="collapse" data-target=".navbar-collapse">
		<span class="sr-only">Toggle navigation</span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	</button>-->
	
	<!-- Logout -->
	<s:url action="logout" namespace="/" var="logoutURL"/> 
	<div class="btn-group pull-right">
		<a href="<s:property value="#logoutURL" />" role="button" class="btn btn-default"><span class="hidden-sm-x hidden-xs">${USER_INFO.id} ${USER_INFO.name}</span> 您好<i class="fa fa-sign-out fa-fw"></i></a>
		
	</div>

</div>
</div><!-- END-Top navbar -->
