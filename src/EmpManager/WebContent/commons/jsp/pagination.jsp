<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<center>
	
	<s:if test="#attr.method == ''">
		<c:set var="method" value="query" />
	</s:if>
	<s:else>
		<c:set var="method" value="${attr.method}" />
	</s:else>
	
	<c:set var="liSize" value="${form.pageElement.liSize}" />
	<c:set var="currentPage" value="${form.pageElement.currentPage}" />
	<c:set var="totalPage" value="${form.pageElement.totalPage}" />	
	<c:set var="start" value="0" />
	<c:set var="end" value="0" />
			
		
	<s:hidden name="form.pageElement.movePage" id="pageElement_movePage"/>
	<s:hidden name="form.pageElement.currentPage" id="pageElement_currentPage"/>
	<s:hidden name="form.pageElement.pageSize"  id="pageElement_pageSize"/>
	
	<div class="text-center">
		<div class="col-sm-12 col-lg-12">
			<ul class="pagination">
				
				<s:if test="form.pageElement.currentPage == 1 || form.pageElement.totalPage == 0 || form.pageElement.totalPage == 1">
		        	<li class="disabled"><a class="show-column-small" href="#" ><i class="fa fa-fast-backward"></i><span><s:text name="global.pagination.first" /></span><!-- 第一頁 --></a></li>
		        	<li class="disabled"><a class="show-column-small" href="#" ><i class="fa fa-chevron-left"></i><span><s:text name="global.pagination.prev" /></span><!-- 上一頁 --></a></li>
				</s:if>
				<s:else>
					<li><a class="show-column-small" href="javascript:movePage('${method}', '1')" ><i class="fa fa-fast-backward"></i><span><s:text name="global.pagination.first" /></span><!-- 第一頁 --></a></li>
					<li><a class="show-column-small" href="javascript:movePage('${method}', '${form.pageElement.currentPage - 1}')" ><i class="fa fa-chevron-left"></i><span><s:text name="global.pagination.prev" /></span><!-- 上一頁 --></a></li>
				</s:else>
			
				<fmt:formatNumber var="flag" value="${((currentPage - 1) - (currentPage - 1) % liSize ) / liSize}" />
				
				<s:if test="#attr.flag == 0">
					<c:set var="start" value="1" />
					<c:set var="end" value="${liSize}" />
				</s:if>
				<s:else>
					<c:set var="start" value="${liSize * flag + 1}" />
					<c:set var="end" value="${liSize * (flag + 1)}" />
				</s:else>
				
				<s:if test="#attr.end > #attr.totalPage">
					<c:set var="end" value="${totalPage}" />
				</s:if>
				
				<s:iterator begin="%{#attr.start}" end="%{#attr.end}" status="stat">
					<s:if test="top == #attr.currentPage">
						<li class="active"><a class="hide-column-small" href="#" >${top}</a></li>
					</s:if>
					<s:else>
						<li><a class="hide-column-small" href="javascript:movePage('${method}', '${top}')" >${top}</a></li>
					</s:else>
				</s:iterator>
			
				<s:if test="form.pageElement.currentPage == form.pageElement.totalPage || form.pageElement.totalPage == 0 || form.pageElement.totalPage == 1">
	        		<li class="disabled"><a class="show-column-small" href="#" ><i class="fa fa-chevron-right"></i><span><s:text name="global.pagination.next" /></span><!-- 下一頁 --></a></li>
	        		<li class="disabled"><a class="show-column-small" href="#" ><i class="fa fa-fast-forward"></i><span><s:text name="global.pagination.last" /></span><!-- 最後一頁 --></a></li>
				</s:if>
				<s:else>
					<li><a class="show-column-small" href="javascript:movePage('${method}', '${form.pageElement.currentPage + 1}')" ><i class="fa fa-chevron-right"></i><span><s:text name="global.pagination.next" /></span><!-- 下一頁 --></a></li>
					<li><a class="show-column-small" href="javascript:movePage('${method}', '${form.pageElement.totalPage}')" ><i class="fa fa-fast-forward"></i><span><s:text name="global.pagination.last" /></span><!-- 最後一頁 --></a></li>
				</s:else>	
			</ul>
		</div>	
	</div>	
</center>
<script>
function movePage(method, currentPage){

	//移動頁數
	$('#pageElement_currentPage').val(currentPage);
	$('#pageElement_movePage').val("true");
    
    var oform = document.forms[0];
   	var actionValue = oform.action;
   	actionValue = actionValue.replace('.do','');
   	var action = actionValue;
	
   	if (actionValue.indexOf("?") > 0) {
		action = actionValue.substring(0, actionValue.indexOf("?"));
	}
	if (action.indexOf("!") > 0) {
		action = action.substring(0, action.indexOf("!"));
	}
	action += ((method != null && method != "")? "!" + method : "") + ".do";
	
	if (actionValue.indexOf("?") > 0) {
		action += actionValue.substring(actionValue.indexOf("?"));
	}
	//alert(action);
	oform.action = action;
	oform.submit();
}

</script>
