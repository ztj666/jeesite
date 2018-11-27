<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="decorator" content="defaultFront" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>文章内容页</title>
<link href="${ctxStatic }/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxStatic }/css/glwly.css" rel="stylesheet" type="text/css"/>
</head>

<body>

<div class="clear mhei mt10"></div>
<div class="wrap">
<script>
<!--
function setTab(name,cursel,n){
 for(i=1;i<=n;i++){
  var menu=document.getElementById(name+i);
  var con=document.getElementById("con_"+name+"_"+i);
  menu.className=i==cursel?"hover":"";
  con.style.display=i==cursel?"block":"none";
 }
}
//-->
</script>
<div class="fl wenzhangliebiao">
<div class="newmain">
<div class="newtitle"><h1>${fnc:getArticle(id).title}</h1>
<p>电子<span class="fabutime"><fmt:formatDate value="${fnc:getArticle(id).updateDate}" pattern="yyyy.MM.dd"/></span></span><span class="yueduliang">XXX</span></p>

</div>

<div class="newzhenwen">
 <p>${fnc:getArticleData(id).content}</p>

</div>

<div class="biaoqianmz">标签：
<c:set value="${fn:split(fnc:getArticle(id).keywords,',')}" var="str1"/>
  <c:if test="${fnc:getArticle(id).keywords!=null }">
   <c:forEach items="${str1 }" var="s">
     <a href="${ctxf }/search/label.htm?keywords=${s}"> ${s }</a>
   </c:forEach>
  </c:if>
</div>
</div>

<div class=" fr bdshare-button-style0-32" >

<div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_more" data-cmd="more"></a></div>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"24"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>

</div>
<div class="mhei clear"></div>
<div class="graytiao"></div>

<!---相关新闻--->
<div class="xiangguannew mt20">
<h1 class="biaoqian bordebott"><span class="biaoqian1"></span>相关新闻</h1>
<ul class="newtop-list">
<c:if test="${fn:length(list3)<=5}">
   <c:forEach items="${list3}" var="articlecontent">
      <c:choose>
        <c:when test="${articlecontent.link==null }">
           <li><a href="${ctxf }/article/content.htm?id=${articlecontent.id}">${fns:abbr(articlecontent.title,80)}</a></li>
        </c:when>
        <c:otherwise>
           <li><a href="${articlecontent.link }">${fns:abbr(articlecontent.title,80)}</a></li>
        </c:otherwise>
      </c:choose>
   </c:forEach>
</c:if>
<c:if test="${fn:length(list3)>5}">
   <c:forEach items="${list3}" var="articlecontent" begin="0" end="4">
      <c:choose>
        <c:when test="${articlecontent.link==null }">
           <li><a href="${ctxf }/article/content.htm?id=${articlecontent.id}">${fns:abbr(articlecontent.title,80)}</a></li>
        </c:when>
        <c:otherwise>
           <li><a href="${articlecontent.link }">${fns:abbr(articlecontent.title,80)}</a></li>
        </c:otherwise>
      </c:choose>
   </c:forEach>
</c:if>
</ul>
</div>
<div class="mhei clear"></div>
<div class="graytiao"></div>

</div>
<!--热门标签-->
<div class="fr remenbiaoqian">
<div class="">
${fnc:getSiteAd('761375008190234624').content}</div>


<div class="remen-bq">
<h1 class="biaoqian"><span class="biaoqian1"></span>热门标签</h1>
<ul class="biaoqian-list">
${fnc:getSiteAd('761390199007739904').content}
</ul>
</div>
<div class="remen-bq">
<h1 class="biaoqian"><span class="biaoqian1"></span>推荐阅读</h1>
<c:forEach items="${fnc:getArticleList(2, '', 6, 'posid:2')}" var="article1"  varStatus="a">
 <c:choose>
   <c:when test="${article1.link==null }">
      <c:if test="${a.first}">
     	<a href="${ctxf }/article/content.htm?id=${article1.id}" target="_blank"><img src="${article1.image}" onerror="this.src='${ctxStatic }/image/product.jpg'" width="420" height="243"/></a>
     	<p class="newtop">${fns:abbr(article1.title,45)}</p>
	  </c:if>
	  <c:if test="${!a.first}">
	     <ul class="newtop-list">
	         <li><a href="${ctxf }/article/content.htm?id=${article1.id}">${fns:abbr(article1.title,45)}</a></li>
	    </ul>
	  </c:if>
   </c:when>
   <c:otherwise>
      <c:if test="${a.first}">
     	<a href="${article1.link}" target="_blank"><img src="${article1.image}" onerror="this.src='${ctxStatic }/image/product.jpg'" width="420" height="243"/></a>
     	<p class="newtop">${fns:abbr(article1.title,45)}</p>
	  </c:if>
	  <c:if test="${!a.first}">
	     <ul class="newtop-list">
	         <li><a href="${article1.link}">${fns:abbr(article1.title,45)}</a></li>
	    </ul>
	  </c:if>
   </c:otherwise>
 </c:choose>
</c:forEach>
</div>
</div></div>
</body>
</html>
