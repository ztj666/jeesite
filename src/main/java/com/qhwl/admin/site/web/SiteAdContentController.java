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

import com.qhwl.admin.site.entity.SiteAdContent;
import com.qhwl.admin.site.service.SiteAdContentService;
import com.qhwl.common.config.Global;
import com.qhwl.common.persistence.Page;
import com.qhwl.common.utils.StringUtils;
import com.qhwl.common.web.BaseController;

/**
 * 广告内容Controller
 * @author 蔡龙
 * @version 2016-07-22
 */
@Controller
@RequestMapping(value = "${adminPath}/ad/siteAdContent")
public class SiteAdContentController extends BaseController {

	@Autowired
	private SiteAdContentService siteAdContentService;
	
	@ModelAttribute
	public SiteAdContent get(@RequestParam(required=false) String id) {
		SiteAdContent entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = siteAdContentService.selectById(id);
		}
		if (entity == null){
			entity = new SiteAdContent();
		}
		return entity;
	}
	
	@RequiresPermissions("ad:siteAdContent:view")
	@RequestMapping(value = {"list", ""})
	public String list(SiteAdContent siteAdContent, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SiteAdContent> page = siteAdContentService.selectByWhere(new Page<SiteAdContent>(request, response), siteAdContent); 
		model.addAttribute("page", page);
		return "admin/site/siteAdContentList";
	}

	@RequiresPermissions("ad:siteAdContent:view")
	@RequestMapping(value = "form")
	public String form(SiteAdContent siteAdContent, Model model) {
		model.addAttribute("siteAdContent", siteAdContent);
		return "admin/site/siteAdContentForm";
	}

	@RequiresPermissions("ad:siteAdContent:edit")
	@RequestMapping(value = "save")
	public String save(SiteAdContent siteAdContent, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, siteAdContent)){
			return form(siteAdContent, model);
		}
		siteAdContentService.saveOrUpdate(siteAdContent);
		addMessage(redirectAttributes, "保存广告内容成功");
		return "redirect:"+Global.getAdminPath()+"/ad/siteAdContent.do?repage";
	}
	
	@RequiresPermissions("ad:siteAdContent:edit")
	@RequestMapping(value = "delete")
	public String delete(SiteAdContent siteAdContent, RedirectAttributes redirectAttributes) {
		siteAdContentService.deleteById(siteAdContent.getId());
		addMessage(redirectAttributes, "删除广告内容成功");
		return "redirect:"+Global.getAdminPath()+"/ad/siteAdContent.do?repage";
	}

}