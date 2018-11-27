<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/front/cms/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html style="overflow-x: auto; overflow-y: auto;">
<head>
<title><sitemesh:title /></title>
<%@include file="/WEB-INF/views/member/include/head.jsp"%>
<!-- 统计代码 -->
<sitemesh:head />
</head>
<body>
<!--积分商城主菜单开始--->
<div class="wrap">
<div class=" mallnavmain mt20">
<h1 class="fl"><a href="${ctxf}/scoreStore/index.htm"><img src="${ctxStatic}/image/malllogo.png" width="189" height="60" /></a></h1>
<ul class="fl mallnav ">
			<li><a href="${ctxf}/index.htm" target=_blank>首页</a></li>
			<li><a href="${ctxf}/brand/brandList.htm" target=_blank>品牌查找</a></li>
			<li><a href="${ctxf}/product/index.htm" target=_blank>供应商</a></li>
			<li><a href="${ctxf}/purchase/index.htm" target=_blank>采购商</a></li>
			<li><a href="${ctxf}/scoreStore/index.htm" target=_blank>积分商城<i class="icon_hot icon"></i></a><i></i></li>
			<li><a href="${ctxf}/helpMenu/helpMenu.htm?cid=756000193835958272&&gid=756051886865776640" target=_blank>关于我们</a></li>
</ul>
</div></div>
<div class="clear btoomborder mt20"></div>
<!--积分商城主菜单结束--->
<sitemesh:body />
<%@ include file="/WEB-INF/views/front/include/footer.jsp"%>
</body>
</html>