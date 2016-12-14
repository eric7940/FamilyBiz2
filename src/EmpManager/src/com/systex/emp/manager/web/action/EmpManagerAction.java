package com.systex.emp.manager.web.action;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.struts2.ServletActionContext;

import com.systex.emp.base.util.BaseCodeType;
//import com.systex.emp.base.util.CommonUtil;
import com.systex.emp.base.util.ConstEnumerable;
import com.systex.emp.base.util.ConstUtil;
import com.systex.emp.base.util.EnumUtil;
import com.systex.emp.base.util.ResourceKey;
import com.systex.emp.base.web.action.BaseAction;
import com.systex.emp.base.web.form.element.OptionElement;
//import com.systex.emp.manager.exception.EmpManagerException;
import com.systex.emp.manager.vo.LookupCodeVO;

public abstract class EmpManagerAction extends BaseAction {

	private static final Logger logger = Logger.getLogger(EmpManagerAction.class);
	
	private static final long serialVersionUID = -3806215287701366538L;

	protected static final String EDIT = "edit";
	protected static final String DEFAULT = "default";

	public abstract String execute();	

	public abstract String initAdd();

	public abstract String initModify();
	
	public abstract String add();

	public abstract String modify();
	
	public abstract String remove();

	public Locale getLocale() {
		return (Locale) request.getSession().getAttribute(ConstUtil.SESSION_ATTR_LOCALE);
	}

//	@SuppressWarnings("unchecked")
//	protected List<ConfigVO> getConfigs() {
//		return (List<ConfigVO>) request.getSession().getAttribute(ConstUtil.SESSION_ATTR_CONFIG);
//	}
//
//	@SuppressWarnings("unchecked")
//	protected String getConfig(String configKey) {
//		List<ConfigVO> configs = (List<ConfigVO>) request.getSession().getAttribute(ConstUtil.SESSION_ATTR_CONFIG);
//		if (configs != null && configs.size() > 0) {
//			for (ConfigVO config : configs) {
//				if (config.getConfigKey().equals(configKey))
//					return config.getConfigValue();
//			}
//		}
//		return null;
//	}

//	protected void resetConfigs(List<ConfigVO> configs) {
//		request.getSession().setAttribute(ConstUtil.SESSION_ATTR_CONFIG, configs);
//	}

//	@SuppressWarnings("unchecked")
//	protected List<LocaleVO> getLocales() {
//		return (List<LocaleVO>) context.getAttribute(ConstUtil.CONTEXT_ATTR_LOCALES);
//	}
	
//	protected void resetLocales(List<LocaleVO> locales) {
//		context.setAttribute(ConstUtil.CONTEXT_ATTR_LOCALES, locales);
//	}
	
	@SuppressWarnings("unchecked")
	protected String getLocaleMessage(String resourceKey) {
		Map<String, Map<String, String>> localeMessages = (Map<String, Map<String, String>>) context.getAttribute(ConstUtil.CONTEXT_ATTR_LOCALE_MESSAGE);
		if (localeMessages != null && localeMessages.size() > 0) {
			Map<String, String> map = localeMessages.get(resourceKey);
			Locale locale = this.getLocale();
			if (map != null && locale != null) {
				return map.get(locale.toString());
			}
		}
		return null;
	}

//	protected void reloadLocaleMessages() throws EmpManagerException {
//		CommonService commonService = (CommonService) this.getServiceFactory().getService("commonService");
//		Map<String, Map<String, String>> localeMessages = commonService.getLocaleMessages();		
//		context.setAttribute(ConstUtil.CONTEXT_ATTR_LOCALE_MESSAGE, localeMessages);
//	}
//	
//	protected void reloadLocales() throws EmpManagerException {
//		LocaleService localeService = (LocaleService) this.getServiceFactory().getService("localeService");
//		context.setAttribute(ConstUtil.CONTEXT_ATTR_LOCALES, localeService.getLocales());
//	}
//	
//	//用於 與locale變動無關，但會影響到covert後的locale的地方
//	protected void resetLocale() throws EmpManagerException {
//		CommonService commonService = (CommonService) this.getServiceFactory().getService("commonService");
//		List<LocaleVO> locales = commonService.getLocaleMapping();
//		String defaultLocale = this.getConfig(ConstUtil.ConfigKey.SYSTEM_LOCALE.name());
//		resetLocale(locales, defaultLocale);
//	}

//	private void resetLocale(List<LocaleVO> locales, String defaultLocale) throws EmpManagerException {
//		LocaleConverter.resetLocaleMapping(locales);
//		
//		Locale locale = request.getLocale();
//		Locale convertLocale = LocaleConverter.convertLocale(locale, defaultLocale);
//		
//		logger.debug("locale: " + convertLocale);
//		request.getSession().setAttribute(ConstUtil.SESSION_ATTR_LOCALE, convertLocale);
//	}

