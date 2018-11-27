/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.qhwl.admin.site.entity.SitePictureCarousel;
import com.qhwl.admin.site.service.SitePictureCarouselService;
import com.qhwl.common.config.Global;
import com.qhwl.common.persistence.Page;
import com.qhwl.common.utils.StringUtils;
import com.qhwl.common.web.BaseController;

/**
 * 轮播图片管理Controller
 * @author 张加利
 * @version 2016-07-02
 */
@Controller
@RequestMapping(value = "${adminPath}/sitecarousel/sitePictureCarousel")
public class SitePictureCarouselController extends BaseController {

	@Autowired
	private SitePictureCarouselService sitePictureCarouselService;
	
	@ModelAttribute
	public SitePictureCarousel get(@RequestParam(required=false) String id) {
		SitePictureCarousel entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sitePictureCarouselService.selectById(id);
		}
		if (entity == null){
			entity = new SitePictureCarousel();
		}
		return entity;
	}
	
	@RequiresPermissions("sitecarousel:sitePictureCarousel:view")
	@RequestMapping(value = {"list", ""})
	public String list(SitePictureCarousel sitePictureCarousel, HttpServletRequest request, HttpServletResponse response, Model model) {
		//R.saveParameter2Cache();//把进入列表页所使用的查询参数取出来，放入session，供第二次进入列表时使用
		Page<SitePictureCarousel> page = sitePictureCarouselService.selectByWhere(new Page<SitePictureCarousel>(request, response), sitePictureCarousel); 
		model.addAttribute("page", page);
		return "admin/site/sitePictureCarouselList";
	}

	@RequiresPermissions("sitecarousel:sitePictureCarousel:view")
	@RequestMapping(value = "form")
	public String form(SitePictureCarousel sitePictureCarousel, Model model) {
		model.addAttribute("sitePictureCarousel", sitePictureCarousel);
		return "admin/site/sitePictureCarouselForm";
	}

	@RequiresPermissions("sitecarousel:sitePictureCarousel:edit")
	@RequestMapping(value = "save")
	public String save(SitePictureCarousel sitePictureCarousel, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sitePictureCarousel)){
			return form(sitePictureCarousel, model);
		}
		sitePictureCarouselService.saveOrUpdate(sitePictureCarousel);
		addMessage(redirectAttributes, "保存轮播图片信息表成功");
		return "redirect:"+Global.getAdminPath()+"/sitecarousel/sitePictureCarousel.do?repage";
	}
	
	@RequiresPermissions("sitecarousel:sitePictureCarousel:edit")
	@RequestMapping(value = "delete")
	public String delete(SitePictureCarousel sitePictureCarousel, RedirectAttributes redirectAttributes) {
		sitePictureCarouselService.deleteById(sitePictureCarousel.getId());
		addMessage(redirectAttributes, "删除轮播图片信息表成功");
		return "redirect:"+Global.getAdminPath()+"/sitecarousel/sitePictureCarousel.do?repage";
	}
}