package com.qhwl.front.helpMenu.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qhwl.admin.site.entity.SiteFriendlyLink;
import com.qhwl.admin.site.service.SiteFriendlyLinkService;

@Controller
@RequestMapping(value = "${frontPath}/helpMenu")
public class HelpMenuController {
	
	@Autowired
	private SiteFriendlyLinkService friendlyService;
    
	@RequestMapping(value = "helpMenu")
	public String helpMenu(HttpServletRequest request, HttpServletResponse response, Model model) {
	    String gid=request.getParameter("gid");
	    String cid=request.getParameter("cid");
	    if(("767616356853809152").equals(gid)){
	    	model.addAttribute("friendlyLink",friendlyService.selectAll(new SiteFriendlyLink()));
	    }
	    model.addAttribute("gid", gid);
	    model.addAttribute("cid", cid);
		return "front/helpMenu/helpMenu";
		
	}
	
}
