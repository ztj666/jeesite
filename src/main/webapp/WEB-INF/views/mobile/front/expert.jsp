<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>大咖</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link href="${ctxStatic}/css/main/expert.css" rel="stylesheet" />
</head>
<body >
	<script type="text/javascript">
		mui.init()
	</script>
<!--  <header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a href="#popover"><img src="${ctxStatic}/image/ic_menu_white.png"
			class="mine_head" /></a> 
		<div id="search"><img width="24px" height="24px"  src="${ctxStatic}/image/ic_search_white.png" style="margin-left: 52px; margin-top: 10px;"></div>
		  <div  style="position: absolute; top:12px;left: 32%;  width: 35%; text-align: center; font-size: 16px; color: white;">大咖</div>
	</header>  -->	
	
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;width: 100%;">
		<a href="#popover"><div style="float: left;margin-right: 8px;">
			<img src="${ctxStatic}/image/ic_menu_white.png" width="20px" height="18px" align="center" style="margin-left:5px; margin-right: 5px;margin-top: 13px;margin-bottom: 5px;">
		</div></a>
		<div id="search" style="float: left;">
			<img src="${ctxStatic}/image/ic_search_white.png" width="20px" height="20px" align="center" style="margin-left:5px; margin-right: 5px;margin-top: 13px;margin-bottom: 5px;">
		</div>
		<h1 class="mui-title" style="font-size: 16px; color: white; right: 100px; left:100px ;">大咖</h1>
	</header>
	
	
	
	
	<%@ include file="/WEB-INF/views/mobile/include/indexHead.jsp"%>
	<div class="mui-content">
		<p
			style="margin: 5px; padding-left: 5px; color: #888888; font-size: 14px">推荐</p>
		<div
			style="width: 100%; height: 125px; display: block; overflow: auto;">
			<div style="width: 1000%; overflow: visible; margin-left: 5px;" >
				<c:forEach items="${expertInfo}" var="item">
				    <a href="${ctxw }/bigShot.htm?id=${item.id}">
					<div style="margin-right: 10px; float: left; background: #eeeeee; border: 1px solid #CCCCCC; border-radius: 4px; border-color: #CCCCCC; width: 80px; height: 115px; text-align: center;">
						<img style="margin-top: 3px; border-radius: 100px;"
							src="${item.headImg }"
							onerror="this.src='${ct }${fs}${item.headImg!=null and item.headImg!=''?item.headImg:'/avatar_s.png' }@!50x50'"
							width="50px" height="50px">
						<p style="font: 14px; color: #333333">
							${item.name} <img src="${ctxStatic}/image/ic_approval.png"
								style="width: 12px; height: 12px;">
						</p>
						<p class="my_line1" style="font: 14px;">${item.domain}</p>
					</div>
					</a>
				</c:forEach>
			</div>
		</div>
		<div
			style="width: 100%; background: #dddddd; height: 40px; white-space: nowrap;">
			<div
				style="float: left; width: 68%; padding-left: 10px; margin-top: 6px; padding-top: 4px; font-size: 14px; color: #888888;">
				<img src="${ctxStatic}/image/ic_hot.png" width="17px" height="20px" align="center" />
				热门问答/约见
			</div>
			<div
				style="float: right; width: 30%; padding-left: 10px; padding-top: 10px; font-size: 14px; color: #4AACC5; display:none;">
				<a href="#popovers"><span style="color:#4AACC5;">分类<span></span><img width="12px" height="10px"
					style="margin-left: 3px;" src="${ctxStatic}/image/ic_menu_blue.png" align="center">
			</div>
			</a>
		</div>

		<c:forEach items="${askInfo}" var="item">
	
		<a href="${ctxw }/My/consultDetail.htm?id=${item.id}">
		<div class="detail">
			<p>${item.subject}</p>
			<div class="div2-1">
				<div class="lebel">
					<img src="${ctxStatic}/image/ic_tag.png" width="19px" height="19px" align="center" />
					${item.label}
				</div>
				<div class="lebel2">
					<span class="btn" style="background: #FFAC5B;">问答</span>
				</div>
			</div>
		</div>
		</a>
		</c:forEach>
		
		
		<c:forEach items="${apptInfo}" var="item">
		<a href="${ctxw }/My/apptDetail.htm?id=${item.id}">
		<div class="detail">
			<p>${item.subject}</p>
			<div class="div2-1">
				<div class="lebel">
					<img src="${ctxStatic}/image/ic_tag.png" width="19px" height="19px" align="center" />
					${item.label}
				</div>
				<div class="lebel2">
					<span class="btn" style="background: #4AACC5;">约见</span>
				</div>
			</div>
		</div>
		</a>
		</c:forEach>
		<div id="popovers" class="mui-popover mui-popovers" style="margin-top:10px;">
			<ul>
				<li>农业基因组</li>
				<li>药物研发</li>
				<li>实验</li>
				<li>云计算</li>
				<li>培训</li>
				<li>科研服务</li>
				<li>基因编辑</li>
				<li>测序</li>
				<li>消费级基因检测</li>
				<li>健康管理</li>
				<li>微生物</li>
				<li>司法鉴定</li>
				<li>生育生殖</li>
				<li>肿瘤</li>
				<li>遗传病</li>
			</ul>
		</div>
	<script type="text/javascript">
	var search = document.getElementById('search');
	search.addEventListener('tap', function(event) {
		mui.openWindow({
			  url: ctxw+'/bigShot/search.htm'
		  });
	});
	</script>
	</div>

</body>
</html>