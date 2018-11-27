/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.admin.sys.dao.AreaDao;
import com.qhwl.admin.sys.entity.Area;
import com.qhwl.admin.sys.utils.UserUtils;
import com.qhwl.common.service.TreeService;

/**
 * 区域Service
 * @author Admin
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class AreaService extends TreeService<AreaDao, Area> {
	@Autowired
	private AreaDao areaDao;

	public List<Area> selectByType(String type){
		return areaDao.selectByType(type);
	}
	public List<Area> selectByParentId(String parentId){
		return areaDao.selectByParentId(parentId);
	}
	public List<Area> findAll(){
		return UserUtils.getAreaList();
	}

	@Transactional(readOnly = false)
	public void save(Area area) {
		super.save(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(Area area) {
		super.delete(area);
		UserUtils.removeCache(UserUtils.CACHE_AREA_LIST);
	}
	//通过地域表id查抄名称
	public String selectAreaNameById(String id) {
		return areaDao.selectAreaNameById(id);
	}
	
}
