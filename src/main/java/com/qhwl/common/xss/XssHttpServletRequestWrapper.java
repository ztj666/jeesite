package com.qhwl.common.xss;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.lang3.StringEscapeUtils;

/**
 * 关键是XssHttpServletRequestWrapper的实现方式，继承servlet的HttpServletRequestWrapper，并重写相应的几个有可能带xss攻击的方法
 * <p>标题: </p>
 * <p>描述: </p>
 * <p>公司: 谦亨科技 www.qhwl.net</p>
 * @author zhaolei
 * @date 2016年8月1日 上午12:37:53
 */
public class XssHttpServletRequestWrapper extends HttpServletRequestWrapper {

	public XssHttpServletRequestWrapper(HttpServletRequest request) {
		super(request);
	}

	@Override
	public String getHeader(String name) {
		return StringEscapeUtils.escapeHtml4(super.getHeader(name));
	}

	@Override
	public String getQueryString() {
		//赵磊注释 2016-8-13 (花了两天时间才找到原因)
		//我在本项目中，重点使用了redirectAttributes.addFlashAttribute("message", "保存成功");
		//如果这里使用StringEscapeUtils工具对super.getQueryString()的值进行了处理，a=1&b=2  会被处理成  a=1&amp;b=2  
		//就会干扰AbstractFlashMapManager的正常工作，AbstractFlashMapManager中进行匹配，既要匹配url,也要匹配参数的名字和数量。
		//显然“b”和“amp;b”是无法匹配的，就会导致无法取出message参数。
		//所以getQueryString()方法要保持原样，不可以被StringEscapeUtils工具转码。
		//return StringEscapeUtils.escapeHtml4(super.getQueryString());
		
		return super.getQueryString();
	}

	@Override
	public String getParameter(String name) {
		return StringEscapeUtils.escapeHtml4(super.getParameter(name));
	}

	@Override
	public String[] getParameterValues(String name) {
		String[] values = super.getParameterValues(name);
		if (values != null) {
			int length = values.length;
			String[] escapseValues = new String[length];
			for (int i = 0; i < length; i++) {
				escapseValues[i] = StringEscapeUtils.escapeHtml4(values[i]);
			}
			return escapseValues;
		}
		return super.getParameterValues(name);
	}

	public static void main(String[] args) {
		String html = " ' \"  <  > & 中文";
		String s = StringEscapeUtils.escapeHtml4(html);
		System.out.println(s);
		// 输出的是  ' &quot;  &lt;  &gt; &amp;    可能会造成破坏的符号都被转义了，单引号未转义，中文未被转义，总体满意。

		String s2 = StringEscapeUtils.unescapeHtml4(s);
		System.out.println(s2);
		// 输出  ' "  <  > & 
	}

}