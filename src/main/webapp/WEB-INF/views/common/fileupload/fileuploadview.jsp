<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>文件上传</title>
		<link href="${ctxStatic}/css/uploadcss.css" rel="stylesheet"  type="text/css" />
		<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
		<script type="text/javascript" src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="${ctxStatic}/ajaxfileupload/ajaxfileupload.js"></script>
		<script type="text/javascript" src="${ctxStatic}/js/upload.js"></script>
		<script type="text/javascript" src="${ctxStatic}/js/json2.js"></script>
		<script type="text/javascript" src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js"></script>
	</head>
	<body style="background:#F6F5F4;" onunload="${isClose==1?'parent.location.reload();':''}">
		<div class="big">
			<!-- 左边的tree开始 -->
			<div class="left">
				<div class="leftcont">
					<div class="fl">文件夹</div>
					<div id="tree" style="margin-left:-8px;">
						<ul show="true" id="ul1" class="ul" val="${imgId}">
						  	<c:forEach items="${bumpage.list}" var="ProductAlBum" varStatus="a">
						  		<c:choose> 
					  			<c:when test="${not empty imgId}">
							  	<c:choose>  
								<c:when test="${ProductAlBum.id ==imgId}">
									<div class="li1" onclick="selectImgBum('${ProductAlBum.id}','${onSelect}','${productAlbum.type}');">
										<li class="li2" id='${ProductAlBum.id}' val='${imgId}'>${ProductAlBum.name}</li>
									</div>
								</c:when>  
								<c:otherwise>
									<div class="li1" onclick="selectImgBum('${ProductAlBum.id}','${onSelect}','${productAlbum.type}');">
										<li class="li2" id='${ProductAlBum.id}'>${ProductAlBum.name}</li>
									</div>
								</c:otherwise>  
								</c:choose>
								 </c:when> 
								<c:otherwise>
								<c:choose>
					  			<c:when test="${a.first}">
					  				<div class="li1 imgBumSelect" id="firstBum" onclick="selectImgBum('${ProductAlBum.id}','${onSelect}','${productAlbum.type}');">
										<li class="li2" id='${ProductAlBum.id}' val='${ProductAlBum.id}'>${ProductAlBum.name}</li>
									</div>
								</c:when>
							   <c:otherwise>
							  	 	<div class="li1" onclick="selectImgBum('${ProductAlBum.id}','${onSelect}','${productAlbum.type}');">
										<li class="li2" id='${ProductAlBum.id}'>${ProductAlBum.name}</li>
							   		</div>
							   </c:otherwise>
								</c:choose> 
								</c:otherwise> 
								</c:choose>
						  	</c:forEach>
						 </ul>
					</div>
				</div>
			</div>
			<!-- 左边的tree结束 -->
			<!-- 右边的内容开始 -->		
			<div class="right">
				<div class="top">
					<div class="filebtn">
						<div class="upbtn" id="upbtn1" style="width:157px;background:url('${ctxStatic }/image/add.gif');background-repeat:no-repeat;background-position:0 50%;">
							<div class="cke_icon"></div>
							<span id="cke_9_label" class="cke_label">
								<input type="file" id="file" name="file"  onchange="selectbum()" multiple="multiple"/>
							</span>
						</div>
						<div class="upbtn" style="margin-top:5px;" onclick="selectImgBum(null,'${onSelect}','${type}')">
							<div class="cke_icon1"></div>
							<span id="cke_9_label" class="cke_label">刷新</span>
						</div>
						<div class="upbtn" style="margin-top: 5px;background:url('${ctxStatic }/image/true.png');background-repeat:no-repeat;background-position:0 50%;" >
							<a>
								<div class="cke_icon1" style="height:16px;width:20px;background:none"></div>
								<div class="trueupload">确定</div>
							</a>
						</div>
					</div>
				</div>
				<div class="content">
					<c:forEach items="${imgpage}" var="productAlbumImg">
						<div class="imgs" onMouseOver="fun(this)" onMouseOut="out(this)">
							<div class="image">
								<c:if test="${type == 1}">
									<img alt="" src="${ct}${fs}${productAlbumImg.filePath}@!120x120" width="120px" height="120px;" class="img">
								</c:if>
								<c:if test="${type == 2}">
									<img src='${ctxStatic }/image/pdf.png' width='120px' height='120px;' class='img'>
								</c:if>
							</div>
							<div class="imginfo">
								<div class="name">${productAlbumImg.bak1}</div>
								<div class="cratedate">
									<fmt:formatDate value="${productAlbumImg.createDate}" pattern="yyyy/MM/dd HH:mm:ss"/>
								</div>
								<div class="size">${productAlbumImg.bak2}</div>
								<div class="id" style="display: none;">${productAlbumImg.id}</div> 
								<div class="url" style="display: none;">${productAlbumImg.filePath}</div>
							</div>
							<div class="del" id="del" val="${productAlbumImg.id}" ty="${type}"></div>
							<div class="select"></div>
						</div>
					</c:forEach>
					
				</div>
				<div class="loading" style="background:#ccc;display: none;height: 85%;opacity: 0.7;position: absolute;top: 44px; width: 100%">
						<img alt="" src="${ctxStatic}/image/loading.jpg"  style="position: absolute; left: 42%; top: 42%;">
					</div>
				<div class="footer">
					<span class="coun">${imgCount}</span>个文件
				</div>
			</div>
			<!-- 右边的内容结束-->
		</div>	
	</body>
	<script type="text/javascript">
		var count = 1;  
		var type=${productAlbum.type};
		var onSuccess="${onSuccess}";//无用
		var onSelect="${onSelect}";//选择一张图片后的，回调的父页面的函数名称
		$(function() {
			var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
			if (userAgent.indexOf("Firefox") > -1) {
				$("#upbtn1").css("margin-top","0");
		    }
			
			var bumId='${bumID}';
			if(bumId !=null){
				$("#"+bumId).parent().addClass("imgBumSelect");
			}
		});
		//点击确定按钮的事件：把当前选中的图片返回去
		$(".trueupload").click(function(){
			//查找imgs下的class,如果有delselect（被选中的），则把图片的信息获取到，否则提示选择图片
			var sel=$(".imgs").parent().parent().find("div[class='delselect']");
			if(sel.length==0){
				//alert("请选择图片");
				$.jBox.tip("请选择图片");
			}else{
				var name=$(sel).parent().find("div[class='name']").html();
				var size=$(sel).parent().find("div[class='size']").html();
				var cratedate=$(sel).parent().find("div[class='cratedate']").html();
				var url=$(sel).parent().find("div[class='url']").html();
				var id=$(sel).parent().find("div[class='id']").html();
				onSelectCallback(name,id,cratedate,url);
			}
		});
		
		//单击和双击事件
		var _time = null; 
		$(".right").delegate("div[class='imgs']",'dblclick',function(e){
			clearTimeout(_time); 
			var name=$(e.target).parent().parent().find("div[class='name']").html();
			var size=$(e.target).parent().parent().find("div[class='size']").html();
			var cratedate=$(e.target).parent().parent().find("div[class='cratedate']").html();
			var url=$(e.target).parent().parent().find("div[class='url']").html();
			var id=$(e.target).parent().parent().find("div[class='id']").html();
			onSelectCallback(name,id,cratedate,url);
		});
		$(".right").delegate("div[class='imgs']",'click',function(e){
			clearTimeout(_time);
			_time = setTimeout(function(){
			$(e.target).parent().parent().parent().parent().find("div[class='delselect']").attr("class","select");
			$(e.target).parent().parent().find("div[class='select']").attr("class","delselect");
			}, 150);
		});
		
		//根据不同的打开方式，相应的运行父窗口的方法
		function onSelectCallback(name,size,cratedate,url){
			if(window.opener){
				eval("var pFunction1=window.opener."+onSelect);
				if(pFunction1){
					pFunction1(name,size,cratedate,url);
					window.close();
					return;
				}
			}
			if(window.parent){
				eval("var pFunction2=window.parent."+onSelect);
				if(pFunction2){
					pFunction2(name,size,cratedate,url);
					top.$.jBox.close(true);
					return;
				}
			}
		}
		
		var url;
		if(window.opener){
			url=window.opener.formAction;
		}else{
			url=window.parent.formAction;
		}
		
		//上传时，如果没有选择某个相册，会给出相应的提示
		function selectbum(){
		   	var status=0;
		   	var imgBumId="";
			imgBumId=$(".ul").find(".imgBumSelect").find(".li2").attr("id");
			if(imgBumId !='undefined'){
				$(".loading").css("display","block");
				ajaxUpload(imgBumId,type);
			}else{
		   		//alert("请选择相册");
		   		$.jBox.tip("请选择相册");
		   		return false;
		   	 }
		}
		
		//上传方法
		function ajaxUpload(imgBumId,type){
	    	 $.ajaxFileUpload({  
	 	        url : '${ctxm}/common/fileupload/uploadImg.htm?imgBumId='+imgBumId+'&type='+type, //用于文件上传的服务器端请求地址  
	 	        secureuri : false, //一般设置为false  
	 	        fileElementId : 'file', 
	 	        //fileElementId : arrId,
	 	        method : 'POST',  
		        data:{format:'json'},//告诉服务器请给我返回json格式的数据，spring mvc内容协商支持本参数
		        dataType:'json',//本组件按什么格式接收服务器返回的数据,可以是json或xml等,空表示直接返回data
	 	        fileSize:5000000,//文件大小限制，可选，0 为无限制(IE浏览器不兼容) 
		        allowType:'jpg,jpeg,png,gif,bmp,pdf',//可选，限定上传文件的格式
	 	        success : function(data){ //服务器成功响应处理函数  
	 	        	if(data.length ==0){
	 	        		$.jBox.tip("上传文件格式不正确");
	 	        		$(".loading").css("display","none");
	 	        	}else{
		 	        	for(var o in data){  
			 	        	imgPath=data[o].imgPath;
			 	        	size=data[o].size;
			 	        	createDate=data[o].createDate;
			 	        	imgname=data[o].imgname;
			 	        	id=data[o].id;
			 	        	type=data[o].type;
			 	        	addImg(imgPath,size,createDate,id,imgname,type);
		 	             }
		 	        	$(".loading").css("display","none");
	 	        	}
	 	        },
	 	        error:function(e){
	 	        	//alert("上传失败");
	 	        	$.jBox.tip("上传失败");
	 	        	$(".loading").css("display","none");
	 	        }
	 	    }); 
		}
		
		//添加一个图片
		function addImg(imgPath,size,createDate,id,imgname,type){
			var img;
			if(type==2){
				img="<img src='${ctxStatic }/image/pdf.png' width='120px' height='120px;' class='img'>"
			}if(type==1){
				img="<img src='${ct}${fs}"+imgPath+"@!120x120' width='120px' height='120px;' class='img'>"
			}
			 $("<div class='imgs' onMouseOver='fun(this)' onMouseOut='out(this)'>"
				+"<div class='image'>"+img+"</div>"
				+"<div class='imginfo' style='overflow:hidden;word-break: break-all;word-wrap: break-word;'><div class='name'>"+imgname+"</div>"
				+"<div class='cratedate'>"+createDate+ "</div>"
				+"<div class='size'>"+size+"</div>"
				+"<div class='id' style='display: none;'>"+id+"</div>"
				+"<div class='url' style='display: none;'>"+imgPath+"</div></div>"
				+"<div class='del' id='del' val='"+id+"' ty='"+type+"'></div>"
				+"<div class='select'></div>"
				+"</div>").prependTo(".content");
			var coun=$(".coun").text();
			coun++;
			$(".coun").text(coun);
		}
		
		//删除图片
		$(".content").delegate("div[class='del']",'click',function(e){
			deleImg(e);
		});
		 
		//删除图片
		function deleImg(e){
			var id=$(e.target).attr("val");
			var type=$(e.target).attr("ty");
			$.ajax({
				url: "${ctxm}/common/fileupload/delete.htm?id="+id+"&type="+type,
	            type: "post",
	            data: '',
	            dataType: "json",
	            success: function(data) {
	                if(data.status == 1){
	                	$.jBox.tip("删除成功");
	                    removeImg(id);
	                }else{
	                	$.jBox.tip("删除失败");
	                }
	            }
			});
		}
		
		//移除一个图片
		function removeImg(id){
			$(".imgs").find("div[val='"+id+"']").parent().remove();
			var coun=$(".coun").text();
			coun--;
			$(".coun").text(coun);
		}
		
		//选择相册
		function selectImgBum(id,select,type){
			$(".ul").find(".imgBumSelect").removeClass("imgBumSelect");
			if(id == null){
				$("#firstBum").addClass("imgBumSelect");
			}else{
				$("#"+id).parent().addClass("imgBumSelect");
			}
			$.ajax({
				url:"${ctxm}/common/fileupload/selectBum.htm?bumId="+id+"&onSelect="+select+"&type="+type,
				type: "post",
	            data: '',
	            dataType: "json",
	            success: function(data) {
	            	$(".content").html("");
	            	if(data.length != '0'){
	 	        		$.each(data,function(n,value) {
	 	        			addImg(value.filePath,value.fileSize,value.createDate,value.id,value.bak1,type);
		 	       			$(".coun").text(data.length);
	 	        		});
	 	        	}
	            }
			});
		}
	</script>
</html>