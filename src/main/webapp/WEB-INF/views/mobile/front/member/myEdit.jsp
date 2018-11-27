<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>编辑</title>
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
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5; box-shadow: 0px 0px 0px 0px;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white;">编辑</h1>
	</header>
	<p style="position: absolute; top: 51px; left: 20px; width: 56px; height: 17px;">个人信息</p>
	<form id="editSubmit" action="${ctxw }/mine/faceBackSave.htm" method="post">
		<div id="content" style="position: absolute; top: 75px; width: 100%;">
			<ul class="mui-table-view mui-table-view-chevron">
				<li id="headImage" class="mui-table-view mui-table-view-cell" style="height: 80px;">
					<p class="editor_cell_title">头像</p> <img id="headImg" src="${memberUser.headImg }"
					onerror="this.src='${ct }${fs}${memberUser.headImg!=''?memberUser.headImg:'/avatar_s.png' }@!60x60'"
					style="border-radius: 100px; position: absolute; top: 10px; right: 30px; width: 60px; height: 60px;"> <input type="hidden" value=""
					name="headImg">
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">昵称</label> <input type="text" name="name"
							value="${memberUser.name }" class="mui-input-clear mui-input" style="float: left;" placeholder="请输入昵称" maxlength="32" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">真实姓名</label> <input type="text" name="realName"
							value="${memberUser.realName }" class="mui-input-clear mui-input" style="float: left;" placeholder="请输入真实姓名" maxlength="32" />
					</div>
				</li>
				<c:if test="${memberUser.type==2 }">
					<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
						<div class="mui-input-row">
							<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">咨询费</label> <input type="number"
								name="consultPrice" value="${memberUser.consultPrice }" class="mui-input-clear mui-input" style="float: left;" placeholder="请输入咨询费"
								maxlength="32" />
						</div>
					</li>
				</c:if>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">单位</label> <input type="text" name="orgName"
							value="${memberUser.orgName }" class="mui-input-clear mui-input" style="float: left;" placeholder="请输入公司名称" maxlength="64" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">职位</label> <input type="text" name="position"
							value="${memberUser.position }" class="mui-input-clear mui-input" style="float: left;" placeholder="请输入职位" maxlength="64" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">省份</label> <input type="text" name="province"
							value="${memberUser.province }" class="mui-input-clear mui-input" style="float: left;" placeholder="请输入省份" maxlength="64" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">城市</label> <input type="text" name="city"
							value="${memberUser.city }" class="mui-input-clear mui-input" style="float: left;" placeholder="请输入城市" maxlength="64" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">手机号</label> <input type="text" name="phone"
							value="${memberUser.phone }" class="mui-input-clear mui-input" style="float: left;" placeholder="请输入手机号" maxlength="32" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">邮箱</label> <input type="text" name="email"
							value="${memberUser.email }" class="mui-input-clear mui-input" style="float: left;" placeholder="请输入邮箱" maxlength="128" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">公众号</label> <input type="text" name="blog"
							value="${memberUser.blog }" class="mui-input-clear mui-input" style="float: left;" placeholder="请输入公众号" maxlength="128" />
					</div>
				</li>
				<%--<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<div class="mui-input-row">
					<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">行业</label>
					<div class="mui-select" style="width: 70%; float: left;">
						<select name="domain">
							<c:forEach items="${fns:getDictList('member_domain')}" var="item">
								<option value="${item.value }">${item.label }</option>
							</c:forEach>
						</select>
						<script type="text/javascript">
							var domain = "${memberUser.domain }";
							$("select[name=domain]").find("option").each(
									function() {
										var val = $(this).val();
										if (domain == val) {
											$(this)
													.attr("selected",
															"selected");
										}
									});
						</script>
					</div>
				</div>
			</li>
			<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<div class="mui-input-row">
					<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">岗位</label>
					<div class="mui-select" style="width: 70%; float: left;">
						<select name="position">
							<c:forEach items="${fns:getDictList('member_position')}" var="item">
								<option value="${item.value }">${item.label }</option>
							</c:forEach>
						</select>
						<script type="text/javascript">
							var position = "${memberUser.position }";
							$("select[name=position]").find("option").each(
									function() {
										var val = $(this).val();
										if (position == val) {
											$(this)
													.attr("selected",
															"selected");
										}
									});
						</script>
					</div>
				</div>
			</li>
			<li class="mui-table-view mui-table-view-cell" style="height: 50px;"><label
				style="float: left; width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">我擅长</label>
				<div class="input-label" style="margin-left: 0px">xxx</div>
				<div class="input-label">xxx</div>
				<div class="input-label">xxx</div></li>
			<li class="mui-table-view mui-table-view-cell" style="height: 50px;"><label
				style="float: left; width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">感兴趣</label>
				<div class="input-label" style="margin-left: 0px">xxx</div>
				<div class="input-label">xxx</div>
				<div class="input-label">xxx</div></li>--%>
				<li class="mui-table-view mui-table-view-cell" style="height: 102px;">
					<div class="mui-input-row">
						<label style="width: 25%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">简介</label>
						<div style="width: 70%; float: left;">
							<textarea rows="3" cols="15" maxlength="512" name="detail">${memberUser.detail }</textarea>
						</div>
					</div>
				</li>
			</ul>
		</div>
		<p style="position: absolute; top: ${memberUser.type==2?'758px':'708px'}; left: 20px; width: 84px; height: 17px;">社交账号</p>
		<div style="position: absolute; top: ${memberUser.type==2?'782px':'732px'}; height: 150px; background-color: white; width: 100%;">

			<div class="mui-input-row">
				<label style="width: 25%;"><img src="${ctxStatic }/image/ic_qq.png" class="editor_div_iamge"></label> <input type="text" name="qq"
					value="${memberUser.qq }" class="mui-input" style="float: left; margin-top: 8px" placeholder="请输QQ号" maxlength="64" />
			</div>
			<div style="position: absolute; top: 98px; left: 61px; right: 0px; height: 2px; background-color: #DDDDDD;"></div>
			<div class="mui-input-row">
				<label style="width: 25%;"><img src="${ctxStatic }/image/ic_wechat_light.png" class="editor_div_iamge"></label> <input type="text"
					name="fax" value="${memberUser.fax }" class="mui-input" style="float: left; margin-top: 5px" placeholder="请输微信号" maxlength="255" />
			</div>
			<div style="position: absolute; top: 48px; left: 61px; right: 0px; height: 2px; background-color: #DDDDDD;"></div>
			<div class="mui-input-row">
				<label style="width: 25%;"><img src="${ctxStatic }/image/ic_weibo.png" class="editor_div_iamge"></label> <input type="text" name="weibo"
					value="${memberUser.weibo }" class="mui-input" style="float: left; margin-top: 10px" placeholder="请输微博" maxlength="64" />
			</div>
		</div>

		<div id="subButton"
			style="position: absolute; top: ${memberUser.type==2?'972px':'922px'}; left: 20px; right: 20px; height: 44px; background-color: #FFAC5B; border-radius: calc(5px);">
			<p style="position: relative; top: 13px; width: 43px; color: white; margin: auto;">完成</p>
		</div>
	</form>
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
			var headImage = doc.getElementById('headImage');
			var editSubmit = doc.getElementById('editSubmit');
			var subButton = doc.getElementById('subButton');
			var localIds = '';
			headImage.addEventListener('tap', function(event) {
				wx.chooseImage({
					count : 1, // 默认9
					sizeType : [ 'compressed' ], // 可以指定是原图还是压缩图，默认二者都有
					sourceType : [ 'album', 'camera' ], // 可以指定来源是相册还是相机，默认二者都有
					success : function(res) {
						localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
						doc.getElementById('headImg').src = localIds;
						$('input[name=headImg]').attr('value', localIds);
						m.toast("头像选择成功！保存后生效")
					}
				});
			});
			subButton.addEventListener('tap', function(event) {
				var re = /^([1-9]\d{0,15}|0)(\.\d{1,2})?$/;
				if (!re.test($('input[name=consultPrice]').val())) {
					m.toast('咨询费格式不正确(支持小数点后两位)!');
				} else {
					if ($('input[name=headImg]').val() == null
							|| $('input[name=headImg]').val() == '') {
						editSubmit.submit();
					} else {
						wx.uploadImage({
							localId : localIds.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
							isShowProgressTips : 1, // 默认为1，显示进度提示
							success : function(res) {
								var serverId = res.serverId.toString(); // 返回图片的服务器端ID
								$('input[name=headImg]')
										.attr('value', serverId);
								editSubmit.submit();
							}
						});
					}
				}
			});
		}(mui, document));
	</script>
</body>
</html>