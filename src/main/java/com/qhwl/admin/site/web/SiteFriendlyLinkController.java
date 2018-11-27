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

import com.qhwl.admin.site.entity.SiteFriendlyLink;
import com.qhwl.admin.site.service.SiteFriendlyLinkService;
import com.qhwl.common.config.Global;
import com.qhwl.common.persistence.Page;
import com.qhwl.common.utils.StringUtils;
import com.qhwl.common.web.BaseController;
import com.qhwl.common.web.R;

/**
 * 友情链接Controller
 * @author ztj
 * @version 2016-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/site/siteFriendlyLink")
public class SiteFriendlyLinkController extends BaseController {

	@Autowired
	private SiteFriendlyLinkService siteFriendlyLinkService;
	
	@ModelAttribute
	public SiteFriendlyLink get(@RequestParam(required=false) String id) {
		SiteFriendlyLink entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = siteFriendlyLinkService.selectById(id);
		}
		if (entity == null){
			entity = new SiteFriendlyLink();
		}
		return entity;
	}
	
	@RequiresPermissions("site:siteFriendlyLink:view")
	@RequestMapping(value = {"list", ""})
	public String list(SiteFriendlyLink siteFriendlyLink, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SiteFriendlyLink> page = siteFriendlyLinkService.selectByWhere(new Page<SiteFriendlyLink>(request, response), siteFriendlyLink); 
		model.addAttribute("page", page);
		return "admin/site/siteFriendlyLinkList";
	}

	@RequiresPermissions("site:siteFriendlyLink:view")
	@RequestMapping(value = "form")
	public String form(SiteFriendlyLink siteFriendlyLink, Model model) {
		model.addAttribute("siteFriendlyLink", siteFriendlyLink);
		return "admin/site/siteFriendlyLinkForm";
	}

	@RequiresPermissions("site:siteFriendlyLink:edit")
	@RequestMapping(value = "save")
	public String save(SiteFriendlyLink siteFriendlyLink, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, siteFriendlyLink)){
			return form(siteFriendlyLink, model);
		}
		siteFriendlyLinkService.saveOrUpdate(siteFriendlyLink);
		addMessage(redirectAttributes, "保存链接成功");
		return "redirect:"+Global.getAdminPath()+"/site/siteFriendlyLink.do?repage";
	}
	
	@RequiresPermissions("site:siteFriendlyLink:edit")
	@RequestMapping(value = "delete")
	public String delete(SiteFriendlyLink siteFriendlyLink, RedirectAttributes redirectAttributes) {
		siteFriendlyLinkService.deleteById(siteFriendlyLink.getId());
		addMessage(redirectAttributes, "删除链接成功");
		return "redirect:"+Global.getAdminPath()+"/site/siteFriendlyLink.do?repage";
	}

}