<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>小慧在线</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
</head>
<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5; box-shadow: 0px 0px 0px 0px;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white;">小慧在线</h1>
	</header>
	<div style="position: absolute; top: 0px; width: 100%; height: 100px; background-color: #4AACC5;"></div>
	<img src="${ctxStatic}/image/avatar_app.png" style="position: relative; top: 60px; width: 80px; height: 80px; left: 50%; margin-left: -40px;">

	<div class="mui-content"
		style="position: absolute; top: 170px; background-color: white; width: 100%; height: 100px; border-width: 1px; border-color: #DDDDDD;">
		<ul id="" class="mui-table-view mui-table-view-chevron" style="top: -58px;">
			<li id="faceBack" class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="mine_ul_li_p" style="left: 20px;">反馈建议</p> <img src="${ctxStatic}/image/ic_into.png" class="mine_ul_li_into"/>
			</li>
			<li id="cooperation" class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="mine_ul_li_p" style="left: 20px;">合作</p> <img src="${ctxStatic}/image/ic_into.png" class="mine_ul_li_into">
			</li>
		</ul>
	</div>

	<div class="mui-content"
		style="position: absolute; top: 291px; background-color: white; width: 100%; height:150px; border-width: 1px; border-color: #DDDDDD;">
		<ul id="" class="mui-table-view mui-table-view-chevron" style="top: -58px;">
			<li id="doc1" class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="mine_ul_li_p" style="left: 20px;">使用帮助</p> <img src="${ctxStatic}/image/ic_into.png" class="mine_ul_li_into">
			</li>
			<li id="doc2" class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="mine_ul_li_p" style="left: 20px;">关于我们</p> <img src="${ctxStatic}/image/ic_into.png" class="mine_ul_li_into">
			</li>
			<li id="doc3" class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="mine_ul_li_p" style="left: 20px;">用户协议</p> <img src="${ctxStatic}/image/ic_into.png" class="mine_ul_li_into">
			</li>
		</ul>
	</div>
	<script type="text/javascript">
	(function($, doc) {
		$.init();
		var faceBack = doc.getElementById('faceBack');
		var cooperation=doc.getElementById('cooperation');
		var doc1 = doc.getElementById('doc1');
		var doc2 = doc.getElementById('doc2');
		var doc3 = doc.getElementById('doc3');
		
		doc1.addEventListener('tap', function(event) {
			$.openWindow({
				url: ctxw+'/csCenter/document.htm?id=779595740100689920'
			});
		});
		doc2.addEventListener('tap', function(event) {
			$.openWindow({
				url: ctxw+'/csCenter/document.htm?id=779596090018889728'
			});
		});
		doc3.addEventListener('tap', function(event) {
			$.openWindow({
				url: ctxw+'/csCenter/document.htm?id=779596731646738432'
			});
		});
		faceBack.addEventListener('tap', function(event) {
			$.openWindow({
				url: ctxw+'/csCenter/faceBack.htm?type=1'
			});
		});
		cooperation.addEventListener('tap', function(event) {
			$.openWindow({
				url: ctxw+'/csCenter/faceBack.htm?type=3'
			});
		});
		}(mui, document));
	</script>
</body>
</html>