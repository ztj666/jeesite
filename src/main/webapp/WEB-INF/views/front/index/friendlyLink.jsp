<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="decorator" content="defaultFront" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>慧聪芯城--友情链接</title>
<meta name="keywords" content="电子元器件现货, ic现货,电子元器件报价, ic报价,电子元器件市场,ic行情,ic交易" />
<meta name="description" content="慧聪芯城现货资源，拥有海量电子元器件及ic现货资源供您挑选，免费提供最新电子元器件ic现货报价，免费提供电子元器件ic价格查阅。" />
<link href="${ctxStatic}/css/glwly.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="clear mhei"></div>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/front/include/friendly_head.jsp"%>
		<div class="fr guanyuwomenright">
			<h1>
				<a href="${ctxf }/index.htm">慧聪芯城首页 > </a> 友情链接
			</h1>
			<ul class="wenzilianjie">
				<p>文字连接</p>
				<c:forEach items="${friendlyLink }" var="friendlyLink">
					<c:if test="${friendlyLink.type==1 }">
						<li><a href="${friendlyLink.url }">${friendlyLink.name }</a></li>
					</c:if>
				</c:forEach>
			</ul>
			<div class="wenzilianjie-tu wenzilianjie">
				<p>图片链接</p>
				<c:forEach items="${friendlyLink }" var="friendlyLink">
					<c:if test="${friendlyLink.type==2 }">
						<a href="${friendlyLink.url }"><img src="${ct }${fs}${friendlyLink.img }" width="140" height="54"></a>
					</c:if>
				</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>