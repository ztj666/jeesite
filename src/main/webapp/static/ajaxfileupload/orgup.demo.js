var url = URL; //文件上传URL路径 
				$.ajaxFileUpload({
					url : ctxw + "/mine/fileUpload.htm",
					secureuri : false,
					fileElementId : "headImage", //file的id 
					dataType : "json", //返回数据类型为文本 
					success : function(data) {
						alert(data);
					}
				})