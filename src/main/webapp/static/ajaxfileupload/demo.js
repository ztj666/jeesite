<script type="text/javascript" src="${ctxStatic }/ajaxfileupload/ajaxfileupload.js"></script>
$.ajaxFileUpload({
	url : ctxm + "/shop/fileUpload.htm",// 默认为post请求
	secureuri : false, // 是否启用安全提交,默认为false
	fileElementId : 'picUrl1', // 文件选择框的id属性
	method : 'POST',
	data : {
		format : 'json'
	},// 告诉服务器请给我返回json格式的数据，spring mvc内容协商支持本参数
	dataType : 'json',// 本组件按什么格式接收服务器返回的数据,可以是json或xml等,空表示直接返回data
	fileSize : 5242880,// 文件大小限制，可选，0 为无限制(IE浏览器不兼容)
	allowType : 'jpg,jpeg,png,bmp',// 可选，限定上传文件的格式
	success : function(data) {
		$('#result').html('上传成功！！');// 文件上传后的提示语
		$("#picUrlUploadImg")
				.attr("src", ct + fs + data.imagePath + "@850x120");
		$("#picUrl2").val(data.imagePath);
		$("#picUrlUploadImg").css("display", "");
	},
	error : function(data) { // 服务器响应失败时的处理函数
		$('#result').html('上传失败，请重试！！');
	}
});