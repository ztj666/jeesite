<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
	<title>文件上传</title>
	<link href="${ctxStatic }/css/uploadcss.css" rel="stylesheet"  type="text/css" />
	<script type="text/javascript" src="${ctxStatic }/js/upload.js"></script>
	<script type="text/javascript">
	
	//选择一张图片后的，上传组件会回调本函数来回显数据
	function fileuploadtest(name,size,cratedate,url){
		var aa=name+","+size+","+cratedate+","+url;
		$(".name").val(name);
		$(".size").val(size);
		$(".cratedate").attr("value",cratedate);
		$(".url").attr("value",url);
	}
	function uploadOpen(){
		var onSelectCallback="fileuploadtest";//选择一张图片后的，回调的父页面的函数名称
		var formAction="${ctxm}/xxx/xxx.htm";//上传表单提交地址
		var url="${ctxm}/common/fileupload/index.htm?onSelect="+onSelectCallback+"&formAction="+formAction+"&type=1";
	    var iWidth=1000; //弹出窗口的宽度;
	    var iHeight=650;//弹出窗口的高度;
	    //获得窗口的垂直位置
	    var iTop = (window.screen.availHeight-30-iHeight)/2;
	    //获得窗口的水平位置
	    var iLeft = (window.screen.availWidth-10-iWidth)/2;
	    var params='width='+iWidth+',height='+iHeight+',top='+iTop+',left='+iLeft;
		//window.open(url,'newwindow',params);
		top.$.jBox("iframe:"+url, {title: "文件管理", width: 1010, height:560, buttons:{'关闭': true}});
	}
	</script>
</head>
<body>
<h1>相册上传组件（批量文件上传）测试页</h1>
<p>
	<div>回显示数据区</div>
	name：<input type="text"  value="123" class="name"/></br>
	size：<input type="text"  value="" class="size"/></br>
	cratedate：<input type="text"  class="cratedate"/></br>
	url：<input type="text"  class="url"/></br>
	</br>
	<a href="javascript:uploadOpen();">上传图片</a>       
	<input type="button" onclick="uploadOpen()" value="上传图片"/>
	
</p>
</body>
</html>