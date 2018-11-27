<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/front/cms/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>首页</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="fdp ${site.description}" />
	<meta name="keywords" content="fdp ${site.keywords}" />
	<%@include file="/WEB-INF/views/member/include/head.jsp"%>
</head>
<body>
<h1>这是慧聪芯城的大首页</h1>
    <p>
	    <a href="${ct}/login.htm">登录</a>|
	    <a href="${ct}/register.htm">注册</a>|
	    <a href="http://oauth.hc360.com/oauth/authorize?response_type=code&client_id=100005&state=123&redirect_uri=http://www.hcicmall.com:8080/hcxc/oauth/hclogin.htm">慧聪账号登陆</a>|
	    <a href="${ct}/shop/750163554329296896/index.htm">进入会员15866958266的商铺</a>|
	    <a href="${ct}/admin/login.do">进入管理后台</a>|
	    <a href="${ct}/cms/index.htm">cms首页</a>|
	    <a href="${ct}/scoreStore/scoreStoreShow.htm">积分商城</a>|
	    <a href="${ct}/scoreStore/convertGift.htm?giftNum=123">礼品详情页</a>|
    </p>
    
<br/>
<input type="button" onclick="selectCity1()" value="test1"/>
<input type="button" onclick="selectCity2()" value="test2"/>
<br/>
<input type="button" onclick="selectCity3()" value="test3"/>
<input type="button" onclick="selectCity4()" value="test4"/>
<script type="text/javascript">
function selectCity1() {
	//$('select[name=city]').empty();
	var value = 13;
	$.get(ctxf + "/user/selectCity.htm", {parentId:value}, function(data, status) {
		alert(data)
	});
}
function selectCity2() {
	//$('select[name=city]').empty();
	var value = 13;
	$.get(ctxf + "/user/selectCity2.htm", {parentId:value}, function(data, status) {
		alert(data)
	});
}
function selectCity3() {
	//$('select[name=city]').empty();
	var value = 13;
	$.get(ctxf + "/user/selectCity.abc", {parentId:value}, function(data, status) {
		alert(data)
	});
}
function selectCity4() {
	//$('select[name=city]').empty();
	var value = 13;
	$.get(ctxf + "/user/selectCity2.abc", {parentId:value}, function(data, status) {
		alert(data)
	});
}
</script>    
</body>
</html>