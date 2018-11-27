<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<title>发布会议</title>
<style type="text/css">
.div_box {
	position: absolute;
	top: 44px;
	width: 100%;
	height: 50px;
	background-color: white;
	border: 0.5px solid #BBBBBB;
}

.div_box_img {
	position: absolute;
	top: 18px;
	left: 18px;
	width: 16px;
}

.div_box_input {
	position: absolute;
	top: 15px;
	left: 40px;
	height: 22px;
}

.div_box_content {
	position: absolute;
	top: 6px;
	left: 40px;
	right: 39px;
	height: 120px;
}
</style>
</head>

<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="color: white; font-size: 16px;">发布会议</h1>
	</header>
	<form id="subForm" action="${ctxw }/meeting/save.htm" method="post">
		<div class="div_box">
			<img src="${ctxStatic}/image/ic_tittle_blue.png" class="div_box_img">
			<div class="div_box_input">
				<input type="text" placeholder="输入会议主题" name="subject" maxlength="64" value="${meeting.subject }"
					style="height: 22px; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px;">
			</div>
		</div>
		<div class="div_box" style="top: 96px;">
			<img src="${ctxStatic}/image/ic_time_blue.png" class="div_box_img">
			<div class="div_box_input" style="overflow: auto;">
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${meeting.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" placeholder="会议开始时间"
					style="height: 22px; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px; width: 145px" /> <input name="endTime" type="text"
					readonly="readonly" maxlength="20" class="input-medium Wdate " value="<fmt:formatDate value="${meeting.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" placeholder="会议结束时间"
					style="height: 22px; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px; width: 145px" />
			</div>
		</div>
		<div class="div_box" style="top: 148px;">
			<img src="${ctxStatic}/image/ic_address_blue.png" class="div_box_img" />
			<div class="div_box_input">
				<input type="text" name="address" value="${meeting.address }" placeholder="请输入会议地址"
					style="height: 22px; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px;">
			</div>
		</div>
		<div class="div_box" style="height: 140px; top: 200px;">
			<img src="${ctxStatic}/image/ic_doc_blue.png" class="div_box_img">
			<div class="div_box_content">
				<textarea cols=40 rows=4 name="detail" placeholder="请输入会议简介"
					style="height: 110px; text-ailgn: left; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px; word-break: break-word;">${meeting.detail }</textarea>
			</div>
		</div>

		<div class="div_box" style="top: 354px;">
			<ul class="mui-table-view mui-table-view-chevron">
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">主办方</label> <input type="text" name="sponsor"
							value="${meeting.sponsor }" class="mui-input-clear mui-input" style="color: #BBBBBB; float: left;" placeholder="主办方" maxlength="32" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">协办方</label> <input type="text" name="coSponsor"
							value="${meeting.coSponsor }" class="mui-input-clear mui-input" style="color: #BBBBBB; float: left;" placeholder="协办方" maxlength="32" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">联系人</label> <input type="text" name="contact"
							value="${meeting.contact }" class="mui-input-clear mui-input" style="color: #BBBBBB; float: left;" placeholder="联系人" maxlength="32" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 28%; padding-left: 0px; color: #8f8f94; margin-left: 5px; font-size: 14px;">电话</label> <input type="text" name="phone"
							value="${meeting.phone }" class="mui-input-clear mui-input" style="color: #BBBBBB; float: left;" placeholder="电话" maxlength="32" />
					</div>
				</li>
			</ul>
		</div>

		<div id="submitButton"
			style="position: absolute; top: 569px; left: 20px; right: 20px; height: 44px; background-color: #FFAC5B; border-radius: calc(5px);">
			<p style="position: relative; top: 13px; width: 43px; margin: auto; color: white;">提交</p>
		</div>
	</form>
	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			var submitButton = doc.getElementById('submitButton');

			submitButton.addEventListener('tap', function(event) {
				if ($('input[name=contact]').val().length <= 0) {
					m.toast('联系人不能为空');
				} else if ($('input[name=phone]').val().length <= 0) {
					m.toast('电话不能为空');
				} else if ($('input[name=subject]').val().length <= 0) {
					m.toast('主题不能为空');
				}else if ($('textarea[name=detail]').val().length <= 0) {
					m.toast('内容不能为空');
				}  else
					$('#subForm').submit();
			});
		}(mui, document));
	</script>
</body>
</html>