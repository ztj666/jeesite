/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.cms.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.admin.cms.dao.ArticleDataDao;
import com.qhwl.admin.cms.entity.ArticleData;
import com.qhwl.common.service.CrudService;

/**
 * 站点Service
 * @author Admin
 * @version 2013-01-15
 */
@Service
@Transactional(readOnly = true)
public class ArticleDataService extends CrudService<ArticleDataDao, ArticleData> {

}
