/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.qhwl.admin.sys.entity.Area;
import com.qhwl.common.persistence.TreeDao;
import com.qhwl.common.persistence.annotation.MyBatisDao;

/**
 * 区域DAO接口
 * 
 * @author Admin
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	public List<Area> selectByType(String type);
	public List<Area> selectByParentId(String parentId);
	//通过地域表id查抄名称
	public String selectAreaNameById(@Param(value="id") String id);
}
