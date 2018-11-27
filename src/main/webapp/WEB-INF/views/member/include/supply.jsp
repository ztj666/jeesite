<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<div id="supply_1" class="subNav currentDd currentDt">供应中心</div>
<ul id="supply_ul_1" class="navContent" style="display: block;">
	<li><a id="supply1" href="${ctxm }/supply/productRelease/from.htm">商品发布</a></li>
	<li><a id="supply4" href="${ctxm }/supply/excelRelease/from.htm">批量发布</a></li>
	<li><a id="supply2" href="${ctxm }/supply/saleGoods/form.htm">在售商品</a></li>
	<li><a id="supply3" href="${ctxm }/supply/weiShangJia/form.htm?status=3">下架商品</a></li>
	<li><a id="supply7" href="${ctxm }/supply/sendGoods.htm">我发出的供货</a></li>
	<li><a id="supply8" href="${ctxm }/supply/receiverInquiry.htm">我收到的询价</a></li>
	<li><a id="supply5" href="${ctxm }/trade/gongyingtradeOrder/gongyingtradeOrder.htm">我的订单</a></li>
	<li><a id="supply6" href="${ctxm }/buy/gongyingtradeVoucher/gongyingtradeVoucher.htm">交易凭证</a></li>
</ul>
<script type="text/javascript">
	$('.navContent a').click(function() {
		$('.navContent a').each(function() {
			$(this).attr("class", "");
		});
		$(this).attr("class", "hover");
	});
</script>