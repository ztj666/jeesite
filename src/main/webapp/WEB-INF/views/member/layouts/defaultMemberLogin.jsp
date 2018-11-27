<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html style="overflow-x: auto; overflow-y: auto;">
<head>
<title><sitemesh:title /></title>
<%@include file="/WEB-INF/views/member/include/head.jsp"%>
<sitemesh:head />
</head>
<body>
	<header>
		
	</header>
	<sitemesh:body />
	<footer>
		<div class="clear"></div>
		<div class="footer">
			<div class="clear mhei"></div>
			<div class="wrap contact">

				<p>
					<a href="#">慧聪芯城</a> | <a href="#">商家入驻</a> | <a href="#">人才招聘</a>
					| <a href="#">问题反馈</a> | <a href="${ctxf}/helpMenu/helpMenu.htm?cid=756058458367066112&&gid=756059374856044544">联系我们</a> | <a href="#">网站导航</a>
					| <a href="#">法律声明</a> | <a href="#">客服中心</a> | <a href="#">友情链接</a>
				<p>
					客服：010-80707000 客服传真：010-80707000-5 买卖通咨询热线：400-6360-888（免长途费）
					010-80706099 传真：010-80706009-9</br> 版权所有 慧聪网 京ICP证010051号
					广告经营许可证：京昌工商厂字第0029号</br> Copyright@2000-2014 hc360.com. All Rights
					Reserved
				</p>
			</div>
		</div>
	</footer>
</body>
</html>