<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<title>${memberUser.username }</title>
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<style type="text/css">
.div_box {
	position: absolute;
	top: 44px;
	width: 100%;
	height: 50px;
	background-color: white;
	border: 0.5px solid #BBBBBB;
	
}

.div_box_img {
	position: absolute;
	top: 18px;
	left: 18px;
	width: 16px;
	height: 16px;
}

.div_box_input {
	position: absolute;
	top: 15px;
	left: 40px;
	right: 39px;
	height: 22px;
}
.div_box_content {
	position: absolute;
	top: 6px;
	left: 40px;
	right: 39px;
	height: 120px;
}
</style>
</head>

<body>
	<script src="${ctxStatic}/js/mui.min.js"></script>
	<script type="text/javascript">
		mui.init()
	</script>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"
			style="color: white;"></a>
		<h1 class="mui-title" style="color: white; font-size: 16px;">${memberUser.name }</h1>
	</header>
	<div style="display: none;">
	<sys:message content="${message}" />
	</div>
	<div class="div_box">
		<img src="${ctxStatic}/image/ic_star_blue.png" class="div_box_img">
		<div class="div_box_input">
			<input type="text" placeholder="${bigShotId }"
				style="height: 22px; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px;">
		</div>
	</div>

	<div class="div_box" style="height: 140px; top: 92px;">
		<img src="${ctxStatic}/image/ic_doc_blue.png" class="div_box_img" style="width:13px;height:16px;">
		<div class = "div_box_content">
			<textarea  cols=40 rows=4 name="content" placeholder="请输入内容详情"
				style="height: 110px;text-ailgn:left;border: 0px ; font-size: 16px; color: #BBBBBB; line-height: 22px; word-break: break-word;"></textarea>
		</div>
	</div>

	<div class="div_box" style="top: 230px;">
		<img src="${ctxStatic}/image/ic_money_blue.png" class="div_box_img">
		<div class="div_box_input">
			<input type="text" placeholder="咨询费用"
				style="height: 22px; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px;">
		</div>
	</div>

	<div class="div_box" style="top: 279px;">
		<img src="${ctxStatic}/image/ic_tag_blue.png" class="div_box_img" />
		<div class="div_box_input">
			<input type="text" placeholder="标签"
				style="height: 22px; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px;">
		</div>
	</div>

	<div class="div_box" style="top: 354px;">
		<div
			style="position: absolute; top: 16px; left: 20%; width: 66px; height: 22px;">
			<div
				style="position: absolute; border: 2px solid #4AACC5; width: 18px; height: 18px; border-radius: 9px;">
				<div
					style="position: absolute; top: 2px; left: 2px; width: 10px; height: 10px; border-radius: 5px; background-color: #4AACC5;">

				</div>
			</div>
			<p
				style="position: absolute; right: 0px; font-size: 16px; color: #333333;">私密</p>
		</div>

		<div
			style="position: absolute; top: 16px; right: 20%; width: 66px; height: 22px;">
			<div
				style="position: absolute; border: 2px solid #888888; width: 18px; height: 18px; border-radius: 9px;">
			</div>
			<p
				style="position: absolute; right: 0px; font-size: 16px; color: #888888;">公开</p>
		</div>
	</div>

	<p
		style="position: absolute; top: 409px; left: 20px; right: 20px; height: 28px; font-size: 12px; color: #888888;">注：私密——只有你和大咖课件：公开——问题其他人可见，
		答案其他人付费0.99可见，你有60%收入</p>

	<div
		style="position: absolute; top: 509px; left: 20px; right: 20px; height: 44px; background-color: #FFAC5B; border-radius: calc(5px);">
		<p
			style="position: relative; top: 13px; width: 43px; margin: auto; color: white;">提交</p>
	</div>
</body>

</html>