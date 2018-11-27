<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>公司信息</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
<style type="text/css">
.input-label {
	float: left;
	margin-left: 15px;
	width: 52px;
	height: 24px;
	text-align: center;
	border-radius: 40px;
	border: 1px;
	border-style: solid;
	border-color: #4AACC5;
	width: 52px;
}
</style>
</head>
<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white; font-weight: normal">公司信息</h1>
		<div id="release" style="position: absolute; top: 7px; right: 20px; width: 60px; height: 30px; border: 1px solid #FFFFFF; border-radius: 100px;">
			<p style="position: absolute; top: 10px; left: 15px; width: 28px; height: 18px; color: white; font-size: 14px; line-height: 8px;">纠错</p></a>
		</div>
	</header>
	<img src="${ctxStatic}/image/industry_banner.png" class="myPage_pic">
	<img id="headImg" src="${industry.logo }" onerror="this.src='${ct }${fs}${industry.logo!='' and industry.logo!=null?industry.logo:'/avatar_s.png' }@!80x80'"
		 style="border-radius: 100px; position: relative; top: 74px; width: 120px; height: 120px; left: 50%; margin-left: -60px;">

	<div id="content" style="position: absolute; top: 214px; width: 100%;">
			<input style="color: #555555;" readonly="readonly" type="hidden" name="logo"> <input style="color: #555555;" readonly="readonly" type="hidden" name="user.id" value="${memberUser.id }">
			<ul class="mui-table-view mui-table-view-chevron">
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title" style="width: 56px;">公司名称</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 75px; width: 70%;">
						<div class="">
							<input style="color: #555555;" readonly="readonly" readonly="readonly" type="text" name="name" value="${industry.name }" maxlength="32">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">地址</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input style="color: #555555;" style="color: #555555;" readonly="readonly" type="text" name="address" value="${industry.address }" maxlength="100">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 80px;">
					<p class="editor_cell_title" style="width: 56px;">公司简介</p>
					<div class="mui-input-group" style="position: absolute; height: 81px; top: -1px; left: 75px; width: 70%;">
						<div class="">
							<textarea style="color: #555555;" readonly="readonly" rows="3" cols="15" maxlength="1000" name="detail">${industry.detail }</textarea>
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">产品</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input style="color: #555555;" readonly="readonly" type="text" name="product" value="${industry.product }" maxlength="200">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">网址</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input style="color: #555555;" readonly="readonly" type="text" name="url" value="${industry.url }" maxlength="200">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">电话</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input style="color: #555555;" readonly="readonly" type="text" name="phone" value="${industry.phone }" maxlength="11">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">法人</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input style="color: #555555;" readonly="readonly" type="text" name="corporate" value="${industry.corporate }" maxlength="100">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">股东</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input style="color: #555555;" readonly="readonly" type="text" name="partner" value="${industry.partner }" maxlength="200">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title" style="width: 56px;">关联公司</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 75px; width: 70%;">
						<div class="">
							<input style="color: #555555;" readonly="readonly" type="text" name="affiliatedEnterprise" value="${industry.affiliatedEnterprise }" maxlength="200">
						</div>
					</div>
				</li>
			</ul>
	</div>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			var faceBack = doc.getElementById('release');
			
			faceBack.addEventListener('tap', function(event) {
				m.openWindow({
					url: ctxw+'/industry/faceBack.htm?id='+'${industry.id}'
				});
			});
		}(mui, document));
	</script>
</body>
</html>