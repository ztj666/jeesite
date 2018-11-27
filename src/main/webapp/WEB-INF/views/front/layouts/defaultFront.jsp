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
<%@ include file="/WEB-INF/views/front/include/header_all.jsp"%>
<sitemesh:body />
<%@ include file="/WEB-INF/views/front/include/footer.jsp"%>
</body>
</html>