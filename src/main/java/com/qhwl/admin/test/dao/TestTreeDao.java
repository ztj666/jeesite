/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.test.dao;

import com.qhwl.admin.test.entity.TestTree;
import com.qhwl.common.persistence.TreeDao;
import com.qhwl.common.persistence.annotation.MyBatisDao;

/**
 * 树结构生成DAO接口
 * @author Admin
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestTreeDao extends TreeDao<TestTree> {
	
}