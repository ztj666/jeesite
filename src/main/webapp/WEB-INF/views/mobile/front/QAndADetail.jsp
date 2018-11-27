<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>问答详情</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link href="${ctxStatic}/css/main/answerDetail.css" rel="stylesheet" />
<style>
.feedback .mui-inline {
	vertical-align: bottom;
	font-size: 14px;
	color: #8f8f94;
}

.mui-icon-star {
	color: #B5B5B5;
	font-size: 22px;
}

.mui-icon-star-filled {
	color: #FFB400;
	font-size: 22px;
}
</style>
</head>
<body>
	<div style="display: none;">
		<sys:message content="${message}" />
	</div>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: #FFFFFF;"></a>
		<h1 class="mui-title title-style">问答详情</h1>
	</header>
	<div class="mui-content">
		<div class="div1">
			<c:choose>
				<c:when
					test="${!empty memberUser &&!empty memberConsult && memberUser.id ne memberConsult.userBy && memberUser.id ne memberConsult.userTo && memberConsult.isShow eq '2'}">
					<!-- 私密类型的问答 其他人无法查看 -->
					<div style="background: #FFFFFF; text-align: center; padding: 20px; color: #CCCCCC;">私密问答，无法查看</div>
				</c:when>
				<c:when
					test="${!empty memberUser &&!empty memberConsult && memberUser.id ne memberConsult.userBy && memberUser.id ne memberConsult.userTo && memberConsult.isShow eq '1'}">
					<!-- 公开类型的问答  其他人可以查看 -->
					<span>主题：</span>
					<span>${memberConsult.subject}</span>
					<div style="margin-top: 10px; min-height: 40px;">
						<p>
							<span>描述：</span><span>${memberConsult.content}</span>
						</p>
					</div>
				</c:when>
				<c:when test="${!empty memberUser &&!empty memberConsult && memberUser.id eq memberConsult.userBy || memberUser.id eq memberConsult.userTo}">
					<!-- 本用户为提问者或回答者时 ，显示 -->
					<span>主题：</span>
					<span>${memberConsult.subject}</span>

					<div style="margin-top: 10px; min-height: 40px;">
						<p>
							<span>描述：</span><span>${memberConsult.content}</span>
						</p>
					</div>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</div>
					<!--  
					<div  style="margin-top: 10px; font-size: 12px; color: #666666; margin-left:10px;">咨询人</div>
					<c:if test="${userBy.type eq 2}">
					<a href="${ctxw }/bigShot.htm?id=${userBy.id}">
					</c:if>
					<c:if test="${userBy.type eq 1}">
					<a href="${ctxw }/mine/myPage.htm?id=${userBy.id}">
					</c:if>
					<div class="head div2_1" style="padding-top:0px;">
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
							<p class="names">${userBy.detail}</p>
						</div>
					</div>
					</a>
					-->
		<div class="div2">
		<!-- 	<div  style="margin-top: 10px; font-size: 12px; color: #666666; margin-left:10px;">回答大咖</div>  -->
			<div class="div2_1">
				<a href="${ctxw }/bigShot.htm?id=${userTo.id}">
					<div class="div2_1_1">
						<img src="${userTo.headImg }"
							onerror="this.src='${ct }${fs}${userTo.headImg!=null and userTo.headImg!=''?userTo.headImg:'/avatar_s.png' }@!50x50'" /> 
							<span class="name">${!empty userTo.realName? userTo.realName:userTo.name}</span> 
							<c:if test="${userTo.type eq 2}">
								<span><img width="20px" height="20px" align="center"
									src="${ctxStatic}/image/ic_approval.png" /></span>
							</c:if>
							<span class="trade">${userTo.domain}</span>
					</div>
				</a>
				<div class="div2_1_2">
					<c:choose>
						<c:when test="${memberConsult.status eq 0 && memberConsult.userBy eq memberUser.id}">
							<!-- 提问者为本用户，并且问题状态为未支付  -->
							<div style="text-align: center; margin: 3px; background: #FFFFFF; color: #666666; padding-top: 5px; padding-bottom: 5px;">请您支付后等待系统操作</div>
						</c:when>
						
						<c:when test="${memberConsult.status eq 1 && memberConsult.userBy eq memberUser.id}">
							<!-- 提问者为本用户，并且问题状态为未回答  -->
							<div style="text-align: center; margin: 3px; background: #FFFFFF; color: #666666; padding-top: 5px; padding-bottom: 5px;">未回答</div>
						</c:when>
						<c:when
							test="${memberConsult.status eq 2 && memberConsult.userBy ne memberUser.id &&memberConsult.userTo ne memberUser.id &&memberConsult.isShow eq '1' && myResource}">
							<!-- 问题已回答，当前不是回答者，也不是提问者时，并且该问题类型是公开问题 已购买 -->
							 ${memberConsult.answer}
						</c:when>
						<c:when
							test="${memberConsult.status eq 2 && memberConsult.userBy ne memberUser.id &&memberConsult.userTo ne memberUser.id &&memberConsult.isShow eq '1'}">
							<!-- 问题已回答，当前不是回答者，也不是提问者时，并且该问题类型是公开问题 -->
							<p id="isShow" style="line-height: 30px;">点此支付0.99元可查看答案</p>

							<span id="anwshow" style="display: none;">${memberConsult.answer}</span>
						</c:when>

						<c:when
							test="${memberConsult.status eq 2 && memberConsult.isShow eq '2' && memberConsult.userBy ne memberUser.id && memberConsult.userTo ne memberUser.id}">
							<!-- 问题已回答，当前不是回答者，也不是提问者时，并且该问题类型是私密问题 -->
						</c:when>


						<c:when test="${memberConsult.status eq 2 && memberConsult.userBy eq memberUser.id}">
							<!-- 问题已回答，当前为提问者显示答案 -->  
                         ${memberConsult.answer}
                        </c:when>
						<c:when test="${memberConsult.status eq 2 && memberConsult.userTo eq memberUser.id}">
							<!-- 问题已回答，当前为回答者时显示答案 -->  
                         ${memberConsult.answer}
                        </c:when>

						<c:when test="${memberConsult.status eq 3}">
							<!-- 问题当前状态为已关闭时 -->
							<div style="text-align: center; margin: 3px; background: #FFFFFF; color: #666666; padding-top: 5px; padding-bottom: 5px;">该问题已关闭</div>
						</c:when>
						
						<c:when test="${memberConsult.status eq 0 && memberConsult.userTo eq memberUser.id}">
							<!-- 问题状态待支付，大咖应显示  -->
							<div style="text-align: center; margin: 3px; background: #FFFFFF; color: #666666; padding-top: 5px; padding-bottom: 5px;">请等待对方支付后再进行操作</div>
						</c:when>
						<c:when test="${memberConsult.status eq '1' && memberConsult.userTo eq memberUser.id}">
							<!-- 状态为未回答时 大咖可以进行回答问题 -->
							<div>
								<span id="answer" class="ask">回答</span>
								<div id="answer2" style="display: none;">
									<form id="AnswerForm" action="${ctxw }/My/save.htm" method="post">
										<input name="id" value="${memberConsult.id }" type="text" style="display: none;" />
										<textarea name="answer" rows="4" style="margin: 0;" placeholder="请输入您的回答。"></textarea>
										<div style="text-align: right; padding-right: 5px;">
											<button type="button" id="submitAnswer" name="submitAnswer" class="mui-btn mui-btn-warning">提交答案</button>
										</div>
									</form>
								</div>
							</div>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
					<div class="solid"></div>
				</div>
				<div class="div2_1_3">
					<c:choose>
						<c:when test="${empty againAsk && memberConsult.userBy eq memberUser.id && memberConsult.status eq 2}">
							<!-- 追问为空 并且本用户是提问者 并且这个问题状态已经为已回答状态时，用户才能进行追问 -->
							<span id="Askagain" class="ask">追问</span>
							<div id="Askagain2" style="display: none;">
								<form id="AgainAskForm" action="${ctxw }/My/askAgain.htm" method="post">
									<input name="userBy" value="${memberConsult.userBy}" type="text" style="display: none;" /> <input name="userTo"
										value="${memberConsult.userTo}" type="text" style="display: none;" /> <input name="label" value="${memberConsult.label}" type="text"
										style="display: none;" /> <input name="isShow" value="${memberConsult.isShow}" type="text" style="display: none;" /> <input
										name="orgConsultId" value="${memberConsult.id}" type="text" style="display: none;" />
									<textarea name="content" rows="4" style="margin: 0;" placeholder="如还有疑问，请输入追问。"></textarea>
									<div style="text-align: right; padding-right: 5px;">
										<button id="submitAgainAsk" type="button" class="mui-btn mui-btn-warning">提交追问</button>
									</div>
								</form>
							</div>

							<div class="mui-content-padded" style="display: none;">
								<div class="mui-inline">评价</div>
								<div class="icons mui-inline" style="margin-left: 6px;">
									<i data-index="1" class="mui-icon mui-icon-star"></i> <i data-index="2" class="mui-icon mui-icon-star"></i> <i data-index="3"
										class="mui-icon mui-icon-star"></i> <i data-index="4" class="mui-icon mui-icon-star"></i> <i data-index="5" class="mui-icon mui-icon-star"></i>
								</div>
							</div>

						</c:when>
						<c:when test="${!empty againAsk && againAsk[0].status eq 1 && memberUser.id eq againAsk[0].userTo}">
							<!-- 当追问的状态是未回答时，显示追问的问题，并且您是回答者，您可以进行追答 -->
							<span class="ask_again">追问</span>
							<span class="answer_again">${againAsk[0].content}</span>
							<div class="solid"></div>
							<div>
								<span id="AnswerAgain" class="ask">追答</span>
								<div id="AnswerAgain2" style="display: none;">
									<form id="againAnswerForm" action="${ctxw }/My/againAnswer.htm" method="post">
										<input name="id" value="${againAsk[0].id}" type="text" style="display: none;" />
										<textarea name="answer" rows="4" style="margin: 0;" placeholder="请输入 回答内容。"></textarea>
										<div style="text-align: right; padding-right: 5px;">
											<button id="submitAgainAnswer" type="button" class="mui-btn mui-btn-warning">提交追答</button>
										</div>
									</form>
								</div>
							</div>
						</c:when>

						<c:when test="${!empty againAsk && againAsk[0].status eq 1 && memberUser.id eq againAsk[0].userBy}">
							<!-- 当这个追问问题状态是未回答，显示这个问题追问问题，并且提问者是本用户，本人可看到追答问题，状态为待回答-->
							<span class="ask_again">追问</span>
							<span class="answer_again">${againAsk[0].content}</span>
							<div class="solid"></div>
							<div style="text-align: center; margin: 3px; background: #FFFFFF; color: #666666; padding-top: 5px; padding-bottom: 5px;">待回答</div>
						</c:when>

						<c:when test="${!empty againAsk && againAsk[0].status eq 2 && memberUser.id eq againAsk[0].userBy || memberUser.id eq againAsk[0].userTo}">
							<!-- 当这个追问问题状态是已回答，并且本人是提问者或 回答者 显示这个问题的追问问题 -->
							<span class="ask_again">追问</span>
							<span class="answer_again">${againAsk[0].content}</span>
							<div class="solid"></div>
							<div class="div2_1_4">
								<span>${againAsk[0].answer}</span>
							</div>
						</c:when>

						<c:when
							test="${!empty againAsk && againAsk[0].isShow eq '1' && againAsk[0].status eq 2 && memberUser.id ne againAsk[0].userBy && memberUser.id ne againAsk[0].userTo}">
							<!-- 当这个追问问题状态是已回答，并且本人不是提问者也不是回答者 并且类型为公开 显示这个问题的追问问题 -->
							<!-- 刮开效果 查看追问和追答  -->
							<div id="anwshow2" style="display: none">
								<span class="ask_again">追问</span> <span class="answer_again">${againAsk[0].content}</span>
								<div class="solid"></div>
								<div class="div2_1_4">
									<span>${againAsk[0].answer}</span>
								</div>
							</div>
						</c:when>

						<c:when
							test="${!empty againAsk && againAsk[0].isShow eq '2' && againAsk[0].status eq 2 && memberUser.id ne againAsk[0].userBy && memberUser.id ne againAsk[0].userTo}">
							<!-- 当这个追问问题状态是已回答，并且本人不是提问者也不是回答者 并且类型为私密  隐藏这个问题的追问问题 -->
						</c:when>
						<c:otherwise>

						</c:otherwise>
					</c:choose>
				</div>

			</div>
		</div>
		<div class="div3">
			<div class="div3_1">评价评价</div>
			<div style="text-align: center;">
				<button class="mui-btn mui-btn-warning">提 交</button>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var userById = "${memberConsult.userBy}";
		var anshow = document.getElementById('anwshow'); //答案div
		var anshow2 = document.getElementById('anwshow2'); //追答div
		(function(m, doc) {
			m.init();
			var myLastBalance = "${memberUser.lastBalance}";
			var show = doc.getElementById('isShow'); //查看答案
			var submitAnswer = doc.getElementById('submitAnswer'); //回答
			var submitAgainAsk = doc.getElementById('submitAgainAsk'); //追问
			var submitAgainAnswer = doc.getElementById('submitAgainAnswer'); //追答
			if (submitAnswer != null) {
				submitAnswer.addEventListener('tap', function(event) {
					if ($('textarea[name=answer]').val().length <= 0) {
						m.toast('回答不能为空');
					} else {
						$('#AnswerForm').submit();
					}
				});
			}
			//data: { id: idIndex, name: nameIndex },//提交参数
			if (show != null) {
				show
						.addEventListener(
								'tap',
								function(event) {
									var btnArray = [ '否', '是' ];
									mui
											.confirm(
													'支付0.99元可查看答案',
													'支付',
													btnArray,
													function(e) {
														if (e.index == 1) {
															if (myLastBalance < 0.99) {
																mui
																		.openWindow({
																			url : ctxw
																					+ '/accountRecord/pay.htm?type=11&id='
																					+ '${memberConsult.id}'
																		});
															} else {
																answerPay();
															}
														} else {
															m.toast('操作已取消');
														}
													});
								});
			}

			if (submitAgainAsk != null) {
				submitAgainAsk.addEventListener('tap', function(event) {
					if ($('textarea[name=content]').val().length <= 0) {
						m.toast('追问不能为空');
					} else {
						$('#AgainAskForm').submit();
					}
				});
			}

			if (submitAgainAnswer != null) {
				submitAgainAnswer.addEventListener('tap', function(event) {
					if ($('textarea[name=answer]').val().length <= 0) {
						m.toast('追答不能为空');
					} else {
						$('#againAnswerForm').submit();
					}
				});
			}
		}(mui, document));

		//评分
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

		function answerPay() {
			$.ajax({
				type : "POST",
				url : ctxw + "/My/answerPay.htm",
				data : {
					id : userById,
					meetingId : '${memberConsult.id}'
				},
				dataType : "text",
				success : function(result) {
					if (result == "NOT") {
						mui.toast("您的余额不足");
					} else if (result == "FAIL") {
						mui.toast("支付失败");
					} else if (result == "OK") {
						if ($("#anwshow") != null) {
							$("#isShow").hide();
							$("#anwshow").show();
						}
						if ($("#anwshow2") != null) {
							$("#isShow").hide();
							$("#anwshow2").show();
						}

					}
				},
				error : function(XMLHttpRequest, data, textStatus) {
					mui.toast("请求失败，请重试！");
				}
			});
		}
	</script>


	<script>
		$("#answer").click(function() {
			if ($("#answer2").css("display") == "none") {
				$("#answer").html("隐藏");
				$("#answer2").show();
			} else {
				$("#answer").html("回答");
				$("#answer2").hide();
			}
		});
		$("#Askagain").click(function() {
			if ($("#Askagain2").css("display") == "none") {
				$("#Askagain").html("隐藏");
				$("#Askagain2").show();
			} else {
				$("#Askagain").html("追问");
				$("#Askagain2").hide();
			}
		});
		$("#AnswerAgain").click(function() {
			if ($("#AnswerAgain2").css("display") == "none") {
				$("#AnswerAgain").html("隐藏");
				$("#AnswerAgain2").show();
			} else {
				$("#AnswerAgain").html("追答");
				$("#AnswerAgain2").hide();
			}
		});
	</script>
</body>
</html>