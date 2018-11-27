/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.interceptor;

import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.qhwl.common.service.BaseService;
import com.qhwl.common.utils.StringUtils;

/**
 * Repage拦截器（带着参数重定向）
 * 
 * Repage的意思是：回到原来的页面
 * 有一个列表页，总共有数据50条，我搜索：地区=北京 的数据有10条，我想修改这个10条数据。
 * 我想每修改完一条，页面刷后，再次回到  按条件搜索：地区=北京 的列表，还显示这10条数据，我可继续修改工作
 * 
 * 使用方法：
 * 
 * 在spring mvc框架的Controller中，当你完成“修改”和“删除”工作后，为了防止表单重复提交，应当重定向到成功页(列表页)。
 * 并且带有repage参数，告诉框架你想“回到原来的页面”。 例如：
 * return "redirect:"+Global.getMemberPath()+"/buy/purchaesOrder/purchaesOrder.htm?repage";
 * 两个要素：必须以redirect:开头，必须带有repage参数。
 * 
 * 原理：
 * 
 * 使用了spring mvc的Interceptor，在每进入一个Controller的方法时，把request中的全部参数都取出来，放入一个map中，map被放入session中。
 * map的key是映射的路径名，值是全部参数串
 * 当生了重定向，并且带在repage参数，框架会查检重定向的目标，取出重定向的目标的路径做为key，从map中取参数串，如何不为空，就带参数重定向，实现了“回到原来的页面”。
 * 
 * 内存保护：
 * 
 * map中的元素数量超过100个，就清理。
 * 
 * 
 * @author 赵磊
 * @version 2016-8-13
 */
public class RepageInterceptor extends BaseService implements HandlerInterceptor {
	
	String repage="repage";
	String sessionKey="REPAGE_PARAMETER";
	String redirect="redirect:";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//请求的路径
		String path= this.getRequestUrl(request);
		//所有的参数拼接一个串
		String param=this.getAllParameter(request);
		
		//放入缓存中
		if(path!=null && !"".equals(path.trim()) && param!=null && !"".equals(param.trim())){
			@SuppressWarnings("unchecked")
			Map<String,Object> map=(Map<String,Object>)request.getSession().getAttribute(sessionKey);
			if(map==null){
				map=new ConcurrentHashMap<String,Object>();
				request.getSession().setAttribute(sessionKey, map);
			}
			if(map.size()>100){
				map.clear();
			}
			map.put(path, param);
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if (modelAndView == null){
			// 如果null，什么也不做，放过
			return ;
		}
		
		String viewName=modelAndView.getViewName();
		if(viewName!=null){
			viewName=viewName.trim();
		}
		
		if( ! StringUtils.startsWithIgnoreCase(viewName, redirect)){
			// 如果不是重定向，什么也不做，放过
			return ;
		}
		
		// 去查找viewName的URL中是否带有repage参数
		boolean hasRepage=false;
		int index=viewName.indexOf("?");
		if(index!=-1){
			String queryString=viewName.substring(index+1);
			String[] arr=queryString.split("&");
			for(String s:arr){
				if(s!=null && !"".equals(s)){
					String[] arr2=s.split("=");
					if(arr2!=null && arr2.length>0){
						String key=arr2[0];
						if(key!=null && key.equalsIgnoreCase(repage)){
							//发现了repage参数
							hasRepage=true;
							break;
						}
					}
				}
			}
		}
		
		if(!hasRepage){
			//未发现repage参数，什么也不做，放过
			return ;
		}
		
		//发现了repage参数，带着参数进行重定向
		String path=viewName;
		int index1=path.indexOf(redirect);
		if(index1!=-1){
			path=path.substring(index1+redirect.length());
		}
		int index2=path.indexOf("?");
		if(index2!=-1){
			path=path.substring(0,index2);
		}
		
		@SuppressWarnings("unchecked")
		Map<String,Object> map=(Map<String,Object>)request.getSession().getAttribute(sessionKey);
		if(map!=null){
			String param=(String)map.get(path);
			if(param!=null && !"".equals(param)){
				String joinParam="";
				if(index!=-1){
					if(viewName.endsWith("&")){
						joinParam=param;
					}else{
						joinParam="&"+param;
					}
				}else{
					joinParam="?"+param;
				}
				
				//经过url的匹配，取出了正确的参数，带着参数重定向
				modelAndView.setViewName(viewName + joinParam);
			}
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, 
			Object handler, Exception ex) throws Exception {
	}
	
	/**
	 * 从request对象中取出请求的URL
	 * 兼容Tomcat与WebSphere
	 * 
	 * @param request
	 * @return
	 */
	public String getRequestUrl(HttpServletRequest request){
		// 请求的url
		String currentUri = request.getServletPath();// 在tomcat下运行OK
		if (currentUri == null || "".equals(currentUri)) {
			currentUri = request.getPathInfo();// 在WebSphere下运行OK
		}
		return currentUri;
	}
	
	/**
	 * 从Request中取出所有参数，拼成一个串：a=1&a=2&b=2&c=3
	 * 注意：a有两个值，分别是1和2，当使用复选框提交数据时会出现这种情况
	 * 
	 *  java.net.URLEncoder.encode(v,"utf-8")
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String getAllParameter(HttpServletRequest request) {
		StringBuilder sbl = new StringBuilder();
		Map<String, String[]> map = request.getParameterMap();
		if(map==null){
			return null;
		}
		for (String key : map.keySet()) {
			
			//由于repage是关键字，所以要过滤掉repage
			if(repage.equalsIgnoreCase(key)){
				continue;
			}
			
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
}