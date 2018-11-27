/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.dao;

import com.qhwl.common.persistence.CrudDao2;
import com.qhwl.common.persistence.annotation.MyBatisDao;
import com.qhwl.admin.sys.entity.SysMessage;

/**
 * 消息管理DAO接口
 * @author ztj
 * @version 2016-09-29
 */
@MyBatisDao
public interface SysMessageDao extends CrudDao2<SysMessage> {
	
}