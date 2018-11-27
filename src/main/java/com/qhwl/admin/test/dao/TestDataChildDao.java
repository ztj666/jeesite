/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.test.dao;

import com.qhwl.admin.test.entity.TestDataChild;
import com.qhwl.common.persistence.CrudDao;
import com.qhwl.common.persistence.annotation.MyBatisDao;

/**
 * 主子表生成DAO接口
 * @author Admin
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestDataChildDao extends CrudDao<TestDataChild> {
	
}