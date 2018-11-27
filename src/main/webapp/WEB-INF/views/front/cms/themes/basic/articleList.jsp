<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="decorator" content="defaultFront" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<style type="">
	.bluecss{
		padding: 0px;
	    background: #0C76F5;
	    height: 40px;
	    padding: 0px 20px;
	    color: #fff;
	    line-height: 40px;
	    z-index: 999;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
	 $('.Mouse a').mouseover(function(){
		//$("ul").find("li[class='Mouse']").css("background","");
		//$(this).parent().css("background","url(${ctxStatic }/image/jiantou.jpg");
		$(this).parent().addClass("bluecss");
		
	 });
	 $('.Mouse a').mouseout(function(){
		 //alert(1);
			//$(this).addClass("hover");
		//$(this).parent().css("background","");
		$(this).parent().removeClass("bluecss");
	 });
 });
 
</script>
<script type="text/javascript">
function artic(e,id){
	//$(e).parent().css("background","blue");
	$(e).parent().addClass("bluecss");
	 location.href="${ctxf }/article/index.htm?id="+id+"#1F";
}
</script>
<title>文章列表页</title>
<link href="${ctxStatic }/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxStatic }/css/glwly.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="http://www.ec.hc360.com/scedfenghui/newenergy/lrtk.js"></script>
</head>

<body>

<!--导航开始-->
<div class="clear mhei"></div>
<!--焦点图部分---->
<div class="wrap">
<div class="fl wenzhanglist">
<!-- 代码 开始 -->
  <div id="playBox">
    <div class="pre"></div>
    <div class="next"></div>
    <div class="smalltitle">
      <ul>
       <c:choose>
          <c:when test="${list==null}">
              <li class="thistitle"></li>
              <li ></li>
              <li ></li>
          </c:when>
          <c:otherwise>
             <c:forEach items="${list}" var="sitePictureCarousels" varStatus="s" >
               <c:choose>
                <c:when test="${s.first}">
                  <li class="thistitle"></li>
                </c:when>
                <c:otherwise>
                  <li></li>
                </c:otherwise>
               </c:choose>
             </c:forEach>
          </c:otherwise>
       </c:choose>
      </ul>
    </div>
    <ul class="oUlplay">
      <c:choose>
        <c:when test="${list==null}">
            <li><a href="http://img02.hc360.com/ec/201607/201607071021552668.jpg" target="_blank"><img src="http://img02.hc360.com/ec/201607/201607071021552668.jpg" width="709" height="476"/></a></li>
            <li><a href="http://img04.hc360.com/ec/201606/201606120951314588.jpg" target="_blank"><img src="http://img04.hc360.com/ec/201606/201606120951314588.jpg" width="709" height="476" /></a></li>
            <li><a href="http://img01.hc360.com/ec/201607/201607071024193752.jpg" target="_blank"><img src="http://img01.hc360.com/ec/201607/201607071024193752.jpg" width="709" height="476" /></a></li>
        </c:when>
        <c:otherwise>
           <c:forEach items="${list}" var="sitePictureCarousels">
       			<li><a href="${sitePictureCarousels.taget}" target="_blank"><img src="${ct}${fs}${sitePictureCarousels.path }" width="709" height="476"/></a></li>
           </c:forEach>
        </c:otherwise>
      </c:choose>
    </ul>
  </div>
