<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>账户记录</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta name="decorator" content="defaultWx" />
<link rel="stylesheet" type="text/css" href="${ctxStatic }/css/mine.css" />
<style type="text/css">
li{
 	margin-bottom:2px;
 	padding: 10px;
 	background-color: white;
}
</style>
</head>
<body>
	<header class="mui-bar mui-bar-nav" style="background-color: #4AACC5;">
		<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color: white"></a>
		<h1 class="mui-title" style="font-size: 16px; color: white; font-weight: normal">账户记录</h1>
	</header>
	<div class="mui-content">
		<div id="slider" class="mui-slider mui-fullscreen" >
			<div class="mui-slider-group">
				<div id="item1mobile" class="mui-slider-item mui-control-content mui-active">
					<div id="scroll1" class="mui-scroll-wrapper">
						<div class="mui-scroll">
							<ul id="item1" class="mui-table-view" style="background-color: transparent;">
								<c:forEach items="${list }" var="item">
									<li>
										<span><h4 style="font-size: 16px;color: #333333;float:left; width: 80%">${item.record}</h4><p style="float:right;text-align:right; width:20%; font-size: 16px;color: #333333;">${item.coinNumber}</p></span>
										<span><h5 ><fmt:formatDate value="${item.updateDate }" pattern="yyyy-MM-dd HH:mm:ss" /></h5></span>
										</li>
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
				 var createFragment = function(ul, index, count, reverse) {
						var length = ul.querySelectorAll('li').length;
						if(index==0)
							pageNo=index;
						else
							pageNo++;
						var fragment = document.createDocumentFragment();
						m.ajax({
							type : "post",
							url : ctxw + "/accountRecord/reAccount.htm",
							data : {
								pageNo:pageNo
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
										//li.id = data.list[i].id;
										var html = "<span><h4 style=\"font-size: 16px;color: #333333;float:left; width: 80%\">"+data.list[i].record+"</h4><p style=\"float:right;text-align:right; width:20%; font-size: 16px;color: #333333;\">"+data.list[i].coinNumber+"</p></span>"
										+"<span><h5 >"+formatDate(new Date(data.list[i].updateDate),"yyyy-MM-dd hh:mm:ss")+"</h5></span>";
										//							li.innerHTML = '第' + (index + 1) + '个选项卡子项-' + (length + (reverse ? (count - i) : (i + 1)));
										li.innerHTML = html;
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
			}(mui, document));
		</script>
</body>
</html>