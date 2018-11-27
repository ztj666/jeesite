<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>标签选择</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<style type="text/css">
.input-label {
	float: left;
	padding-left: 10px;
	padding-top: 3px;
	padding-right: 10px;
	margin-top: 10px;
	min-width: 40px;
	margin-left: 15px;
	height: 24px;
	color: #4AACC5;
	text-align: center;
	border-radius: 40px;
	border: 1px;
	border-style: solid;
	border-color: #4AACC5;
	float: left;
	min-width: 40px;
	margin-top: 10px;
	padding-right: 10px;
}

.input-label2 {
	float: left;
	padding-top: 3px;
	padding-left: 10px;
	padding-right: 10px;
	margin-top: 10px;
	min-width: 40px;
	margin-left: 15px;
	height: 24px;
	color: #4AACC5;
	text-align: center;
	border-radius: 40px;
	border: 1px;
	border-style: solid;
	border-color: #4AACC5;
	float: left;
	min-width: 40px;
	margin-top: 10px;
}
</style>
</head>
<body background="#FFFFFF">
	<div class="mui-content" style="padding: 10px">
		<div style="padding: 18px 20px 0 18px">
			<div style="width: 100%; padding: 5px">
				<img style="float: left;" width="19px" height="19px" src="${ctxStatic}/image/ic_tag_blue.png" />
				<p style="float: left; color: #4AACC5; margin-left: 5px">我擅长</p>
			</div>
			<div style="height: 4px; background-color: #94D3E2; margin-top: 20px"></div>
		</div>
		<div class="mui-clearfix" style="margin: 10px">
			<c:forEach items="${list }" var="item">
				<c:set var="flag" value="true" />
				<c:forEach items="${list1 }" var="item1" varStatus="status">
					<c:choose>
						<c:when test="${item1.label.id==item.id }">
							<div id="${item.id }" class="input-label" checked="checked" style="background-color: #4AACC5; color: white;">${item.name }</div>
							<c:set var="flag" value="false" />
						</c:when>
						<c:otherwise>
							<c:if test="${status.last and flag}">
								<div id="${item.id }" class="input-label">${item.name }</div>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${fn:length(list1)==0 }">
					<div id="${item.id }" class="input-label">${item.name }</div>
				</c:if>
			</c:forEach>
		</div>
		<div style="padding: 18px 10px 0 18px" class="mui-clearfix">
			<div style="width: 100%; padding: 5px">
				<img style="float: left;" width="19px" height="19px" src="${ctxStatic}/image/ic_interest_blue.png" />
				<p style="float: left; color: #4AACC5; margin-left: 5px">感兴趣</p>
			</div>
			<div style="height: 4px; background-color: #94D3E2; margin-top: 20px"></div>
		</div>
		<div class="mui-clearfix" style="margin: 10px">
			<c:forEach items="${list }" var="item">
				<c:set var="flag" value="true" />
				<c:forEach items="${list2 }" var="item1" varStatus="status">
					<c:choose>
						<c:when test="${item1.label.id==item.id }">
							<div id="${item.id }" class="input-label2" checked="checked" style="background-color: #4AACC5; color: white;">${item.name }</div>
							<c:set var="flag" value="false" />
						</c:when>
						<c:otherwise>
							<c:if test="${status.last and flag }">
								<div id="${item.id }" class="input-label2">${item.name }</div>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${fn:length(list2)==0 }">
					<div id="${item.id }" class="input-label2">${item.name }</div>
				</c:if>
			</c:forEach>
		</div>
		<div class="mui-content-padded" style="margin-top: 20px;">
			<button id='subButton' class="mui-btn mui-btn-block" style="color: white; background-color: #FFAC5C">确&nbsp;&nbsp;定</button>
		</div>
	</div>
	<form id="subForm" action="${ctxw }/selectLabel/save.htm" method="post">
		<input type="hidden" name="label1"> <input type="hidden" name="label2">
	</form>
	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			var label1 = 0;
			var label2 = 0;
			$('.input-label').each(function() {
				if ($(this).attr('checked') == 'checked') {
					label1++;
				}
			});
			$('.input-label2').each(function() {
				if ($(this).attr('checked') == 'checked') {
					label2++;
				}
			});
			var subButton = doc.getElementById('subButton');

			$('.input-label').click(function() {
				if ($(this).attr('checked') == 'checked') {
					label1--;
					$(this).removeAttr('checked');
					this.style.background = "";
					this.style.color = "#4AACC5";
				} else if (label1 < 4) {
					label1++;
					$(this).attr('checked', 'checked');
					this.style.background = "#4AACC5";
					this.style.color = "white";
				} else {
					m.toast('最多选4个技能标签');
				}
			});
			$('.input-label2').click(function() {
				if ($(this).attr('checked') == 'checked') {
					label2--;
					$(this).removeAttr('checked');
					this.style.background = "";
					this.style.color = "#4AACC5";
				} else if (label2 < 4) {
					label2++;
					$(this).attr('checked', 'checked');
					this.style.background = "#4AACC5";
					this.style.color = "white";
				} else {
					m.toast('最多选4个兴趣标签');
				}
			});
			subButton.addEventListener('tap', function(event) {
				var labelId1 = '';
				var labelId2 = '';
				$('.input-label').each(function() {
					if ($(this).attr('checked') == 'checked') {
						labelId1 += this.id + ",";
					}
				});
				$('.input-label2').each(function() {
					if ($(this).attr('checked') == 'checked') {
						labelId2 += this.id + ",";
					}
				});
				if (labelId1.length < 36 || labelId2.length < 36) {
					m.toast('请每类选择2~4个标签');
				} else {
					$('input[name=label1]').val(labelId1);
					$('input[name=label2]').val(labelId2);
					$('#subForm').submit();
				}
			});
		}(mui, document));
	</script>
</body>
</html>