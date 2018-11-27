//文件异步上传
function ajaxFileUpload(id) {
	var id = id;
	$.ajaxFileUpload({
		url : ctx + "/brand/brandInfo/fileUpload.do",// 默认为post请求
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
			$("#picUrlUploadImg").attr("src",
					ct + fs + data.imagePath + "@100x100");
			$('#' + id).val(data.imagePath);
			$("#picUrlUploadImg").css("display", "");
		},
		error : function(data) { // 服务器响应失败时的处理函数
			$('#result').html('上传失败，请重试！！');
		}
	});
}
function delFile(id) {
	$('#picUrl1').val('');
	$('#' + id).val('');
	$('#result').html('');
	$("#picUrlUploadImg").hide();
}
function checkNum(obj) {
	// 检查是否是非数字值
	if (isNaN(obj.value)) {
		obj.value = "";
	}
	if (obj != null && obj.value.replace(/(^\s*)|(\s*$)/g, "") != '') {
		// 检查小数点后是否对于两位onkeyup="checkNum(this)"
		if (obj.value < 0 || obj.value.toString().indexOf(".") > -1) {
			obj.value = "";
		}
	} else {
		obj.value = "";
	}
}
function checkPrice(obj) {
	var re = /^([1-9]\d{0,15}|0)(\.\d{1,2})?$/;
	if (!re.test(obj.value)) {
		obj.value = "";
	}
}