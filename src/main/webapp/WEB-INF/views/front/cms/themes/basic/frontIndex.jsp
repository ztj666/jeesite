<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/front/cms/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>首页</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="fdp ${site.description}" />
	<meta name="keywords" content="fdp ${site.keywords}" />
</head>
<body>
    <div class="hero-unit" style="padding-bottom:35px;margin:10px 0;">
      <c:set var="article" value="${fnc:getArticle('2')}"/>
      <h1>${fns:abbr(article.title,28)}</h1><p></p>
      <p>${fns:abbr(fns:replaceHtml(article.articleData.content),260)}</p>
      <p><a href="${article.url}" class="btn btn-primary btn-large">&nbsp;&nbsp;&nbsp;查看详情 &raquo;&nbsp;&nbsp;&nbsp;</a></p>
    <p><a href="login.htm">登录</a>|<a href="register.htm">注册</a>|<a href="http://oauth.hc360.com/oauth/authorize?response_type=code&client_id=100005&state=123&redirect_uri=http://www.hcicmall.com:8080/hcxc/oauth/hclogin.htm">慧聪账号登陆</a>|<a href="${ctxm }/user/register/index.htm"></a></p>
    </div>
    <div class="row">
      <div class="span4">
        <h4><small><a href="${ctx}/list-2${fns:getUrlSuffix()}" class="pull-right">更多&gt;&gt;</a></small>组织机构</h4>
		<ul><c:forEach items="${fnc:getArticleList(site.id, 2, 8, '')}" var="article">
			<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span>
			<a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a>
			</li>
		    </c:forEach>
		</ul>
      </div>
      <div class="span4">
        <h4> <small><a href="${ctx}/list-6${fns:getUrlSuffix()}" class="pull-right">更多&gt;&gt;</a></small>质量监督</h4>
		<ul><c:forEach items="${fnc:getArticleList(site.id, 6, 8, '')}" var="article">
			<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a></li>
		</c:forEach></ul>
      </div>
      <div class="span4">
        <h4><small><a href="${ctx}/list-10${fns:getUrlSuffix()}" class="pull-right">更多&gt;&gt;</a></small>政策法规</h4>
		<ul><c:forEach items="${fnc:getArticleList(site.id, 10, 8, '')}" var="article">
			<li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy.MM.dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a></li>
		</c:forEach></ul>
      </div>
    </div>
</body>
</html>