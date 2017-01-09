<%@ page language="java" contentType="text/html; charset=utf-8" isErrorPage="true" %>
<%@ include file="/commons/jsp/taglibs.jsp"%>
<%!
private static final java.util.Map<Integer,String> errMsg = new java.util.HashMap<Integer,String>();
static {
	errMsg.put(javax.servlet.http.HttpServletResponse.SC_BAD_REQUEST,  "Bad Request");   //400
	errMsg.put(javax.servlet.http.HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");  //401
	errMsg.put(javax.servlet.http.HttpServletResponse.SC_FORBIDDEN,    "Forbidden");     //403
	errMsg.put(javax.servlet.http.HttpServletResponse.SC_NOT_FOUND,    "Not Found");     //404
	errMsg.put(javax.servlet.http.HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Server Error");	//500
}
%>
<%
String WEB_CONTEXT = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Error Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href='<%=WEB_CONTEXT %>/commons/css/bootstrap.min.css' rel="stylesheet" id="bootstrap-css">
    <link href='<%=WEB_CONTEXT %>/commons/css/font-awesome-4.1.0/css/font-awesome.min.css' rel="stylesheet" type="text/css" />
    <style type="text/css">
    body { background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABoAAAAaCAYAAACpSkzOAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAABZ0RVh0Q3JlYXRpb24gVGltZQAxMC8yOS8xMiKqq3kAAAAcdEVYdFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzVxteM2AAABHklEQVRIib2Vyw6EIAxFW5idr///Qx9sfG3pLEyJ3tAwi5EmBqRo7vHawiEEERHS6x7MTMxMVv6+z3tPMUYSkfTM/R0fEaG2bbMv+Gc4nZzn+dN4HAcREa3r+hi3bcuu68jLskhVIlW073tWaYlQ9+F9IpqmSfq+fwskhdO/AwmUTJXrOuaRQNeRkOd5lq7rXmS5InmERKoER/QMvUAPlZDHcZRhGN4CSeGY+aHMqgcks5RrHv/eeh455x5KrMq2yHQdibDO6ncG/KZWL7M8xDyS1/MIO0NJqdULLS81X6/X6aR0nqBSJcPeZnlZrzN477NKURn2Nus8sjzmEII0TfMiyxUuxphVWjpJkbx0btUnshRihVv70Bv8ItXq6Asoi/ZiCbU6YgAAAABJRU5ErkJggg==);}
.error-template {padding: 40px 15px;text-align: center;}
.error-details {text-align: left;}
.error-actions {margin-top:15px;margin-bottom:15px;}
.error-actions .btn { margin-right:10px; }
    </style>
    <script src='<%=WEB_CONTEXT %>/commons/js/jquery-1.12.4.min.js'></script>
    <script src='<%=WEB_CONTEXT %>/commons/js/bootstrap.min.js'></script>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="error-template">
                <h1>Oops!</h1>
                <h2><%=response.getStatus() %> <%=errMsg.get(response.getStatus())%></h2>
                <font color="red">Please contact system administrator</font>
                <!-- <div class="error-details">
					<h3></h3>
					<br>
					
				</div> -->
                <div class="error-actions" >
                    <a href='<%=WEB_CONTEXT %>/' class="btn btn-primary btn-lg" target="_top">
                    	<i class="fa fa-home"></i>
                        Take Me Home </a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>