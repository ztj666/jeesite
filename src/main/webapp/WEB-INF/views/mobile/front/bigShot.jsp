<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>${member.type eq 2? '大咖':'获取失败！'}</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link href="${ctxStatic}/css/main/bigShot.css" rel="stylesheet" />
</head>
<body>
		<script type="text/javascript">
			mui.init()
		</script>
		<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"
				style="color: #FFFFFF;"></a>
			<h1 class="mui-title title-style">${!empty member.realName? member.realName: member.name }主页
			</h1>
		</header>
		<div style="display: none;">
			<sys:message content="${message}" />
		</div>
		<nav id = "foolt" class="mui-bar mui-bar-tab">
			<a id="quiz" class="mui-tab-item mui-active bottom-bg" id="tiwen" target="#">
				<span  class="mui-tab-label color-white">提问</span>
			</a> <a id="meet" class="mui-tab-item bottom-bg1" id="yuejian" target="#"> <span
				 class="mui-tab-label color-white">约见</span>
			</a>
		</nav>
		<div class="mui-content" style="margin-top:-25px;">
			<div class="box1">
				<div class="box2">
					<c:choose>
						<c:when test="${empty member.headImg}">
							<img width="120px" height="120px"
								src="${ctxStatic}/image/avatar_s.png" />
						</c:when>
						<c:otherwise>
							<img width="120px" height="120px" style="border-radius: 120px;"
							src="${member.headImg }"
							onerror="this.src='${ct }${fs}${member.headImg!=null and member.headImg!=''?member.headImg:'/avatar_s.png' }@!120x120'"
								/>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<p
				style="text-align: center; color: #333333; font-size: 18px; line-height: 10px; margin-top: 55px;">
				&emsp;${!empty member.realName? member.realName: member.name }
				<c:if test="${member.type eq 2}">
				<img width="20px" height="20px" align="center" src="${ctxStatic}/image/ic_approval.png" />
				</c:if>
			</p>
			<p class="centered" style="font-size: 14px; color: #888888; line-height: 10px;">公司&nbsp;${member.orgName}</p> 
		<p class="centered" style="font-size: 14px; color: #888888; line-height: 10px; ">岗位&nbsp;${member.position}</p>
		<p class="centered" style="font-size: 14px; color: #888888; line-height: 10px; ">咨询费&nbsp;${member.consultPrice}</p>
			<span class="paddingleft"><img align="center" width="19px"
				height="19px" src="${ctxStatic}/image/ic_tag_blue.png" />&nbsp;擅长</span>
			<hr/>
			<div class="tag-list bottom-margin">
				<ul>
					<c:forEach items="${tag}" var="item">
						<c:if test="${item.type eq '1'}">
							<li>${item.label.name}</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>

			<span class="paddingleft"><img align="center" width="19px"
				height="19px" src="${ctxStatic}/image/ic_doc_blue.png" />&nbsp;简介</span>
			<hr />
			<div class="explain bottom-margin paddingleft">
				<p>${member.detail}</p>
			</div>

			<span class="paddingleft"><img align="center" width="19px"
				height="19px" src="${ctxStatic}/image/ic_chat_blue.png" />&nbsp;回答过的公开问题</span>
			<hr />
			<c:forEach items="${answerer}" var="ansitem">
			<c:if test="${ansitem.isShow eq '1' && ansitem.type eq '1' && ansitem.status eq '2'}">
				<a href="${ctxw }/My/consultDetail.htm?id=${ansitem.id}">
				<div class="explain bottom-margin paddingleft">
					<p>${ansitem.subject }</p>
					<p style="padding-top: 0px; font-size: 14px; color: #888888;">
						<img align="center" src="${ctxStatic}/image/ic_tag.png"
							width="19px" height="19px" />${ansitem.label}
					</p>
				</div>
				</a>
			</c:if>  
			</c:forEach>
			
			    <div style="margin-top:10px;"></div>
				<span class="paddingleft"><img align="center" width="19px"
				height="19px" src="${ctxStatic}/image/ic_chat_blue.png" />&nbsp;赴约过的公开约见</span>
			<hr />
			<c:forEach items="${apptlist}" var="item">
				<c:if test="${item.isShow eq '1' && item.status eq '2'}">
				<a href="${ctxw }/My/apptDetail.htm?id=${item.id}">
				<div class="explain bottom-margin paddingleft">
					<p>${item.subject }</p>
					<p style="padding-top: 0px; font-size: 14px; color: #888888;">
						<img align="center" src="${ctxStatic}/image/ic_tag.png"
							width="19px" height="19px" />${item.label}
					</p>
				</div>
				</a>
				</c:if>
			</c:forEach>
		</div>
	<script>
	     var type = "${member.type}";
	     if(type != ""){
	     if("2" === type){
	    	 $("#foolt").show();
	     }else{
	    	 $("#foolt").hide(); 
	      }
	     }else{
	    	 $("#foolt").hide(); 
	     }
	</script>
	<script>
	    var id = "${member.id}";
		//tap为mui封装的单击事件，带大咖id参数跳向提问界面
		document.getElementById('quiz').addEventListener('tap', function() {
			//打开提问页面
			mui.openWindow({
				url : ctxw+'/My/quiz.htm?id='+id
			});
		});
		//tap为mui封装的单击事件，带大咖id参数跳向约见界面
		document.getElementById('meet').addEventListener('tap', function() {
			//打开约见页面 
			mui.openWindow({
				url : ctxw+'/My/appt.htm?id='+id
			});
		});
	</script>
</body>
</html>