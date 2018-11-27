/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.oa.dao;

import java.util.List;

import com.qhwl.admin.oa.entity.OaNotifyRecord;
import com.qhwl.common.persistence.CrudDao;
import com.qhwl.common.persistence.annotation.MyBatisDao;

/**
 * 通知通告记录DAO接口
 * @author Admin
 * @version 2014-05-16
 */
@MyBatisDao
public interface OaNotifyRecordDao extends CrudDao<OaNotifyRecord> {

	/**
	 * 插入通知记录
	 * @param oaNotifyRecordList
	 * @return
	 */
	public int insertAll(List<OaNotifyRecord> oaNotifyRecordList);
	
	/**
	 * 根据通知ID删除通知记录
	 * @param oaNotifyId 通知ID
	 * @return
	 */
	public int deleteByOaNotifyId(String oaNotifyId);
	
}