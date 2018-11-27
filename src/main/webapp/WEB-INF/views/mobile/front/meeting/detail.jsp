<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<title>会议详情</title>
<script src="${ctxStatic}/jquery/jquery.qrcode.min.js" type="text/javascript"></script>
<style type="text/css">
.my_line1 {
	word-break: keep-all; /* 不换行 */
	white-space: nowrap; /* 不换行 */
	overflow: hidden; /* 内容超出宽度时隐藏超出部分的内容 */
	text-overflow: ellipsis; /* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用。*/
}

.fixed {
	position: fixed;
	*position: absolute;
	bottom: 0px;
	margin: 0px
}
</style>
</head>

<body style="background-color: #FFFFFF;">
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="color: white; font-size: 16px;">会议详情</h1>
	</header>
	<div class="mui-content" style="height: 100%;">
		<div class="mui-content-padded" style="margin-bottom: 70px">
			<h3>${meeting.subject }</h3>
			<div style="height: 20px; color: #888888; font-size: 14px; margin-top: 10px">
				<img src="${ctxStatic }/image/ic_time.png" style="float: left; margin-right: 5px" width="18px" height="18px" /> 时间&nbsp;&nbsp;&nbsp;
				<fmt:formatDate value="${meeting.startTime }" pattern="yyyy-MM-dd HH" />
			</div>
			<div style="color: #888888; font-size: 14px; margin-top: 5px">
				<img src="${ctxStatic }/image/ic_address.png" style="float: left; margin-left: 2px; margin-right: 5px" width="15px" height="20px" />地点&nbsp;&nbsp;&nbsp;${meeting.address }
			</div>
			<div style="background-color: #F6F4F4; margin-top: 10px; padding-bottom: 10px">
				<img src="${meeting.banner }" height="140px" width="98%">
				<h4 style="margin: 10px; color: #333333">${meeting.detail }</h4>
				<div style="margin: 10px">
					<p style="float: left; width: 20%; color: #888888; font-size: 14px">主办方：</p>
					<p style="width: 80%; color: #4AACC5; font-size: 16px">${meeting.sponsor }</p>
				</div>
				<div style="margin: 10px">
					<p style="width: 30%; color: #888888; font-size: 14px">协办方：</p>
					<p style="width: 70%; color: #4AACC5; font-size: 16px">${meeting.coSponsor }</p>
				</div>
			</div>
			<p style="font-weight: bold; margin: 5px; padding-left: 5px; color: #888888; font-size: 14px">嘉宾</p>
			<div style="width: 100%; height: 120px; display: block; overflow: auto;">
				<div style="width: 1000%; overflow: visible;">
					<c:forEach items="${memberUser }" var="item">
						<div
							style="margin-right: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;">
							<c:if test="${item.type==2 }">
								<a href="${ctxw }/mine/myPage.htm?id=${item.homePage}"><img style="margin-top: 3px; border-radius: 100px;" src="${item.headImg }"
									onerror="this.src='${ct }${fs}${item.headImg!=null and item.headImg!=''?item.headImg:'/avatar_s.png' }@!50x50'" width="50px" height="50px"></a>
							</c:if>
							<c:if test="${item.type==1 }">
								<img style="margin-top: 3px; border-radius: 100px;" src="${item.headImg }"
									onerror="this.src='${ct }${fs}${item.headImg!=null and item.headImg!=''?item.headImg:'/avatar_s.png' }@!50x50'" width="50px" height="50px">
							</c:if>
							<p style="font: 15px; color: #333333; margin-bottom: 5px;">${item.name }<c:if test="${item.type==2 }">
									<img src="${ctxStatic}/image/ic_approval.png" style="width: 12px; height: 12px;">
								</c:if>
							</p>
							<p class="my_line1" style="font: 15px;">${item.orgName }</p>
						</div>
					</c:forEach>
				</div>
			</div>
			<div style="background-color: #F6F4F4; width: 100%; display: block; overflow: auto;">
				<div style="width: 100%; overflow: visible; padding: 5px">
					<p style="width: 40px; float: left; font-weight: bold; margin: 5px; color: #888888; font-size: 14px">资料</p>
					<c:forEach items="${resource }" var="item" varStatus="status">
						<c:if test="${item.type!=3 }">
							<c:set value="true" var="flag"></c:set>
							<c:if test="${fn:length(myResource)==0 }">
								<div style="margin-right: 10px; float: left; border-radius: 4px; text-align: center;">
									<a href="javascript:comPay('${item.id }','${item.path }')"><img src="${ctxStatic }/image/pic_ppt.jpg" width="50px" height="50px"><br>${fns:abbr(item.name,10) }</a>
								</div>
							</c:if>
							<c:forEach items="${myResource }" var="item1" varStatus="status1">
								<c:choose>
									<c:when test="${item.id == item1.mettingId }">
										<c:set value="false" var="flag"></c:set>
										<div style="margin-right: 10px; float: left; border-radius: 4px; text-align: center;">
											<a href="${item.path }"><img src="${ctxStatic }/image/pic_ppt.jpg" width="50px" height="50px"><br>${fns:abbr(item.name,10) }</a>
										</div>
									</c:when>
									<c:otherwise>
										<c:if test="${status1.last and flag }">
											<div style="margin-right: 10px; float: left; border-radius: 4px; text-align: center;">
												<a href="javascript:comPay('${item.id }','${item.path }')"><img src="${ctxStatic }/image/pic_ppt.jpg" width="50px" height="50px"><br>${fns:abbr(item.name,10) }</a>
											</div>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div style="background-color: #F6F4F4; width: 100%; display: block; overflow: auto;">
				<div style="width: 100%; overflow: visible; padding: 5px">
					<p style="width: 40px; float: left; font-weight: bold; margin: 5px; color: #888888; font-size: 14px">视频</p>
					<c:forEach items="${resource }" var="item" varStatus="status">
						<c:if test="${item.type==3 }">
							<div style="margin-right: 10px; float: left; background: #FFFFFF; border-radius: 4px; text-align: center;">
								<a href="${ctxw }/meeting/voide.htm?id=${item.id}"><img src="${ctxStatic }/image/pic_video.png" width="60px" height="50px"><br>${item.name }</a>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
		<c:if test="${fn:length(enroll)<=0 }">
			<a href="${ctxw }/meetingEnroll.htm?meetingId=${meeting.id}"><button id="submitButton" class="mui-btn mui-btn-block fixed"
					style="background-color: #FFAC5B; color: white;">报名</button></a>
		</c:if>
		<c:if test="${fn:length(enroll)>0 and enroll[0].status == '2' }">
			<div id="code" style="margin-left: 35%; margin-bottom: 40px;"></div>
		</c:if>
	</div>
	<script type="text/javascript">
		function comPay(id, path) {
			if (confirm('查看完整PDF、请确认支付!')) {
				mui.openWindow({
					url : ctxw + '/accountRecord/pay.htm?type=32&id=' + id
				});
			} else {
				location = path + '?isPdf=0'
			}
		}
		$("#code").qrcode({
			render : "table", //table方式 
			width : 90, //宽度 
			height : 90, //高度 
			text : "${user.id}" //任意内容 
		});
		(function(m, doc) {
			m.init();
		}(mui, document));
	</script>
</body>
</html>