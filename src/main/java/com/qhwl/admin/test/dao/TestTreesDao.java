/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.test.dao;

import com.qhwl.common.persistence.TreeDao;
import com.qhwl.common.persistence.annotation.MyBatisDao;
import com.qhwl.admin.test.entity.TestTrees;

/**
 * 测试树DAO接口
 * @author ztj
 * @version 2016-09-13
 */
@MyBatisDao
public interface TestTreesDao extends TreeDao<TestTrees> {
	
}