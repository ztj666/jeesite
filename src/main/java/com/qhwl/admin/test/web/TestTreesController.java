/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.test.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.qhwl.common.config.Global;
import com.qhwl.common.web.BaseController;
import com.qhwl.common.utils.StringUtils;
import com.qhwl.admin.test.entity.TestTrees;
import com.qhwl.admin.test.service.TestTreesService;

/**
 * 测试树Controller
 * @author ztj
 * @version 2016-09-13
 */
@Controller
@RequestMapping(value = "${adminPath}/test/testTrees")
public class TestTreesController extends BaseController {

	@Autowired
	private TestTreesService testTreesService;
	
	@ModelAttribute
	public TestTrees get(@RequestParam(required=false) String id) {
		TestTrees entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = testTreesService.get(id);
		}
		if (entity == null){
			entity = new TestTrees();
		}
		return entity;
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(TestTrees testTrees, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<TestTrees> list = testTreesService.findList(testTrees); 
		model.addAttribute("list", list);
		return "admin/test/testTreesList";
	}

	@RequestMapping(value = "form")
	public String form(TestTrees testTrees, Model model) {
		if (testTrees.getParent()!=null && StringUtils.isNotBlank(testTrees.getParent().getId())){
			testTrees.setParent(testTreesService.get(testTrees.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(testTrees.getId())){
				TestTrees testTreesChild = new TestTrees();
				testTreesChild.setParent(new TestTrees(testTrees.getParent().getId()));
				List<TestTrees> list = testTreesService.findList(testTrees); 
				if (list.size() > 0){
					testTrees.setSort(list.get(list.size()-1).getSort());
					if (testTrees.getSort() != null){
						testTrees.setSort(testTrees.getSort() + 30);
					}
				}
			}
		}
		if (testTrees.getSort() == null){
			testTrees.setSort(30);
		}
		model.addAttribute("testTrees", testTrees);
		return "admin/test/testTreesForm";
	}

	@RequiresPermissions("test:testTrees:edit")
	@RequestMapping(value = "save")
	public String save(TestTrees testTrees, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, testTrees)){
			return form(testTrees, model);
		}
		testTreesService.save(testTrees);
		addMessage(redirectAttributes, "保存树成功");
		return "redirect:"+Global.getAdminPath()+"/test/testTrees/?repage";
	}
	
	@RequiresPermissions("test:testTrees:edit")
	@RequestMapping(value = "delete")
	public String delete(TestTrees testTrees, RedirectAttributes redirectAttributes) {
		testTreesService.delete(testTrees);
		addMessage(redirectAttributes, "删除树成功");
		return "redirect:"+Global.getAdminPath()+"/test/testTrees/?repage";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<TestTrees> list = testTreesService.findList(new TestTrees());
		for (int i=0; i<list.size(); i++){
			TestTrees e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
}