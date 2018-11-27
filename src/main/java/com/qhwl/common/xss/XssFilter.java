package com.qhwl.common.xss;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * XssFilter xss过滤器
 * 主要原理是用到commons-lang3-3.1.jar这个包的org.apache.commons.lang3.StringEscapeUtils.escapeHtml4()这个方法。
 * 解决过程主要在用户输入和显示输出两步：在输入时对特殊字符如<>" ' & 转义，在输出时用jstl的fn:excapeXml("xxx")方法。
 * 在页面显示数据的时候，只是简单地用fn:escapeXml()对有可能出现xss漏洞的地方做一下转义输出。
 * 另外，有些情况不想显示过滤后内容的话，可以用StringEscapeUtils.unescapeHtml4()这个方法，把StringEscapeUtils.escapeHtml4()转义之后的字符恢复原样。
 * 
 * <filter>  
 * <filter-name>XssEscape</filter-name>  
 * <filter-class>com.qhwl.common.xss.XssFilter</filter-class>  
 * </filter>  
 * <filter-mapping>  
 * <filter-name>XssEscape</filter-name>  
 * <url-pattern>/*</url-pattern>  
 * <dispatcher>REQUEST</dispatcher>  
 * </filter-mapping>
 * 
 * <p>标题: </p>
 * <p>描述: </p>
 * <p>公司: 谦亨科技 www.qhwl.net</p>
 * @author zhaolei
 * @date 2016年8月1日 上午12:38:33
 */
public class XssFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest new_request =new XssHttpServletRequestWrapper((HttpServletRequest) request);
		chain.doFilter(new_request, response);
	}

	@Override
	public void destroy() {
	}
}