<!-- 代码 结束 -->
</div>
<div class="fr wenzhanglistr"><div class="">${fnc:getSiteAd('761184619917344768').content}</div>
<div class=" mt20">${fnc:getSiteAd('761184239468806144').content}</div>
</div>
</div>
<!--列表部分---->
<div class="clear mhei"></div>

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
<div id="lib_Tab5">
<div class="lib_Menubox5 lib_tabborder5"><a name="1F"></href>
<ul>
  <c:forEach items="${fnc:getCategoryList(2, 1, 8, '')}" var="item" varStatus="a">
  <c:choose> 
  		<c:when test="${not empty id}">
			 <c:choose>  
			   	<c:when test="${item.id ==id}">
	       			<li id="five1" class="Mouse" style="padding: 0px;
					    background: #0C76F5;
					    height: 40px;
					    padding: 0px 20px;
					    color: #fff;
					    line-height: 40px;
					    z-index: 999;"><a href="javascript:void(0);" onclick="artic(this,'${item.id}');" var="1">${item.name}</a></li> 
				</c:when> 
				 <c:otherwise>
	       			<li id="five1" class="Mouse"><a href="javascript:void(0);" onclick="artic(this,'${item.id}');" var="1">${item.name}</a></li> 
			   </c:otherwise> 
			</c:choose>  
  		</c:when>
  		  <c:otherwise>
  			  <c:choose>
	  			<c:when test="${a.first}">
	       			<li id="five1" class="Mouse"  style="padding: 0px;
					    background: url(${ctxStatic }/image/jiantou.jpg) no-repeat center 39px #0C76F5;
					    height: 45px;
					    padding: 0px 20px;
					    color: #fff;
					    line-height: 40px;
					    z-index: 999;"><a href="javascript:void(0);" onclick="artic(this,'${item.id}');" var="1">${item.name}</a></li> 
				</c:when>
			   <c:otherwise>
	       			<li id="five1" class="Mouse"><a href="javascript:void(0);" onclick="artic(this,'${item.id}');" var="1">${item.name}</a></li> 
			   </c:otherwise> 
			 </c:choose> 
		 </c:otherwise> 
		</c:choose> 
  </c:forEach>  
</ul>
</div>
 <div class="lib_Contentbox5 lib_tabborder5 clear">  
 
   <div id="con_five_1" >
   <ul class="dakatalk">
   <c:forEach items="${page.list}" var="article">
      <c:choose>
        <c:when test="${article.link!=null }">
           <li>
	         <div class="fl"><a href="${article.link }"><img src="${article.image}" onerror="this.src='${ctxStatic }/image/product.jpg'" width="190" height="137"></a></div>
	         <div class="fl listxiangqin ml20">
	           <h1><a href="${article.link }">${fns:abbr(article.title,55)}</a></h1>
	           <p><a href="${article.link }">${fns:abbr(fnc:getArticleData(article.id).content,100)}</a></p>
	           <p>
	             <span>${article.createBy}  <fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span>
	             <span class="laizina">慧聪电子网 </span>
	           </p>
	         </div>
	        </li> 
        </c:when>
        <c:otherwise>
           <li>
	         <div class="fl"><a href="${ctxf }/article/content.htm?id=${article.id}"><img src="${article.image}" onerror="this.src='${ctxStatic }/image/product.jpg'" width="190" height="137"></a></div>
	         <div class="fl listxiangqin ml20">
	           <h1><a href="${ctxf }/article/content.htm?id=${article.id}">${fns:abbr(article.title,55)}</a></h1>
	           <p><a href="${ctxf }/article/content.htm?id=${article.id}">${fns:abbr(fnc:getArticleData(article.id).content,100)}</a></p>
	           <p>
	             <span>${article.createBy}  <fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span>
	             <span class="laizina">慧聪电子网 </span>
	           </p>
	         </div>
	        </li> 
        </c:otherwise>
      </c:choose>
</c:forEach>
  </ul> 
   </div>
 </div>
</div>

  <div class="clear mhei"></div>
 <div class="clear mhei mt10"></div>
<%@ include file="/WEB-INF/views/front/include/page.jsp"%>
</div>



 
<!--热门标签-->
<div class="fr remenbiaoqian">
<div class="">
${fnc:getSiteAd('761185078723870720').content}</div>

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
     	<p class="newtop">${fns:abbr(article1.title,42)}</p>
	  </c:if>
	  <c:if test="${!a.first}">
	     <ul class="newtop-list">
	         <li><a href="${ctxf }/article/content.htm?id=${article1.id}">${fns:abbr(article1.title,42)}</a></li>
	    </ul>
	  </c:if>
   </c:when>
   <c:otherwise>
      <c:if test="${a.first}">
     	<a href="${article1.link}" target="_blank"><img src="${article1.image}" onerror="this.src='${ctxStatic }/image/product.jpg'" width="420" height="243"/></a>
     	<p class="newtop">${fns:abbr(article1.title,42)}</p>
	  </c:if>
	  <c:if test="${!a.first}">
	     <ul class="newtop-list">
	         <li><a href="${article1.link}">${fns:abbr(article1.title,42)}</a></li>
	    </ul>
	  </c:if>
   </c:otherwise>
 </c:choose>
</c:forEach>
</div>
</div>
</div>
</body>
</html>
