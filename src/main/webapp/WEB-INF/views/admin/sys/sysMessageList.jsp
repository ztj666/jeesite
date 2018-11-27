<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/admin/include/taglib.jsp"%>
<html>
<head>
	<title>消息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/sysMessage.do">消息列表</a></li>
		<shiro:hasPermission name="sys:sysMessage:edit"><li><a href="${ctx}/sys/sysMessage/form.do">消息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysMessage" action="${ctx}/sys/sysMessage.do" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>user_id：</label>
				<sys:treeselect id="user" name="user.id" value="${sysMessage.user.id}" labelName="user.name" labelValue="${sysMessage.user.name}"
					title="用户" url="/sys/office/treeData.do?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>user_id</th>
				<th>update_date</th>
				<th>remarks</th>
				<shiro:hasPermission name="sys:sysMessage:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysMessage">
			<tr>
				<td><a href="${ctx}/sys/sysMessage/form.do?id=${sysMessage.id}">
					${sysMessage.user.name}
				</a></td>
				<td>
					<fmt:formatDate value="${sysMessage.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysMessage.remarks}
				</td>
				<shiro:hasPermission name="sys:sysMessage:edit"><td>
    				<a href="${ctx}/sys/sysMessage/form.do?id=${sysMessage.id}">修改</a>
					<a href="${ctx}/sys/sysMessage/delete.do?id=${sysMessage.id}" onclick="return confirmx('确认要删除该消息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>