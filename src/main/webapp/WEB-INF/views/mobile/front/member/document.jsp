<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<title>${document.title }</title>
</head>

<body style="background-color: #FFFFFF;">
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="color: white; font-size: 16px;">${document.title }</h1>
	</header>
	<div class="mui-content" style="height: 100%;">
		<div class="mui-content-padded">
		${document.content }
		</div>
	</div>
	<script type="text/javascript">
		mui.init();
	</script>
</body>
</html>