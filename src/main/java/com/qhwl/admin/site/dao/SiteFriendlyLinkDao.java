/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.dao;

import com.qhwl.admin.site.entity.SiteFriendlyLink;
import com.qhwl.common.persistence.CrudDao2;
import com.qhwl.common.persistence.annotation.MyBatisDao;

/**
 * 友情链接DAO接口
 * @author ztj
 * @version 2016-08-04
 */
@MyBatisDao
public interface SiteFriendlyLinkDao extends CrudDao2<SiteFriendlyLink> {
	
}