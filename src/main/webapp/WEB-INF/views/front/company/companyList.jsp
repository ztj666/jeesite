<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/member/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="decorator" content="defaultFront" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>公司列表</title>
<link href="${ctxStatic }/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctxStatic }/css/caigoulist.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	$(document).ready(function(){   
		$("#searchBtn").click(function(){
			document.getElementById("formid").submit();
		});
	});
</script>
<script type="text/javascript">
function selectCity(obj) {
	$('select[name=city]').empty();
	var value = $(obj).find("option:selected").val();
	if(value=="-1"){
		$('select[name=city]').empty();
		var msg = "<option value=\"" + "-2" + "\">" + "====请选择===="+ "</option>";
		$('select[name=city]').append(msg);
	}else{
		$.get(ctxf + "/user/selectCity2.htm", {parentId:value}, function(data, status) {
			for (var i = 0; i < data.length; i++) {
				var area=data[i];
				var msg = "<option value=\"" + area.id + "\">" + area.name+ "</option>";
				$('select[name=city]').append(msg);
			}
		});
	}
}


</script>
</head>
<body>
<div class="clear mhei"></div>
<div class=" wrap">
<form id="formid" action="${ctxf }/company/index.htm" method="post">
<div class="caigou-xh">
<p class="gongyin_sear">
     <span> <i>供应商名称： </i> <input class="inp_yu" type="text" name="spBreed" id="spBreed" value="${spBreed}"> </span>
     <span> <i>地区 ： </i>    
       <select name="province" id="J_MobileArea" aria-label="省" class="diqu-sf" onchange="selectCity(this)">
		<option value="-1" >====请选择====</option>
		<c:forEach items="${provinceList }" var="province">
			<option  value="${province.id}" ${province.id==pr?"selected":" "}>${province.name }</option>
		</c:forEach>
	   </select> 
	   <select name="city" id="J_MobileArea" aria-label="市" class="diqu-sf">
	     <c:choose>
	        <c:when test="${ci=='-2' || ci==null}">
	           <option value="-2" >====请选择====</option>
	       </c:when>
	       <c:otherwise>
	          <c:forEach items="${cityList }" var="city">
			   <option  value="${city.id}" ${city.id==ci?"selected":" "}>${city.name }</option>
	         </c:forEach>
	       </c:otherwise>
	     </c:choose>
	    </select>
      </span>
      <input class="submit_btn" type="button" value="搜 索 " id="searchBtn"  />
</p>
</div>
</form>
<div class=" clear caigou-shuai"><span>采购信息列表</span><span class="caigou-shuliang">共搜索到<em class="red">${page.count }</em>条信息</span>
<span class="caigou-shijian"></span>
每页显示：<em class="tiaoshu"><a href="${ctxf }/company/index.htm?tiaoshu=20&spBreed=${spBreed}&province=${province.id}&city=${city.id}">20条</a></em>
<em class="tiaoshu4"><a href="${ctxf }/company/index.htm?tiaoshu=40&spBreed=${spBreed}&province=${province.id}&city=${city.id}">40条</a></em>
<em class="tiaoshu4"><a href="${ctxf }/company/index.htm?tiaoshu=60&spBreed=${spBreed}&province=${province.id}&city=${city.id}">60条</a></em></div>
</div>
</div>
<div class=" clear mhei"></div>
<div class="wrap gongsilieb">
<table border="0" cellspacing="0" cellpadding="0" width="1198">
  <tr>
    <th width="300" scope="col">供应商</th>
    <th width="150" scope="col">省</th>
    <th width="150" scope="col">地区</th>
    <th scope="col">&nbsp;</th>
  </tr>
<c:forEach items="${page.list}" var="memberCompany">
  <c:if test="${memberCompany.comName!=null}">
     <tr>
	    <td>${memberCompany.comName}</td>
	    <td>${memberCompany.memberUser.area1.name}</td>
	    <td>${memberCompany.memberUser.area2.name}</td>
	    <td>
	     <c:choose>
	       <c:when test="${memberCompany.memberUser.memberRank==10}">
	       </c:when>
	       <c:otherwise>
	           <a href="${ctxf}/shop/${memberCompany.memId}/index.htm">进入店铺</a>
	       </c:otherwise>
	     </c:choose>
	    </td>
    </tr>
  </c:if>
</c:forEach>
</table>
</div>
<div class="clear mhei"></div>
<div class="wrap">
<%@ include file="/WEB-INF/views/front/include/page.jsp"%>
</div>
</body>
</html>