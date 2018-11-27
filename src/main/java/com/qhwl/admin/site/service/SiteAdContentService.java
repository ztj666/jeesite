/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.admin.site.dao.SiteAdContentDao;
import com.qhwl.admin.site.entity.SiteAdContent;
import com.qhwl.common.persistence.Page;
import com.qhwl.common.service.CrudService2;

/**
 * 广告内容Service
 * @author 蔡龙
 * @version 2016-07-22
 */
@Service
@Transactional(readOnly = true)
public class SiteAdContentService extends CrudService2<SiteAdContentDao, SiteAdContent> {

	public SiteAdContent selectById(String id) {
		return super.selectById(id);
	}
	
	public List<SiteAdContent> selectByWhere(SiteAdContent siteAdContent) {
		return super.selectByWhere(siteAdContent);
	}
	
	public Page<SiteAdContent> selectByWhere(Page<SiteAdContent> page, SiteAdContent siteAdContent) {
		return super.selectByWhere(page, siteAdContent);
	}
	
	@Transactional(readOnly = false)
	public int saveOrUpdate(SiteAdContent siteAdContent) {
		return super.saveOrUpdate(siteAdContent);
	}
	
	@Transactional(readOnly = false)
	public int deleteById(String id) {
		return super.deleteById(id);
	}
	
}