	protected List<OptionElement> list(BaseCodeType codeType) {
		return this.list(codeType, null);
	}

	protected List<OptionElement> list(BaseCodeType codeType, ResourceKey.Option option) {
		List<OptionElement> list = new ArrayList<OptionElement>();
		if (option != null) {
			list.add(this.getOptionElement(option));
		}
		if (EnumUtil.getEnum(codeType) != null) {
			for (ConstEnumerable e : EnumUtil.getEnum(codeType)) {
				if (e != null) {
					list.add(new OptionElement(e.toString(), this.getText(e.getResourceKey())));
				}
			}
		}
		return list;
	}

	protected OptionElement getOptionElement(ResourceKey.Option option) {

		OptionElement optionElement = null;
		if (option != null) {
			switch (option) {
			case all:
				optionElement = (new OptionElement("*", this.getText(option.toString())));
				break;

			case one:
				optionElement = (new OptionElement("", this.getText(option.toString())));
				break;

			default:
				break;
			}
		}
		return optionElement;
	}

	protected static List<OptionElement> convertToOptionElement(List<LookupCodeVO> list) {
		List<OptionElement> result = new ArrayList<OptionElement>();
		for (LookupCodeVO vo : list) {
			result.add(new OptionElement(vo.getCode(), vo.getLabel()));
		}
		return result;
	}
	
	/**
	 * get預設查詢頁面筆數
	 * 
	 * @return int
	 */
//	protected int getPageSize() {
//		int size = CommonUtil.toInt(this.getConfig("QUERY_PAGE_SIZE"));
//		return (size == 0 ? ConstUtil.QUERY_PAGE_SIZE : size);
//	}

	/**
	 * Response顯示Json格式
	 * 
	 * @param result
	 * @throws IOException
	 */
	protected void writeResponseJson(String result) throws IOException {
		response.setContentType("text/html");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Content-Type", "text/html; charset=utf-8");

		PrintWriter pw = response.getWriter();
		pw.write(result);
		pw.close();
	}
	
	/**
	 * 不同瀏覽器，下載中文檔名處理方式
	 * 
	 * @param fileName
	 * @return
	 * @throws Exception
	 */
	public String getDownloadFileName(String fileName) throws Exception{
		String retFileName ;
		HttpServletRequest request = ServletActionContext.getRequest();
		String userAgent = request.getHeader("User-Agent");
		if((userAgent.contains("MSIE"))||(userAgent.contains("Trident"))){
           //IE6.11正常、FF的中文部分會出現%XX%XX的代碼
			retFileName= java.net.URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
		}else{
           //Firefox / google Chrome正常，IE6檔名整個亂碼 (連副檔名都看不見)
			retFileName= new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
		}
		return retFileName;
	}
	
	/**
	 * Response下載Excel檔案
	 * @param workbook Excel檔案
	 * @param filename 檔案名稱(不含副檔名)
	 * @throws IOException
	 */
	protected void downloadFile(Workbook workbook, String filename) {
		OutputStream os = null;

		try {
			response.reset();

			// 生成文件名
			filename = new String(filename.getBytes("UTF-8"), "ISO8859-1") + ".xlsx";
			logger.debug("downloadFile:" + filename);

			response.setHeader("Content-disposition", "attachment; filename=" + filename);
			response.setContentType("application/msexcel");

			os = response.getOutputStream();
			if (workbook != null) {				
				workbook.write(os);
			}

			if (os != null) {
				os.flush();
				os.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
