<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>行业地图</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
<style type="text/css">
.input-label {
	float: left;
	margin-left: 15px;
	width: 52px;
	height: 24px;
	text-align: center;
	border-radius: 40px;
	border: 1px;
	border-style: solid;
	border-color: #4AACC5;
	width: 52px;
}
#item1 li{
	width: 33.3%;
	float: left;
	text-align: center;
	height: 81px;
}
#item1 li img{
	margin:15px;
	float:left;
	width: 80px;
	height: 80px;
	border-radius: 100px;
}
option{
  width: 100%;
  text-align: center;
}
</style>
</head>
<body>
<!-- <header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
           <div style="float: left; padding-top: 10px;margin-right: 10px;">
				<img src="../image/ic_menu_white.png" width="20px" height="18px" align="center">
			</div>
			<div style="float: left; padding-top: 10px;">
				<img src="../image/ic_search_white.png" width="20px" height="20px" align="center">
			</div>
		    <h1 class="mui-title" style="font-size: 16px; color: white;">行业</h1>
		
		<div id="release" style="position: absolute; top: 7px; right: 20px; width: 60px; height: 30px; border: 1px solid #FFFFFF; border-radius: 100px;">
			<p style="position: absolute; top: 10px; left: 15px; width: 28px; height: 18px; color: white; font-size: 14px; line-height: 8px;">发布</p></a>
		</div>
		<div  style="position: absolute; top:12px;left: 32%;  width: 35%; text-align: center; font-size: 16px; color: white;">行业地图</div>
	</header>  -->
	
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;width: 100%;">
		<a href="#popover"><div style="float: left;margin-right: 8px;">
			<img src="${ctxStatic}/image/ic_menu_white.png" width="20px" height="18px" align="center" style="margin-left:5px; margin-right: 5px;margin-top: 13px;margin-bottom: 5px;">
		</div></a>
		<div id="search" style="float: left;">
			<img src="${ctxStatic}/image/ic_search_white.png" width="20px" height="20px" align="center" style="margin-left:5px; margin-right: 5px;margin-top: 13px;margin-bottom: 5px;">
		</div>
		<div id="release" style="position: absolute; top: 7px; right: 20px; width: 60px; height: 30px; border: 1px solid #FFFFFF; border-radius: 100px;">
			<p style="position: absolute; top: 10px; left: 15px; width: 28px; height: 18px; color: white; font-size: 14px; line-height: 8px;">发布</p>
		</div>
		<h1 class="mui-title" style="font-size: 16px; color: white; right: 100px; left:100px ;">行业地图</h1>
	</header>
	
	<%@ include file="/WEB-INF/views/mobile/include/indexHead.jsp"%>
		<div id="offCanvasContentScroll" class="mui-content mui-scroll-wrapper" style="z-index: 0;">
		<div class="mui-scroll">
			<div class="mui-collapse-content">
				<div id="slider" class="mui-slider">
					<div class="mui-slider-group mui-slider-loop">
					<c:forEach items="${banner }" var="item" varStatus="status">
					<c:if test="${status.first }">
						<!-- 额外增加的一个节点(循环轮播：第一个节点是最后一张轮播) -->
						<div class="mui-slider-item mui-slider-item-duplicate">
							<a href="#"> <img src="${banner[fn:length(banner)-1].url }" style="width: 100%;height: 140px" >
							</a>
						</div>
						</c:if>
						<!-- 第一张 -->
						<div class="mui-slider-item">
							<a href="#"> <img src="${item.url }" width="100%" height="140px">
							</a>
						</div>
						<c:if test="${status.last }">
						<!-- 额外增加的一个节点(循环轮播：最后一个节点是第一张轮播) -->
						<div class="mui-slider-item mui-slider-item-duplicate">
							<a href="#"> <img src="${banner[0].url }" width="100%" height="140px">
							</a>
						</div>
						</c:if>
						</c:forEach>
					</div>
					<div class="mui-off-canvas-backdrop"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- <p
		style="position: relative; top: 89px; margin: auto; width: 187px; height: 23px; font-size: 16px; color: white; font-family: PingFangSC-Semibold; text-shadow: 0px 1px 10px rgba(0, 0, 0, 0.50);">连接您和1000家基因公司</p> -->
	<div id="content" style="position: absolute; top: 184px; width: 100%;height: 440px">
		<div style="background-color: #F6F4F4; height: 40px;">
		  <div style="position: absolute; width: 49%;">
			  <p id="showCityPicker" class="expert_list_div_title" style="width: 100%;float:left;text-align:center; margin-right: 30%">全部城市</p>
		  </div>
		  <div class="expert_div_line" style="left: 50%;"></div>
		  <div style="position: absolute; width: 49%; left: 49%;">
		 	  <select id="cate" style="margin-left:50px; background-color: transparent;color: #4AACC5;width: 130px;text-align: center;">
					<option value="">全部行业</option>
						<c:forEach items="${label }" var="item">
							<option value="${item.name }">${item.name }</option>
						</c:forEach>
				</select>
		  </div>
		</div>
		<div id="slider" class="mui-slider mui-fullscreen" style="margin-top: 45px;">
			<div class="mui-slider-group">
				<div id="item1mobile" class="mui-slider-item mui-control-content mui-active">
					<div id="scroll1" class="mui-scroll-wrapper">
						<div class="mui-scroll">
							<ul id="item1" class="mui-table-view">
								<c:forEach items="${list }" var="item">
									<li id="${item.id}"><img src="${item.logo }" style="width: 80px" onerror="this.src='${ct }${fs}${item.logo!=''?item.logo:'/avatar_s.png' }@!80x80'" ></li>
								</c:forEach>
								<c:forEach step="1" begin="1" end="${fn:length(list)>=3?fn:length(list)%3:3-fn:length(list) }" var="item">
									<li></li>
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
				var release = doc.getElementById('release');
				var showCityPickerButton = doc.getElementById('showCityPicker');
				var cate = doc.getElementById('cate');
				var ul1 = document.getElementById('item1');
				var search = document.getElementById('search');
				var pageNo=1;
				search.addEventListener('tap',function(){
					m.openWindow({
						url : ctxw + '/industry/search.htm'
					});
				});
				release.addEventListener('tap',function(){
					m.openWindow({
						url : ctxw + '/industry/release.htm'
					});
				});
				$('#item1 li').each(function(){
					if(this.id!=null&&this.id!=''){
						this.addEventListener('tap',function(){
							var url=ctxw + '/industry/detail.htm?id='+this.id;
							m.openWindow({
								url : url
							});
						});
					}
				})
				cate.addEventListener('change', function() {
					ul1.innerHTML = '';
					ul1.appendChild(createFragment(ul1, 0, 10));
				});
				var createFragment = function(ul, index, count, reverse) {
					var length = ul.querySelectorAll('li').length;
					var cateIndex = cate.selectedIndex;
					var city = showCityPickerButton.innerText == '城市选择' || showCityPickerButton.innerText == '全部城市' ? '' : showCityPickerButton.innerText;
					if(index==0)
						pageNo=index;
					else
						pageNo++;
					var fragment = document.createDocumentFragment();
					m.ajax({
						type : "post",
						url : ctxw + "/industry/reIndustry.htm",
						data : {
							pageNo:pageNo,
							bak2:city,
							bak3:cate.options[cateIndex].value
						},
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.code == 1) {
								// alert(JSnN.stringify(data))
								if (index!=0 && pageNo > data.pageSize) {
									m.toast('这是最后一页!');
									return fragment;
								}else{
									pageNo=data.pageNo;
								}
								for (var i = 0; i < data.list.length; i++) {
									var li = doc.createElement('li');
									//li.className = 'mui-table-view-cell';
									li.id = data.list[i].id;
									var html = "<img src=\""+data.list[i].logo+"\" style=\"width: 80px\" onerror=\"this.src='${ct }${fs}"+(data.list[i].logo!=''?data.list[i].logo:'/avatar_s.png')+"@!80x80'\" >";
									//							li.innerHTML = '第' + (index + 1) + '个选项卡子项-' + (length + (reverse ? (count - i) : (i + 1)));
									li.innerHTML = html;
									li.addEventListener('tap', function(event) {
										//								alert(this.id);
										var url=ctxw + '/industry/detail.htm?id='+this.id;
										m.openWindow({
											url : url
										});
									});
									fragment.appendChild(li);
								}
								for(var i = 0; i < (data.list.length>=3?data.list.length:3-data.list.length); i++){
									var li = doc.createElement('li');
									fragment.appendChild(li);
								}
							} else {
								m.toast(data.message);
							}
						},
						error : function(data) {
							//if (data.status == '401') {
							//}
							m.toast('服务错误!');
						}
					});
				 return fragment;
				};
				//循环初始化所有下拉刷新，上拉加载。
				m.each(document.querySelectorAll('.mui-slider-group .mui-scroll'), function(index, pullRefreshEl) {
					m(pullRefreshEl).pullToRefresh({
						down: {
							callback: function() {
								var self = this;
								setTimeout(function() {
									var ul = self.element.querySelector('.mui-table-view');
									ul.innerHTML = '';
									ul.insertBefore(createFragment(ul, 0, 10, true), ul.firstChild);
									self.endPullDownToRefresh();
								}, 1000);
							}
						},
						up: {
							callback: function() {
								var self = this;
								setTimeout(function() {
									var ul = self.element.querySelector('.mui-table-view');
									index++;
									ul.appendChild(createFragment(ul, index, 5));
									self.endPullUpToRefresh();
								}, 1000);
							}
						}
					});
				});

				//-----------------------------------------
				//级联示例
				var cityPicker = new m.PopPicker({
					layer: 2
				});
				cityPicker.setData(cityData);
				showCityPickerButton.addEventListener('tap', function(event) {
					cityPicker.show(function(items) {
						showCityPickerButton.innerText = items[1].text;
						ul1.innerHTML = '';
						ul1.appendChild(createFragment(ul1, 0, 10));
						//返回 false 可以阻止选择框的关闭
						//return false;
					});
				}, false);
				
			}(mui, document));
		</script>
</body>
</html>