<%@ page contentType="text/html; charset=UTF-8"%>
<!--企业logo 开始-->
<div class="clear mhei"></div>
<div class="wrap">
	<c:set var="a" value="${ctxStatic}/image/xinqiyelogo.jpg"/>
	<c:set var="b" value="${ct}${fs}${memberShop.pictureLogo}@!1200x100"/>${memberShop.bak1}
	<div id="logoPicture" class="qilogo" style="background: url('${ empty memberShop.pictureLogo?a:b}') no-repeat;">
		${comName}
	</div>
</div>
<div class="clear mhei"></div>
<!--企业导航开始-->
<div class="wrap sp-nav">
	<div class="sp-nav1 fl">
		<a href="${ctxf}/shop/${memId }/index.htm">首 页</a> <a href="${ctxf}/shop/${memId }/list.htm">产品展示</a> <a
			href="${ctxf}/shop/${memId }/datumDownload.htm">资料库下载</a> <a href="${ctxf}/shop/${memId }/companyInfo.htm">公司简介</a> <a
			href="${ctxf}/shop/${memId }/successfulCase.htm">成功案例</a> <a href="${ctxf}/shop/${memId }/honor.htm">荣誉资质</a> <a
			href="${ctxf}/shop/${memId }/contact.htm">联系我们</a>
	</div>
	<div class="sp-seacher fr">
		<form action="${ctxf}/shop/${memId}/list.htm">
			<input type="text" value="${model_s }" name="model_s" class="souskuang" placeholder="请输入产品型号"><input type="submit" value="搜索商铺" class="sousanniu">
		</form>
	</div>
</div>
<script type="text/javascript">
	$('.sp-nav1 a').click(function() {
		$('.sp-nav1 a').each(function() {
			$(this).attr("class", "");
		});
		$(this).attr("class", "hover");
	});
</script>
<div class="clear mhei"></div>
