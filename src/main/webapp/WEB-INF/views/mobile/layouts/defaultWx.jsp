<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html style="overflow-x: auto; overflow-y: auto;">
<head>
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<title><sitemesh:title /></title>
<%@include file="/WEB-INF/views/mobile/include/head.jsp"%>
<!-- <script src="http://s11.cnzz.com/z_stat.php?id=1260531594&web_id=1260531594" language="JavaScript"></script> -->
<sitemesh:head />
</head>
<body>
	<header> </header>
	<div style="display: none;">
		<sys:message content="${message}" />
	</div>
	<sitemesh:body />
	<%
		if (request.getParameter("subscribe") != null && request.getParameter("subscribe").equals("0")) {
	%>
	<div id="my-div-release">
		<button id="my-btn-close"></button>
		<div style="margin: 16% 30px 0 30px; text-align: center; background: #FFFFFF">
			<img alt="" src="${ctxStatic }/image/logo_app.png" width="224px" height="90px" style="margin-top: 10px">
			<h4 style="margin-top: 10px">
				精准医疗行业移动互联信息服务提供商
				</h5>
				<img alt="" src="${ctxStatic }/image/qrcode_for_gh_70b8a0809198_430.jpg" width="220px" height="220px">
				<p style="font-family: .PingFangSC-Medium; font-size: 12px; color: #4AACC5;">长按上图，选择“识别图中的二维码”关注我们</p>
				<div style="height: 17px"></div>
		</div>
	</div>
	<script type="text/javascript">
		(function($, doc) {
			$.init();
			var releaseDiv = document.getElementById('my-div-release');
			releaseDiv.style.display = 'block';
			var myBtnClose = document.getElementById('my-btn-close');
			myBtnClose.addEventListener('tap', function(event) {
				releaseDiv.style.display = 'none';
			});
		}(mui, document));
	</script>
	<%
		}
	%>
	<footer> </footer>
</body>
</html>