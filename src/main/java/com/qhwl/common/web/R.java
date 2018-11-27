package com.qhwl.common.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;


/**
 * R工具--Request\Response便捷工具类
 * 
 * 从ThreadLocal中获得Request
 * R工具中，提供了大量的，从Request获取参数并转换为合适的类型的简便方法--是对getParameter()的封装(是最常使用工具方法)
 * 通过getRequest()方法获取Request
 * 通过getResponse()方法获取Response
 * 通过getSession()方法获取session
 * 通过Map<String,String[]> getMapAll()方法获取Request中的全部参数(一个key可以对应多个value)
 * 通过Map<String,String> getMap()方法获取Request中的全部参数（如果一个key对应多个value，只保留第一个value）
 * 如果一个key对应多个value,可以使用 String[] getArray(String paramName) 方法获取
 * R工具中，void setAttr(String key,Object value)--是对setAttribute()的封装
 * R工具中，Object getAttr(String key)--是对getAttribute()的封装
 * 
 * @author 赵磊
 * @version 创建时间：2011-4-28 下午04:29:24
 */
public class R {
	
	/**
	 * 获得Request
	 */
	public static  HttpServletRequest getRequest() {
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
	}

	/**
	 * 获取Response
	 */
	public static  HttpServletResponse getResponse() {
		return ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getResponse();
	}

	/**
	 * 获取session
	 */
	public static  HttpSession getSession() {
		return getRequest().getSession();
	}

//	/**
//	 * 把进入列表页所使用的查询参数取出来，放入cache，供第二次进入列表时使用
//	 * 用 姓名=张三，查出一个列表页，在删除、修改后一条记录后，回到原列表页，并带着查询参数
//	 */
//	public static void saveParameter2Cache(){
//		String param=R.getAllParameter();
//		getSession().setAttribute("LIST_PAGE_SELECT_PARAMETER", param);
//	}
//	/**
//	 * 从cache取出查询参数
//	 * @return
//	 */
//	public static String getParameterFromCache(){
//		return (String)getSession().getAttribute("LIST_PAGE_SELECT_PARAMETER");
//	}
	
	/**
	 * 通过Map<String,String[]> getMapAll()方法获取Request中的全部参数(一个key可以对应多个value)
	 */
	@SuppressWarnings("unchecked")
	public static  Map<String,String[]> getMapAll() {
		HttpServletRequest request = getRequest();
		return request.getParameterMap();
	}

	/**
	 * 通过Map<String,String> getMap()方法获取Request中的全部参数（如果一个key对应多个value，只保留第一个value）
	 */
	@SuppressWarnings("rawtypes")
	public static  Map<String, String> getMap() {
		Map map = getMapAll();
		Map<String, String> newMap = new HashMap<String, String>();
		for (Iterator iter = map.entrySet().iterator(); iter.hasNext();) {
			Map.Entry element = (Map.Entry) iter.next();
			String strKey = (String) element.getKey();
			String strObj = ((String[]) element.getValue())[0];
			newMap.put(strKey, strObj);
		}
		return newMap;
	}
	
	/**
	 * 如果一个key对应多个value,可以使用 String[] getArray(String paramName) 方法获取
	 * @param paramName
	 * @return
	 */
	public static  String[] getArray(String paramName) {
		HttpServletRequest request = getRequest();
		String[] arr = request.getParameterValues(paramName);
		if (arr == null) {
			return new String[0];
		}
		return arr;
	}

	/**
	 * 从Request中获取参数的值，并转换为String类型，并trim去掉前后半角空格
	 * 是对getParameter()方法的封装，是最常使用工具方法
	 * 
	 * 如果Request中无此参数(==null)，则返回默认值。
	 * 如果Request中参数值是""，则返回""。
	 * 
	 * @param paramName 参数名称
	 * @param defaultValue 默认值，可传入null
	 * @return String类型的参数值
	 * 
	 */
	public static  String get(String paramName, String defaultValue) {
		HttpServletRequest request = getRequest();
		String value = request.getParameter(paramName);
		if (value == null) {
			return defaultValue;
		} else {
			return value.trim();
		}
	}

	/**
	 * 从Request中获取参数的值，并转换为String类型，并trim去掉前后半角空格
	 * 是对getParameter()方法的封装，是最常使用工具方法
	 * 
	 * 如果Request中无此参数(==null)，则返回null。
	 * 如果Request中参数值是""，则返回""。
	 * 
	 * @param paramName 参数名称
	 * @return String类型的参数值
	 * 
	 */
	public static  String get(String paramName) {
		return get(paramName, null);
	}

