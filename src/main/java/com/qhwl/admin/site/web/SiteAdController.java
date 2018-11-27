/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.qhwl.admin.site.entity.SiteAd;
import com.qhwl.admin.site.entity.SiteAdContent;
import com.qhwl.admin.site.service.SiteAdContentService;
import com.qhwl.admin.site.service.SiteAdService;
import com.qhwl.common.config.Global;
import com.qhwl.common.persistence.Page;
import com.qhwl.common.utils.StringUtils;
import com.qhwl.common.web.BaseController;

/**
 * 广告Controller
 * @author 蔡龙
 * @version 2016-07-22
 */
@Controller
@RequestMapping(value = "${adminPath}/ad/siteAd")
public class SiteAdController extends BaseController {

	@Autowired
	private SiteAdService siteAdService;
	
	@Autowired
	private SiteAdContentService siteAdContentService;
	
	@ModelAttribute
	public SiteAd get(@RequestParam(required=false) String id) {
		SiteAd entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = siteAdService.selectById(id);
		}
		if (entity == null){
			entity = new SiteAd();
		}
		return entity;
	}
	
	@RequiresPermissions("ad:siteAd:view")
	@RequestMapping(value = {"list", ""})
	public String list(SiteAd siteAd, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SiteAd> page = siteAdService.selectByWhere(new Page<SiteAd>(request, response), siteAd); 
		model.addAttribute("page", page);
		return "admin/site/siteAdList";
	}

	@RequiresPermissions("ad:siteAd:view")
	@RequestMapping(value = "form")
	public String form(HttpServletRequest request, HttpServletResponse response, Model model) {
		String id=request.getParameter("id");
		if(id==null || "".equals(id)){
			SiteAd siteAd = new SiteAd();
			model.addAttribute("siteAd", siteAd);
			return "admin/site/siteAdForm";
		}else{
			//查询广告内容
			SiteAd siteAd = siteAdService.selectById(id);
			SiteAdContent siteAdContent1 = new SiteAdContent();
			siteAdContent1.setAdid(id);
			siteAdContent1.setStatus("1");
			List<SiteAdContent> list =  siteAdContentService.selectByWhere(siteAdContent1);
			SiteAdContent siteAdContent = list.get(0);
			//查询广告列表
			SiteAdContent siteAdContent2 = new SiteAdContent();
			siteAdContent2.setAdid(id);
			siteAdContent2.setStatus("0");
			Page<SiteAdContent> page = siteAdContentService.selectByWhere(new Page<SiteAdContent>(request, response), siteAdContent2); 
			model.addAttribute("page", page);
			model.addAttribute("siteAd", siteAd);
			model.addAttribute("siteAdContent", siteAdContent);
			return "admin/site/siteAdForm";
		}
	}

	@RequiresPermissions("ad:siteAd:edit")
	@RequestMapping(value = "save")
	public String save(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		String id=request.getParameter("id");
		String name=request.getParameter("name");
		String content=request.getParameter("content");
		if(!(id==null || "".equals(id))){
			//查找原来广告内容表中的有效数据并且修改未删除状态
			SiteAdContent siteAdContent1 = new SiteAdContent();
			siteAdContent1.setAdid(id);
			siteAdContent1.setStatus("1");
			List<SiteAdContent> siteAdContent2 =  siteAdContentService.selectByWhere(siteAdContent1);
			SiteAdContent siteAdContent3 = siteAdContent2.get(0);
			siteAdContent3.setStatus("0");
			siteAdContentService.saveOrUpdate(siteAdContent3);			
		}
		//如果有改标题名字的，进入的方法进行更改名字或者增加		
		SiteAd siteAd = new SiteAd();
		siteAd.setName(name);
		siteAd.setId(id);
		siteAdService.saveOrUpdate(siteAd);
		//添加一条新数据，来记录新的广告内容
		SiteAdContent siteAdContent = new SiteAdContent();
		siteAdContent.setAdid(siteAd.getId());
		siteAdContent.setContent(StringEscapeUtils.unescapeHtml4(content));
		siteAdContent.setStatus("1");
		siteAdContentService.saveOrUpdate(siteAdContent);
		addMessage(redirectAttributes, "保存广告成功");
		return "redirect:"+Global.getAdminPath()+"/ad/siteAd.do?repage";
	}
	
	@RequiresPermissions("ad:siteAd:edit")
	@RequestMapping(value = "delete")
	public String delete(SiteAd siteAd, RedirectAttributes redirectAttributes) {
		siteAdService.deleteById(siteAd.getId());
		addMessage(redirectAttributes, "删除广告成功");
		return "redirect:"+Global.getAdminPath()+"/ad/siteAd.do?repage";
	}

}