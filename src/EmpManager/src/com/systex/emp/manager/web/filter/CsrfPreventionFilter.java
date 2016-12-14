package com.systex.emp.manager.web.filter;

import java.io.IOException;
import java.io.Serializable;
import java.security.SecureRandom;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import javax.servlet.http.HttpSession;

import org.apache.catalina.filters.FilterBase;
import org.apache.commons.lang3.StringUtils;
import org.apache.juli.logging.Log;
import org.apache.juli.logging.LogFactory;
import org.apache.log4j.Logger;

public class CsrfPreventionFilter extends FilterBase {

	private static final Logger logger = Logger.getLogger(CsrfPreventionFilter.class);
	private static final Log log = LogFactory.getLog(CsrfPreventionFilter.class);
	
	private final Set<String> excludeURLs;

	private String randomClass;
	private Random randomSource;
	private final Set<String> entryPoints;
	private int nonceCacheSize;
	private final Set<String> postPatterns;

	public CsrfPreventionFilter() {
		this.randomClass = SecureRandom.class.getName();
		this.entryPoints = new HashSet<String>();
		this.nonceCacheSize = 5;
		this.excludeURLs = new HashSet<String>();
		this.postPatterns = new HashSet<String>();
	}

	public void setExcludeURLs(String excludeURLs) {
		String[] values = excludeURLs.split(",");
		for (String value : values) {
			this.excludeURLs.add(value.trim());
		}
	}
	
	public void setPostPatterns(String postPatterns) {
		String[] values = postPatterns.split(",");
		for (String value : values) {
			this.postPatterns.add(value.trim());
		}
	}

	public void setEntryPoints(String entryPoints) {
		String[] values = entryPoints.split(",");
		for (String value : values) {
			this.entryPoints.add(value.trim());
		}
	}

	public void setNonceCacheSize(int nonceCacheSize) {
		this.nonceCacheSize = nonceCacheSize;
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		super.init(filterConfig);
		
//		setExcludeURLs(filterConfig.getInitParameter("excludeURLs"));
//		setEntryPoints(filterConfig.getInitParameter("entryPoints"));
//		setNonceCacheSize(Integer.parseInt(filterConfig.getInitParameter("nonceCacheSize")));
		
		try {
			Class<?> clazz = Class.forName(this.randomClass);
			this.randomSource = ((Random) clazz.newInstance());
		} catch (ClassNotFoundException e) {
			ServletException se = new ServletException("csrfPrevention.invalidRandomClass:" + this.randomClass, e);
			throw se;
		} catch (InstantiationException e) {
			ServletException se = new ServletException("csrfPrevention.invalidRandomClass:" + this.randomClass, e);
			throw se;
		} catch (IllegalAccessException e) {
			ServletException se = new ServletException("csrfPrevention.invalidRandomClass:" + this.randomClass, e);
			throw se;
		}
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		ServletResponse wResponse = null;

		if (((request instanceof HttpServletRequest)) && ((response instanceof HttpServletResponse))) {

			HttpServletRequest req = (HttpServletRequest) request;
			HttpServletResponse res = (HttpServletResponse) response;

			logger.debug(req.getMethod() + " ServletPath = " + req.getServletPath());
			boolean skip = false;
			for (String url : this.excludeURLs) {
				if (StringUtils.isNotBlank(url)) {
					if (req.getServletPath().indexOf(url) != -1) {
						skip = true;
						break;
					} else if (url.indexOf("*.") != -1) {
						// 排除的副檔名
						String type = url.replace("*", "");
						if (req.getServletPath().endsWith(type)) {
							skip = true;
						}
					}
				}
			}
			logger.debug("is exclude = " + skip);
			if (skip == false) {
			
				boolean skipNonceCheck = false;
	
//				if ("GET".equals(req.getMethod())) {
//					String path = req.getServletPath();
//					if (req.getPathInfo() != null) {
//						path = path + req.getPathInfo();
//					}
//	
//					logger.debug("path = " + path);
//					if (this.entryPoints.contains(path)) {
//						skipNonceCheck = true;
//					}
//				}
//				logger.debug("skipNonceCheck 1= " + skipNonceCheck);
//				
//				//如果是GET且不在EntryPoints清單的話，若有是從左邊menu進入的，則不檢查 (切iframe才需要如此判斷)
//				//如果是POST，且ServletPath是/login.do的話，則不檢查
//				if (/*(skipNonceCheck == false && "GET".equals(req.getMethod()) && req.getParameter("pe") != null) ||*/
//						skipNonceCheck == false && "POST".equals(req.getMethod()) && "/login.do".equals(req.getServletPath())) {
//					skipNonceCheck = true;
//				}
//				logger.debug("skipNonceCheck 2= " + skipNonceCheck);
				
				// postPatterns為要檢查, 其餘不檢查
				skipNonceCheck = true;
				for (String url : this.postPatterns) {
					if (StringUtils.isNotBlank(url)) {
						if (req.getServletPath().indexOf(url) != -1) {
							skipNonceCheck = false;
							break;
						}
					}
				}
				logger.debug("skipNonceCheck = " + skipNonceCheck);
				
				HttpSession session = req.getSession(false);
	
				@SuppressWarnings("unchecked")
				LruCache<String> nonceCache = (session != null)? (LruCache<String>) session.getAttribute("EMP.CSRF_NONCE"): null;
				logger.debug("session: " + session);
				logger.debug("nonceCache: " + nonceCache);
				
				if (!skipNonceCheck) {
					String previousNonce = req.getParameter("token");
	
					if ((nonceCache == null) || (previousNonce == null) || (!nonceCache.contains(previousNonce))) {
						
						logger.debug("token param: " + previousNonce);
						logger.error("nonceCache is null or token param is null or nonceCache not contains. (error:" + HttpServletResponse.SC_FORBIDDEN + ")");
						res.sendError(HttpServletResponse.SC_FORBIDDEN);
						return;
					}
				}
	
				if (nonceCache == null) {
					nonceCache = new LruCache<String>(this.nonceCacheSize);
					if (session == null) {
						session = req.getSession(true);
					}
					logger.debug("set session attribute: nonceCache");
					session.setAttribute("EMP.CSRF_NONCE", nonceCache);
				}
	
				String newNonce = generateNonce();
	
				nonceCache.add(newNonce);
				logger.debug("nonceCache add " + newNonce);
				
				wResponse = new CsrfResponseWrapper(res, newNonce);
			} else {
				wResponse = response;
			}
		} else {
			wResponse = response;
		}
		chain.doFilter(request, wResponse);
	}