	/**
	 * 从Request中获取参数的值，并转换为Float类型
	 * 
	 * 如果Request中无此参数(==null)，则返回默认值。
	 * 如果Request中有此参数，但在转换为Float类型是发生异常，则返回默认值。
	 * 如果Request中参数值是"1.5"，则返回1.5。
	 * 
	 * @param paramName 参数名称
	 * @param defaultValue 默认值，可传入null
	 * @return Float类型的参数值
	 */
	public static  Float getFloat(String paramName, Float defaultValue) {
		HttpServletRequest req = getRequest();
		String temp = req.getParameter(paramName);
		if(temp==null){
			return defaultValue;
		}
		try {
			return Float.parseFloat(temp);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}

	/**
	 * 从Request中获取参数的值("true","false")，并转换为Boolean类型
	 * 
	 * 如果Request中无此参数(==null)，则返回默认值。
	 * 如果Request中参数值是"true"，则返回true。
	 * 如果Request中参数值是非"true"，则返回false。
	 * 
	 * @param paramName 参数名称
	 * @param defaultValue 默认值，可传入null
	 * @return Boolean类型的参数值
	 */
	public static  Boolean getBoolean(String paramName, Boolean defaultValue) {
		HttpServletRequest req = getRequest();
		String temp = req.getParameter(paramName);
		if (temp == null) {
			return defaultValue;
		}
		Boolean bl=Boolean.valueOf(temp);
		return bl;
	}
	public static  Boolean getBoolean(String paramName) {
		return getBoolean( paramName, null);
	}
	
	/**
	 * 从Request中获取参数的值("1","0",等等int值)，并转换为Boolean类型
	 * @param paramName 参数名称
	 * @param _true  true值的代表(如"1","0"等)，非此值表示false,一般1表示true,0表示false
	 * @return Boolean类型的参数值
	 */
	public static  Boolean getBoolean4Int(String paramName, int _true) {
		HttpServletRequest req = getRequest();
		String temp = req.getParameter(paramName);
		if (temp == null) {
			return false;
		}
		try{
			Integer ii=Integer.parseInt(temp);
			if(ii==_true){
				return true;//一般1表示true,0表示false
			}else{
				return false;
			}
		}catch(NumberFormatException e){
			return false;
		}
	}

	/**
	 * 从Request中获取参数的值，并转换为Double类型
	 * 
	 * 如果Request中无此参数(==null)，则返回默认值。
	 * 如果Request中有此参数，但在转换为Double类型是发生异常，则返回默认值。
	 * 如果Request中参数值是"1.5"，则返回1.5。
	 * 
	 * @param paramName 参数名称
	 * @param defaultValue 默认值，可传入null
	 * @return Double类型的参数值
	 */
	public static  Double getDouble(String paramName, Double defaultValue) {
		HttpServletRequest req = getRequest();
		String temp = req.getParameter(paramName);
		if(temp==null){
			return defaultValue;
		}
		try {
			return Double.parseDouble(temp);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	public static  Double getDouble(String paramName) {
		return getDouble(paramName,null);
	}

	/**
	 * 从Request中获取参数的值，并转换为Integer类型
	 * 
	 * 如果Request中无此参数(==null)，则返回默认值。
	 * 如果Request中有此参数，但在转换为Integer类型是发生异常，则返回默认值。
	 * 如果Request中参数值是"1"，则返回1。
	 * 
	 * @param paramName 参数名称
	 * @param defaultValue 默认值，可传入null
	 * @return Integer类型的参数值
	 */
	public static  Integer getInteger(String paramName, Integer defaultValue) {
		HttpServletRequest req = getRequest();
		String temp = req.getParameter(paramName);
		if(temp==null){
			return defaultValue;
		}
		try {
			return Integer.parseInt(temp);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	public static  Integer getInteger(String paramName) {
		return getInteger(paramName, null);
	}

	/**
	 * 从Request中获取参数的值，并转换为Long类型
	 * 
	 * 如果Request中无此参数(==null)，则返回默认值。
	 * 如果Request中有此参数，但在转换为Long类型是发生异常，则返回默认值。
	 * 如果Request中参数值是"1"，则返回1。
	 * 
	 * @param paramName 参数名称
	 * @param defaultValue 默认值，可传入null
	 * @return Long类型的参数值
	 */
	public static  Long getLong(String paramName, Long defaultValue) {
		HttpServletRequest req = getRequest();
		String temp = req.getParameter(paramName);
		if(temp==null){
			return defaultValue;
		}
		try {
			return Long.parseLong(temp);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	public static  Long getLong(String paramName) {
		return getLong(paramName, null);
	}
	
	/**
	 * 从Request中获取参数的值，并转换为Byte类型
	 * 
	 * 如果Request中无此参数(==null)，则返回默认值。
	 * 如果Request中有此参数，但在转换为Byte类型是发生异常，则返回默认值。
	 * 如果Request中参数值是"1"，则返回1。
	 * 
	 * @param paramName 参数名称
	 * @param defaultValue 默认值，可传入null
	 * @return Byte类型的参数值
	 */
	public static  Byte getByte(String paramName, Byte defaultValue) {
		HttpServletRequest req = getRequest();
		String temp = req.getParameter(paramName);
		if(temp==null){
			return defaultValue;
		}
		try {
			return Byte.parseByte(temp);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	public static  Byte getByte(String paramName) {
		return getByte(paramName,null);
	}
	
	/**
	 * 从Request中获取参数的值，并转换为Short类型
	 * 
	 * 如果Request中无此参数(==null)，则返回默认值。
	 * 如果Request中有此参数，但在转换为Short类型是发生异常，则返回默认值。
	 * 如果Request中参数值是"1"，则返回1。
	 * 
	 * @param paramName 参数名称
	 * @param defaultValue 默认值，可传入null
	 * @return Short类型的参数值
	 */
	public static  Short getShort(String paramName, Short defaultValue) {
		HttpServletRequest req = getRequest();
		String temp = req.getParameter(paramName);
		if(temp==null){
			return defaultValue;
		}
		try {
			return Short.parseShort(temp);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	
	public static  Short getShort(String paramName) {
		return getShort( paramName, null);
	}
	
	/**
	 * 从Request中获取参数的值，并转换为Date类型
	 * 
	 * 如果Request中无此参数(==null)，则返回默认值。
	 * 如果Request中有此参数，但在转换为Date类型是发生异常，则返回默认值。
	 * 如果Request中参数值是"1"，则返回1。
	 * 
	 * @param paramName 参数名称
	 * @param format 日期时间的格式，一般如："yyyy-MM-dd HH:mm:ss"
	 * @param defaultValue 默认值，可传入null
	 * @return Date类型的参数值
	 */
	public static  Date getDate(String paramName, String format,Date defaultValue) {
		HttpServletRequest req = getRequest();
		String sDateTime = req.getParameter(paramName);
		if(sDateTime==null){
			return defaultValue;
		}
		Date date = null;
		if ((null != sDateTime) && (0 <= sDateTime.length())) {
			try {
				date = (Date) (new SimpleDateFormat(format)).parseObject(sDateTime);
			} catch ( ParseException e) {
				return defaultValue;// 不需要抛出异常
			}
		}
		return date;
	}
	
	public static  Date getDate(String paramName, String format) {
		return getDate(paramName,format);
	}

	/**
	 * R工具中，void setAttr(String key,Object value)--是对setAttribute()的封装
	 * @param key
	 * @param value
	 */
	public static  void setAttr(String key,Object value){
		HttpServletRequest request = getRequest();
		request.setAttribute(key, value);
	}
	
	/**
	 * R工具中，Object getAttr(String key)--是对getAttribute()的封装
	 * @param key
	 * @return
	 */
	public static  Object getAttr(String key){
		HttpServletRequest request = getRequest();
		Object obj=request.getAttribute(key);
		return obj;
	}
	
	/**
	 * 调用request对象的forward方法 ，转发请求
	 * HttpServletRequest、HttpServletResponse从当前线程中获取
	 * 
	 * @param path
	 * @throws ServletException
	 * @throws IOException
	 */
	public static void forward(String path) {
		HttpServletRequest request = getRequest();
		HttpServletResponse response= getResponse() ;
		try {
			request.getRequestDispatcher(path).forward(request, response);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 调用HttpServletResponse的sendRedirect方法，重定向
	 * @param url
	 * @throws IOException
	 */
	public static void redirect(String url){
		HttpServletResponse response= getResponse() ;
		try {
			response.sendRedirect(url);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 注意：本方法未开发完成
	 * 从Request中取出所有参数，拼成一个串：{a=[1,2],b=2,c=2}
	 * 注意：a有两个值，分别是1和2，当使用复选框提交数据时会出现这种情况
	 * 
	 * @return
	 */
	public static String getAllParameterJson() {
		StringBuilder sbl = new StringBuilder();
		sbl.append("{");
		Map<String,String[]> map = getMapAll();
		int k = 0;
		for (String key:map.keySet()) {
			String[] valueArr = map.get(key);
			sbl.append(key);
			sbl.append(":");
			if (valueArr.length == 1) {
				sbl.append(valueArr[0]);
			} else {
				sbl.append("[");
				for (int i = 0; i < valueArr.length; i++) {
					String value = valueArr[0];
					sbl.append(value);
					if (i < valueArr.length - 1) {
						sbl.append(",");
					}
				}
				sbl.append("]");
			}

			if (k < map.keySet().size() - 1) {
				sbl.append(",");
			}
			k++;
		}
		sbl.append("}");
		return sbl.toString();
	}

	/**
	 * 从Request中取出所有参数，拼成一个串：a=1&a=2&b=2&c=3
	 * 注意：a有两个值，分别是1和2，当使用复选框提交数据时会出现这种情况
	 * 
	 *  java.net.URLEncoder.encode(v,"utf-8")
	 * 
	 * @return
	 */
	public static String getAllParameter() {
		StringBuilder sbl = new StringBuilder();
		Map<String, String[]> map = getMapAll();
		if(map==null){
			return null;
		}
		for (String key : map.keySet()) {
			String[] valueArr = map.get(key);//取出一个数组
			for (int i = 0; i < valueArr.length; i++) {
				sbl.append(key);
				sbl.append("=");
				try {
					String v=valueArr[i];
					String v2 = java.net.URLEncoder.encode(v,"utf-8");//中文编码的处理
					sbl.append(v2);
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}   
				
				sbl.append("&");
			}
		}
		if(sbl.length()>0){
		    return sbl.substring(0, sbl.length() -1);
		}else{
			return sbl.toString();
		}
	}
	
	public static void writeHtml(String html,String encoding){
		HttpServletResponse response=R.getResponse();
		if(html==null){
			return;
		}
		if(encoding==null){
			encoding="UTF-8";
		}
		try {
			response.setContentType("text/html;charset="+encoding); //设置编码
			response.setCharacterEncoding(encoding); //设置编码
	        response.setHeader("Pragma", "No-cache");
	        response.setHeader("Cache-Control", "no-cache");
	        response.setDateHeader("Expires", 0);
	        PrintWriter out = response.getWriter();
			out.write(html);
	        out.flush();
	        out.close();
		} catch (IOException e) {
			//logger.error("向浏览器输出HTML异常", e);
		}
	}
	public static void writeJson(String json,String encoding){
		HttpServletResponse response=R.getResponse();
		if(json==null){
			return;
		}
		if(encoding==null){
			encoding="UTF-8";
		}
		try {
			response.setContentType("application/json;charset="+encoding);
			response.setCharacterEncoding(encoding); //设置编码
	        response.setHeader("Pragma", "No-cache");
	        response.setHeader("Cache-Control", "no-cache");
	        response.setDateHeader("Expires", 0);
	        PrintWriter out = response.getWriter();
			out.write(json);
	        out.flush();
	        out.close();
		} catch (IOException e) {
			//logger.error("向浏览器输出HTML异常", e);
		}
	}

	public static String getCtx() {
		return getRequest().getContextPath();
	}
	
	/** 
	   * 获取用户真实IP地址，不使用request.getRemoteAddr();的原因是有可能用户使用了代理软件方式避免真实IP地址, 
	   * 
	   * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值，究竟哪个才是真正的用户端的真实IP呢？ 
	   * 答案是取X-Forwarded-For中第一个非unknown的有效IP字符串。 
	   * 
	   * 如：X-Forwarded-For：192.168.1.110, 192.168.1.120, 192.168.1.130, 
	   * 192.168.1.100 
	   * 
	   * 用户真实IP为： 192.168.1.110 
	   * 
	   * @param request 
	   * @return 
	   */
	  @SuppressWarnings("unchecked")
	public static String getIpAddress(HttpServletRequest request) { 
	    String ip = null; 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	      ip = request.getHeader("x-forwarded-for"); 
	    }
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	    	ip = request.getHeader("x-real-ip");
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	    	ip = request.getHeader("Proxy-Client-IP"); 
	    } 

	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	      ip = request.getHeader("WL-Proxy-Client-IP"); 
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	      ip = request.getHeader("HTTP_CLIENT_IP"); 
	    } 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	      ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
	    } 

	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	      ip = request.getRemoteAddr(); 
	    } 
	    Enumeration<String> eee=request.getHeaderNames();
	    while(eee.hasMoreElements()){
	    	String headName=eee.nextElement();
	    	String value=request.getHeader(headName);
	    	System.out.println(headName);
	    }
	    
	    return ip; 
	  } 
}