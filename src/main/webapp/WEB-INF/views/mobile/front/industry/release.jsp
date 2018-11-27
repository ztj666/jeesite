<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>添加我的公司信息</title>
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
		<h1 class="mui-title" style="font-size: 16px; color: white; font-weight: normal">添加我的公司信息</h1>
	</header>
	<img src="${ctxStatic}/image/back.jpg" / class="myPage_pic">
	<img id="headImg" src="${ctxStatic}/image/logo.png"
		/ style="border-radius: 100px; position: relative; top: 74px; width: 120px; height: 120px; left: 50%; margin-left: -60px;">

	<div id="content" style="position: absolute; top: 214px; width: 100%;">
		<form id="editSubmit" action="${ctxw }/industry/save.htm" method="post">
			<input type="hidden" name="logo"> <input type="hidden" name="user.id" value="${memberUser.id }">
			<ul class="mui-table-view mui-table-view-chevron">
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">地址</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input type="text" name="address" value="${industry.address }" maxlength="100">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title" style="width: 56px;">公司名称</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 75px; width: 70%;">
						<div class="">
							<input type="text" name="name" value="${industry.name }" maxlength="32">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 80px;">
					<p class="editor_cell_title" style="width: 56px;">公司简介</p>
					<div class="mui-input-group" style="position: absolute; height: 81px; top: -1px; left: 75px; width: 70%;">
						<div class="">
							<textarea rows="3" cols="15" maxlength="1000" name="detail">${industry.detail }</textarea>
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">产品</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input type="text" name="product" value="${industry.product }" maxlength="200">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">网址</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input type="text" name="url" value="${industry.url }" maxlength="200">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">电话</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input type="text" name="phone" value="${industry.phone }" maxlength="11">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">法人</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input type="text" name="corporate" value="${industry.corporate }" maxlength="100">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title">股东</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
						<div class="">
							<input type="text" name="partner" value="${industry.partner }" maxlength="200">
						</div>
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<p class="editor_cell_title" style="width: 56px;">关联公司</p>
					<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 75px; width: 70%;">
						<div class="">
							<input type="text" name="affiliatedEnterprise" value="${industry.affiliatedEnterprise }" maxlength="200">
						</div>
					</div>
				</li>
			</ul>
		</form>
		<div class="mui-content-padded" style="margin: 20px;">
			<button id="subButton" class="mui-btn mui-btn-block" style="background-color: #FFAC5B; color: white;">提交</button>
		</div>
	</div>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript">
		wx.config({
			debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			appId : '${config.appId}', // 必填，公众号的唯一标识
			timestamp : '${config.timestamp}', // 必填，生成签名的时间戳
			nonceStr : '${config.nonceStr}', // 必填，生成签名的随机串
			signature : '${config.signature}',// 必填，签名，见附录1
			jsApiList : [ "chooseImage", "previewImage", "uploadImage",
					"downloadImage", "closeWindow", "scanQRCode",
					"chooseWXPay", "addCard", "chooseCard", "openCard", ]
		// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		});
		wx.ready(function() {

			// config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
		});
		wx.error(function(res) {

			// config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。

		});

		(function(m, doc) {
			m.init();
			var headImg = doc.getElementById('headImg');
			var editSubmit = doc.getElementById('editSubmit');
			var subButton = doc.getElementById('subButton');
			var localIds = '';
			headImg.addEventListener('tap', function(event) {
				wx.chooseImage({
					count : 1, // 默认9
					sizeType : [ 'compressed' ], // 可以指定是原图还是压缩图，默认二者都有
					sourceType : [ 'album', 'camera' ], // 可以指定来源是相册还是相机，默认二者都有
					success : function(res) {
						localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
						headImg.src = localIds;
						$('input[name=logo]').attr('value', localIds);
						m.toast("logo选择成功！保存后生效")
					}
				});
			});
			subButton.addEventListener('tap', function(event) {
				//if ($('input[name=logo]').val() == null
				//		|| $('input[name=logo]').val() == '') {
				//	m.toast('公司logo未选择');
				//} else 
				if ($('input[name=name]').val().length <= 0) {
					m.toast('公司名称不能为空');
				} else if ($('textarea[name=detail]').val().length <= 0) {
					m.toast('公司简介不能为空');
				} else {
					wx.uploadImage({
						localId : localIds.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
						isShowProgressTips : 1, // 默认为1，显示进度提示
						success : function(res) {
							var serverId = res.serverId.toString(); // 返回图片的服务器端ID
							$('input[name=logo]').attr('value', serverId);
							editSubmit.submit();
						}
					});
				}
			});
		}(mui, document));
	</script>
</body>
</html>