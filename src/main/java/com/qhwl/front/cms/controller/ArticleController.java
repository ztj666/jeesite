package com.qhwl.front.cms.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qhwl.admin.cms.entity.Article;
import com.qhwl.admin.cms.entity.ArticleData;
import com.qhwl.admin.cms.entity.Category;
import com.qhwl.admin.cms.entity.Site;
import com.qhwl.admin.cms.service.ArticleDataService;
import com.qhwl.admin.cms.service.ArticleService;
import com.qhwl.admin.cms.service.CategoryService;
import com.qhwl.admin.site.entity.SitePictureCarousel;
import com.qhwl.admin.site.service.SitePictureCarouselService;
import com.qhwl.common.persistence.Page;

/**
 * 前台文章Controller
 * @author 蔡龙
 * @version 2016-7-23
 */
@Controller
@RequestMapping(value = "${frontPath}/article")
public class ArticleController {
	
	@Autowired 
	private SitePictureCarouselService sitePictureCarouselService;
	@Autowired 
	private ArticleService articleService;
	@Autowired
	private ArticleDataService articleDataService;
	@Autowired
	private CategoryService categoryService;
	/**
	 * 文章首页
	 */
	@RequestMapping(value = "index")
	public String index(HttpServletRequest request,Model model) {
		List<Category> list1=categoryService.findByParentId("1", "2");
        //判断是否传回来id		
		String id=request.getParameter("id");
		if(id==null){
			id=list1.get(0).getId();
		}
		Page<Article> page = new Page<Article>();
		Category category = new Category(id, new Site("2"));
		category.setParentIds("1");
		Article article = new Article(category);
		//获取是否显示图片的新闻
//		article.setImage(Global.YES);
		page.setOrderBy("a.update");
		article.setDelFlag(Article.DEL_FLAG_NORMAL);
		page = articleService.findPage(page, article, false);

		SitePictureCarousel sitePictureCarousel = new SitePictureCarousel();
		sitePictureCarousel.setType("3");
		sitePictureCarousel.setStatus("1");
		List<SitePictureCarousel> spc = sitePictureCarouselService.selectByWhere(sitePictureCarousel);
//      控制轮播焦点图的数量
//		if(null == spc || spc.size() ==0){
//			
//		}else if(spc.size()>3){
//    		List<SitePictureCarousel> list = spc.subList(0, 3);
//    		model.addAttribute("list", list);
//		}else if(spc.size()<=3){
//			model.addAttribute("list", spc);
//		}
		model.addAttribute("list", spc);
		model.addAttribute("id", id);
		model.addAttribute("page", page);
		return "/front/cms/themes/basic/articleList";
	}
	
	
	@RequestMapping(value = "content")
	public String content(HttpServletRequest request,Model model){
        String id=request.getParameter("id");
        ArticleData articleData = articleDataService.get(id);
        String relation=articleData.getRelation();
        if(relation==null || "".equals(relation)){
        	model.addAttribute("id", id);
        	return "/front/cms/themes/basic/articleContent";
        }else{
	        List<Object> list2 = new ArrayList<>();
	        String[] str = relation.split(",");
	        for(String s : str){
	        	list2.add(s);
	        }
	        List<Article> list3=articleService.selectByIdIn(list2);
	        model.addAttribute("id", id);
	        model.addAttribute("list3", list3);
			return "/front/cms/themes/basic/articleContent";
        }
	}

}
