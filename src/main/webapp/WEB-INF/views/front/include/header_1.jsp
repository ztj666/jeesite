<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="listtopnav bordebott">
	<div class="wrap">
		<p class="fl listtopnavleft">${userInfo.contact!=null and userInfo.contact!=''?userInfo.contact:userInfo.username} 您好，欢迎来到慧聪芯城网！
		<c:if test="${userInfo.username==null}"><a href="${ctxf}/login.htm">登录</a> | <a href="${ctxf}/register.htm">免费注册</a></c:if>
		<c:if test="${userInfo.username!=null}"><a href="${ctxf}/login/logout.htm">退出</a></c:if>
		</p>
		<p class="fr listtopnavright"><a href="${ctxm}/index.htm">会员中心</a> | <a href="${ct}/scoreStore/index.htm" target="_blank">积分商城</a>交易时间： 工作日  9:00-18:00</p>
	</div>
</div>