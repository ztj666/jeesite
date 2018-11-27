package com.qhwl.member.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jfinal.weixin.sdk.api.SnsAccessTokenApi;
import com.qhwl.common.config.Global;
import com.qhwl.common.web.Servlets;
import com.qhwl.member.util.LoginUtil;

public class LoginFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// 获得在下面代码中要用的request,response,session对象
		HttpServletRequest servletRequest = (HttpServletRequest) request;
		HttpServletResponse servletResponse = (HttpServletResponse) response;

		// 获得用户请求的URI
		String path = servletRequest.getRequestURI() + "?" + servletRequest.getQueryString();
//		User memberUser=new User();
//		memberUser.setId("773689985728512000");
//		memberUser.setWxId("otTFHwmIHSUZbUwqhL0-PH1wT1KA");
//		memberUser.setType("2");
//		LoginUtil.setLoginUser(servletRequest, memberUser);
		// 从session里取员工工号信息
		String username = LoginUtil.getLoginUser(servletRequest) != null
				? LoginUtil.getLoginUser(servletRequest).getBak1() : null;
		// 判断如果没有取到员工信息,就跳转到登陆页面
		if ((username == null || "".equals(username)) && !path.contains("login.htm")) {
			if (Servlets.isAjaxRequest2(servletRequest)) {
				// 如果是AJAX异步请求，则直接返回JSON信息
				servletResponse.setContentType("text/plain;charset=UTF-8");// 为了解决ie下载的问题，必须使用text/plain头
				servletResponse.setCharacterEncoding("UTF-8"); // 设置编码
				servletResponse.setHeader("Pragma", "No-cache");
				servletResponse.setHeader("Cache-Control", "no-cache");
				servletResponse.setDateHeader("Expires", 0);
				PrintWriter out = response.getWriter();
				out.write("{\"isLogin\":false}");// 请在这里返JSON串，有客户端自行弹出登录窗口完成Ajax登录
				out.flush();
				out.close();
				return;
			} else {
				String ua = servletRequest.getHeader("user-agent").toLowerCase();
				if (ua.indexOf("micromessenger") > 0) {// 是微信浏览器
					// 跳转到登陆
					servletRequest.getSession().setAttribute("path", path);
					servletResponse.sendRedirect(SnsAccessTokenApi.getAuthorizeURL(Global.getConfig("appId"),
							"http://"+Global.getDoMainPath()+"/auth.htm", null, false));
				} else {
					servletResponse.sendRedirect(servletRequest.getContextPath() + "/index.htm?subscribe=0");
				}
			}
		} else {
			// 已经登陆,继续此次请求
			chain.doFilter(request, response);
		}
	}

	@Override
	public void destroy() {

	}

}