/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.web;

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

import com.qhwl.common.config.Global;
import com.qhwl.common.persistence.Page;
import com.qhwl.common.web.BaseController;
import com.qhwl.common.utils.StringUtils;
import com.qhwl.admin.sys.entity.SysMessage;
import com.qhwl.admin.sys.service.SysMessageService;

/**
 * 消息管理Controller
 * @author ztj
 * @version 2016-09-29
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/sysMessage")
public class SysMessageController extends BaseController {

	@Autowired
	private SysMessageService sysMessageService;
	
	@ModelAttribute
	public SysMessage get(@RequestParam(required=false) String id) {
		SysMessage entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysMessageService.selectById(id);
		}
		if (entity == null){
			entity = new SysMessage();
		}
		return entity;
	}
	
	@RequiresPermissions("sys:sysMessage:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysMessage sysMessage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysMessage> page = sysMessageService.selectByWhere(new Page<SysMessage>(request, response), sysMessage); 
		model.addAttribute("page", page);
		return "admin/sys/sysMessageList";
	}

	@RequiresPermissions("sys:sysMessage:view")
	@RequestMapping(value = "form")
	public String form(SysMessage sysMessage, Model model) {
		model.addAttribute("sysMessage", sysMessage);
		return "admin/sys/sysMessageForm";
	}

	@RequiresPermissions("sys:sysMessage:edit")
	@RequestMapping(value = "save")
	public String save(SysMessage sysMessage, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysMessage)){
			return form(sysMessage, model);
		}
		sysMessageService.saveOrUpdate(sysMessage);
		addMessage(redirectAttributes, "保存消息成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysMessage.do?repage";
	}
	
	@RequiresPermissions("sys:sysMessage:edit")
	@RequestMapping(value = "delete")
	public String delete(SysMessage sysMessage, RedirectAttributes redirectAttributes) {
		sysMessageService.deleteById(sysMessage.getId());
		addMessage(redirectAttributes, "删除消息成功");
		return "redirect:"+Global.getAdminPath()+"/sys/sysMessage.do?repage";
	}

}