	protected boolean isConfigProblemFatal() {
		return true;
	}

	protected String generateNonce() {
		byte[] random = new byte[16];

		StringBuilder buffer = new StringBuilder();

		this.randomSource.nextBytes(random);

		for (int j = 0; j < random.length; j++) {
			byte b1 = (byte) ((random[j] & 0xF0) >> 4);
			byte b2 = (byte) (random[j] & 0xF);
			if (b1 < 10) {
				buffer.append((char) (48 + b1));
			} else {
				buffer.append((char) (65 + (b1 - 10)));
			}
			if (b2 < 10) {
				buffer.append((char) (48 + b2));
			} else {
				buffer.append((char) (65 + (b2 - 10)));
			}
		}

		return buffer.toString();
	}

	protected static class CsrfResponseWrapper extends HttpServletResponseWrapper {
		private final String nonce;

		public CsrfResponseWrapper(HttpServletResponse response, String nonce) {
			super(response);
			this.nonce = nonce;
		}

		@Deprecated
		public String encodeRedirectUrl(String url) {
			return encodeRedirectURL(url);
		}

		public String encodeRedirectURL(String url) {
			return addNonce(super.encodeRedirectURL(url));
		}

		@Deprecated
		public String encodeUrl(String url) {
			return encodeURL(url);
		}

		public String encodeURL(String url) {
			return addNonce(super.encodeURL(url));
		}

		private String addNonce(String url) {
			if ((url == null) || (this.nonce == null)) {
				return url;
			}

			String path = url;
			String query = "";
			String anchor = "";
			int pound = path.indexOf('#');
			if (pound >= 0) {
				anchor = path.substring(pound);
				path = path.substring(0, pound);
			}
			int question = path.indexOf('?');
			if (question >= 0) {
				query = path.substring(question);
				path = path.substring(0, question);
			}
			// c:url的URL, 只有.do的才要串上nonce, 其餘的不需要
			if (path.endsWith(".do")) {
				StringBuilder sb = new StringBuilder(path);
				if (query.length() > 0) {
					sb.append(query);
					sb.append('&');
				} else {
					sb.append('?');
				}
				sb.append("token");
				sb.append('=');
				sb.append(this.nonce);
				sb.append(anchor);
				return sb.toString();
			} else {
				return url;
			}
		}
	}

	protected static class LruCache<T> implements Serializable {
		private static final long serialVersionUID = 1L;
		private final Map<T, T> cache;

		public LruCache(final int cacheSize) {
			this.cache = new LinkedHashMap<T,T>() {
				private static final long serialVersionUID = 1L;

				protected boolean removeEldestEntry(Map.Entry<T,T> eldest) {
					if (size() > cacheSize) {
						return true;
					}
					return false;
				}
			};
		}

		public void add(T key) {
			synchronized (this.cache) {
				this.cache.put(key, null);
			}
		}

		public boolean contains(T key) {
			synchronized (this.cache) {
				return this.cache.containsKey(key);
			}
		}
	}

	@Override
	protected Log getLogger() {
		return log;
	}
}
