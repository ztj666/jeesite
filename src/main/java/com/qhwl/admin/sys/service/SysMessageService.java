/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.common.persistence.Page;
import com.qhwl.common.service.CrudService2;
import com.qhwl.admin.sys.entity.SysMessage;
import com.qhwl.admin.sys.dao.SysMessageDao;

/**
 * 消息管理Service
 * @author ztj
 * @version 2016-09-29
 */
@Service
@Transactional(readOnly = true)
public class SysMessageService extends CrudService2<SysMessageDao, SysMessage> {

	public SysMessage selectById(String id) {
		return super.selectById(id);
	}
	
	public List<SysMessage> selectByWhere(SysMessage sysMessage) {
		return super.selectByWhere(sysMessage);
	}
	
	public Page<SysMessage> selectByWhere(Page<SysMessage> page, SysMessage sysMessage) {
		return super.selectByWhere(page, sysMessage);
	}
	
	@Transactional(readOnly = false)
	public int saveOrUpdate(SysMessage sysMessage) {
		return super.saveOrUpdate(sysMessage);
	}
	
	@Transactional(readOnly = false)
	public int deleteById(String id) {
		return super.deleteById(id);
	}
	
}