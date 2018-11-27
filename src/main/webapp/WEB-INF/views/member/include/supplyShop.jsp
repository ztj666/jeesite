<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<script type="text/javascript">
	$(function() {
		$(".subNav").click(
				function() {
					$(this).toggleClass("currentDd").siblings(".subNav")
							.removeClass("currentDd")
					$(this).toggleClass("currentDt").siblings(".subNav")
							.removeClass("currentDt")

					// 修改数字控制速度， slideUp(500)控制卷起速度
					//$(this).next(".navContent").slideToggle(500).siblings(
							//".navContent").slideUp(500);
				})
	})
</script>
<div id="supply_3" class="subNav">商铺管理</div>
<ul id="supply_ul_3" class="navContent">
	<li><a id="supply7" href="${ctxm }/supply/img.htm">图片中心</a></li>
	<li><a id="supply8" href="${ctxm }/supply/pdf.htm">资料中心</a></li>
	<c:if test="${userInfo.memberRank>10 }">
		<li><a id="supply9" href="${ctxm }/shop/headPicture.htm">商铺头文件</a></li>
		<li><a id="supply10" href="${ctxm }/supply/showWindow.htm">产品橱窗推荐</a></li>
		<li><a id="supply11" href="${ctxm }/shop/successfulCase.htm">成功案例</a></li>
		<li><a id="supply12" href="${ctxm }/shop/honor.htm">荣誉资质</a></li>
		<li><a id="supply13" href="${ctxm }/custservice/custSer.htm">客服管理</a></li>
	</c:if>
</ul>
<script type="text/javascript">
	$('.navContent a').click(function() {
		$('.navContent a').each(function() {
			$(this).attr("class", "");
		});
		$(this).attr("class", "hover");
	});
</script>