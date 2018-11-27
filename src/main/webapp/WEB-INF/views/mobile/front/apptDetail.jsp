<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>约见详情</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link href="${ctxStatic}/css/main/apptDetail.css" rel="stylesheet" />
</head>
<body>
	<script type="text/javascript">
		mui.init()
	</script>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"
			style="color: #FFFFFF;"></a>
		<h1 class="mui-title title-style">约见详情</h1>
	</header>
	<div class="mui-content">
		<div class="div1">
			<c:choose>
				<c:when
					test="${!empty memberUser &&!empty apptDetail && memberUser.id ne apptDetail.userBy && memberUser.id ne apptDetail.userTo && apptDetail.isShow eq '2'}">
					<!-- 私密类型的约见 其他人无法查看 -->

					<div
						style="background: #FFFFFF; text-align: center; padding: 20px; color: #CCCCCC;">私密约见，无法查看</div>
				</c:when>

				<c:when
					test="${!empty memberUser &&!empty apptDetail && memberUser.id ne apptDetail.userBy && memberUser.id ne apptDetail.userTo && apptDetail.isShow eq '1'}">
					<!-- 公开类型的约见 其他人可以查看 -->
					<span>主题：</span>
					<span>${apptDetail.subject}</span>

					<div style="margin-top: 10px; min-height: 70px;">
						<p>
							<span>描述：</span><span>${apptDetail.content}</span>
						</p>
					</div>
				</c:when>

				<c:when
					test="${!empty memberUser &&!empty apptDetail && memberUser.id eq apptDetail.userBy || memberUser.id eq apptDetail.userTo}">
					<!-- 本用户为约见者或赴约者时 ，显示 -->
					<span>主题：</span>
					<span>${apptDetail.subject}</span>

					<div style="margin-top: 10px; min-height: 70px;">
						<p>
							<span>描述：</span><span>${apptDetail.content}</span>
						</p>
					</div>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>


			<c:choose>
				<c:when
					test="${!empty memberUser &&!empty apptDetail && memberUser.id eq apptDetail.userTo}">
					<!-- 当被邀约者为当前登录用户时(自己为大咖)，应该显示对方的头像和资料  -->
					<div style="margin-top: 10px; font-size: 12px; color: #666666">对方资料</div>
					<a href="${ctxw }/mine/myPage.htm?id=${userBy.id}">
					<div class="head">
						<div style="float: left;" class="div-img">
							<img class="img" src="${userBy.headImg }"
							onerror="this.src='${ct }${fs}${userBy.headImg!=null and userBy.headImg!=''?userBy.headImg:'/avatar_s.png' }@!120x120'" />
						</div>
						<div style="float: right;" class="img-text">
							<span>${!empty userBy.realName? userBy.realName:userBy.name}</span>
							<c:if test="${userBy.type eq 2}">
								<span><img width="20px" height="20px" align="center"
									src="${ctxStatic}/image/ic_approval.png" /></span>
							</c:if>
							<span class="name" style="margin-left: 18px;">${userBy.domain}</span>
							<p class="name">${userBy.detail}</p>
						</div>
					</div>
					</a>
					<div style="margin-top: 5px;">
						<span class="mui-badge"
							style="position: absolute; left: 10px; font-size: 12px;">约见费：${apptDetail.price}</span>
						<span class="mui-badge"
							style="position: absolute; right: 10px; text-align: right; font-size: 12px;">约见类型：${apptDetail.isShow eq '1'? '公开':'私密'}</span>
					</div>
				</c:when>

				<c:when
					test="${!empty memberUser &&!empty apptDetail && memberUser.id eq apptDetail.userBy}">
					<!-- 当发起约见者为当前登录用户时(自己为普通用户)，应该显示大咖的头像和资料  -->
					<div style="margin-top: 10px; font-size: 12px; color: #666666">对方资料</div>
					<a href="${ctxw }/bigShot.htm?id=${userTo.id}">
					<div class="head">
						<div style="float: left;" class="div-img">
							<img class="img" src="${userTo.headImg }"
							onerror="this.src='${ct }${fs}${userTo.headImg!=null and userTo.headImg!=''?userTo.headImg:'/avatar_s.png' }@!120x120'" />
						</div>
						<div style="float: right;" class="img-text">
							<span>${!empty userTo.realName? userTo.realName:userTo.name}</span>
							<c:if test="${userTo.type eq 2}">
								<span><img width="20px" height="20px" align="center"
									src="${ctxStatic}/image/ic_approval.png" /></span>
							</c:if>
							<span class="name" style="margin-left: 18px;">${userTo.domain}</span>
							<p class="name">${userTo.detail}</p>
						</div>
					</div>
					</a>
					<div style="margin-top: 5px;">
						<span class="mui-badge"
							style="position: absolute; left: 10px; font-size: 12px;">约见费：${apptDetail.price}</span>
						<span class="mui-badge"
							style="position: absolute; right: 10px; text-align: right; font-size: 12px;">约见类型：${apptDetail.isShow eq '1'? '公开':'私密'}</span>
					</div>
				</c:when>

				<c:when
					test="${!empty memberUser &&!empty apptDetail && memberUser.id ne apptDetail.userBy && memberUser.id ne apptDetail.userTo && apptDetail.isShow eq '1'}">
					<!-- 当发起者和被约见者都不是当前登录的本用户时，并且本约见信息类型为公开时(为其他的用户查看时)同时显示大咖和发起约见人的资料  -->
					<div style="margin-top: 10px; font-size: 12px; color: #666666">赴约大咖</div>
					<a href="${ctxw }/bigShot.htm?id=${userTo.id}">
					<div class="head">
						<div style="float: left;" class="div-img">
							<img class="img" src="${userTo.headImg }"
							onerror="this.src='${ct }${fs}${userTo.headImg!=null and userTo.headImg!=''?userTo.headImg:'/avatar_s.png' }@!120x120'" />
						</div>
						<div style="float: right;" class="img-text">
							<span>${!empty userTo.realName? userTo.realName:userTo.name}</span>
							<c:if test="${userTo.type eq 2}">
								<span><img width="20px" height="20px" align="center"
									src="${ctxStatic}/image/ic_approval.png" /></span>
							</c:if>
							<span class="name" style="margin-left: 18px;">${userTo.domain}</span>
							<p class="name">${userTo.detail}</p>
						</div>
					</div>
					</a>

					<div style="margin-top: 10px; font-size: 12px; color: #666666">邀约用户</div>
					<a href="${ctxw }/mine/myPage.htm?id=${userBy.id}">
					<div class="head">
						<div style="float: left;" class="div-img">
							<img class="img" src="${userBy.headImg }"
							onerror="this.src='${ct }${fs}${userBy.headImg!=null and userBy.headImg!=''?userBy.headImg:'/avatar_s.png' }@!120x120'" />
						</div>
						<div style="float: right;" class="img-text">
							<span>${!empty userBy.realName? userBy.realName:userBy.name}</span>
							<c:if test="${userBy.type eq 2}">
								<span><img width="20px" height="20px" align="center"
									src="${ctxStatic}/image/ic_approval.png" /></span>
							</c:if>
							<span class="name" style="margin-left: 18px;">${userBy.domain}</span>
							<p class="name">${userBy.detail}</p>
						</div>
					</div>
					</a>
			<!-- 	<div style="margin-top: 5px;">
						<span class="mui-badge"
							style="position: absolute; left: 10px; font-size: 12px;">约见费：${apptDetail.price}</span>
						<span class="mui-badge"
							style="position: absolute; right: 10px; text-align: right; font-size: 12px;">约见类型：${apptDetail.isShow eq '1'? '公开':'私密'}</span>
					</div>   -->	
				</c:when>

				<c:otherwise>
				</c:otherwise>
			</c:choose>


		</div>

		<div class="div2">
			<div class="div2_1">
				<div class="div2_1_2">
					<c:choose>
						<c:when test="${apptDetail.status eq 0 && apptDetail.userBy eq memberUser.id}">
							<!-- 当前用户为发起约见者时，并且问题状态为未支付  -->
							<div style="text-align: center; margin: 3px; background: #FFFFFF; color: #666666; padding-top: 5px; padding-bottom: 5px;">请您支付后稍等</div>
						</c:when>
					
						<c:when
							test="${!empty memberUser && apptDetail.status eq 3 &&!empty apptDetail && apptDetail.userBy eq memberUser.id }">
							<!-- 当前用户为发起约见者时，并且约见状态为已拒绝时，显示此处 -->
							<div
								style="background: #FFFFFF; text-align: center; padding: 10px; color: #888888;">已被拒绝</div>
							<div
								style="background: #FFFFFF; text-align: center; padding-left: 10px; color: #888888;">${apptDetail.remarks}</div>
						</c:when>
						<c:when
							test="${!empty memberUser && apptDetail.status eq 3 &&!empty apptDetail && apptDetail.userTo eq memberUser.id }">
							<!-- 当前用户为被约见(大咖)时，并且约见状态为已拒绝时，显示此处 -->
							<div
								style="background: #FFFFFF; text-align: center; padding: 10px; color: #888888;">已拒绝邀约</div>
							<div
								style="background: #FFFFFF; text-align: center; padding-left: 10px; padding-right: 10px; padding-bottom: 10px; color: #888888;">${apptDetail.remarks}</div>
						</c:when>
						<c:when
							test="${!empty memberUser &&!empty apptDetail && apptDetail.userBy eq memberUser.id && apptDetail.status eq '1'}">
							<!-- 当前用户为发起约见者时，并且约见状态为未约见时，显示此处 -->
							<div
								style="background: #FFFFFF; text-align: center; padding: 10px; color: #888888;">当前状态为待约见</div>
						</c:when>
						<c:when
							test="${!empty memberUser &&!empty apptDetail && apptDetail.userBy eq memberUser.id && apptDetail.status eq '2'}">
							<!-- 当前用户为发起约见者时，并且约见状态为已约见时，显示此处 -->
							<div class="mui-badge-success"
								style="padding-bottom: 3px; padding-top: 3px; margin-left: 7%; margin-right: 7%;">
								<span style="font-size: 16px;">已同意约见</span>
								<p class="mui-badge-success"
									style="margin-bottom: 0px; font-size: 14px; padding-top: 3px;">对方联系方式：${userTo.phone}</p>
							</div>
						</c:when>
						<c:when
							test="${!empty memberUser &&!empty apptDetail && apptDetail.userTo eq memberUser.id && apptDetail.status eq 2}">
							<!-- 当前用户为被约见人（大咖）时，并且约见状态为已约见时，显示此处 -->
							<div class="mui-badge-success"
								style="padding-bottom: 3px; padding-top: 3px; margin-left: 7%; margin-right: 7%;background:#4AACC5;">
								<span style="font-size: 16px;">已同意接见</span>
								<p class="mui-badge-success"
									style="margin-bottom: 0px; font-size: 14px; padding-top: 3px; background:#4AACC5;">对方联系方式：${userBy.phone}</p>
							</div>
						</c:when>
						
						<c:when test="${apptDetail.status eq 0 && apptDetail.userTo eq memberUser.id}">
							<!-- 当前用户为被约见大咖，并且约见状态为未支付  -->
							<div style="text-align: center; margin: 3px; background: #FFFFFF; color: #666666; padding-top: 5px; padding-bottom: 5px;">请您等对方支付后再进行操作</div>
						</c:when>
						
						
						<c:when
							test="${!empty memberUser &&!empty apptDetail && apptDetail.userTo ne memberUser.id && apptDetail.userBy ne memberUser.id && apptDetail.status eq '2' && apptDetail.isShow eq '1'}">
							<!-- 当前用户不是邀约者也不是被约见者，并且约见状态为已约见时显示 -->
							<div 
								style="background:#4AACC5;border-radius:5px; padding-bottom: 6px; padding-top: 6px; margin-left: 7%; margin-right: 7%;">
								<span style="font-size: 16px; color:#FFFFFF">已约见成功！</span>
							</div>
						</c:when>

						<c:when
							test="${!empty memberUser &&!empty apptDetail && apptDetail.userTo eq memberUser.id && apptDetail.status eq '1'}">
							<!-- 当前用户为被约见人（大咖）时，并且约见状态为未约见时，显示此处 -->
							<form id="okForm" action="${ctxw }/My/okSave.htm" method="post">
								<input name="id" value="${apptDetail.id}" type="text"
									style="display: none;" />
								<button id="submitSuccess" type="button"
									class="mui-btn mui-btn-success"
									style="width: 35%; margin-right: 15%;">确认赴约</button>

								<button id="submitOff" type="button"
									class="mui-btn mui-btn-warning" style="width: 35%;">拒绝赴约</button>
							</form>
							<div class="div2_1_3">
								<!-- 拒绝赴约时显示提交拒绝理由-->
								<div id="off2" style="display: none;">
									<form id="refuseForm" action="${ctxw}/My/refuseSave.htm"
										method="post">
										<input name="id" value="${apptDetail.id}" type="text"
											style="display: none;" />
										<textarea name="remarks" rows="2" style="margin: 0;"
											placeholder="请输入拒绝理由。"></textarea>
										<div style="text-align: right; padding-right: 5px;">
											<button id="submitRefuse" type="button"
												class="mui-btn mui-btn-warning" style="height: 30px;">确认</button>
										</div>
									</form>
								</div>
							</div>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
					<!--	
					<button id="submitSuccess" type="button"
						class="mui-btn mui-btn-success"
						style="width: 35%; margin-right: 15%;">确认赴约</button>
					<button id="submitOff" type="button"
						class="mui-btn mui-btn-warning" style="width: 35%;">拒绝赴约</button>

					<div class="div2_1_3">
					
						<div class="mui-badge-success"
							style="padding-bottom: 3px; padding-top: 3px; display: none;">
							<span style="width: 86%; font-size: 16px;">已确认赴约</span>
							<p class="mui-badge-success"
								style="margin-bottom: 0px; font-size: 14px; padding-top: 3px;">对方联系方式：13333333333</p>
						</div>

					
						<div id="off2" style="display: none;">
							<form id="refuseForm" action="${ctxw }/My/refuseSave.htm"
								method="post">
								<textarea name="remarks" rows="2" style="margin: 0;"
									placeholder="请输入拒绝理由。"></textarea>
								<div style="text-align: right; padding-right: 5px;">
									<button id="submitRefuse" type="button"
										class="mui-btn mui-btn-warning" style="height: 30px;">确认</button>
								</div>
							</form>
						</div>
					</div>  -->
					<div class="solid"></div>
				</div>
				<c:if
					test="${!empty apptDetail && apptDetail.userTo eq memberUser.id || apptDetail.userBy eq memberUser.id }">
					<div class="div2_1_3">
						<button id="help" type="button" class="mui-btn mui-btn-warning"
							style="width: 86%; font-size: 16px;">小慧协助</button>
					</div>
				</c:if>
			</div>
		</div>

		<!--  
		<div class="div3">
			<div class="div3_1">评价评价</div>
			<div style="text-align: center;">
				<button class="mui-btn mui-btn-warning">提 交</button>
			</div>
		</div>
		-->
	</div>

	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			var submitOk = doc.getElementById('submitSuccess'); //确认赴约
			var submitRefuse = doc.getElementById('submitRefuse'); //提交拒绝理由
			var help = doc.getElementById('help'); //小慧在线
			if (submitOk != null) {
				submitOk.addEventListener('tap', function(event) {
					$('#okForm').submit();
				});
			}
			//拒绝赴约提交
			if (submitRefuse != null) {
				submitRefuse.addEventListener('tap', function(event) {
					if ($('textarea[name=remarks]').val().length <= 0) {
						m.toast('拒绝理由不能为空');
					} else {
						$('#refuseForm').submit();
					}
				});
			}

			//小慧在线 /csCenter.htm
			if (help != null) {
				help.addEventListener('tap', function(event) {
					mui.openWindow({
						url : ctxw + '/csCenter/faceBack.htm?type=1'
					});
				});
			}
		}(mui, document));

		//拒绝时隐藏与显示
		$("#submitOff").click(function() {
			if ($("#off2").css("display") == "none") {
				$("#submitOff").html("隐藏");
				$("#off2").show();
			} else {
				$("#submitOff").html("拒绝赴约");
				$("#off2").hide();
			}
		});

		//(暂时未实现)评分
		mui('.icons').on('tap', 'i', function() {
			var index = parseInt(this.getAttribute("data-index"));
			var parent = this.parentNode;
			var children = parent.children;
			if (this.classList.contains("mui-icon-star")) {
				for (var i = 0; i < index; i++) {
					children[i].classList.remove('mui-icon-star');
					children[i].classList.add('mui-icon-star-filled');
				}
			} else {
				for (var i = index; i < 5; i++) {
					children[i].classList.add('mui-icon-star')
					children[i].classList.remove('mui-icon-star-filled')
				}
			}
			starIndex = index;
		});
	</script>
</body>

</html>