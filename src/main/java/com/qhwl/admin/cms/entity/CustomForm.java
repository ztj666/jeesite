/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.cms.entity;

import org.hibernate.validator.constraints.Length;

import com.qhwl.common.persistence.DataEntity;

import javax.validation.constraints.NotNull;

/**
 * 自定义表单Entity
 * @author 赵磊
 * @version 2016-06-03
 */
public class CustomForm extends DataEntity<CustomForm> {
	
	private static final long serialVersionUID = 1L;
	private String formName;		// 名称
	private Integer sort;		// 排序
	private String formXml;		// 表单的数据结构
	
	public CustomForm() {
		super();
	}

	public CustomForm(String id){
		super(id);
	}

	@Length(min=1, max=100, message="名称长度必须介于 1 和 100 之间")
	public String getFormName() {
		return formName;
	}

	public void setFormName(String formName) {
		this.formName = formName;
	}
	
	@NotNull(message="排序不能为空")
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	public String getFormXml() {
		return formXml;
	}

	public void setFormXml(String formXml) {
		this.formXml = formXml;
	}
	
}