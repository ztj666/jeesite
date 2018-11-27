<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<div class="clear mhei"></div>
<div class="wrap">
<!--企业信息 开始-->
<div class="fl dangan-qy">
	  <div class="fl dangan-qy bordebott">
	    <h1 class="qiyedangan"><i class="qiyeioc qiyeioctu"></i>企业档案</h1>
	    <p class="font18 gongsi-daan">${enterpriseInfo.compnayName}</p>
	    <ul class="renzhenone">
	      <li><img src="${ctxStatic}/image/oneren.png" width="31" height="31" /><span class="green"><fmt:formatDate value="${enterpriseInfo.yearTime}" pattern="yyyy"/></span></li>
	      <li><img src="${ctxStatic}/image/tworen.png" width="31" height="31" /><span class="buu">${enterpriseInfo.operateType}</span></li>
	      <li><img src="${ctxStatic}/image/threeren.png" width="31" height="31" /><span class="yellow">${enterpriseInfo.memberRank}</span></li>
	    </ul>
	    <div class="renzhenone pt20">
	      <p>电话：${enterpriseInfo.telephoneNum}</p>
	      <p>传真：${enterpriseInfo.fax}</p>
	      <p>手机：${enterpriseInfo.cphoneNum}</p>
	      <p>联系人：${enterpriseInfo.name}</p>
	      <p>QQ:
	      <a target="_blank" rel="nofollow" href="http://wpa.qq.com/msgrd?v=3&amp;uin=${enterpriseInfo.nameqq}&amp;site=qq&amp;menu=yes">
	      	<img src="${ctxStatic}/image/button_old_41.gif" width="23" height="16" style="${empty enterpriseInfo.nameqq ?'display:none;':''}"/>
	      </a>
	      </p>
	      <p>地址：${fns:getAreaLabel(enterpriseInfo.province,'')}${fns:getAreaLabel(enterpriseInfo.cityid,'')}${enterpriseInfo.comAddress}</p>
	    </div>
	    <div class="zhuying-qe pt20">
	      <p>主营：${enterpriseInfo.sellProduct}</p>
	    </div>