<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>我的会议</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
<style type="text/css">
#item1 li {
	margin-top: 1px;
	padding: 5px;
	color: #888888;
	word-break:keep-all; /* 不换行 */ 
	white-space:nowrap; /* 不换行 */ 
	overflow:hidden; /* 内容超出宽度时隐藏超出部分的内容 */ 
	text-overflow:ellipsis; /* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用。*/ 
}
</style>
</head>
<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white;"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white;">我的会议</h1>
	</header>
	<div class="mui-content">
	<div style="background-color: #FFFFFF; height: 40px;margin: 10px">
			<div style="position: absolute; width: 30%;height: 38px;margin-top: 8px;margin-right: 5px">
				<a href="${ctxw }/meeting/myMeeting1.htm"><h4 style="color: #333333" align="center">报名的会议</h4></a>
			</div>
			<div style="background-color:#4AACC5; position:relative; top:37px;left:10px; width: 96px;height: 4px;">
			</div>
			<div style="position: absolute; width: 30%; left: 36%;margin-top: 5px;margin-right: 5px">
				<a href="${ctxw }/meeting/myMeeting2.htm"><h4 style="color: #333333" align="center">发布的会议</h4></a>
			</div>
			<div style="position: absolute; width: 30%; left: 66%;margin-top: 5px;margin-right: 5px">
				<a href="${ctxw }/meeting/myMeeting3.htm"><h4 style="color: #333333" align="center">购买记录</h4></a>
			</div>
		</div>
		<div class="mui-slider mui-fullscreen" style="margin-top: 56px;">
			<div class="mui-slider-group">
				<div id="item1mobile" class="mui-slider-item mui-control-content mui-active">
					<div id="scroll1" class="mui-scroll-wrapper">
						<div class="mui-scroll">
							<ul id="item1" class="mui-table-view">
								<c:forEach items="${list }" var="item">
									<li id="${item.meeting.id}">
									<div style="float: left;width: 120px">
										<img src="${item.meeting.banner }" width="120px" height="90px">
									</div>
									<div style="float: left;margin-left: 10px">
										<h4 style="color: #333333">${fns:abbr(item.meeting.subject,23)}</h3>
										<fmt:formatDate value="${item.meeting.startTime }" pattern="yy-M-d H:m" />&nbsp;~&nbsp;<fmt:formatDate value="${item.meeting.endTime }" pattern="yy-M-d H:m" /><br>${item.meeting.address }
									</div></li>
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
				var ul1 = document.getElementById('item1');
				var pageNo=1;
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
				var createFragment = function(ul, index, count, reverse) {
					var length = ul.querySelectorAll('li').length;
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
									formatDate(new Date(data.list[i].startTime),"yyyy-MM-dd hh:mm:ss")+"&nbsp;~&nbsp;"+formatDate(new Date(data.list[i].endTime),"yyyy-M-d hh:mm:ss");
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
									//ul.innerHTML = '';
									//ul.insertBefore(createFragment(ul, 0, 10, true), ul.firstChild);
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
									//ul.appendChild(createFragment(ul, index, 5));
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