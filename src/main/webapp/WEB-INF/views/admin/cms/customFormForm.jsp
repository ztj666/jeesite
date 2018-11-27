<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/admin/include/taglib.jsp"%>
<html>
<head>
	<title>自定义表单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/customForm.do">自定义表单列表</a></li>
		<li class="active"><a href="${ctx}/cms/customForm/form.do?id=${customForm.id}">自定义表单<shiro:hasPermission name="cms:customForm:edit">${not empty customForm.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:customForm:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="customForm" action="${ctx}/cms/customForm/save.do" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">名称：</label>
			<div class="controls">
				<form:input path="formName" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" class="input-xlarge required digits"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:customForm:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
<legend>占用下面的预先准备好的槽位</legend>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
		<tr>
			<th title="数据库字段名">列名</th>
			<th title="默认读取数据库字段备注">说明</th>
			<th title="实体对象的属性字段类型">Java类型</th>
			<th title="最大长度">长度</th>
			<th title="数据库字段名">占用</th>
			<th title="">Label</th>
			<th title="">提示语</th>
			<th title="">字段验证规则</th>
			<th title="字段在表单中显示的类型">显示表单类型</th>
			<th title="显示表单类型设置为“下拉框、复选框、点选框”时，需设置字典的类型">字典类型</th>
			<th>排序</th>
			<th title="重启一行">新行</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${slot.tableList}" var="table">
	<c:forEach items="${table.columnList}" var="column" varStatus="vs">
		<tr>
			<td nowrap>
				<input type="hidden" name="fieldList[${vs.index}].tableName" value="${table.name}"/>
				<input type="hidden" name="fieldList[${vs.index}].columnName" value="${column.name}"/>${column.name}
			</td>
			<td>
				${column.comments}
			</td>
			<td nowrap>
				${column.jdbcType}
			</td>
			<td>
				${column.maxlength}
			</td>
			<td>
				<input type="checkbox" name="fieldList[${vs.index}].use" value="1" />
			</td>
			<td>
				<input type="text" name="fieldList[${vs.index}].label" value="" maxlength="200" class="input-mini"/>
			</td>										
			<td>
				<input type="text" name="fieldList[${vs.index}].helpMsg" value="" maxlength="200" class="input-mini"/>
			</td>										
			<td>
				<select name="fieldList[${vs.index}].validation" class="required" style="width:100px;">
					<c:forEach items="${slot.ruleList}" var="rule">
					<option value="${rule.id}">${rule.name}</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select name="fieldList[${vs.index}].showType" class="required" style="width:100px;">
					<c:forEach items="${slot.showTypeList}" var="showType">
					<option value="${showType.value}">${showType.label}</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<input type="text" name="fieldList[${vs.index}].dictType" value="" maxlength="200" class="input-mini"/>
			</td>
			<td>
				<input type="text" name="fieldList[${vs.index}].sort" value="${(vs.index+1)*10}" maxlength="200" class="required input-min digits"/>
			</td>
			<td>
				<input type="checkbox" name="fieldList[${vs.index}].newRow" value="${column.name}" />
			</td>			
		</tr>
	</c:forEach>
	</c:forEach>
	</tbody>
</table>
		
	</form:form>
</body>
</html>