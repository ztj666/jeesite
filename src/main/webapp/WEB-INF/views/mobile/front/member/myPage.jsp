<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>个人主页</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
<style type="text/css">
.mui-ios .mui-table-view-cell1 {
	-webkit-transform-style: preserve-3d;
	transform-style: preserve-3d;
}

.mui-table-view-chevron .mui-table-view-cell1 {
	padding-right: 65px;
}

.mui-table-view-cell1 {
	position: relative;
	overflow: hidden;
	padding: 11px 15px;
	-webkit-touch-callout: none;
}

.mui-table-view1 {
	position: relative;
	margin-top: 0;
	margin-bottom: 0;
	padding-left: 0;
	list-style: none;
	background-color: #fff;
}
</style>
</head>
<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5; width: 100%;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white;">${memberUser.name }</h1>
	</header>
	<img src="${ctxStatic}/image/back.jpg" class="myPage_pic">
	<img id="headImg" src="${memberUser.headImg }" onerror="this.src='${ct }${fs}${memberUser.headImg!=''?memberUser.headImg:'/avatar_s.png' }@!120x120'"
		style="border-radius: 100px;" class="myPage_myImage">
	<p class="myPage_name" style="right: 47.5%">${memberUser.realName!=null&&memberUser.realName!=''?memberUser.realName:memberUser.name }</p>
	<c:if test="${memberUser.type==2 }">
		<img src="${ctxStatic}/image/ic_approval.png" style="position: absolute; top: 236px; left: 55%; width: 20px; height: 20px;">
	</c:if>
	<p class="myPage_name" style="top: 266px;">${memberUser.orgName }</p>
	<p style="position: absolute; top: 266px; left: 51%; height: 20px;">${memberUser.position }</p>


	<div class="myPage_div">
		<img src="${ctxStatic}/image/ic_tag_blue.png" class="myPage_div_image">
		<p class="myPage_div_title" style="width: 20%">我擅长</p>
		<div class="myPage_div_line"></div>
		<p class="myPage_div_text">
			<c:forEach items="${labelList }" var="item">
			${item.label.name }&nbsp;&nbsp;
			</c:forEach>
		</p>
		<img src="${ctxStatic}/image/ic_doc_blue.png" class="myPage_div_image" style="top: 88px; width: 13px; height: 16px;">
		<p class="myPage_div_title" style="top: 86px;">简介</p>
		<div class="myPage_div_line" style="top: 110px;"></div>
		<p class="myPage_div_text" style="height: 100px; top: 122px; overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */ text-overflow: ellipsis;">${memberUser.detail }</p>
	</div>
	<img src="${ctxStatic}/image/ic_share_blue.png" class="myPage_div_image" style="top: 530px; left: 20px; width: 12px; height: 13px;">
	<p class="myPage_div_title" style="top: 526px; width: 60px; left: 40px;">社交账号</p>
	<div id="" class="myPage_div_line" style="top: 550px; left: 20px; right: 20px;"></div>

	<div id="content" style="position: absolute; top: 554px; width: 100%;">
		<ul class="mui-table-view1 mui-table-view-chevron" style="background-color: transparent;">
			<li class="mui-table-view mui-table-view-cell" style="height: 50px; background-color: transparent;">
				<div class="mui-input-row" style="border: 0px">
					<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">手机号</label> <input type="text" name="realName"
						value="${memberUser.phone }" class="mui-input" style="float: left;" readonly="readonly" maxlength="32" />
				</div>
			</li>
			<li class="mui-table-view mui-table-view-cell" style="height: 50px; background-color: transparent;">
				<div class="mui-input-row" style="border: 0px">
					<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">微信号</label> <input type="text" name="realName"
						value="${memberUser.fax }" class="mui-input" style="float: left;" readonly="readonly" maxlength="32" />
				</div>
			</li>
			<li class="mui-table-view mui-table-view-cell" style="height: 50px; background-color: transparent;">
				<div class="mui-input-row" style="border: 0px">
					<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">公众号</label> <input type="text" name="realName"
						value="${memberUser.blog }" class="mui-input" style="float: left;" readonly="readonly" maxlength="32" />
				</div>
			</li>
			<li class="mui-table-view mui-table-view-cell" style="height: 50px; background-color: transparent;">
				<div class="mui-input-row" style="border: 0px">
					<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">微博</label> <input type="text" name="realName"
						value="${memberUser.weibo }" class="mui-input" style="float: left;" readonly="readonly" maxlength="32" />
				</div>
			</li>
			<li class="mui-table-view mui-table-view-cell" style="height: 50px; background-color: transparent;">
				<div class="mui-input-row" style="border: 0px">
					<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">邮箱</label> <input type="text" name="realName"
						value="${memberUser.email }" class="mui-input" style="float: left;" readonly="readonly" maxlength="32" />
				</div>
			</li>
		</ul>
	</div>
	<script type="text/javascript">
		(function($, doc) {
			$.init();
		}(mui, document));
	</script>
</body>
</html>