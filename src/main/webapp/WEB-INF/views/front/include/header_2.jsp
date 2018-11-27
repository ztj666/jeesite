<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="wrap">
	<div class="fl logo mt_20"><a href="${ct}/"><img src="${ctxStatic}/image/caigoulogo.png" width="396" height="40"/></a></div>
	<div class="hc-search fr mt_10">
		<div class="wen_zj mt_20">
			<div class="search">
				<div class="select_list" onmouseout="hiddenMenuList()" onmouseover="showMenuList()">
				    <p><a href="javascript:;" id="init_c" target="_self">${not empty c?c:'供应'}</a></p>
				    <div style=" display:none;" id="ycssnr">
				    <p><a href="javascript:;" name="menu" >求购</a></p>
				    <p><a href="javascript:;" name="menu" >公司</a></p>
				    <p><a href="javascript:;" name="menu" >资讯</a></p>
				    <p><a href="javascript:;" name="menu" >供应</a></p>
				    </div>
				</div>
				<script>
					function hiddenMenuList(){
						$("#ycssnr").css({display:"none"})
					}
					function showMenuList(){
						$("#ycssnr").css({display:""})
					}
					$(document).ready(function(){
						//根据用户点击决定选中哪一个menu
						$("a[name='menu']").click(function selectMenu(obj){
							var temp=$("#init_c").html();
							var cerrent_menu_value=$(this).html();
							$("#init_c").html(cerrent_menu_value);
							$("#ycssnr").css({display:"none"});
							var ssnr_txt = $("#init_c").html();
							var c = ssnr_txt;
							var w = "请输入搜索内容";
							$("#c").val(c);
							var w_value = $("#w").val();
							var rs=(w_value=='' ? w : (w_value != w ? w_value:w));
							$("#w").val(rs);
						});
						$("#w").click(function(){
							if($(this).val()=="请输入搜索内容"){
								$(this).val("");
							}
						});
						$("#w").focus(function(){
							if($(this).val()=="请输入搜索内容"){
								$(this).val("");
							}
						});
						$("#w").blur(function(){
							if($(this).val()==""){
								$(this).val("请输入搜索内容");
							}
						});
						initMenu();//页面初始时，根据init_c参数决定选中哪一个menu
					});
					function initMenu(){
						var currentMenuValue=$("#init_c").text();
						$("a[name='menu']").each(function(){
							if($(this).text()==currentMenuValue){
								$(this).trigger("click");//模拟点击
							}
						});
					}
				</script>
				<form action="${ctxf}/search/index.htm" method="get" name="hyformnew" target="_blank" id="hyformnew2">
					<div>
						<div class="serach_box">
							<input type="hidden" name="c" id="c" value="">
							<input type="text" name="w" id="w" value="${w}">
						</div>
						<div class="search_button">
							<input type="image" src="http://www.dzqjd.hc360.com/images/sousuo.jpg" height="42">
						</div>
					</div>
				</form>
			</div>
			<div class="clear"></div>
		</div>
		</div>
	</div>
</div>