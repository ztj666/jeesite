/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.cms.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.admin.cms.dao.CustomFormDao;
import com.qhwl.admin.cms.entity.CustomForm;
import com.qhwl.common.persistence.Page;
import com.qhwl.common.service.CrudService2;

/**
 * 自定义表单Service
 * @author 赵磊
 * @version 2016-06-03
 */
@Service
@Transactional(readOnly = true)
public class CustomFormService extends CrudService2<CustomFormDao, CustomForm> {

	public CustomForm selectById(String id) {
		return super.selectById(id);
	}
	
//	public List<CustomForm> selectByWhere(CustomForm customForm) {
//		return super.selectByWhere(customForm);
//	}
	
	public Page<CustomForm> selectByWhere(Page<CustomForm> page, CustomForm customForm) {
		return super.selectByWhere(page, customForm);
	}
	
	@Transactional(readOnly = false)
	public int saveOrUpdate(CustomForm customForm) {
		return super.saveOrUpdate(customForm);
	}
	
	@Transactional(readOnly = false)
	public int deleteById(String id) {
		return super.deleteById(id);
	}
	
}