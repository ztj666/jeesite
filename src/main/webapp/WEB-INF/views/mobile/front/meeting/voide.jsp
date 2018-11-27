<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<script type="text/javascript" src="http://player.youku.com/jsapi"></script>
<title>视频详情</title>
</head>

<body style="background-color: #FFFFFF;">
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="color: white; font-size: 16px;">视频详情</h1>
	</header>
	<form id="subForm" action="${ctxw }/meeting/pay.htm" method="post">
		<input type="hidden" name="id" value="${resource.id }">
	</form>
	<div class="mui-content" style="height: 100%;">
		<div class="mui-content-padded" style="margin-bottom: 50px">
			<div id="youkuplayer"
				style="margin-right: 10px; float: left; background: #FFFFFF; border-radius: 4px; width: 100%; height: 280px; text-align: center;"></div>
		</div>
		<div class="mui-content-padded">
			<c:if test="${!isM }">
				<button id="submitButton" class="mui-btn mui-btn-block"
					style="position: absolute; bottom: 80px; width: 95%; color: white; background-color: orange;">支付后查看完整视频</button>
			</c:if>
		</div>
	</div>
	<script type="text/javascript">
		mui.init();
		var lastBalance = "${user.lastBalance}";
		var price = "${resource.price}";
		var submitButton = document.getElementById('submitButton');

		player = new YKU.Player('youkuplayer', {
			styleid : '0',
			client_id : 'ae3b76b3f8261c2d',
			vid : '${resource.path}',
			password : '${md5}',
			newPlayer : true,
			autoplay : true,
			show_related : true
		});
		if ("${isM}" == 'false' && price > 0) {
			submitButton.addEventListener('tap', function(event) {
				if (confirm('查看完整视频、请确认支付' + price + '￥')) {
					if (lastBalance < price) {
						mui.openWindow({
							url : ctxw + '/accountRecord/pay.htm?type=33&id=${resource.id}'
						});
					} else{
						if (confirm('使用账户余额支付？')) {
								$('#subForm').submit();
						} else {
							mui.openWindow({
								url : ctxw + '/accountRecord/pay.htm?type=33&id=${resource.id}'
							});
						}
					}
				} else {
					mui.toast('操作已取消');
				}
			});
			function currentTime() {
				if (player.currentTime() > 180) {
					player.pauseVideo();
					if (confirm('查看完整视频、请确认支付' + price + '￥')) {
						if (lastBalance < price) {
							mui.openWindow({
								url : ctxw + '/accountRecord/pay.htm?id=${resource.id}'
							});
							player.seekTo(5);
						} else{
							if (confirm('使用账户余额支付？')) {
									$('#subForm').submit();
							} else {
								mui.openWindow({
									url : ctxw + '/accountRecord/pay.htm?id=${resource.id}'
								});
								player.seekTo(5);
							}
						}
					} else {
						mui.toast('操作已取消');
						player.seekTo(5);
					}
				}
			}
			window.setInterval("currentTime()", 5000);
		}
	</script>
</body>
</html>