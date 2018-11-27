/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.dao;

import com.qhwl.admin.sys.entity.Office;
import com.qhwl.common.persistence.TreeDao;
import com.qhwl.common.persistence.annotation.MyBatisDao;

/**
 * 机构DAO接口
 * @author Admin
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {
	
}
