<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>会议签到</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
</head>
<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<h1 class="mui-title" style="font-size: 16px; color: white; font-weight: normal">会议签到</h1>
	</header>

	<div id="content" style="position: absolute; top: 100px; width: 100%;">
		<input type="hidden" name="meetingId" value="${meeting.id }">
		<ul class="mui-table-view mui-table-view-chevron">
			<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="editor_cell_title" style="width: 56px;">会议：</p>
				<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
					<div class="">
						<input type="text" value="${meeting.subject }" maxlength="100">
					</div>
				</div>
			</li>
			<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="editor_cell_title" style="width: 56px;">参会人：</p>
				<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 75px; width: 70%;">
					<div class="">
						<input type="text" name="userId" maxlength="64">
					</div>
				</div>
			</li>
		</ul>
		<div class="mui-content-padded" style="margin: 50px;">
			<button id="subButton" class="mui-btn mui-btn-block" style="background-color: #FFAC5B; color: white;">提交</button>
		</div>
		<ul class="mui-table-view mui-table-view-chevron">
			<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="editor_cell_title" style="width: 156px;">结果：</p>
				<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 65px; width: 70%;">
					<div class="">
						<input type="text" readonly="readonly" name="result" maxlength="100">
					</div>
				</div>
			</li>
			<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
				<p class="editor_cell_title" style="width: 156px;">扫码次数：</p>
				<div class="mui-input-group" style="position: absolute; height: 51px; top: -1px; left: 75px; width: 70%;">
					<div class="">
						<input type="text" readonly="readonly" name="result1" maxlength="100">
					</div>
				</div>
			</li>
		</ul>
	</div>
	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			function check(){
				var meetingId = $('input[name=meetingId]').val();
				var userId = $('input[name=userId]').val();
				if (meetingId == null || meetingId == '') {
					m.toast('会议未选择');
				} else if (userId.length <= 0) {
					m.toast('参会人未选择');
				} else {
					mui.toast('查询中。。。请稍等');
					m.ajax({
						type: "post",
						url: "/meetingSign/check.htm",
						data: {
							meetingId: meetingId,
							userId: userId
						},
						async: false,
						dataType: "json",
						success: function(data) {
							if (data.code != 0) {
								if (data.message.length > 0) {
									$('input[name=result]').val(data.message);
									$('input[name=result1]').val(data.code);
									mui.toast(data.message);
								} else {
									mui.toast('服务错误');
								}
							} else {
								$('input[name=result]').val(data.message);
								$('input[name=result1]').val('');
								mui.toast(data.message);
							}
						},
						error: function(data) {
							mui.toast('服务错误!');
						}
					});
				}
			}
			document.onkeydown = function(event) {
				var e = event || window.event || arguments.callee.caller.arguments[0];
				if (e && e.keyCode == 13) { // enter 键
					check();
				}
			};
			var subButton = doc.getElementById('subButton');
			subButton.addEventListener('tap', function(event) {
				check();
			});
			
		}(mui, document));
	</script>
</body>
</html>