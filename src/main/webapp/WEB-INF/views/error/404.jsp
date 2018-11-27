<%
response.setStatus(404);
//System.out.println("##########");
// 如果是异步请求或是手机端，则直接返回信息
if (Servlets.isAjaxRequest(request)) {
	out.print("页面不存在.");
}

//输出异常信息页面
else {
%>
<%@page import="com.qhwl.common.web.Servlets"%>
<%@page contentType="text/html; charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/admin/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>404 - 页面不存在</title>
	<%@include file="/WEB-INF/views/admin/include/head.jsp" %>
</head>
 <style>
      .item {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: hidden; background: #fff none no-repeat center center;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }
				 .sorry{ position:relative; font-size:32px; color:#FFF; font-weight:bold; left:610px;  top:27%; line-height:50px;}
		.anniiu{ position:relative; top:30%; left:610px;}
		.anniiu a{ width:200px; height:48px; display:inline-block; font-size:22px; border:1px solid #FFF; border-radius:4px; line-height:50px; text-align:center; text-decoration:none;font-family:"微软雅黑"; }
         .fanhui {color:#0255d0; background:#FFF; margin-right:70px;}
		 .fanhushouye {color:#FFF;}
    </style>
<body>
	<div class="item item3" style="background-image:url(${ctxStatic }/image/xinnozai.jpg)">
		<p class="sorry">非常抱歉，您访问的页面地址有误<br>或该页面不存在。</p>
		<p class="anniiu">
			<a href="javascript:" onclick="history.go(-1);"  class="fanhui">返回上一级页面</a>
			<a href="${ct}/index.htm" class="fanhushouye">返回首页</a>
		</p>
	</div>
	<script>try{top.$.jBox.closeTip();}catch(e){}</script>
</body>
</html>
<%
out.print("<!--"+request.getAttribute("javax.servlet.forward.request_uri")+"-->");
} out = pageContext.pushBody();
%>