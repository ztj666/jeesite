/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.admin.site.dao.SitePictureCarouselDao;
import com.qhwl.admin.site.entity.SitePictureCarousel;
import com.qhwl.common.persistence.Page;
import com.qhwl.common.service.CrudService2;

/**
 * 轮播图片管理Service
 * @author 张加利
 * @version 2016-07-02
 */
@Service
@Transactional(readOnly = true)
public class SitePictureCarouselService extends CrudService2<SitePictureCarouselDao, SitePictureCarousel> {
@Autowired
private SitePictureCarouselDao sitePictureCarouselDao;
	public SitePictureCarousel selectById(String id) {
		return super.selectById(id);
	}
	
	public List<SitePictureCarousel> selectByWhere(SitePictureCarousel sitePictureCarousel) {
		return super.selectByWhere(sitePictureCarousel);
	}
	
	public Page<SitePictureCarousel> selectByWhere(Page<SitePictureCarousel> page, SitePictureCarousel sitePictureCarousel) {
		return super.selectByWhere(page, sitePictureCarousel);
	}
	
	@Transactional(readOnly = false)
	public int saveOrUpdate(SitePictureCarousel sitePictureCarousel) {
		return super.saveOrUpdate(sitePictureCarousel);
	}
	
	@Transactional(readOnly = false)
	public int deleteById(String id) {
		return super.deleteById(id);
	}
    /**
     * ryl
     * @description 积分商城首页轮播图片提取
     * @return
     */
	public List<SitePictureCarousel> findScoreStorePic() {
		return sitePictureCarouselDao.findScoreStorePic();
	}
	
}