/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.dao;

import java.util.List;

import com.qhwl.admin.sys.entity.Dict;
import com.qhwl.common.persistence.CrudDao;
import com.qhwl.common.persistence.annotation.MyBatisDao;

/**
 * 字典DAO接口
 * @author Admin
 * @version 2014-05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	public List<String> findTypeList(Dict dict);
	//按类型查询字典记录  并排序  升序 
	public List<Dict> selectList(Dict dict);
	//按标签名查询字典记录
	public Dict selectByLabel(String label);
	//按数据值查询字典记录
	public Dict selectByValue(String value);
}
