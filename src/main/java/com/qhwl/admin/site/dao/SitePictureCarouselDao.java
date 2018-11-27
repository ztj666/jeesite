/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.dao;

import java.util.List;

import com.qhwl.admin.site.entity.SitePictureCarousel;
import com.qhwl.common.persistence.CrudDao2;
import com.qhwl.common.persistence.annotation.MyBatisDao;

/**
 * 轮播图片管理DAO接口
 * @author 张加利
 * @version 2016-07-02
 */
@MyBatisDao
public interface SitePictureCarouselDao extends CrudDao2<SitePictureCarousel> {
	 /**
     * ryl
     * @description 积分商城首页轮播图片提取
     * @return
     */
	List<SitePictureCarousel> findScoreStorePic();
}