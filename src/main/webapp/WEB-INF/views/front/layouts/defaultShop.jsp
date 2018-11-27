<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html style="overflow-x: auto; overflow-y: auto;">
<head>
<title><sitemesh:title /></title>
<%@include file="/WEB-INF/views/member/include/head.jsp"%>
<sitemesh:head />
</head>
<body>
<!---顶部灰条开始--->
<%@ include file="/WEB-INF/views/front/include/header_1.jsp"%>
<!---顶部灰条结束--->
<div class=" clear mhei"></div>
<!--logo、search 开始-->
<%@ include file="/WEB-INF/views/front/include/header_2.jsp"%>
<!--logo、search 结束-->
<div class="clear "></div>
<sitemesh:body />
<%@ include file="/WEB-INF/views/front/include/footer.jsp"%>
</body>
</html>