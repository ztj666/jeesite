<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>大咖认证</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
</head>
<body background="#FFFFFF">
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5; width: 100%;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white;">大咖认证</h1>
	</header>
	<div style="position: absolute; top: 45px; width: 100%; background-color: #F6F4F4; height: 40px;">
			<input type="search" name="name" class="mui-input-clear" placeholder="您收到${fn:length(userList) }条认证请求" readonly="readonly"
				style="color: black; background: #F6F4F4; width: 100%; border-radius: 100px; margin-left: -10px; margin-right: 0px; font-size: 14px;">
	</div>
	<form id="subForm" action="${ctxw }/expert/save2.htm" method="post">
	<input type="hidden" name="status" value="2">
		<div id="content" style="position: absolute; top: 85px; height: 395px; width: 100%; background-color: white; min-height: 86%">
			<ul class="mui-table-view mui-table-view-chevron" style="min-height: 540px;">
				<c:forEach items="${userList}" var="item">
					<li class="mui-table-view mui-table-view-cell mui-input-row mui-checkbox" style="height: 80px;"><a class=""
						href="${ctxw }/mine/myPage.htm?id=${item.recordUser.id}" style="width: 50px"><img style="border-radius: 100px;" src="${item.recordUser.headImg }"
							onerror="this.src='${ct }${fs}${item.recordUser.headImg!=null and item.recordUser.headImg!=''?item.recordUser.headImg:'/avatar_s.png' }@!50x50'" width="50px" height="50px"></a>
						<p class="expert_div_name">${item.recordUser.realName }</p> 
						<p class="expert_div_industry">${item.recordUser.position }</p>
						<p class="expert_div_intro" style="word-break: keep-all; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${item.recordUser.detail }</p> <input
						name="checkbox" value="${item.id }" type="checkbox" class="expert_div_duigou"></li>
				</c:forEach>
				<li style="height: 80px;"></li>
				<li style="height: 80px;"></li>
			</ul>
		</div>
		<div id="subCal"
			style="position: fixed; *position: absolute; top: 529px; left: 20px; right: 50%; margin-right: 20px; height: 44px; background-color: #555555; border-radius: calc(5px);">
			<p style="position: relative; top: 13px; margin: auto; color: white; width: 38px;">忽略</p>
		</div>

		<div id="subBut"
			style="position: fixed; *position: absolute; top: 529px; left: 50%; right: 20px; margin-left: 20px; height: 44px; background-color: #FFAC5B; border-radius: calc(5px);">
			<p style="position: relative; top: 13px; margin: auto; color: white; width: 38px;">同意</p>
		</div>
	</form>
	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			var subBut = doc.getElementById('subBut');
			var subCal = doc.getElementById('subCal');
			subCal.addEventListener('tap', function(event) {
				$('input[name=status]').val('3');
				$('#subForm').submit();
			});
			subBut.addEventListener('tap', function(event) {
				$('#subForm').submit();
			});
		}(mui, document));
	</script>
</body>
</html>