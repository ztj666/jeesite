<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>我</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
<style type="text/css">
.fixed {
	position: fixed;
	*position: absolute;
	bottom: 0px;
	margin: 0px
}
</style>
</head>
<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a href="#popover"><img src="${ctxStatic }/image/ic_menu_white.png" class="mine_head"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white;">${title }</h1>
	</header>
	<%@ include file="/WEB-INF/views/mobile/include/indexHead.jsp"%>
	<div id="myEdit" class="mui-content" style="position: absolute; top: 44px; background-color: white; width: 100%; height: 90px;">
		<img src="${memberUser.headImg }" onerror="this.src='${ct }${fs}${memberUser.headImg!=''?memberUser.headImg:'/avatar_s.png' }@!60x60'"
			style="border-radius: 100px; position: absolute; width: 50px; height: 50px; top: 20px; left: 30px;">
		<p style="position: absolute; top: 25px; left: 90px;">${memberUser.realName!=null&&memberUser.realName!=''?memberUser.realName:memberUser.name }</p>
		<p style="position: absolute; top: 47px; left: 90px;">${memberUser.orgName }&nbsp;&nbsp;${memberUser.position }</p>
		<img src="${ctxStatic }/image/ic_into.png" / style="position: absolute; top: 39px; right: 20px; width: 8px; height: 13px;">
	</div>

	<div class="mui-content"
		style="position: absolute; top: 154px; background-color: white; width: 100%; height: 402px; border-width: 1px; border-color: #DDDDDD;">
		<ul id="" class="mui-table-view mui-table-view-chevron" style="top: -57px;">
			<c:if test="${memberUser.type==2 }">
				<li class="mui-table-view mui-table-view-cell" style="height: 50px;"><img src="${ctxStatic }/image/ic_money_l.png" /  class="mine_ul_li_img">
					<p class="mine_ul_li_p">咨询费用</p>
					<p style="position: absolute; top: 15px; height: 13px; right: 50px">${memberUser.consultPrice }</p></li>
			</c:if>
			<li id="accountShow" class="mui-table-view mui-table-view-cell" style="height: 50px;"><img src="${ctxStatic }/image/ic_money_blue.png"
				/ class="mine_ul_li_img">
				<p class="mine_ul_li_p">知币/余额</p>
				<p style="position: absolute; top: 15px; height: 13px; right: 50px">${memberUser.lastCoin }&nbsp;/&nbsp;${memberUser.lastBalance }</p> <img
				src="${ctxStatic }/image/ic_into.png" / class="mine_ul_li_into"></li>
			<li id="yw" class="mui-table-view mui-table-view-cell" style="height: 50px;"><img src="${ctxStatic }/image/ic_qa_l.png" / class="mine_ul_li_img">
				<p class="mine_ul_li_p">我的问答/约见</p> <img src="${ctxStatic }/image/ic_into.png" / class="mine_ul_li_into"></li>
			<li id="myMeeting" class="mui-table-view mui-table-view-cell" style="height: 50px;"><img src="${ctxStatic }/image/ic_meeting_l.png"
				/ class="mine_ul_li_img">
				<p class="mine_ul_li_p">我的会议</p> <img src="${ctxStatic }/image/ic_into.png" / class="mine_ul_li_into"></li>
			<li id="myCircle" class="mui-table-view mui-table-view-cell" style="height: 50px;"><img src="${ctxStatic }/image/ic_circle_l.png"
				class="mine_ul_li_img">
				<p class="mine_ul_li_p">我的圈子</p> <img src="${ctxStatic }/image/ic_into.png" / class="mine_ul_li_into"></li>
			<li id="csCenter" class="mui-table-view mui-table-view-cell" style="height: 50px;"><img src="${ctxStatic }/image/ic_help_l.png"
				class="mine_ul_li_img">
				<p class="mine_ul_li_p">小慧在线</p> <img src="${ctxStatic }/image/ic_into.png" / class="mine_ul_li_into"></li>
			<li id="message" class="mui-table-view mui-table-view-cell" style="height: 50px;"><img src="${ctxStatic }/image/ic_message_l.png" / class="mine_ul_li_img">
				<p class="mine_ul_li_p">系统消息</p> <img src="${ctxStatic }/image/ic_into.png" / class="mine_ul_li_into"></li>
			<li id="myExpert" class="mui-table-view mui-table-view-cell" style="height: 50px;"><img src="${ctxStatic }/image/ic_people_l.png"
				class="mine_ul_li_img">
				<p class="mine_ul_li_p">大咖认证</p> <img src="${ctxStatic }/image/ic_into.png" / class="mine_ul_li_into"></li>
		</ul>
	</div>
	<div id="account" class="mui-content"
		style="display: none; width: 100%; height: 100%; position: absolute; background-color: rgba(10%, 20%, 30%, 0.3);">
		<div class="mui-content"
			style="position: absolute; top: 134px; left: 20px; right: 20px; height: 280px; background-color: #FFFFFF; box-shadow: 0px 2px 8px 0px rgba(0, 0, 0, 0.20); border-radius: 4px;">
			<div style="position: absolute; right: 0px; left: 0px; height: 30px; background-color: #FFAC5B; border-radius: 4px;">
				<h1 style="float: left; position: relative; top: 4px; left: 20px; width: 63px; height: 17px; font-size: 14px; color: white; font-weight: normal;">知币/余额</h1>
				<div style="float: left; position: relative; top: 4px; left: 20px; width: 70%; text-align: right;">
					<img id="accountHide" src="${ctxStatic }/image/sign-error-icon.png" style="width: 20px; height: 20px;">
				</div>
			</div>
			<div style="position: absolute; top: 40px; left: 10px; right: 10px; height: 80px; background: #F6F4F4;">
				<h1 class="myCount_text" style="left: 10px;">知币</h1>
				<a href="${ctxw }/csCenter/document.htm?id=780312027691352064"><p class="myCount_text"
						style="left: 48px; width: 56px; color: #4AACC5; font-family: PingFangSC-Medium; top: 11px;">兑换说明</p></a> <a href="${ctxw }/accountRecord/coin.htm"><p
						class="myCount_text" style="right: 10px; width: 56px; color: #4AACC5; font-family: PingFangSC-Medium; top: 11px;">查看记录</p></a>
				<p style="position: absolute; top: 46px; left: 10px; width: 75px; height: 36px; font-size: 36px; color: #FF5D08; font-family: PingFangSC-Medium;">${memberUser.lastCoin }</p>
			</div>

			<div style="position: absolute; top: 130px; left: 10px; right: 10px; height: 140px; background: #F6F4F4;">
				<h1 class="myCount_text" style="left: 10px;">余额</h1>
				<p id="inMoney" class="myCount_text" style="left: 48px; width: 56px; color: #4AACC5; font-family: PingFangSC-Medium; top: 11px;"></p>
				<a href="${ctxw }/accountRecord.htm"><p class="myCount_text"
						style="right: 10px; width: 56px; color: #4AACC5; font-family: PingFangSC-Medium; top: 11px;">查看记录</p></a>
				<p style="position: absolute; top: 46px; left: 10px; width: 75px; height: 36px; font-size: 36px; color: #FF5D08; font-family: PingFangSC-Medium;">${memberUser.lastBalance }</p>
				<div id="outMoney"
					style="position: absolute; top: 83px; left: 10px; right: 10px; height: 44px; background-color: #FFAC5B; border-radius: calc(5px);">
					<p style="position: relative; top: 13px; width: 42px; color: white; margin: auto;">提现</p>
				</div>
			</div>
		</div>
	</div>
	<form id="outForm" action="${ctxw }/accountRecord/outMoney1.htm" method="post">
		<input type="hidden" name="coinNumber">
	</form>
	<form id="inForm" action="${ctxw }/accountRecord/pay.htm" method="post">
		<input type="hidden" name="money">
		<input type="hidden" name="type">
	</form>
	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			var myEdit = doc.getElementById('myEdit');
			var myCircle = doc.getElementById('myCircle');
			var csCenter = doc.getElementById('csCenter');
			var myExpert = doc.getElementById('myExpert');
			var accountShow = doc.getElementById('accountShow');
			var accountHide = doc.getElementById('accountHide');
			var myMeeting = doc.getElementById('myMeeting');
			var outMoney = doc.getElementById('outMoney');
			var inMoney = doc.getElementById('inMoney');
			var message = doc.getElementById('message');
			var yw = doc.getElementById('yw');
			
			inMoney.addEventListener('tap', function(e) {
				e.detail.gesture.preventDefault(); //修复iOS 8.x平台存在的bug，使用plus.nativeUI.prompt会造成输入法闪一下又没了
				var btnArray = [ '取消', '确定' ];
				mui.prompt('请输入你充值的金额：', '0.00', '充值', btnArray, function(e) {
					if (e.index == 1) {
						var re = /^([1-9]\d{0,15}|0)(\.\d{1,2})?$/;
						if (!re.test(e.value)) {
							m.toast('请输入正确数值（最多保留两位小数的数字）');
						} else {
							$('input[name=money]').val(e.value);
							$('input[name=type]').val('40');
							$('#inForm').submit();
						}
					} else {
						m.toast('操作已取消');
					}
				})
			});
			outMoney.addEventListener('tap', function(e) {
				if("${memberUser.lastBalance }"==0){
					m.toast('你的余额为0');
				}else{
				e.detail.gesture.preventDefault(); //修复iOS 8.x平台存在的bug，使用plus.nativeUI.prompt会造成输入法闪一下又没了
				var btnArray = [ '取消', '确定' ];
				mui.prompt('请输入你提现金额：', '0.00', '提现', btnArray, function(e) {
					if (e.index == 1) {
						var re = /^([1-9]\d{0,15}|0)(\.\d{1,2})?$/;
						if (!re.test(e.value)) {
							m.toast('请输入正确数值（最多保留两位小数的数字）');
						} else if (e.value > "${memberUser.lastBalance }") {
							m.toast('提现金额不能大于余额！');
						} else {
							$('input[name=coinNumber]').val(e.value);
							$('#outForm').submit();
						}
					} else {
						m.toast('操作已取消');
					}
				})
				}
			});
			yw.addEventListener('tap', function(event) {
				m.openWindow({
					url : ctxw + '/My.htm'
				});
			});
			message.addEventListener('tap', function(event) {
				m.openWindow({
					url : ctxw + '/mine/massage.htm'
				});
			});
			myMeeting.addEventListener('tap', function(event) {
				m.openWindow({
					url : ctxw + '/meeting/myMeeting1.htm'
				});
			});
			accountShow.addEventListener('tap', function(event) {
				$('#account').toggle();
			});
			accountHide.addEventListener('tap', function(event) {
				$('#account').toggle();
			});
			myEdit.addEventListener('tap', function(event) {
				m.openWindow({
					url : ctxw + '/mine/myEdit.htm'
				});
			});
			myCircle.addEventListener('tap', function(event) {
				m.openWindow({
					url : ctxw + '/mine/circle.htm'
				});
			});
			csCenter.addEventListener('tap', function(event) {
				m.openWindow({
					url : ctxw + '/csCenter.htm'
				});
			});
			myExpert.addEventListener('tap', function(event) {
				m.openWindow({
					url : ctxw + '/expert.htm'
				});
			});
		}(mui, document));
	</script>
</body>
</html>