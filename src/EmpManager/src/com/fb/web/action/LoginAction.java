package com.fb.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.fb.service.AuthenticationService;
import com.fb.util.ConstUtil;
import com.fb.vo.MenuFuncVO;
import com.fb.vo.MenuVO;
import com.fb.vo.UserVO;

public class LoginAction extends BaseAction {

	private static final long serialVersionUID = -4225192769241250325L;

	private static final Logger logger = Logger.getLogger(LoginAction.class);

	private String userId;
	private String password;

	private Boolean error;

	public String execute() {
		error = false;
		if (userId.equals("")) {
			addLocalizationActionError("login.error.required.userId");
			error = true;
		} else if (password.equals("")) {
			addLocalizationActionError("login.error.required.password");
			error = true;
		} 
	
		if (error) {
			return INPUT;
		} 

		try {
			AuthenticationService service = (AuthenticationService) this.getServiceFactory().getService("authentication");
			UserVO user = service.login(userId, password);
			if (user == null) {
				addLocalizationActionError("login.error.invalid");
				error = true;
			} else {	
				logger.debug("login success: " + user.getId() + ", " + user.getName());
				request.getSession().setAttribute(ConstUtil.SESSION_ATTR_USER, user.getId());
				request.getSession().setAttribute(ConstUtil.SESSION_ATTR_USER_INFO, user);
				
				logger.debug("locale: " + request.getLocale());
				request.getSession().setAttribute(ConstUtil.SESSION_ATTR_LOCALE, request.getLocale());

				List<MenuFuncVO> menuFuncs = service.getMenuFunctions(user);
				
				Map<Integer,List<MenuFuncVO>> menuFuncMap = new HashMap<Integer,List<MenuFuncVO>>();
				List<List<MenuFuncVO>> orderMenuFuncList = new ArrayList<List<MenuFuncVO>>();
				
				for(MenuFuncVO func : menuFuncs) {
					MenuVO menu = func.getMenu();
					List<MenuFuncVO> funcList = menuFuncMap.get(menu.getId());
					if (funcList == null) {
						funcList = new ArrayList<MenuFuncVO>(); 
						orderMenuFuncList.add(funcList);
					}
					funcList.add(func);
					menuFuncMap.put(menu.getId(), funcList);
				}
				
				List<MenuVO> menus = new ArrayList<MenuVO>();
				Iterator<List<MenuFuncVO>> it = orderMenuFuncList.iterator();
				while(it.hasNext()) {
					List<MenuFuncVO> funcList = it.next();
					MenuVO menu = funcList.get(0).getMenu();
					menu.setFuncs(menuFuncMap.get(menu.getId()));
					menus.add(menu);
				}
				
				logger.info("left menu = " + menus);
				request.getSession().setAttribute(ConstUtil.SESSION_ATTR_LEFT_MENU, menus);
				
			}
			
		} catch (Exception e) {
			logger.error("action fail.", e);
			addActionError(e);
			error = true;
		}
		
		return error? INPUT: SUCCESS;
	}

	public String logout() {
		request.getSession().setAttribute(ConstUtil.SESSION_ATTR_USER, null);
		request.getSession().removeAttribute(ConstUtil.SESSION_ATTR_USER);
		return SUCCESS;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
