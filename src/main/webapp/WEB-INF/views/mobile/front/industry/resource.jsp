<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>行业资料</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
</head>
<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white; font-weight: normal">行业资料</h1>
	</header>
	<div class="mui-content">
		<div id="slider" class="mui-slider mui-fullscreen" >
			<div class="mui-slider-group">
				<div id="item1mobile" class="mui-slider-item mui-control-content mui-active">
					<div id="scroll1" class="mui-scroll-wrapper">
						<div class="mui-scroll">
							<ul id="item1" class="mui-table-view">
								<c:forEach items="${list }" var="item">
									<li style="margin: 10px;padding: 5px"><a href="${item.url }" target="_blank" download="${item.name }">${fns:abbr(item.name,48) }</a><br><fmt:formatDate value="${item.updateDate }" pattern="yyyy-MM-dd HH:mm:ss" /></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	 <script type="text/javascript">
		(function(m, doc) {
				m.init();
				 m('body').on('tap','a',function(){
					 document.location.href=this.href;
				});
				//循环初始化所有下拉刷新，上拉加载。
				m.each(document.querySelectorAll('.mui-slider-group .mui-scroll'), function(index, pullRefreshEl) {
					m(pullRefreshEl).pullToRefresh({
						down: {
							callback: function() {
								var self = this;
								setTimeout(function() {
									var ul = self.element.querySelector('.mui-table-view');
									//ul.innerHTML = '';
									//ul.insertBefore(createFragment(ul, 0, 10, true), ul.firstChild);
									m.toast('已最新');
									self.endPullDownToRefresh();
								}, 1000);
							}
						},
						up: {
							callback: function() {
								var self = this;
								setTimeout(function() {
									var ul = self.element.querySelector('.mui-table-view');
									//ul.appendChild(createFragment(ul, index, 5));
									m.toast('已最新');
									self.endPullUpToRefresh();
								}, 1000);
							}
						}
					});
				});
			}(mui, document));
		</script>
</body>
</html>