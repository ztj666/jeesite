<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/admin/include/taglib.jsp"%>
<html>
<head>
	<title>审批管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oa/testAudit.do">审批列表</a></li>
		<shiro:hasPermission name="oa:testAudit:edit"><li><a href="${ctx}/oa/testAudit/form.do">审批申请流程</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="testAudit" action="${ctx}/oa/testAudit.do" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>姓名：</label><sys:treeselect id="user" name="user.id" value="${testAudit.user.id}" labelName="user.name" labelValue="${testAudit.user.name}" 
			title="用户" url="/sys/office/treeData.do?type=3" cssStyle="width:150px" allowClear="true" notAllowSelectParent="true"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>姓名</th><th>部门</th><th>岗位职级</th><th>调整原因</th><th>申请时间</th><shiro:hasPermission name="oa:testAudit:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="testAudit">
			<tr>
				<td><a href="${ctx}/oa/testAudit/form.do?id=${testAudit.id}">${testAudit.user.name}</a></td>
				<td>${testAudit.office.name}</td>
				<td>${testAudit.post}</td>
				<td>${testAudit.content}</td>
				<td><fmt:formatDate value="${testAudit.createDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<shiro:hasPermission name="oa:testAudit:edit"><td>
    				<a href="${ctx}/oa/testAudit/form.do?id=${testAudit.id}">详情</a>
					<a href="${ctx}/oa/testAudit/delete.do?id=${testAudit.id}" onclick="return confirmx('确认要删除该审批吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>