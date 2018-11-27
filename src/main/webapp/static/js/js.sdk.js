//Map<String, String> map = new HashMap<String, String>();
map.put("appId", Global.getConfig("appId"));
map.put("timestamp", new Date().getTime() + "");
map.put("nonceStr", UUID.randomUUID().toString());
String
signature = SHA1.getSHA1Url(JsTicketApi.getTicket(JsApiType.jsapi).getTicket(),
		map.get("timestamp"), map.get("nonceStr"), request.getRequestURL()
				.toString());
map.put("signature", signature);
model.addAttribute("config", map);
/**
 * 以上写在web里
 */
//<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
wx.config({
	debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	appId : '${config.appId}', // 必填，公众号的唯一标识
	timestamp : '${config.timestamp}', // 必填，生成签名的时间戳
	nonceStr : '${config.nonceStr}', // 必填，生成签名的随机串
	signature : '${config.signature}',// 必填，签名，见附录1
	jsApiList : [ "chooseImage", "previewImage", "uploadImage",
			"downloadImage", "closeWindow", "scanQRCode", "chooseWXPay",
			"addCard", "chooseCard", "openCard", ]
// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
});
wx.ready(function() {

	// config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
});
wx.error(function(res) {

	// config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。

});
wx.chooseImage({
	count : 1, // 默认9
	sizeType : [ 'compressed' ], // 可以指定是原图还是压缩图，默认二者都有
	sourceType : [ 'album', 'camera' ], // 可以指定来源是相册还是相机，默认二者都有
	success : function(res) {
		var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片

		wx.uploadImage({
			localId : localIds.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
			isShowProgressTips : 1, // 默认为1，显示进度提示
			success : function(res) {
				var serverId = res.serverId; // 返回图片的服务器端ID
				wx.downloadImage({
					serverId : serverId.toString(), // 需要下载的图片的服务器端ID，由uploadImage接口获得
					isShowProgressTips : 1, // 默认为1，显示进度提示
					success : function(res) {
						var downloadId = res.localId; // 返回图片下载后的本地ID

						alert(downloadId);
						headImage.src = downloadId;
						alert(headImage.src);
					}
				});
			}
		});
	}
});