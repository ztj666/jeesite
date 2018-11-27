<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/admin/include/taglib.jsp"%>
<html>
<head>
	<title>自定义表单管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/customForm.do">自定义表单列表</a></li>
		<shiro:hasPermission name="cms:customForm:edit"><li><a href="${ctx}/cms/customForm/form.do">自定义表单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="customForm" action="${ctx}/cms/customForm.do" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>编号：</label>
				<form:input path="id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>名称：</label>
				<form:input path="formName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>备注信息</th>
				<th>排序</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>更新时间</th>
				<shiro:hasPermission name="cms:customForm:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="customForm">
			<tr>
				<td><a href="${ctx}/cms/customForm/form.do?id=${customForm.id}">
					${customForm.formName}
				</a></td>
				<td>
					${customForm.remarks}
				</td>				
				<td>
					${customForm.sort}
				</td>
				<td>
					${customForm.createBy.name}
				</td>
				<td>
					<fmt:formatDate value="${customForm.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${customForm.updateBy.name}
				</td>
				<td>
					<fmt:formatDate value="${customForm.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>

				<shiro:hasPermission name="cms:customForm:edit"><td>
    				<a href="${ctx}/cms/customForm/form.do?id=${customForm.id}">修改</a>
					<a href="${ctx}/cms/customForm/delete.do?id=${customForm.id}" onclick="return confirmx('确认要删除该自定义表单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>