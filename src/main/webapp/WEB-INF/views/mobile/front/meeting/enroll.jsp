<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<title>会议报名</title>
<style type="text/css">
img {
	width: 18px;
	height: 20px;
}
</style>
</head>

<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="color: white; font-size: 16px;">会议报名</h1>
	</header>
	<form id="subForm" action="${ctxw }/meetingEnroll/save.htm" method="post">
		<div class="mui-content" style="margin-top: 45px">
			<ul class="mui-table-view mui-table-view-chevron">
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 16%; padding: 5px 0; color: #8f8f94; margin-left: 5px; font-size: 14px;"><img
							src="${ctxStatic }/image/ic_company_blue.png"></label> <input type="text" name="orgName" value="${enroll.orgName }"
							class="mui-input-clear mui-input" style="color: #BBBBBB; float: left;" placeholder="请输入公司名" maxlength="32" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 16%; padding: 5px 0; color: #8f8f94; margin-left: 5px; font-size: 14px;"><img
							src="${ctxStatic }/image/ic_message_blue.png" style="height: 16px; margin-top: 4px"></label> <input type="text" name="email"
							value="${enroll.email }" class="mui-input-clear mui-input" style="color: #BBBBBB; float: left;" placeholder="邮箱" maxlength="32" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 16%; padding: 5px 0; color: #8f8f94; margin-left: 5px; font-size: 14px;"><img
							src="${ctxStatic }/image/ic_address_blue.png"></label> <input type="text" name="address" value="${enroll.address }"
							class="mui-input-clear mui-input" style="color: #BBBBBB; float: left;" placeholder="地址" maxlength="32" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 16%; padding: 5px 0; color: #8f8f94; margin-left: 5px; font-size: 14px;"><img
							src="${ctxStatic }/image/ic_card_blue.png" style="height: 16px; margin-top: 4px"></label> <input type="text" name="position"
							value="${enroll.position }" class="mui-input-clear mui-input" style="color: #BBBBBB; float: left;" placeholder="职位" maxlength="32" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 16%; padding: 5px 0; color: #8f8f94; margin-left: 5px; font-size: 14px;"><img
							src="${ctxStatic }/image/ic_name_blue.png"></label> <input type="text" name="name" value="${enroll.name }" class="mui-input-clear mui-input"
							style="color: #BBBBBB; float: left;" placeholder="姓名" maxlength="32" />
					</div>
				</li>
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;">
					<div class="mui-input-row">
						<label style="width: 16%; padding: 5px 0; color: #8f8f94; margin-left: 5px; font-size: 14px;"><img
							src="${ctxStatic }/image/ic_phone_blue.png"></label> <input type="text" name="phone" value="${enroll.phone }" class="mui-input-clear mui-input"
							style="color: #BBBBBB; float: left;" placeholder="电话" maxlength="32" />
					</div>
				</li>
			</ul>
		</div>
		<input type="hidden" name="meetingId" value="${enroll.meetingId }">
		<div id="submitButton"
			style="position: absolute; top: 519px; left: 20px; right: 20px; height: 44px; background-color: #FFAC5B; border-radius: calc(5px);">
			<p style="position: relative; top: 13px; width: 43px; margin: auto; color: white;">提交</p>
		</div>
	</form>
	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			var submitButton = doc.getElementById('submitButton');
			var lastBalance = "${user.lastBalance}";
			var price = "${meeting.price}";
			//lastBalance = lastBalance.toFixed(2);
			//price = price.toFixed(2);
			submitButton.addEventListener('tap', function(event) {
				if ($('input[name=name]').val().length <= 0) {
					m.toast('姓名不能为空');
				} else if ($('input[name=phone]').val().length <= 0) {
					m.toast('电话不能为空');
				} else if ($('input[name=email]').val().length <= 0) {
					m.toast('邮箱不能为空');
				} else if ($('input[name=orgName]').val().length <= 0) {
					m.toast('公司不能为空');
				} else {
					//var btnArray = [ '否', '是' ];
					//mui.confirm('请确认支付' + price + '？', '支付', btnArray,
					//		function(e) {
					//			if (e.index == 1) {
					//				if (lastBalance < price) {
					//					m.toast('账户余额不足请充值!');
					//				} else
					$('#subForm').submit();
					//			} else {
					//				m.toast('操作已取消');
					//			}
					//		});
				}
			});
		}(mui, document));
	</script>
</body>
</html>