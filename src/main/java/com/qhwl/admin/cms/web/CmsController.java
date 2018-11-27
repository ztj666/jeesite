/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.cms.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qhwl.admin.cms.service.CategoryService;
import com.qhwl.common.web.BaseController;

/**
 * 内容管理Controller
 * @author Admin
 * @version 2013-4-21
 */
@Controller
@RequestMapping(value = "${adminPath}/cms")
public class CmsController extends BaseController {

	@Autowired
	private CategoryService categoryService;
	
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "")
	public String index() {
		return "admin/cms/cmsIndex";
	}
	
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "tree")
	public String tree(Model model) {
		model.addAttribute("categoryList", categoryService.findByUser(true, null));
		return "admin/cms/cmsTree";
	}
	
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "none")
	public String none() {
		return "admin/cms/cmsNone";
	}

}
