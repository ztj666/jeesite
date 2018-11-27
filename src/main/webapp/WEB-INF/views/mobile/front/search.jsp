<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>搜索</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link href="${ctxStatic}/css/main/search.css" rel="stylesheet" />
</head>
<body>
	<script src="${ctxStatic}/js/mui.min.js"></script>
	<script type="text/javascript">
		mui.init()
	</script>
	<header class="mui-bar mui-bar-nav" style="background: #4AACC5;">
	
		<div class="mui-input-row">
			<form id="formSer" action="${ctxw }/bigShot/searchr.htm">
				<input id="mydiv" name="name" type="search" placeholder="搜索" /> <a class="k mui-btn mui-btn-link"
					style="color: #ffffff; font-size: 14px; margin-top: 4px;" onclick="submit();">搜索</a>
			</form>
		</div>
	</header>
	<div class="mui-content"></div>
	<script>
		function submit() {
			$('#formSer').submit();
		}
	</script>
</body>
</html>