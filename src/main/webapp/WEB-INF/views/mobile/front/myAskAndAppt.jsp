<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>问答/约见</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link href="${ctxStatic}/css/main/myAskAndAppt.css" rel="stylesheet" />
<style type="text/css">
.appt {
	width: 100%;
	padding: 10px;
	background: #fff;
	height: 90px;
	border-bottom: 1px solid #DDDDDD;
}
.appt p {
	margin-top: 6px;
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	font-size: 16px;
	color: #333333;
	height: 38px;
	line-height: 20px;
}
</style>
</head>
<body>
	<script type="text/javascript">
		mui.init()
	</script>
	<header class="mui-bar mui-bar-nav" style="background: #4AACC5;">
		<div id="test" class="mui-segmented-control  ">
			<a id="myask" class="mui-control-item mui-active" href="#item1">我的问答</a>
			<a id="myappt" class="mui-control-item" href="#item2">我的约见</a>
		</div>
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"
			style="color: #FFFFFF;"></a>
	</header>
	<div class="mui-content">
		<div id="item1" class="mui-control-content mui-active">
			<div class="div2" style="display:none;">
				<p id="subject">11111111111</p>
				<div class="div2-1">
					<div class="lebel">
						<img src="${ctxStatic}/image/ic_tag.png" width="19px"
							height="19px" align="center" />健康管理&ensp;云计算
					</div>
					<div class="lebel2">
						<span class="btn">待回答</span>
					</div>
				</div>
			</div>
		</div>

		<div id="item2" class="mui-control-content">
			<div class="appt" style="display:none;">
				<p id="subject">标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题</p>
				<div class="div2-1">
					<div class="lebel">
						<img src="${ctxStatic}/image/ic_tag.png" width="19px"
							height="19px" align="center" /> 健康管理&ensp;云计算
					</div>
					<div class="lebel2">
						<span class="btn">待约见</span>
					</div>
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
	</div>
	<script>
	<!-- 获取 当前用户的信息 -->
		var userId = "${memberUser.id}";
		var name = "${memberUser.name}";
		var reName = "${memberUser.realName}";
		var headImg = "${memberUser.headImg}";
		var type = "${memberUser.type}";
		var domain = "${memberUser.domain}";
		var detail = "${memberUser.detail}";
	</script>
	<script>
		var myask = document.getElementById('myask');
		var myappt = document.getElementById('myappt');
		myask.addEventListener('tap', function() {
			ajax();
		});
		myappt.addEventListener('tap', function() {
			ajax1();
		});
		mui.trigger(myask, 'tap');
		function ajax() {
			$
					.ajax({
						type : "POST",
						url : ctxw + "/My/ask.htm",
						dataType : "json",
						success : function(result) {
							var str = "";
							var status = "";
							if (result.length < 1 || result == null) {
								$("#item1")
										.html(
												"<center><div style=\" background:#FFFFFF; padding:20px; color:#CCCCCC;\">您还没有问答信息！<div><center>");
							} else {
								for (var i = 0; i < result.length; i++) {
									if ("1" == result[i].status) {
										status = "待回答";
									} else if ("2" == result[i].status) {
										status = "已回答";
									} else if ("3" == result[i].status) {
										status = "已关闭";
									} else if ("0" == result[i].status) {
										status = "待支付";
									} else{
										status = "";
									}
									str += "<div id="+result[i].id+" class=\"div2\" style=\"height: 90px\">"
											+ "<p id =\"subject\">"
											+ result[i].subject
											+ "</p>"
											+ "<div class=\"div2-1\">"
											+ "	<div class=\"lebel\">"
											+ "	<img src=\"${ctxStatic}/image/ic_tag.png\" width=\"19px\" height=\"19px\" align=\"center\" />"
											+ result[i].label
											+ "	</div>"
											+ "	<div class=\"lebel2\">"
											if (userId == result[i].userTo) {
												str	+= "<span class=\"btn\" style=\"background:#FF5D08;\">"
												str += "我的回答"
											}
											if (userId == result[i].userBy) {
												str += "<span class=\"btn\" style=\"background:#4AACC5;\">"
												str += "我的提问"
											}
										str	+="</span>"
										str	+= "	<span class=\"btn\""
									if (userId == result[i].userBy) {
										str += "style =\"background:#4AACC5;\""
												+ " >"
										str += status;
									}
									if (userId == result[i].userTo) {
										str += " >"
										str += status;
									}
									str += "</span>" + "	</div>" + "</div>"
											+ "</div>";
								}
								$("#item1").html(str);
							}
						},
						error : function(XMLHttpRequest, data, textStatus) {
							mui.toast("请求失败，请重试！");
						}
					});
		}

		function ajax1() {
			$
					.ajax({
						type : "POST",
						url : ctxw + "/My/appt.htm",
						dataType : "json",
						success : function(result) {
							var str = "";
							var status = "";
							if (result.length < 1 || result == null) {
								$("#item2")
										.html("<center><div style=\" background:#FFFFFF; padding:20px; color:#CCCCCC;\">您还没有约见信息！<div><center>");
							} else {
								for (var i = 0; i < result.length; i++) {
									if ("1" == result[i].status) {
										status = "待接见";
									} else if ("2" == result[i].status) {
										status = "已接见";
									} else if ("3" == result[i].status) {
										status = "已拒绝";
									} else if ("0" == result[i].status) {
										status = "待支付";
									} else{
										status = "";
									}
									str += "<div id="+result[i].id+" class=\"appt\">"
											+ "<p id = \"subject\">"
											+ result[i].subject
											+ "</p>"
											+ "<div class=\"div2-1\">"
											+ "<div class=\"lebel\">"
											+ "<img src=\"${ctxStatic}/image/ic_tag.png\" width=\"19px\""
    				+			"height=\"19px\" align=\"center\" />"
											+ result[i].label
											+ "</div>"
											+ "<div class=\"lebel2\">"
											if (userId == result[i].userTo) {
												str	+= "<span class=\"btn\" style=\"background:#FF5D08;\">"
												str += "我的赴约"
											}
											if (userId == result[i].userBy) {
												str += "<span class=\"btn\" style=\"background:#4AACC5;\">"
												str += "我的约见"
											}
											str	+="</span>"
											str +="<span class=\"btn\""
											if (userId != result[i].userTo) {
												str += "style =\"background:#4AACC5;\""
													+ " >" 
												str += status;
											}
											if (userId == result[i].userTo) {
												str += "style =\"background:#FF5D08;\""
												str += " >"
												str += status;
											}
											str += "</span>" + "	</div>" + "</div>"
													+ "</div>";
								}
								$("#item2").html(str);
							}
						},
						error : function(XMLHttpRequest, data, textStatus) {
							mui.toast("请求失败，请重试！");
						}
					});
		}
	</script>
	<script>
		mui(".mui-control-content").on('tap', '.div2', function() {
			//获取问答的id
			var id = this.getAttribute("id");
			//传值给详情页面，通知加载新数据
			//打开问答详情
			mui.openWindow({
				url : ctxw + '/My/consultDetail.htm?id=' + id
			});
		});

		mui(".mui-control-content").on('tap', '.appt', function() {
			//获取约见的id
			var id = this.getAttribute("id");
			//传值给详情页面，通知加载新数据
			//打开约见详情
				  mui.openWindow({
					  url: ctxw+'/My/apptDetail.htm?id='+id
				  });
		});
	</script>
</body>
</html>