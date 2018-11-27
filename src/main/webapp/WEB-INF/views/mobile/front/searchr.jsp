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
	<script type="text/javascript">
		
	</script>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"
			style="color: #FFFFFF;"></a>
		<h1 class="mui-title title-style" style="color:#FFFFFF">搜索结果</h1>
	</header>
	<div id="content" class="mui-content" style="background:#FFFFFF;">
		<div class="div1">专家</div>
		<hr>
		<c:forEach items="${userList}" var="item">
		<a href="${ctxw }/bigShot.htm?id=${item.id}">
		<div class="div2">
			<div style="float: left;" class="div-img">
				<img class="img" 
						src="${item.headImg }"
						onerror="this.src='${ct }${fs}${item.headImg!=null and item.headImg!=''?item.headImg:'/avatar_s.png' }@!50x50'" />
			</div>
			<div style="float: right;" class="img-text">
				${!empty item.realName? item.realName: item.name }&emsp;<span class="name">${item.domain}</span>
				<p class="name">${item.detail}</p>
			</div>
		</div>
		</a>
		</c:forEach>
		<c:if test="${empty userList}">
		<div style="color:#888888; padding-left:20px;padding-top:7px;padding-bottom:7px;">没有专家结果</div>
		</c:if>
		
		<hr>
		<div class="div1">问答/约见</div>
		<hr>
		<c:if test="${empty consultList && empty apptlist}">
		<div style="color:#888888; padding-left:20px;padding-top:7px;padding-bottom:7px;">没有问答约见结果</div>
		</c:if>
		
		<c:if test="${!empty consultList}">
		<c:forEach items="${consultList}" var="item">
		<a href="${ctxw }/My/consultDetail.htm?id=${item.id}">
		<div class="div3">
			<p style="clear:both;">${item.subject}</p>
			<div style="float: left; width: 70%;">
				<p style="padding-top: 0px; font-size: 14px; color: #888888;">
					<img align="center" src="${ctxStatic}/image/ic_tag.png"
						width="19px" height="19px" />${item.label}
				</p>
			</div>
			<div style="float: right; width: 28%; text-align: right;">
				<span class="btn">问答</span>
			</div>
		</div>
		</a>
		<hr class="solid">
		</c:forEach>
		</c:if>
		
		
		<c:if test="${!empty apptlist}">
		<c:forEach items="${apptlist}" var="item">
		<a href="${ctxw }/My/apptDetail.htm?id=${item.id}">
		<div class="div3">
			<p style="clear:both;">${item.subject}</p>
			<div style="float: left; width: 70%;">
				<p style="padding-top: 0px; font-size: 14px; color: #888888;">
					<img align="center" src="${ctxStatic}/image/ic_tag.png"
						width="19px" height="19px" />${item.label}
				</p>
			</div>
			<div style="float: right; width: 28%; text-align: right;">
				<span class="btn" style="background:#4AACC5;">约见</span>
			</div>
		</div>
		</a>
		<hr class="solid">
		</c:forEach>
		</c:if>
	</div>
	<script type="text/javascript">
		mui.init()
	</script>
</body>
</html>