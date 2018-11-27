/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.admin.site.dao.SiteFriendlyLinkDao;
import com.qhwl.admin.site.entity.SiteFriendlyLink;
import com.qhwl.common.persistence.Page;
import com.qhwl.common.service.CrudService2;

/**
 * 友情链接Service
 * @author ztj
 * @version 2016-08-04
 */
@Service
@Transactional(readOnly = true)
public class SiteFriendlyLinkService extends CrudService2<SiteFriendlyLinkDao, SiteFriendlyLink> {

	public SiteFriendlyLink selectById(String id) {
		return super.selectById(id);
	}
	
	public List<SiteFriendlyLink> selectByWhere(SiteFriendlyLink siteFriendlyLink) {
		return super.selectByWhere(siteFriendlyLink);
	}
	
	public Page<SiteFriendlyLink> selectByWhere(Page<SiteFriendlyLink> page, SiteFriendlyLink siteFriendlyLink) {
		return super.selectByWhere(page, siteFriendlyLink);
	}
	
	@Transactional(readOnly = false)
	public int saveOrUpdate(SiteFriendlyLink siteFriendlyLink) {
		return super.saveOrUpdate(siteFriendlyLink);
	}
	
	@Transactional(readOnly = false)
	public int deleteById(String id) {
		return super.deleteById(id);
	}
	
}