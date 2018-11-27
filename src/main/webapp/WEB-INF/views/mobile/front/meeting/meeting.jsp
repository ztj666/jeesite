<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>会议在线</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
<style type="text/css">
#item1 li {
	margin-top: 1px;
	padding: 5px;
	color: #888888;
	text-align: center;
	word-break:keep-all; /* 不换行 */ 
	white-space:nowrap; /* 不换行 */ 
	overflow:hidden; /* 内容超出宽度时隐藏超出部分的内容 */ 
	text-overflow:ellipsis; /* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用。*/ 
}
option{
  width: 100%;
  text-align: center;
}
</style>
</head>
<body>
	<!--  	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a href="#popover"><img src="${ctxStatic}/image/ic_menu_white.png" class="mine_head"></a> 
		<div id="search"><img width="24px" height="24px"  src="${ctxStatic}/image/ic_search_white.png" style="margin-left: 52px; margin-top: 10px;"></div>
		<div id="release" style="position: absolute; top: 7px; right: 20px; width: 60px; height: 30px; border: 1px solid #FFFFFF; border-radius: 100px;">
			<p style="position: absolute; top: 10px; left: 15px; width: 28px; height: 18px; color: white; font-size: 14px; line-height: 8px;">发布</p>
			</a>
		</div>
		  <div  style="position: absolute; top:12px;left: 32%;  width: 35%; text-align: center; font-size: 16px; color: white;">会议</div>
		</header>   -->
	
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
		<h1 class="mui-title" style="font-size: 16px; color: white; right: 100px; left:100px ;">会议在线</h1>
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
	<div class="mui-content" style="margin-top: 136px">
		<div style="background-color: #F6F4F4; height: 40px;">
			<div style="position: absolute; width: 49%;">
				<p id="showCityPicker" class="expert_list_div_title" style="width: 100%; float: left; text-align: center; margin-right: 30%">全部城市</p>
			</div>
			<div class="expert_div_line" style="left: 50%;top: 185px"></div>
			<div style="position: absolute; width: 49%; left: 49%;">
				<select id="cate" style="margin-left: 50px; background-color: transparent; color: #4AACC5; width: 130px; text-align: center;">
					<option value="(2,3)">近期会议</option>
					<option value="(4)">往期会议</option>
				</select>
			</div>
		</div>
		<div class="mui-slider mui-fullscreen" style="margin-top: 176px;">
			<div class="mui-slider-group">
				<div id="item1mobile" class="mui-slider-item mui-control-content mui-active">
					<div id="scroll1" class="mui-scroll-wrapper">
						<div class="mui-scroll">
							<ul id="item1" class="mui-table-view">
								<c:forEach items="${meeting }" var="item">
									<li id="${item.id}"><h4 style="color: #4AACC5;" align="center">${fns:abbr(item.subject,40)}</h3>
									<fmt:formatDate value="${item.startTime }" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;~&nbsp;<fmt:formatDate value="${item.endTime }"
											pattern="yyyy-MM-dd HH:mm:ss" /></li>
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
				
				 m('body').on('tap','a',function(){
					 document.location.href=this.href;
				});
				 //格式化日期,
			      function formatDate(date,format){
			        var paddNum = function(num){
			          num += "";
			          return num.replace(/^(\d)$/,"0$1");
			        }
			        //指定格式字符
			        var cfg = {
			        	yyyy : date.getFullYear() //年 : 4位
					    ,yy : date.getFullYear().toString().substring(2)//年 : 2位
					    ,M  : date.getMonth() + 1  //月 : 如果1位的时候不补0
					    ,MM : paddNum(date.getMonth() + 1) //月 : 如果1位的时候补0
					    ,d  : date.getDate()   //日 : 如果1位的时候不补0
					    ,dd : paddNum(date.getDate())//日 : 如果1位的时候补0
					    ,hh : paddNum(date.getHours())  //时
					    ,mm : paddNum(date.getMinutes()) //分
					    ,ss : paddNum(date.getSeconds()) //秒
			        }
			        format || (format = "yyyy-MM-dd hh:mm:ss");
			        return format.replace(/([a-z])(\1)*/ig,function(m){return cfg[m];});
			      } 
				mui.ready(function() {
					mui('#slider').slider({
						interval: 5000
					});
				});
				search.addEventListener('tap',function(){
					m.openWindow({
						url : ctxw + '/meeting/search.htm'
					});
				});
				release.addEventListener('tap',function(){
					m.openWindow({
						url : ctxw + '/meeting/release.htm'
					});
				});
				$('#item1 li').each(function(){
					if(this.id!=null&&this.id!=''){
						this.addEventListener('tap',function(){
							var url=ctxw + '/meeting/detail.htm?id='+this.id;
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
						url : ctxw + "/meeting/reMeeting.htm",
						data : {
							pageNo:pageNo,
							address:city,
							status:cate.options[cateIndex].value
						},
						async : false,
						dataType : "json",
						success : function(data) {
							if (data.code == 1) {
								//alert(JSON.stringify(data))
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
									var html = "<h4 style=\"color: #4AACC5\" align=\"center\">"+data.list[i].subject+"</h3>"+
									formatDate(new Date(data.list[i].startTime.replace(/\-/g, "/")),"yyyy-MM-dd hh:mm:ss")+"&nbsp;~&nbsp;"+formatDate(new Date(data.list[i].endTime.replace(/\-/g, "/")),"yyyy-MM-dd hh:mm:ss");
									//							li.innerHTML = '第' + (index + 1) + '个选项卡子项-' + (length + (reverse ? (count - i) : (i + 1)));
									li.innerHTML = html;
									li.addEventListener('tap', function(event) {
										//								alert(this.id);
										var url=ctxw + '/meeting/detail.htm?id='+this.id;
										m.openWindow({
											url : url
										});
									});
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