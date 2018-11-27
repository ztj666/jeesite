<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html style="overflow-x: auto; overflow-y: auto;">
<head>
<title><sitemesh:title /></title>
<%@include file="/WEB-INF/views/member/include/head.jsp"%>
<sitemesh:head />
</head>
<body>
<!---顶部灰条开始--->
<%@ include file="/WEB-INF/views/front/include/header_1.jsp"%>
<!---顶部灰条结束--->
<div class=" clear"></div>
<div class="publicnav">
<!---导航开始--->
<div class="wrap publicmain">
<div class="publicnavmain fl">
	<a href="${ctxf}/index.htm"><img src="http://www.ec.hc360.com/hcxincheng/image/daologo.jpg" width="154" height="50" /></a> 
	<a href="${ctxm}/index.htm" class='${menu1=="1"?"hover":"" }'>会员中心</a>
	<a href="${ctxm}/supply/productRelease/from.htm" class='${menu1=="2"?"hover":"" }'>供应中心</a> 
	<a href="${ctxm}/buy/batchRelease/batchRelease.htm" class='${menu1=="3"?"hover":"" }'>采购中心</a> 
	<a href="${ctxm}/supply/img.htm" class='${menu1=="7"?"hover":"" }'>商铺管理</a> 
	<a href="${ctxm}/application/applicationCenter/form.htm" class='${menu1=="4"?"hover":"" }'>应用中心</a> 
	<a href="${ctxm}/myscore/myscoreShow.htm" class='${menu1=="5"?"hover":"" }'>我的积分</a> 
	<a href="${ctxm}/multiAccount/account/account.htm" class='${menu1=="6"?"hover":"" }'>账户管理</a>
</div>
<div class="NewSea">
<!--search_cx S-->
<form id="searchform" name="searchform" action="${ctxf}/search/index.htm" method="post" target="_blank">
	<input name="c" type="hidden" id="c" value="">
	<div class="SeaRed"><!--h_search S-->
		 <div class="selectBox"><!--s_select S-->
			<div class="s_trigger" id="selectPro">${not empty c?c:'供应'}</div>
			<div class="s_options" id="selectDiv" style="display: none;">
				<a href="javascript:void(0);" name="">供应</a>
				<a href="javascript:void(0);" name="">求购</a>
				<a href="javascript:void(0);" name="">公司</a>
				<a href="javascript:void(0);" name="">资讯</a>
			</div>
		</div>
		<input maxlength="15" name="w" id="corkeyword" value="${w}" onfocus="wfocus()" style="color: rgb(153, 153, 153);">
		<button id="topsearch" name="search" type="submit"></button>
	</div>
</form>
<!--search_cx E-->
<script type="text/javascript">
 jQuery(document).ready(function(){
		//点击选项时将选项值放入文本框和隐藏域中
		jQuery('#selectDiv a').click(function(){
			jQuery('#selectPro').html(jQuery(this).text());
			jQuery('#c').val(jQuery(this).text());
			jQuery('#selectDiv').hide();
			initMsg();
		});
		jQuery("#selectDiv,#selectPro").live("mouseover", function(){
	    	jQuery('#selectDiv').show();
		});
	 	jQuery("#selectDiv,#selectPro").live("mouseleave", function(){
    		jQuery('#selectDiv').hide();
	 	});
		jQuery(".SeaRed").mouseover(function() {
			jQuery(this).addClass("SeaClick");
			jQuery(this).removeClass("SeaRed");
		})
		jQuery(".SeaRed").mouseout(function() {
			jQuery(this).removeClass("SeaClick");
			jQuery(this).addClass("SeaRed");
		})
	});
	function wfocus() {
		var corkeyword = jQuery('#corkeyword').val();
		if (corkeyword == "搜索...") {
			jQuery("#corkeyword").val("");
		}
		document.searchform.w.style.color = '#000';
	}
</script>
</div>
</div>
</div>
<!---导航结束--->
<sitemesh:body />
<%@ include file="/WEB-INF/views/front/include/footer.jsp"%>
</body>
</html>