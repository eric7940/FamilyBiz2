<div class="sidebar-nav">
	<div class="nav-canvas">
		<div class="nav-sm nav nav-stacked">
		</div>
		
		<ul class="nav nav-pills nav-stacked main-menu">
		
			<s:set var="parentMenuCount" value="0" />
			
			<s:iterator value="#session.LEFT_MENU.{?#this.parentMenuId == null}" id="parentMenu">
				<s:set var="parentMenuCount" value="%{#parentMenuCount+1}" />
			</s:iterator>
	
			<s:iterator value="#session.LEFT_MENU.{?#this.parentMenuId == null}" id="menu">
				
	        	<s:set name="groupId" value="%{id}" />
	        	
	        	<s:set name="resourceTag" value="fa fa-wrench fa-fw" />
	        	
	        	<c:choose>
	        	
					<c:when test="${parentMenuCount == 1}">
						<li class="nav-header"><i class="${menu.resourceTag}" style="width: 20px"></i><emp:message key="${menu.resourceKey}" language="${request_locale}"/></li>
					</c:when>
					<c:otherwise>
				        <li class="accordion">
					        <a href="#" onclick="$.cookie('expandedMenuGroupId', ${menu.id}, { expires: 1, path: '/'});setLeftMenuCollapse('${menu.id}');">
			            	<i class="${menu.resourceTag}" style="width: 20px"></i> <emp:message key="${menu.resourceKey}" language="${request_locale}"/><span class="fa arrow"></span>
			            </a>
					</c:otherwise>
					
				</c:choose>

					<ul id="ul-${menu.id}" class="nav nav-pills nav-stacked">
						<s:iterator value="#session.LEFT_MENU.{?#this.parentMenuId == #groupId}" id="menu2">
							<li>
								<s:url value="/%{action}" var="menuURL">
									<s:param name="form.menuId" value="%{id}"/>
								</s:url>
								<s:a href="%{menuURL}"><emp:message key="${menu2.resourceKey}" language="${request_locale}"/></s:a>
							</li>
						</s:iterator>
					</ul>
				<c:choose>
					<c:when test="${parentMenuCount == 1}">
					</c:when>
					<c:otherwise>
				        </li>
					</c:otherwise>
				</c:choose>
			</s:iterator>
		</ul>	
	</div>
</div>