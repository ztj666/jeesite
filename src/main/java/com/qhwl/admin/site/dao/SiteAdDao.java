/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.dao;

import com.qhwl.admin.site.entity.SiteAd;
import com.qhwl.common.persistence.CrudDao2;
import com.qhwl.common.persistence.annotation.MyBatisDao;

/**
 * 广告DAO接口
 * @author 蔡龙
 * @version 2016-07-22
 */
@MyBatisDao
public interface SiteAdDao extends CrudDao2<SiteAd> {
	
	public SiteAd get(String id);
	
}