<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>提问</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<style type="text/css">
.div_box {
	position: absolute;
	top: 44px;
	width: 100%;
	height: 50px;
	background-color: white;
	border-bottom: 1px solid #BBBBBB;
	left: -1px;
	right: -1px;
}

.div_box_img {
	position: absolute;
	top: 18px;
	left: 18px;
	width: 16px;
	height: 16px;
}

.div_box_input {
	position: absolute;
	top: 15px;
	left: 40px;
	right: 39px;
	height: 22px;
}
</style>
</head>

<body>
	<div style="display: none;">
		<sys:message content="${message}"/>
	</div>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"
			style="color: white;"></a>
		<h1 class="mui-title" style="color: white; font-size: 16px;">提问</h1>
	</header>
	<form id="quizSaveForm" action="${ctxw }/My/quizSave.htm"
		method="post">
		
	<input name="userBy" value="${myInfo.id}" type="text" style="display: none;" />
	<input name="userTo" value="${expertInfo.id}" type="text" style="display: none;" />
	
	<div class="div_box">
		<img src="${ctxStatic}/image/ic_star_blue.png"  class="div_box_img">
		<div class="div_box_input">
			<input name="subject" type="text" placeholder="输入主题"
				 style="height: 22px; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px;">
		</div>
	</div>

	<div class="div_box" style="height: 140px; top: 94px;">
		<img src="${ctxStatic}/image/ic_doc_blue.png"  class="div_box_img">
		<div class="div_box_input">
			<textarea name="content" rows="3"
				style="margin: 0; padding-top: 3px; padding-left: 10px; border: 0;"
				placeholder="请输入问题详情。"></textarea>
		</div>
	</div>

	<div class="div_box" style="top: 234px;">
		<input name="price" value="${expertInfo.consultPrice}" type="text" style="display: none;" />
		<img src="${ctxStatic}/image/ic_money_blue.png"  class="div_box_img">
		<div class="div_box_input">
			<p style="padding-left: 12px;">咨询费：¥&nbsp;${expertInfo.consultPrice}</p>
		</div>
	</div>

	<div class="div_box" style="top:284px">
		<img src="${ctxStatic}/image/ic_tag_blue.png" class="div_box_img" />
		<div class="div_box_input" style="top: 5px;">
			<!-- <input name="label" type="text" placeholder="标签"
				 style="height: 22px; border: 0px; font-size: 16px; color: #BBBBBB; line-height: 22px;">  -->
		 <select id="cate" name="label" style=" background-color: transparent;color: #4AACC5;width: 130px;text-align: center;">
					<option value="">选择标签</option>
						<c:forEach items="${label }" var="item">
							<option value="${item.name }">${item.name }</option>
						</c:forEach>
		</select>
		
		</div>
	</div>

	<div class="div_box"
		style="top: 354px; width: 100%; white-space: nowrap;">
		<div
			style="width: 40%; float: left; margin-left: 10%; margin-top: 5px;"
			class=" mui-radio mui-left">
			<label style="padding-top: 9px; font-size: 16px; color: #888888;">公开</label>
			<input name="isShow" type="radio" value="1" checked>
		</div>

		<div
			style="width: 40%; float: right; margin-right: 10%; margin-top: 5px;"
			class=" mui-radio mui-left">
			<label style="padding-top: 9px; font-size: 16px; color: #888888;">私密</label>
			<input name="isShow" type="radio" value="2">
		</div>
	</div>
	<input name="status" type="hidden" />
	<p style="position: absolute; top: 409px; left: 20px; right: 20px; height: 28px; font-size: 12px; color: #888888;">注：私密——只有你和大咖可见，公开——问题其他人可见，
		答案其他人付费0.99可见，你有60%收入</p>

	<div id="quizSbmit" style="position: absolute; top: 509px; left: 20px; right: 20px; height: 44px; background-color: #FFAC5B; border-radius: calc(5px); margin-bottom:10px;">
		<p style="position: relative; top: 13px; width: 43px; margin: auto; color: white;">提交</p>
	</div>
	</form>
	<script>
	(function(m, doc) {
		m.init();
		var myPrice = "${myInfo.lastBalance}";
		var priceTo = "${expertInfo.consultPrice}";
		var cate = doc.getElementById('cate');
		var userBy = "${myInfo.id}";
		var userTo = "${expertInfo.id}";
		var submitButton = doc.getElementById('quizSbmit');
		var isShow = $("input[name='isShow']:first").val();
        $("input[name='isShow']").click(function(){                     //绑定点击事件
        	isShow =  $(this).val() ;                                   //当前值赋值给isshow
		});
		submitButton.addEventListener('tap', function(event) {
			var cateIndex = cate.selectedIndex;
			if(myPrice < priceTo){
				$('input[name=status]').val('0');
				$('#quizSaveForm').submit();
			}else if ($('input[name=subject]').val().length <= 0) {
				m.toast('标题不能为空');
			}else if($('textarea[name=content]').val().length <= 0){
				m.toast('内容不能为空'); 
			}else if(cate.options[cateIndex].value == ""){
				m.toast('标签不能为空');
			}else if(userBy == userTo ){
				m.toast('对不起，您不能向自己提问！');
			}
			else if($('input[name=subject]').val().length > 50){
				m.toast('标题不能超过50个字！');
			}else if($('textarea[name=content]').val().length > 140){
				m.toast('内容不能超过140个字！');
			}else{
				$('#quizSaveForm').submit();
			}
		});
	}(mui, document));
	</script>
</body>





</html>