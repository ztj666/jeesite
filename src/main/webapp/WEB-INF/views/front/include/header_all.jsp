<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!---头部开始--->
<!---顶部灰条开始--->
<%@ include file="/WEB-INF/views/front/include/header_1.jsp"%>
<!---顶部灰条结束--->
<div class=" clear mhei"></div>
<!--logo、search 开始-->
<%@ include file="/WEB-INF/views/front/include/header_2.jsp"%>
<!--logo、search 结束-->
<div class="clear mhei"></div>
<!---主菜单开始--->
<div class="wrap">
	<ul class="listnav">
		<li><a href="${ct}/">首页</a></li>
		<li class="st1"><a href="${ctxf}/product/index.htm"  style="${menu1=="2"?"background:#0061d5":""}">供应列表</a></li>
		<li class="st2"><a href="${ctxf}/purchase/index.htm" style="${menu1=="3"?"background:#0061d5":""}">采购信息</a></li>
		<li><a href="#">样品申请</a></li>
		<li class="st3"><a href="${ctxf}/company/index.htm" style="${menu1=="5"?"background:#0061d5":""}">行业牛商</a></li>
		<li class="st4"><a href="${ctxf}/brand/brandList.htm" style="${menu1=="6"?"background:#0061d5":""}">品牌街</a> </li>
		<li><a href="#">供应链金融</a></li>
		<li><a href="#">找物流</a></li>
	</ul>
</div>
<!---主菜单结束--->
<!---头部结束--->