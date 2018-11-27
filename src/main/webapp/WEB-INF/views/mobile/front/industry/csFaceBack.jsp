<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>${title }</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
</head>

<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="color: white; font-size: 16px;">${title }</h1>
	</header>
	<form id="subForm" action="${ctxw }/industry/faceBackSave.htm" method="post">
		<h1 class="message_h">错误字段</h1>
		<div class="mui-input-group" style="position: absolute; top: 110px; left: 20px; right: 20px; height: 50px;">
			<div class="div_box_input">
				<input name="errorField" type="text" maxlength="30" style="height: 22px; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px;">
			</div>
		</div>
		<h1 class="message_h" style="top: 172px;">具体描述</h1>
		<div class="mui-input-group" style="position: absolute; top: 194px; left: 20px; right: 20px; height: 200px;">
			<div class="div_box_input">
				<textarea id="subject" name="content" type="text" maxlength="512" style="height: 180px; border: 0px; font-size: 16px; color: #BBBBBB;"></textarea>
			</div>
		</div>
		<input type="hidden" value="${remarks }" name="remarks" />
		<div id="submit" style="position: absolute; top: 469px; left: 20px; right: 20px; height: 44px; background-color: #FFAC5B; border-radius: calc(5px);">
			<p style="position: relative; top: 13px; width: 43px; margin: auto; color: white;">提交</p>
		</div>
	</form>
	<script type="text/javascript">
		(function($, doc) {
			$.init();
			var submit = doc.getElementById('submit');
			var subject = doc.getElementById('subject');
			submit.addEventListener('tap',
					function(event) {
						if (subject.value.trim() == ''
								|| subject.value.trim() == null) {
							$.toast("描述不能为空");
						} else
							doc.getElementById('subForm').submit();
					});
		}(mui, document));
	</script>
</body>

</html>