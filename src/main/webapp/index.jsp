<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.qhwl.common.config.Global" %>
<%
//作用：转发进入首页的Controller
//当浏览器访问网站的首页时，地址可能是：http://www.abc.com/,这个请求会被index.jsp处理（因web.xml中配置的welcome-file-list中有index.jsp）
//由FDP的spring mvc只拦截*.do、*.htm后缀，所以不可以拦截住这个请求，spring mvc无机会处理这个请求。
//所以要重定向到index.do (用转发不行，servlet-2.4中Filter默认下只拦截外部提交的请求，forward和include这些内部转发都不会被过滤)
String ctx = request.getContextPath();

String adminPath=Global.getAdminPath();
response.sendRedirect(ctx + adminPath + "/index.do");

//String wxPath=Global.getWxPath();
//response.sendRedirect(ctx + wxPath + "/index.htm");

//String frontPath=Global.getFrontPath();
//String urlSuffix=Global.getUrlSuffix();
//response.sendRedirect(ctx + frontPath + "/index"+urlSuffix);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>正在转入首页</title>
</head>
<body>正在转入首页
</body>
</html>
