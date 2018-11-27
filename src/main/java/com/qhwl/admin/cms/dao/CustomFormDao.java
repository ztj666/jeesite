/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.cms.dao;

import com.qhwl.admin.cms.entity.CustomForm;
import com.qhwl.common.persistence.CrudDao2;
import com.qhwl.common.persistence.annotation.MyBatisDao;

/**
 * 自定义表单DAO接口
 * @author 赵磊
 * @version 2016-06-03
 */
@MyBatisDao
public interface CustomFormDao extends CrudDao2<CustomForm> {
	
}