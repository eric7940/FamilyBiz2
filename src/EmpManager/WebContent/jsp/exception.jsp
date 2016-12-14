<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="/commons/jsp/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Error Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href='<s:url value="/commons/css/bootstrap.min.css"/>' rel="stylesheet" id="bootstrap-css">
    <link href='<s:url value="/commons/css/font-awesome-4.1.0/css/font-awesome.min.css"/>' rel="stylesheet" type="text/css" />
    <style type="text/css">
    body { background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABoAAAAaCAYAAACpSkzOAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAABZ0RVh0Q3JlYXRpb24gVGltZQAxMC8yOS8xMiKqq3kAAAAcdEVYdFNvZnR3YXJlAEFkb2JlIEZpcmV3b3JrcyBDUzVxteM2AAABHklEQVRIib2Vyw6EIAxFW5idr///Qx9sfG3pLEyJ3tAwi5EmBqRo7vHawiEEERHS6x7MTMxMVv6+z3tPMUYSkfTM/R0fEaG2bbMv+Gc4nZzn+dN4HAcREa3r+hi3bcuu68jLskhVIlW073tWaYlQ9+F9IpqmSfq+fwskhdO/AwmUTJXrOuaRQNeRkOd5lq7rXmS5InmERKoER/QMvUAPlZDHcZRhGN4CSeGY+aHMqgcks5RrHv/eeh455x5KrMq2yHQdibDO6ncG/KZWL7M8xDyS1/MIO0NJqdULLS81X6/X6aR0nqBSJcPeZnlZrzN477NKURn2Nus8sjzmEII0TfMiyxUuxphVWjpJkbx0btUnshRihVv70Bv8ItXq6Asoi/ZiCbU6YgAAAABJRU5ErkJggg==);}
.error-template {padding: 40px 15px;text-align: center;}
.error-details {text-align: left;}
.error-actions {margin-top:15px;margin-bottom:15px;}
.error-actions .btn { margin-right:10px; }
    </style>
    <script src='<s:url value="/commons/js/jquery-1.11.1.min.js"/>'></script>
    <script src='<s:url value="/commons/js/bootstrap.min.js"/>'></script>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="error-template">
                <h1>Oops!</h1>
                <h2>System Error</h2>
                <font color="red">Please contact system administrator</font>
                <div class="error-details">
					<h3>Error Message</h3>
					<br>
					<s:property value="exception" />
					<hr />
					<h3>Stack Trace</h3>
					<s:property value="exceptionStack" />
				</div>
                <div class="error-actions" >
                    <a href='<s:url value="/"/>' class="btn btn-primary btn-lg" target="_top">
                    	<i class="fa fa-home"></i>
                        Take Me Home </a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>