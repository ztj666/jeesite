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
		<form action="${ctxw }/expert.htm" method="post">
			<input type="search" name="name" value="${name }" class="mui-input-clear" placeholder="大咖（姓名）"
				style="color: black; background: #F6F4F4; width: 80%; border-radius: 100px; margin-left: -10px; margin-right: 0px; font-size: 14px;">
			<button type="submit" style="background-color: #FFAC5B;margin-top:2px; font-size: 14px; color: white;">搜索</button>
		</form>
	</div>
	<form id="subForm" action="${ctxw }/expert/save.htm" method="post">
		<div id="content" style="position: absolute; top: 85px; height: 395px; width: 100%; background-color: white; min-height: 86%">
			<ul class="mui-table-view mui-table-view-chevron" style="min-height: 540px;">
				<c:forEach items="${userList}" var="item">
					<li class="mui-table-view mui-table-view-cell mui-input-row mui-checkbox" style="height: 80px;"><a class=""
						href="${ctxw }/mine/myPage.htm?id=${item.id}" style="width: 50px"><img style="border-radius: 100px;" src="${item.headImg }"
							onerror="this.src='${ct }${fs}${item.headImg!=null and item.headImg!=''?item.headImg:'/avatar_s.png' }@!50x50'" width="50px" height="50px"></a>
						<p class="expert_div_name">${item.realName }</p> <img src="${ctxStatic }/image/ic_approval.png" class="expert expert_div_cer">
						<p class="expert_div_industry">${item.position }</p>
						<p class="expert_div_intro" style="word-break: keep-all; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${item.detail }</p> <input
						name="checkbox" value="${item.id }" type="checkbox" class="expert_div_duigou"></li>
				</c:forEach>
				<li style="height: 80px;"></li>
				<li style="height: 80px;"></li>
			</ul>
		</div>
		<div id="subBut"
			style="position: fixed; *position: absolute; top: 489px; left: 20px; right: 20px; height: 44px; background-color: #ffac5b; border-radius: calc(5px);">
			<p style="position: relative; top: 13px; width: 64px; margin: auto; color: white;">申请认证</p>
		</div>
		<p style="position: fixed; *position: absolute; top: 543px; left: 35px; right: 15px; font-size: small;">注:72小时内只能申请一次,请选择3~5位专家</p>
	</form>
	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			var subBut = doc.getElementById('subBut');
			subBut.addEventListener('tap', function(event) {
				$('#subForm').submit();
			});
		}(mui, document));
	</script>
</body>
</html>