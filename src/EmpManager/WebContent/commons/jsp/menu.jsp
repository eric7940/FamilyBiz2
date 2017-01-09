		<div class="nav-sm nav nav-stacked">
		</div>
		
		<ul class="nav nav-pills nav-stacked main-menu">
		
			<s:iterator value="#session.LEFT_MENU" id="menu">
		        <li class="accordion">
			        <a href="#"><i class="fa fa-wrench fa-fw" style="width: 20px"></i> ${menu.label}<span class="fa arrow"></span></a>
					<ul id="ul-${menu.id}" class="nav nav-pills nav-stacked">
						<s:iterator value="#menu.funcs" id="func">
							<li>
								<s:url value="%{url}" var="funcURL">
									<s:param name="form.menuId" value="%{id}"/>
								</s:url>
								<s:a href="%{funcURL}">${func.label}</s:a>
							</li>
						</s:iterator>
					</ul>
		        </li>
			</s:iterator>
		</ul>	
