<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/WEB-INF/views/member/include/head.jsp"%>
<title>慧聪芯城-中小企业B2B电子产业供应链垂直电商平台</title>
<meta name="keywords" content="电子元器件采购平台，电子元件交易,IC信息网,电子元器件,IC品牌查询,IC交易,IC查询,IC采购,IC现货查询,IC现货资源,正品元器件,IC商城,集成电路查询,ST代理商,仙童代理商,NXP代理商,TI代理商" />
<meta name="description"
	content="慧聪芯城是慧聪网内部孵化的电子元器件网上商城，通过元器件专业团队的介入，利用互联网技术、移动互联网、大数据，构建掌握电子元器件供应链核心交易关系的数据平台，提高电子产业供应链效率，促进交易达成，成为电子元器件全产业链B2B电商平台。" />
<link href="${ctxStatic }/css/indexindex.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://www.ec.hc360.com/scedfenghui/newenergy/lrtk.js"></script>
</head>
<body>
	<!---头部开始--->
	<!---顶部灰条开始--->
	<%@ include file="/WEB-INF/views/front/include/header_1.jsp"%>
	<!---顶部灰条结束--->
	<div class=" clear mhei"></div>
	<!---首页顶1广告位开始--->
	<div class="wrap">${fnc:getSiteAd('761386292986642432').content}</div>
	<!---首页顶1广告位结束--->
	<div class=" clear mhei"></div>
	<!--logo、search 开始-->
	<%@ include file="/WEB-INF/views/front/include/header_2.jsp"%>
	<!--logo、search 结束-->
	<div class="clear mhei"></div>
	<!---主导航开始--->
	<div class="wrap indexnav">
		<h1 class="fl">
			全部分类<i class="fenlei-jt"></i>
		</h1>
		<ul class="fl">
			<li><a href="${ctxf}" class="hover" target="_blank">首页</a></li>
			<li class="st1"><a href="${ctxf}/product/index.htm?st=st1" target="_blank">供应列表</a></li>
			<li class="st2"><a href="${ctxf}/purchase/index.htm?st=st2" target="_blank">采购信息</a></li>
			<li><a href="#" target="_blank">样品申请</a></li>
			<li class="st3"><a href="${ctxf}/company/index.htm?st=st3" target="_blank">行业牛商</a></li>
			<li class="st4"><a href="${ctxf}/brand/brandList.htm?st=st4" target="_blank">品牌街</a></li>
			<li><a href="#" target="_blank">供应链物流</a></li>
			<li><a href="#" target="_blank">找物流</a></li>
		</ul>
	</div>
	<!---主导航结束--->
	<!---头部结束--->
	<div class="nav-bottom clear"></div>
	<div class="wrap">
		<!---所以分类--->
		<div class="fl all-fenlei">
			<div class="navwrap" id="container">
				<div id="nav">
					<div class="pros subpage">
						<ul class="prosul clearfix" id="proinfo">
							<c:forEach items="${cateList }" var="cate">
								<c:if test="${cate.parent.id=='0' }">
									<li class="enjoy" mon="type=subnav&action=click"><i>&gt;</i> <a class="ti" href="javascript:;">${cate.name }</a>
										<div class="prosmore hide" style="overflow: auto;">
											<c:forEach items="${cateList }" var="cate1">
												<c:if test="${cate1.parent.id==cate.id }">
													<dl>
														<dt>
															<a href="${ctxf }/product/index.htm?categoryName=${cate1.name }"  target="_blank">${cate1.name }</a>
														</dt>
														<dd>
															<c:forEach items="${cateList }" var="cate2">
																<c:if test="${cate2.parent.id==cate1.id }">
																	<a href="${ctxf }/product/index.htm?categoryName=${cate2.name }" style="overflow: hidden;" target="_blank">${cate2.name }</a>
																</c:if>
															</c:forEach>
														</dd>
													</dl>
												</c:if>
											</c:forEach>
										</div></li>
								</c:if>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			<script type="text/javascript">
				var prompt_word = "proinfo";
				if (prompt_word && prompt_word.length > 0) {
					$(document).ready(function() {
						(function(element, str) {
							if (element.size() == 0) {
								return;
							}
							var elem = element;
							var opts = {
								styleDefault : 'prompt-default',
								styleFocus : 'prompt-focus'
							};
							if (elem.val() === "") {
								elem.val(str);
								if (!elem.hasClass(opts.styleDefault)) {
									elem.addClass(opts.styleDefault);
								}
							}
							elem.bind("focus", function(e) {
								elem.removeClass(opts.styleDefault);
								if (!elem.hasClass(opts.styleFocus)) {
									elem.addClass(opts.styleFocus);
								}
								if (elem.val() === str) {
									elem.val("");
								}
							});
							elem.bind("blur", function(e) {
								if (elem.val() === "") {
									elem.val(str);
									elem.removeClass(opts.styleFocus);
									if (!elem.hasClass(opts.styleDefault)) {
										elem.addClass(opts.styleDefault);
									}
								} else {
									elem.removeClass(opts.styleDefault);
								}
							});
						})($("#ssinput"), prompt_word);
					});
				}
				function bindEvent(uname, utip) {
					if (uname.size() == 0)
						return;
					var userNameEnter, userNameLeave, userTipLeave;
					uname.bind("mouseenter", function() {
						userNameEnter = setTimeout(function() {
							if (userNameEnter)
								clearTimeout(userNameEnter);
							utip.show();
						}, 200);
					});
					uname.bind("mouseleave", function() {
						userNameLeave = setTimeout(function() {
							if (userNameLeave)
								clearTimeout(userNameLeave);
							utip.hide();
						}, 200);
					});
					utip.bind("mouseenter", function() {
						if (userNameLeave)
							clearTimeout(userNameLeave);
						if (userTipLeave)
							clearTimeout(userTipLeave);
					});
					utip.bind("mouseleave", function() {
						userTipLeave = setTimeout(function() {
							if (userNameLeave)
								clearTimeout(userNameLeave);
							if (userTipLeave)
								clearTimeout(userTipLeave);
							utip.hide();
						}, 10);
					});
				}
				$(document).ready(function() {
					bindEvent($("#J_mytuanorder"), $("#J_mylist"));
				});
				(function() {
					var $block = $("#jpros"), $subblock = $(".subpage"), $head = $subblock
							.find('h2'), $ul = $("#proinfo"), $lis = $ul
							.find("li"), inter = false;
					$head.click(function(e) {
						e.stopPropagation();
						if (!inter) {
							$ul.show();
						} else {
							$ul.hide();
						}
						inter = !inter;
					});
					$ul.click(function(event) {
						event.stopPropagation();
					});
					$('body').click(function() {
						$ul.show();
						inter = !inter;
					});
					$lis.hover(function() {
						if (!$(this).hasClass('nochild')) {
							$(this).addClass("prosahover");
							$(this).find(".prosmore").removeClass('hide');
						}
					}, function() {
						if (!$(this).hasClass('nochild')) {
							if ($(this).hasClass("prosahover")) {
								$(this).removeClass("prosahover");
							}
							$(this).find(".prosmore").addClass('hide');
						}
					});
				})();
			</script>
		</div>
		<!---注册登录--->
		<div class="fr regin">
			<div class="zhuce-dl">
				<div class="zhuce-dltop">
					<p class="welcome">
						您好！欢迎来到慧聪芯城网。<br>免费帮您找最便宜的正品元器件! 
					</p>
					<p class="zhue-deng">
						<a href="${ctxf }/register.htm" class="zhucehuiyuan">注册会员</a><a href="${ctxf }/login.htm" class="denglu">登陆</a>
					</p>
					<p class="tishi">
						有任何问题请联系<a href="#" class="red">在线客服</a> 电话：<span class="red">400-8370870</span>
					</p>
				</div>
				<script>
					function setTab(name, cursel, n) {
						for (i = 1; i <= n; i++) {
							var menu = document.getElementById(name + i);
							var con = document.getElementById("con_" + name
									+ "_" + i);
							menu.className = i == cursel ? "hover" : "";
							con.style.display = i == cursel ? "block" : "none";
						}
					}
				</script>
				<div class="zuixin-hd">
					<div id="lib_Tab3">
						<div class="lib_Menubox3 lib_tabborder3">
							<ul>
								<li id="three1" onmouseover="setTab('three',1,3)" class="hover"><a href="http://info.ec.hc360.com/list/dzhcft.shtml">最新活动</a></li>
								<li id="three2" onmouseover="setTab('three',2,3)">采购商入门</li>
								<li id="three3" onmouseover="setTab('three',3,3)">供应商入门</li>
							</ul>
						</div>
						<div class="lib_Contentbox lib_tabborder">
							<div id="con_three_1">
								<ul class="dakatalk">
									<li>联营商城成单返利高达2%<a href="#" class="red">正在进行</a></li>
									<li>联营商城成单返利高达2%<a href="#" class="red">正在进行</a></li>
									<li>联营商城成单返利高达2%<a href="#">已结束</a></li>
								</ul>
							</div>
							<div id="con_three_2" style="display: none">
								<ul class="caigoushang">
									<li><a href="#"><img src="http://img02.hc360.com/ec/201607/201607050858096029.jpg" width="40" height="40" />发布询价</a></li>
									<li><a href="#"><img src="http://img01.hc360.com/ec/201606/201606200916103281.jpg" width="40" height="40" />联系交易员</a></li>
									<li><a href="#"><img src="http://img00.hc360.com/ec/201606/201606141134061879.jpg" width="40" height="40" />查看报表镜</a></li>
								</ul>
							</div>
							<div id="con_three_3" style="display: none">
								<ul class="caigoushang">
									<li><a href="#"><img src="http://img02.hc360.com/ec/201607/201607050858096029.jpg" width="40" height="40" />发布询价</a></li>
									<li><a href="#"><img src="http://img01.hc360.com/ec/201606/201606200916103281.jpg" width="40" height="40" />联系交易员</a></li>
									<li><a href="#"><img src="http://img00.hc360.com/ec/201606/201606141134061879.jpg" width="40" height="40" />查看报表镜</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="kuaisu-fbu">
					<div id="lib_Tab4">
						<div class="lib_Menubox4 lib_tabborder4">
							<ul>
								<li id="four1" onmouseover="setTab('four',1,2)" class="hover">快速发布采购</li>
								<li id="four2" onmouseover="setTab('four',2,2)">上传BOM表</li>
							</ul>
						</div>
						<div style="display: none;">
							<sys:message content="${message}" />
						</div>
						<div class="lib_Contentbox4 lib_tabborder">
							<script type="text/javascript">
								$(document)
										.ready(
												function() {
													$("#fabu1")
															.click(
																	function() {
																		var content = $(
																				"#content")
																				.val();
																		var length = $(
																				"#content")
																				.val().length;
																		if (content == null
																				|| content == '') {
																			$.jBox
																					.tip('内容为空');
																			return;
																		}
																		if (length > 2000) {
																			$.jBox
																					.tip('内容过大');
																			return;
																		} else {
																			$(
																					"#inputForm1")
																					.submit();
																		}
																	});
													$("#fabu2")
															.click(
																	function() {
																		if (document
																				.getElementById("file").files.length > 0) {
																			var length = document
																					.getElementById("file").files[0].size;
																			if (length > 20971520) {
																				$.jBox
																						.tip('文件过大');
																				return false;
																			} else {
																				$(
																						"#inputForm2")
																						.submit();
																			}
																		} else {
																			$.jBox
																					.tip('请选择文件');
																			return false;
																		}
																	});
												});
							</script>
							<form action="${ctxm }/buy/purchaesOrder/oneEntrust.htm" id="inputForm1" name="form1" method="get">
								<div id="con_four_1" class="ninde">
									<p class="ninwei-neir">您的委托内容</p>
									<p>
										<textarea rows="" cols="" name="content" id="content" class="neirong-wt"></textarea>
									</p>
									<p class="neirong-fabu">
										<a href="javascript:void(0);" id="fabu1">发布</a>
									</p>
									<p></p>
								</div>
							</form>
							<form action="${ctxf}/saveUploadProductExcel.htm" id="inputForm2" name="form2" method="post" class="frombox" ctr="ajax"
								enctype="multipart/form-data">
								<div id="con_four_2" style="display: none" class="ml20">
									<p class="mhei zhenge"></p>
									<p class="ninwei-neir mt20">
										点击上传BOM：<input type="file" name="file" id="file" />
									</p>
									<p class="queren-tij">
										<a href="javascript:void(0);" id="fabu2">确认提交</a>
									</p>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!---焦点图--->
		<div class="fr focu-main">
			<div class="focu-tu">
				<!-- 代码 开始 -->
				<div id="playBox">
					<div class="pre"></div>
					<div class="next"></div>
					<div class="smalltitle">
						<ul>
							<c:forEach items="${pictureList }" varStatus="status">
								<c:choose>
									<c:when test="${status.first }">
										<li class="thistitle"></li>
									</c:when>
									<c:otherwise>
										<li></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>
					</div>
					<ul class="oUlplay">
						<c:forEach items="${pictureList }" var="picture">
							<li><a href="${picture.taget }" target="_blank"><img src="${ct }${fs}${picture.path }@!598x315" width="598" height="315" /></a></li>
						</c:forEach>
					</ul>
				</div>
				<!-- 代码 结束 -->
			</div>
			<div class="mt10 jiaoyidongt">
				<div class="fl xjcshu">
					<div class="xjcs-yester">
						昨日询价次数<br><span>${countQuery }</span>次 
					</div>
					<div class="xjcs-yester">
						昨日服务客户<br><span>${countService }</span>次 
					</div>
				</div>
				<div class="jybb_le fl">
					<p class="zuixindongtai-title">
						<span class="fl">最新动态</span><span class="fr"></span>
					</p>
					<div class="viphy">
						<div id="viphy">
							<div id="viphy1">
								<c:forEach items="${orderList }" var="order">
									<div class="jine">
										<span style="width: 110px; overflow: hidden;">${order.order.buyMemberCompany!=null?order.order.buyMemberCompany.comName:'北******公司' }</span>
										<span style="width: 120px; overflow: hidden;">${fns:abbr(order.product!=null?order.product.model:'',20)}</span>
										<span style="width: 110px; overflow: hidden;">${fns:getDictLabel(order.order.status, 'order_status', '')}</span>
									</div>
								</c:forEach>
							</div>
							<div id="viphy2"></div>
						</div>
					</div>
				</div>
				<script>
					//交易播报滚动
					var speed = 40;
					var ZJJDemo = document.getElementById('viphy');
					var ZJJDemo1 = document.getElementById('viphy1');
					var ZJJDemo2 = document.getElementById('viphy2');
					ZJJDemo2.innerHTML = ZJJDemo1.innerHTML
					function Marquee1() {
						if (ZJJDemo2.offsetHeight - ZJJDemo.scrollTop <= 0)
							ZJJDemo.scrollTop -= ZJJDemo1.offsetHeight
						else {
							ZJJDemo.scrollTop++
						}
					}
					var MyMar1 = setInterval(Marquee1, speed)
					ZJJDemo.onmouseover = function() {
						clearInterval(MyMar1)
					}
					ZJJDemo.onmouseout = function() {
						MyMar1 = setInterval(Marquee1, speed)
					}
				</script>
			</div>
		</div>
	</div>
	<div class="clear mhei"></div>
	<!---十大品牌专区开始--->
	<div class="pinpai">
		<c:forEach items="${pinpaiList.list }" var="pinpai">
			<c:if test="${pinpai.memberRank>10 }">
				<a href="${ctxf }/shop/${pinpai.id }/index.htm">
			</c:if>
			<c:if test="${pinpai.memberRank<=10 }">
				<a href="javascript:;">
			</c:if>
			<img src="${ct }${fs}${pinpai.bak3 }@!129x45" onerror="this.src='${ctxStatic }/image/product.jpg'" width="129" height="45"></a>
		</c:forEach>
	</div>
	<!---十大品牌专区结束--->
	<div class="clear mhei"></div>
	<!--1F1F1F1F---->
	<c:set var="color" value="${fn:split('one,two,three,four,five,six,senven', ',')}"></c:set>
	<c:forEach items="${floorPage.list }" var="floor" varStatus="status">
		<div class="wrap" style="overflow: hidden;">
			<div class="fl ge-fenlei">
				<p class="lou-${color[status.index%7] } louceng">${floor.name }</p>
				<p class="chnapinpictuier">
					<img src="${ct }${fs}${floor.img}" onerror="this.src='${ctxStatic }/image/product.jpg'" width="191" height="193" />
				</p>
				<p class="chanpin-mingc">
					<c:forEach items="${linkList }" var="link">
						<c:if test="${link.recommend==floor.id }">
							<a href="${link.url }" style="width: 100px">${link.name }</a>
						</c:if>
					</c:forEach>
				</p>
			</div>
			<div class="fl chanpin-list">
				<c:set var="flag" value="true"></c:set>
				<c:set var="num" value="0"></c:set>
				<c:forEach items="${recommendList }" var="recommend">
					<c:if test="${recommend.recommend.recommend==floor.id }">
						<c:if test="${flag }">
							<ul class="fl chanpin-listleft">
								<c:set var="flag" value="false"></c:set>
						</c:if>
						<c:set var="num" value="${num+1 }"></c:set>
						<c:choose>
							<c:when test="${num<7 }">
								<li><p class="mingzi">
										<c:if test="${recommend.shop!=null}">
											<a href="${ctxf }/shop/product/${recommend.product.id }/detail.htm">
										</c:if>${fns:abbr(recommend.product.model,20)}<br>${fns:abbr(recommend.product.name,25)}</a>
									</p>
									<p class="mingzitu">
										<c:if test="${recommend.shop!=null}">
											<a href="${ctxf }/shop/product/${recommend.product.id }/detail.htm">
										</c:if>
										<img src="${ct }${fs}${recommend.product.img.filePath}@!118x80" onerror="this.src='${ctxStatic }/image/product.jpg'" width="118" height="80" /></a>
									</p>
									<p class="chanpin-jiage">${recommend.product.price<=0 or recommend.product.price==null?'':'商城价：'}
										<span class="red">${recommend.product.price<=0 or recommend.product.price==null?'':'￥'}${recommend.product.price<=0 or recommend.product.price==null?'询价':recommend.product.price }</span>
									</p></li>
							</c:when>
							<c:otherwise>
								<c:if test="${num==7 }">
									</ul>
									<div class="fl zhuchanpin">
										<c:if test="${recommend.shop!=null}">
											<a href="${ctxf }/shop/product/${recommend.product.id }/detail.htm">
										</c:if>
										<img src="${ct }${fs}${recommend.product.img.filePath}@!118x240" onload="imgUtils.imageResize(118,240);" onerror="this.src='${ctxStatic }/image/product.jpg'" width="118"
											height="240" /></a>
										<p>
											<c:if test="${recommend.shop!=null}">
											<a href="${ctxf }/shop/product/${recommend.product.id }/detail.htm">
										</c:if>${fns:abbr(recommend.product.model,20)}<br>${fns:abbr(recommend.product.name,25)}&nbsp;</a>
										</p>
										<p class="red ">${recommend.product.price<=0 or recommend.product.price==null?'':'￥'}${recommend.product.price==0 or recommend.product.price==null?'询价':recommend.product.price }</p>
									</div>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div class="clear mhei"></div>
	</c:forEach>
	<div class="wrap">
		<h1 class="huicong-new">
			芯城新闻 <a href="${ct}/article/index.htm">更多&gt;&gt;</a>
		</h1>
		<ul class="fl photograph">
			<c:forEach items="${fnc:getArticleList(2, '', 6, 'posid:1')}" var="article">
				<c:choose>
					<c:when test="${article.link==null }">
						<li><a href="${ctxf }/article/content.htm?id=${article.id}"><img src="${article.image}" width="218" height="170"></a>
							<div class="xianchu">
								<h1>
									<a href="${ctxf }/article/content.htm?id=${article.id}">${fns:abbr(article.title,30)}</a>
								</h1>
							</div></li>
					</c:when>
					<c:otherwise>
						<li><a href="${article.link }"><img src="${article.image}" width="218" height="170"></a>
							<div class="xianchu">
								<h1>
									<a href="${article.link }">${fns:abbr(article.title,30)}</a>
								</h1>
							</div></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</ul>
		<p class="zxdt-zx fl">最新动态</p>
		<ul class="fl new-list">
			<c:forEach items="${fnc:getArticleList(2, '', 8,'posid:1')}" var="article1">
				<c:choose>
					<c:when test="${article1.link==null }">
						<li><a href="${ctxf }/article/content.htm?id=${article1.id}">${fns:abbr(article1.title,40)}</a><span><fmt:formatDate
									value="${article1.updateDate}" pattern="yyyy.MM.dd" /></span></span></li>
					</c:when>
					<c:otherwise>
						<li><a href="${article1.link }">${fns:abbr(article1.title,40)}</a><span><fmt:formatDate value="${article1.updateDate}"
									pattern="yyyy.MM.dd" /></span></span></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</ul>
	</div>
	<div class=" clear mhei"></div>
	<div class=" wrap weibuchanpin">
		<p>${fnc:getSiteAd('757882419385597952').content}</p>
	</div>
	<!---首页底部--->
	<%@ include file="/WEB-INF/views/front/include/footer.jsp"%>
</body>
</html>