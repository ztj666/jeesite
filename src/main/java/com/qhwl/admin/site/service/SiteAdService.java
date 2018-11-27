/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.admin.site.dao.SiteAdDao;
import com.qhwl.admin.site.entity.SiteAd;
import com.qhwl.common.persistence.Page;
import com.qhwl.common.service.CrudService2;

/**
 * 广告Service
 * @author 蔡龙
 * @version 2016-07-22
 */
@Service
@Transactional(readOnly = true)
public class SiteAdService extends CrudService2<SiteAdDao, SiteAd> {
	@Autowired
	private SiteAdDao siteAdDao;
	
	public SiteAd get(String id) {
		return siteAdDao.get(id);
	}

	public SiteAd selectById(String id) {
		return super.selectById(id);
	}
	
	public List<SiteAd> selectByWhere(SiteAd siteAd) {
		return super.selectByWhere(siteAd);
	}
	
	public Page<SiteAd> selectByWhere(Page<SiteAd> page, SiteAd siteAd) {
		return super.selectByWhere(page, siteAd);
	}
	
	@Transactional(readOnly = false)
	public int saveOrUpdate(SiteAd siteAd) {
		return super.saveOrUpdate(siteAd);
	}
	
	@Transactional(readOnly = false)
	public int deleteById(String id) {
		return super.deleteById(id);
	}
	
}