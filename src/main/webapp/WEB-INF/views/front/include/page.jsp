<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.qhwl.common.persistence.Page"%>
<!-- 分页导航start   页面model中的变量名称为 page-->
<div id="pager_div_1" class="pkg_page" ><%Page page_inner=(Page)request.getAttribute("page");if(page_inner==null){page_inner=new Page();}%>
	<%if (page_inner.getPageNo() == page_inner.getFirst()) {// 如果是首页,"上一页"不可点击%>
		<a href='javascript:;' class='up up_nocurrent'>上一页</a>
	<%} else {// 如果不是首页,"上一页"可点击   pageURL+prev%>
		<a href='<%=(page_inner.getPageURL()+page_inner.getPrev())%>' class='up'>上一页</a>
	<%}
	int begin = page_inner.getPageNo() - (page_inner.getLength() / 2);
	if (begin < page_inner.getFirst()) {
		begin = page_inner.getFirst();
	}
	int end = begin + page_inner.getLength() - 1;
	if (end >= page_inner.getLast()) {
		end = page_inner.getLast();
		begin = end - page_inner.getLength() + 1;
		if (begin < page_inner.getFirst()) {
			begin = page_inner.getFirst();
		}
	}
	//在循环中生成 左边的页码。slider为1时，作用就是“首页”
	if (begin > page_inner.getFirst()) {
		int i = 0;
		for (i = page_inner.getFirst(); i < page_inner.getFirst() + page_inner.getSlider() && i < begin; i++) {
		%>
		<a href="<%= (page_inner.getPageURL() + i) %>"><%= (i + 1 - page_inner.getFirst()) %></a>
		<%}
		if (i < begin) {%>
		<a href="javascript:;" class="disabled">...</a>
		<%}
	}
	//在循环中生成 中间的页码，如当前是第50页，46，47，48，49，50，51，52，53，54，并且50页不可点击
	for (int i = begin; i <= end; i++) {
		if (i == page_inner.getPageNo()) {
		%>
		<a href="" class="current"><%=( i + 1 - page_inner.getFirst())%></a>
		<% } else {%>
		<a href="<%=(page_inner.getPageURL()+i)%>" ><%=(i + 1 - page_inner.getFirst())%></a>
		<% }
	}
	if (page_inner.getLast() - end > page_inner.getSlider()) {
	%>
		<a href="javascript:;" class="disabled">...</a>
	<% 
		end = page_inner.getLast() - page_inner.getSlider();
	}
	//在循环中生成 右边的页码。slider为1时，作用就是“尾页”
	for (int i = end + 1; i <= page_inner.getLast(); i++) {
	%>
		<a href="<%=(page_inner.getPageURL()+i)%>" ><%=(i + 1 - page_inner.getFirst())%></a>
	<%}if (page_inner.getPageNo() == page_inner.getLast()) {// 如果是尾页,"下一页"不可点击%>
		<a href='javascript:;' class='down up_nocurrent'>下一页</a>
	<%} else {// 如果不是尾页,"下一页"可点击%>
		<a href='<%=(page_inner.getPageURL()+page_inner.getNext()) %>' class='down'>下一页</a>
	<%}%>
	<span class="pkg_pagevalue">
		到<input type="text" id="iptPageTxt" class="pkg_page_num" href="${page.pageURL}" value=""
		onkeypress="var e157=window.event||this;var c456=e157.keyCode||e157.which;if(c456==13)window.location.href=this.getAttribute('href')+(this.value)">
		<span>页</span>
		<a id="iptPageSubmit" class="pkg_page_submit" href="javascript:;" 
		onclick="var input848=document.getElementById('iptPageTxt');if(input848.value==''){return;}window.location.href=input848.getAttribute('href')+input848.value">确定</a>
	</span>
</div>
<!-- 分页导航end -->