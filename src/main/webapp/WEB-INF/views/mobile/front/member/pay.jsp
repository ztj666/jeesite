<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>支付</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
</head>
<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5; box-shadow: 0px 0px 0px 0px;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white;">支付</h1>
	</header>
	<div class="mui-content"
		style="position: absolute; top: 70px; background-color: white; width: 100%; height: 100px; border-width: 1px; border-color: #DDDDDD;">
		<ul id="" class="mui-table-view mui-table-view-chevron" style="top: -58px;">
			<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="mine_ul_li_p" style="left: 20px;">订单内容：&nbsp;${fns:abbr(name,38) }</p>
			</li>
			<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="mine_ul_li_p" style="left: 20px;">价格：&nbsp;${price }</p>
			</li>
		</ul>
		<div class="mui-content-padded">
				<button id="submitButton" class="mui-btn mui-btn-block"
					style="position: absolute; top: 180px; width: 95%; color: white; background-color: orange;">支付</button>
		</div>
	</div>
	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			function onBridgeReady() {
				WeixinJSBridge.invoke('getBrandWCPayRequest', {
					"appId" : "${params.appId}", //公众号名称，由商户传入       
					"timeStamp" : "${params.timeStamp}", //时间戳，自1970年以来的秒数       
					"nonceStr" : "${params.nonceStr}", //随机串       
					"package" :  '${pg}',
					"signType" : "${params.signType}", //微信签名方式:       
					"paySign" : "${params.paySign}"
				//微信签名   
				},
				function(res) {
					if (res.err_msg == "get_brand_wcpay_request:ok") {
						m.toast("支付成功!请返回页面刷新查看");
					}else{
						m.toast("操作取消")
					} // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。   
				});
			}
			function pay() {
				if (typeof WeixinJSBridge == "undefined") {
					if (document.addEventListener) {
						document.addEventListener('WeixinJSBridgeReady',
								onBridgeReady, false);
					} else if (document.attachEvent) {
						document.attachEvent('WeixinJSBridgeReady',
								onBridgeReady);
						document.attachEvent('onWeixinJSBridgeReady',
								onBridgeReady);
					}
				} else {
					onBridgeReady();
				}
			}
			
			var faceBack = doc.getElementById('submitButton');
			faceBack.addEventListener('tap', function(event) {
				pay();
				return false;
			});
		}(mui, document));
	</script>
</body>
</html>