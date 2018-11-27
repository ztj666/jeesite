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
	<form id="formSer" action="${ctxw }/meeting.htm">
		<header class="mui-bar mui-bar-nav" style="background: #4AACC5;">
			<div class="mui-input-row">
				<input id="mydiv" name="subject" type="search" placeholder="搜索" /> <a class="k mui-btn mui-btn-link"
					style="color: #ffffff; font-size: 14px; margin-top: 4px;" onclick="test();">搜索 </a>
			</div>
		</header>
		<div class="mui-content">
			<input name="beginStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
				value="<fmt:formatDate value="${meeting.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" placeholder="会议开始时间"/> <input name="endStartTime" type="text"
				readonly="readonly" maxlength="20" class="input-medium Wdate "
				value="<fmt:formatDate value="${meeting.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" placeholder="会议结束时间" />
		</div>
	</form>
	<script>
		function test() {
			$('#formSer').submit();
		}
	</script>
</body>
</html>