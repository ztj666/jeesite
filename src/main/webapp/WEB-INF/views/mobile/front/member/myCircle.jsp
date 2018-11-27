<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>我的圈子</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
</head>
<body background="#FFFFFF">
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5; box-shadow: 0px 0px 0px 0px;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white;">我的圈子</h1>
		<a href="${ctxw }/selectLabel.htm" class="mui-pull-right" style="color: white; margin-top: 12px">设置</a>
	</header>
	<div class="mui-content">
		<div style="padding: 18px 20px 0 18px">
			<div style="width: 100%; padding: 5px">
				<img style="float: left;" width="19px" height="19px" src="${ctxStatic}/image/ic_tag_blue.png" />
				<p style="float: left; color: #4AACC5; margin-left: 5px">我擅长</p>
				<p id="reCircle1" style="float: right; color: #4AACC5;">换一批</p>
			</div>
			<div style="height: 4px; background-color: #94D3E2; margin-top: 20px"></div>
		</div>
		<div id="memberUserLabel11">
			<c:if test="${memberUserLabel11.list!=null and fn:length(memberUserLabel11.list)>0 }">
				<div style="width: 100%; margin: 5px; height: 160px; display: block;">
					<p style="margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;">${memberUserLabel11.list[0].label.name }</p>
					<c:forEach items="${memberUserLabel11.list }" var="item">
						<div
							style="margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;">
							<a href="${ctxw }/mine/myPage.htm?id=${item.user.id}"><img style="margin-top:3px; border-radius: 100px;" src="${item.user.headImg }" onerror="this.src='${ct }${fs}${item.user.headImg!=null and item.user.headImg!=''?item.user.headImg:'/avatar_s.png' }@!50x50'"
								width="50px" height="50px"></a>
							<p style="font: 14px; color: #333333">${item.user.name }</p>
							<p style="font: 14px;">${item.user.position }</p>
						</div>
					</c:forEach>
				</div>
			</c:if>

			<c:if test="${memberUserLabel12.list!=null and fn:length(memberUserLabel12.list)>0 }">
				<div style="width: 100%; margin: 5px; height: 160px; display: block;" class="mui-clearfix">
					<p style="margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;">${memberUserLabel12.list[0].label.name }</p>
					<c:forEach items="${memberUserLabel12.list }" var="item">
						<div
							style="margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;">
							<a href="${ctxw }/mine/myPage.htm?id=${item.user.id}"><img  style="margin-top:3px; border-radius: 100px;" src="${item.user.headImg }" onerror="this.src='${ct }${fs}${item.user.headImg!=''?item.user.headImg:'/avatar_s.png' }@!50x50'"
								width="50px" height="50px"></a>
							<p style="font: 14px; color: #333333">${item.user.name }</p>
							<p style="font: 14px;">${item.user.position }</p>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${memberUserLabel13.list!=null and fn:length(memberUserLabel13.list)>0 }">
				<div style="width: 100%; margin: 5px; height: 160px; display: block;" class="mui-clearfix">
					<p style="margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;">${memberUserLabel13.list[0].label.name }</p>
					<c:forEach items="${memberUserLabel13.list }" var="item">
						<div
							style="margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;">
							<a href="${ctxw }/mine/myPage.htm?id=${item.user.id}"><img  style="margin-top:3px; border-radius: 100px;" src="${item.user.headImg }" onerror="this.src='${ct }${fs}${item.user.headImg!=''?item.user.headImg:'/avatar_s.png' }@!50x50'"
								width="50px" height="50px"></a>
							<p style="font: 14px; color: #333333">${item.user.name }</p>
							<p style="font: 14px;">${item.user.position }</p>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${memberUserLabel14.list!=null and fn:length(memberUserLabel14.list)>0 }">
				<div style="width: 100%; margin: 5px; height: 160px; display: block;" class="mui-clearfix">
					<p style="margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;">${memberUserLabel14.list[0].label.name }</p>
					<c:forEach items="${memberUserLabel14.list }" var="item">
						<div
							style="margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;">
							<a href="${ctxw }/mine/myPage.htm?id=${item.user.id}"><img  style="margin-top:3px; border-radius: 100px;" src="${item.user.headImg }" onerror="this.src='${ct }${fs}${item.user.headImg!=''?item.user.headImg:'/avatar_s.png' }@!50x50'"
								width="50px" height="50px"></a>
							<p style="font: 14px; color: #333333">${item.user.name }</p>
							<p style="font: 14px;">${item.user.position }</p>
						</div>
					</c:forEach>
				</div>
			</c:if>
		</div>
		<div style="padding: 18px 20px 0 18px">
			<div style="width: 100%; padding: 5px">
				<img style="float: left;" width="19px" height="19px" src="${ctxStatic}/image/ic_interest_blue.png" />
				<p style="float: left; color: #4AACC5; margin-left: 5px">感兴趣</p>
				<p id="reCircle2" style="float: right; color: #4AACC5;">换一批</p>
			</div>
			<div style="height: 4px; background-color: #94D3E2; margin-top: 20px"></div>
		</div>
		<div id="memberUserLabel12">
			<c:if test="${memberUserLabel21.list!=null and fn:length(memberUserLabel21.list)>0 }">
				<div style="width: 100%; margin: 5px; height: 160px; display: block;" class="mui-clearfix">
					<p style="margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;">${memberUserLabel21.list[0].label.name }</p>
					<c:forEach items="${memberUserLabel21.list }" var="item">
						<div
							style="margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;">
							<a href="${ctxw }/mine/myPage.htm?id=${item.user.id}"><img  style="margin-top:3px; border-radius: 100px;" src="${item.user.headImg }" onerror="this.src='${ct }${fs}${item.user.headImg!=''?item.user.headImg:'/avatar_s.png' }@!50x50'"
								width="50px" height="50px"></a>
							<p style="font: 14px; color: #333333">${item.user.name }</p>
							<p style="font: 14px;">${item.user.position }</p>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${memberUserLabel22.list!=null and fn:length(memberUserLabel22.list)>0 }">
				<div style="width: 100%; margin: 5px; height: 160px; display: block;" class="mui-clearfix">
					<p style="margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;">${memberUserLabel22.list[0].label.name }</p>
					<c:forEach items="${memberUserLabel22.list }" var="item">
						<div
							style="margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;">
							<a href="${ctxw }/mine/myPage.htm?id=${item.user.id}"><img  style="margin-top:3px; border-radius: 100px;" src="${item.user.headImg }" onerror="this.src='${ct }${fs}${item.user.headImg!=''?item.user.headImg:'/avatar_s.png' }@!50x50'"
								width="50px" height="50px"></a>
							<p style="font: 14px; color: #333333">${item.user.name }</p>
							<p style="font: 14px;">${item.user.position }</p>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${memberUserLabel23.list!=null and fn:length(memberUserLabel23.list)>0 }">
				<div style="width: 100%; margin: 5px; height: 160px; display: block;" class="mui-clearfix">
					<p style="margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;">${memberUserLabel23.list[0].label.name }</p>
					<c:forEach items="${memberUserLabel23.list }" var="item">
						<div
							style="margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;">
							<a href="${ctxw }/mine/myPage.htm?id=${item.user.id}"><img  style="margin-top:3px; border-radius: 100px;" src="${item.user.headImg }" onerror="this.src='${ct }${fs}${item.user.headImg!=''?item.user.headImg:'/avatar_s.png' }@!50x50'"
								width="50px" height="50px"></a>
							<p style="font: 14px; color: #333333">${item.user.name }</p>
							<p style="font: 14px;">${item.user.position }</p>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<c:if test="${memberUserLabel24.list!=null and fn:length(memberUserLabel24.list)>0 }">
				<div style="width: 100%; margin: 5px; height: 160px; display: block;" class="mui-clearfix">
					<p style="margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;">${memberUserLabel24.list[0].label.name }</p>
					<c:forEach items="${memberUserLabel24.list }" var="item">
						<div
							style="margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;">
							<a href="${ctxw }/mine/myPage.htm?id=${item.user.id}"><img  style="margin-top:3px; border-radius: 100px;" src="${item.user.headImg }" onerror="this.src='${ct }${fs}${item.user.headImg!=''?item.user.headImg:'/avatar_s.png' }@!50x50'"
								width="50px" height="50px"></a>
							<p style="font: 14px; color: #333333">${item.user.name }</p>
							<p style="font: 14px;">${item.user.position }</p>
						</div>
					</c:forEach>
				</div>
			</c:if>
		</div>
	</div>
	<script type="text/javascript">
		(function(m, doc) {
			m.init();
			var reCircle1 = doc.getElementById('reCircle1');
			var reCircle2 = doc.getElementById('reCircle2');
			var pageNo=2;
			var pageNo2=2;
			reCircle1.addEventListener('tap', function(event) {
				m.toast('正在匹配...');
				m.ajax({
					type : "post",
					url : ctxw + "/mine/reRcircle.htm",
					data : {
						type : '1',
						pageNo:pageNo
					},
					async : true,
					dataType : "json",
					success : function(data) {
						if (data.code == 1) {
							m.toast('已刷新...');
							//alert(JSON.stringify(data))
							if(data.label1!=null&&data.label1.length>0){
								pageNo=data.pageNo+1;
								var list = data.label1;
								var html="<div style=\"width: 100%; margin: 5px; height: 160px; display: block;\">"
									+"<p style=\"margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;\">"+list[0].label.name+"</p>";
								for(var item in list){
									html+="<div style=\"margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;\">"
									+"<a href=\"${ctxw }/mine/myPage.htm?id="+list[item].user.id+"\"><img style=\"margin-top:3px; border-radius: 100px;\" src=\""+list[item].user.headImg+"\" onerror=\"this.src='${ct }${fs}"+(list[item].user.headImg!=''?list[item].user.headImg:'/avatar_s.png')+"@!50x50'\" width=\"50px\" height=\"50px\"></a>"
									+"<p style=\"font: 14px; color: #333333\">"+list[item].user.name+"</p>"
									+"<p style=\"font: 14px;\">"+list[item].user.position+"</p>"
									+"</div>"
								}
								html+="</div>"
								$('#memberUserLabel11').html('');
								$('#memberUserLabel11').append(html);
							}
							if(data.label2!=null&&data.label2.length>0){
								var list = data.label2;
								var html="<div style=\"width: 100%; margin: 5px; height: 160px; display: block;\">"
									+"<p style=\"margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;\">"+list[0].label.name+"</p>";
								for(var item in list){
									html+="<div style=\"margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;\">"
									+"<a href=\"${ctxw }/mine/myPage.htm?id="+list[item].user.id+"\"><img style=\"margin-top:3px; border-radius: 100px;\" src=\""+list[item].user.headImg+"\" onerror=\"this.src='${ct }${fs}"+(list[item].user.headImg!=''?list[item].user.headImg:'/avatar_s.png')+"@!50x50'\" width=\"50px\" height=\"50px\"></a>"
									+"<p style=\"font: 14px; color: #333333\">"+list[item].user.name+"</p>"
									+"<p style=\"font: 14px;\">"+list[item].user.position+"</p>"
									+"</div>"
								}
								html+="</div>"
								$('#memberUserLabel11').append(html);
							}
							if(data.label3!=null&&data.label3.length>0){
								var list = data.label3;
								var html="<div style=\"width: 100%; margin: 5px; height: 160px; display: block;\">"
									+"<p style=\"margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;\">"+list[0].label.name+"</p>";
								for(var item in list){
									html+="<div style=\"margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;\">"
									+"<a href=\"${ctxw }/mine/myPage.htm?id="+list[item].user.id+"\"><img style=\"margin-top:3px; border-radius: 100px;\" src=\""+list[item].user.headImg+"\" onerror=\"this.src='${ct }${fs}"+(list[item].user.headImg!=''?list[item].user.headImg:'/avatar_s.png')+"@!50x50'\" width=\"50px\" height=\"50px\"></a>"
									+"<p style=\"font: 14px; color: #333333\">"+list[item].user.name+"</p>"
									+"<p style=\"font: 14px;\">"+list[item].user.position+"</p>"
									+"</div>"
								}
								html+="</div>"
								$('#memberUserLabel11').append(html);
							}
							if(data.label4!=null&&data.label4.length>0){
								var list = data.label4;
								var html="<div style=\"width: 100%; margin: 5px; height: 160px; display: block;\">"
									+"<p style=\"margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;\">"+list[0].label.name+"</p>";
								for(var item in list){
									html+="<div style=\"margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;\">"
									+"<a href=\"${ctxw }/mine/myPage.htm?id="+list[item].user.id+"\"><img style=\"margin-top:3px; border-radius: 100px;\" src=\""+list[item].user.headImg+"\" onerror=\"this.src='${ct }${fs}"+(list[item].user.headImg!=''?list[item].user.headImg:'/avatar_s.png')+"@!50x50'\" width=\"50px\" height=\"50px\"></a>"
									+"<p style=\"font: 14px; color: #333333\">"+list[item].user.name+"</p>"
									+"<p style=\"font: 14px;\">"+list[item].user.position+"</p>"
									+"</div>"
								}
								html+="</div>"
								$('#memberUserLabel11').append(html);
							}
						} else {
							m.toast(data.message);
						}
					},
					error : function(data) {
						//if (data.status == '401') {
						//}
						m.toast('服务错误!');
					}
				});
			});
			reCircle2.addEventListener('tap', function(event) {
				m.toast('正在匹配...');
				m.ajax({
					type : "post",
					url : ctxw + "/mine/reRcircle.htm",
					data : {
						type : '2',
						pageNo:pageNo
					},
					async : true,
					dataType : "json",
					success : function(data) {
						if (data.code == 1) {
							m.toast('已刷新...');
							//alert(JSON.stringify(data))
							if(data.label1!=null&&data.label1.length>0){
								pageNo=data.pageNo+1;
								var list = data.label1;
								var html="<div style=\"width: 100%; margin: 5px; height: 160px; display: block;\">"
									+"<p style=\"margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;\">"+list[0].label.name+"</p>";
								for(var item in list){
									html+="<div style=\"margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;\">"
									+"<a href=\"${ctxw }/mine/myPage.htm?id="+list[item].user.id+"\"><img style=\"margin-top:3px; border-radius: 100px;\" src=\""+list[item].user.headImg+"\" onerror=\"this.src='${ct }${fs}"+(list[item].user.headImg!=''?list[item].user.headImg:'/avatar_s.png')+"@!50x50'\" width=\"50px\" height=\"50px\"></a>"
									+"<p style=\"font: 14px; color: #333333\">"+list[item].user.name+"</p>"
									+"<p style=\"font: 14px;\">"+list[item].user.position+"</p>"
									+"</div>"
								}
								html+="</div>"
								$('#memberUserLabel12').html('');
								$('#memberUserLabel12').append(html);
							}
							if(data.label2!=null&&data.label2.length>0){
								var list = data.label2;
								var html="<div style=\"width: 100%; margin: 5px; height: 160px; display: block;\">"
									+"<p style=\"margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;\">"+list[0].label.name+"</p>";
								for(var item in list){
									html+="<div style=\"margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;\">"
									+"<a href=\"${ctxw }/mine/myPage.htm?id="+list[item].user.id+"\"><img style=\"margin-top:3px; border-radius: 100px;\" src=\""+list[item].user.headImg+"\" onerror=\"this.src='${ct }${fs}"+(list[item].user.headImg!=''?list[item].user.headImg:'/avatar_s.png')+"@!50x50'\" width=\"50px\" height=\"50px\"></a>"
									+"<p style=\"font: 14px; color: #333333\">"+list[item].user.name+"</p>"
									+"<p style=\"font: 14px;\">"+list[item].user.position+"</p>"
									+"</div>"
								}
								html+="</div>"
								$('#memberUserLabel12').append(html);
							}
							if(data.label3!=null&&data.label3.length>0){
								var list = data.label3;
								var html="<div style=\"width: 100%; margin: 5px; height: 160px; display: block;\">"
									+"<p style=\"margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;\">"+list[0].label.name+"</p>";
								for(var item in list){
									html+="<div style=\"margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;\">"
									+"<a href=\"${ctxw }/mine/myPage.htm?id="+list[item].user.id+"\"><img style=\"margin-top:3px; border-radius: 100px;\" src=\""+list[item].user.headImg+"\" onerror=\"this.src='${ct }${fs}"+(list[item].user.headImg!=''?list[item].user.headImg:'/avatar_s.png')+"@!50x50'\" width=\"50px\" height=\"50px\"></a>"
									+"<p style=\"font: 14px; color: #333333\">"+list[item].user.name+"</p>"
									+"<p style=\"font: 14px;\">"+list[item].user.position+"</p>"
									+"</div>"
								}
								html+="</div>"
								$('#memberUserLabel12').append(html);
							}
							if(data.label4!=null&&data.label4.length>0){
								var list = data.label4;
								var html="<div style=\"width: 100%; margin: 5px; height: 160px; display: block;\">"
									+"<p style=\"margin-left: 15px; width: 100%; color: #333333; font-size: 14px; text-align: left;\">"+list[0].label.name+"</p>";
								for(var item in list){
									html+="<div style=\"margin-left: 10px; float: left; background: #FFFFFF; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;\">"
									+"<a href=\"${ctxw }/mine/myPage.htm?id="+list[item].user.id+"\"><img style=\"margin-top:3px; border-radius: 100px;\" src=\""+list[item].user.headImg+"\" onerror=\"this.src='${ct }${fs}"+(list[item].user.headImg!=''?list[item].user.headImg:'/avatar_s.png')+"@!50x50'\" width=\"50px\" height=\"50px\"></a>"
									+"<p style=\"font: 14px; color: #333333\">"+list[item].user.name+"</p>"
									+"<p style=\"font: 14px;\">"+list[item].user.position+"</p>"
									+"</div>"
								}
								html+="</div>"
								$('#memberUserLabel12').append(html);
							}
						} else {
							m.toast(data.message);
						}
					},
					error : function(data) {
						//if (data.status == '401') {
						//}
						m.toast('服务错误!');
					}
				});
			});
		}(mui, document));
	</script>
</body>
</html>