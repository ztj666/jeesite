//package com.qhwl.common.fileupload;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.apache.shiro.authz.annotation.RequiresPermissions;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.qhwl.admin.product.entity.ProductAlbum;
//import com.qhwl.admin.product.entity.ProductAlbumImg;
//import com.qhwl.admin.product.entity.ProductAlbumPdf;
//import com.qhwl.admin.product.service.ProductAlbumImgService;
//import com.qhwl.admin.product.service.ProductAlbumPdfService;
//import com.qhwl.admin.product.service.ProductAlbumService;
//import com.qhwl.common.fileStorage.FileStorage;
//import com.qhwl.common.fileStorage.FileStorageFcatory;
//import com.qhwl.common.mapper.JsonMapper;
//import com.qhwl.common.persistence.Page;
//import com.qhwl.common.utils.FileSizeHelper;
//import com.qhwl.common.web.BaseController;
//import com.qhwl.front.member.util.LoginUtil;
//
///**
// * 文件上传Controller
// * @author FXX
// */
//
//@Controller
//public class FileUploadController  extends BaseController{
//	
//	@Autowired
//	private ProductAlbumService productAlbumService;
//	@Autowired
//	private ProductAlbumImgService productAlbumImgService;
//	@Autowired
//	private ProductAlbumPdfService productAlbumPdfService;
//	/**
//	 * 管理后台上传,要求登陆后可上：@RequiresPermissions("user")
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	@RequiresPermissions("user")
//	@RequestMapping(value="${adminPath}/common/fileupload/index")
//	public String index1(ProductAlbumImg productAlbumImg, ProductAlbum productAlbum,HttpServletRequest request, HttpServletResponse response, Model model) {
//		return index3(productAlbumImg,productAlbum,request,response,model);
//	}
//	/**
//	 * 
//	 * 会员中心上传，/member/* 会被会员中心登陆拦截器拦截
//	 * @param request
//	 * @param response
//	 * @param model
//	 * @return
//	 */
//	//@ResponseBody
//	@RequestMapping(value="/member/common/fileupload/index")
//	public String index2(ProductAlbumImg productAlbumImg, ProductAlbum productAlbum, HttpServletRequest request, HttpServletResponse response, Model model) {
//		return index3(productAlbumImg,productAlbum,request,response,model);
//	}
//	
//	private String index3(ProductAlbumImg productAlbumImg, ProductAlbum productAlbum, HttpServletRequest request, HttpServletResponse response, Model model) {
//		String onSuccess=request.getParameter("onSuccess");
//		String onSelect=request.getParameter("onSelect");
//		String id=request.getParameter("id");
//		String json="";
//		model.addAttribute("isClose", request.getParameter("isClose"));
//		productAlbum.setMemId(LoginUtil.getLoginUser(request).getId());
//		Page<ProductAlbum> bumpage = productAlbumService.selectByWhere(new Page<ProductAlbum>(request, response), productAlbum);
//		HttpSession session=request.getSession();
//		if(productAlbum.getType()!="" && productAlbum.getType()!=null ){
//			if(productAlbum.getType().equals("1")){
//				List<ProductAlbumImg> imgpage=new ArrayList<ProductAlbumImg>();
//				if(id==null||id.equals("")){
//					List<ProductAlbum> albumList=bumpage.getList();
//					String bumId=albumList.get(0).getId();
//					ProductAlbumImg bumImg=new ProductAlbumImg();
//					bumImg.setMemId(LoginUtil.getLoginUser(request).getId());
//					bumImg.setAlbumId(bumId);
//					imgpage=productAlbumImgService.selectByWhere(bumImg);
//					model.addAttribute("imgId","");
//				}else{
//					ProductAlbumImg bumImg=new ProductAlbumImg();
//					bumImg.setAlbumId(id);
//					bumImg.setMemId(LoginUtil.getLoginUser(request).getId());;
//					imgpage=productAlbumImgService.selectByWhere(bumImg);
//					model.addAttribute("imgId", id);
//				} 
//				model.addAttribute("imgpage",imgpage);
//				model.addAttribute("imgCount", imgpage.size());
//				model.addAttribute("type", "1");
//			}else{
//				List<ProductAlbumPdf> imgpdf=new ArrayList<ProductAlbumPdf>();
//				if(id==null||id.equals("")){
//					List<ProductAlbum> albumList=bumpage.getList();
//					String bumId=albumList.get(0).getId();
//					ProductAlbumPdf bumPdf=new ProductAlbumPdf();
//					bumPdf.setMemId(LoginUtil.getLoginUser(request).getId());
//					bumPdf.setAlbumId(bumId);
//					imgpdf=productAlbumPdfService.selectByWhere(bumPdf);
//					model.addAttribute("imgId","");
//				}else{
//					ProductAlbumPdf bumPdf=new ProductAlbumPdf();
//					bumPdf.setAlbumId(id);
//					bumPdf.setMemId(LoginUtil.getLoginUser(request).getId());;
//					imgpdf=productAlbumPdfService.selectByWhere(bumPdf);
//					model.addAttribute("imgId", id);
//				}
//				model.addAttribute("imgpage",imgpdf);
//				model.addAttribute("imgCount", imgpdf.size());
//				model.addAttribute("type", "2");
//			}
//		}
//		if(productAlbum.getId()!=null){
//			model.addAttribute("bumID",productAlbum.getId());
//		}
//		model.addAttribute("onSuccess",onSuccess);
//		model.addAttribute("onSelect",onSelect);
//		model.addAttribute("bumpage",bumpage);
//		model.addAttribute("productAlbum", productAlbum);
//		return "common/fileupload/fileuploadview";
//	}
//	
//	@RequestMapping(value="/member/common/fileupload/index2")
//	public String index4(HttpServletRequest request, HttpServletResponse response, Model model) {
//		return "common/fileupload/testuploadview";
//	}
//	/*
//	 * 上传图片*/
//	@RequestMapping(value="/member/common/fileupload/uploadImg")  
//	//@ResponseBody
//	public String saveOrUpdate(@RequestParam("file") MultipartFile[] files,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws IOException {  
//		String imgBumId=request.getParameter("imgBumId");
//		String type=request.getParameter("type");
//		List list=new ArrayList();
//		String json="";
//		int status=0;
//		if(files!=null && files.length>0){
//			for(int i = 0;i<files.length;i++){
//				HttpSession session=request.getSession();
//				MultipartFile file = files[i];
//				byte[] data=null;
//	    	    String fileName="";
//	    	    String name = file.getOriginalFilename(); 
//	    	    //String hz=name.substring(name.indexOf(".")+1,name.length()).toLowerCase();
//	    	    String hz=name.substring(name.length()-3, name.length()).toLowerCase();
//	    	    String id="";
//	    	    Date date;
//	    	    String imgsize="";
//	    	    SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
//	    	    String creatdate="";
//	    	    String imgname="";
//	    		try {
//	    			data = file.getBytes();
//	    			FileStorage lf=FileStorageFcatory.get();		 
//	    			fileName=lf.fileName(hz);
//	    			lf.write2(data, fileName);
//	    		} catch (IOException e1) {
//	    			e1.printStackTrace();
//	    		}
//	    		if("2".equals(type) &&"pdf".equals(hz)){
//	    			ProductAlbumPdf pdf=new ProductAlbumPdf();
//	    			pdf.setAlbumId(imgBumId);
//	    			pdf.setFilePath(fileName);
//	    			pdf.setMemId(LoginUtil.getLoginUser(request).getId());
//	    			pdf.setCreateDate(new Date());
//	    			pdf.setFileSize((long) (data==null?0:data.length));
//	    			pdf.setBak1(name);
//	    			pdf.setBak2(FileSizeHelper.getHumanReadableFileSize(data.length));
//	    			productAlbumPdfService.saveOrUpdate(pdf);
//	    			id=pdf.getId();
//		    		date=pdf.getCreateDate();
//		    		imgsize=FileSizeHelper.getHumanReadableFileSize(pdf.getFileSize());
//		    		creatdate=dateFormater.format(date);
//		    		imgname=fileName.substring(fileName.indexOf("/")+1, fileName.length());
//		    		Map<String,String> map=new HashMap<String,String>();
//		    		map.put("imgPath", fileName);
//		    		map.put("size", imgsize);
//		    		map.put("createDate", creatdate);
//		    		map.put("id", id);
//		    		map.put("imgname", name);
//		    		map.put("type","2");
//		    		list.add(map);
//	    		}else if("1".equals(type) && !"pdf".equals(hz)){
//	    			ProductAlbumImg img=new ProductAlbumImg();
//	    			img.setFilePath(fileName);
//	    			img.setAlbumId(imgBumId);
//	    			img.setMemId(LoginUtil.getLoginUser(request).getId());
//	    			img.setCreateDate(new Date());
//	    			img.setFileSize((long) (data==null?0:data.length));
//	    			img.setBak1(name);
//	    			img.setBak2(FileSizeHelper.getHumanReadableFileSize(data.length));
//	    			productAlbumImgService.saveOrUpdate(img);
//	    			id=img.getId();
//	    			date=img.getCreateDate();
//	    			imgsize=FileSizeHelper.getHumanReadableFileSize(img.getFileSize());
//	    			creatdate=dateFormater.format(date);
//	    			imgname=fileName.substring(fileName.lastIndexOf("/")+1, fileName.length()).toLowerCase();
//	    			Map<String,String> map=new HashMap<String,String>();
//		    		map.put("imgPath", fileName);
//		    		map.put("size", imgsize);
//		    		map.put("createDate", creatdate);
//		    		map.put("id", id);
//		    		map.put("imgname", name);
//		    		map.put("type","1");
//		    		list.add(map);
//	    		}else{
//	    			status+=1;
//	    		}
//	    		
//			}
//		}
//		try {
//			if(status>0){
//				list.removeAll(list);
//			}
//			
//			json=JsonMapper.getInstance().toJson(list);
//			
//			//2016-8-17 赵磊修改，改为application/json未发现ie下载的问题
//			//为了解决ie下载的问题，必须使用text/plain头
//			//response.setContentType("text/plain;charset=UTF-8");
//			
//			response.setContentType("application/json;charset=UTF-8"); 
//			response.setCharacterEncoding("UTF-8"); //设置编码
//			response.setHeader("Content-Disposition", "inline;filename=f.txt");
//	        response.setHeader("Pragma", "No-cache");
//	        response.setHeader("Cache-Control", "no-cache");
//	        response.setDateHeader("Expires", 0);
//	        PrintWriter out = response.getWriter();
//			out.write(json);
//	        out.flush();
//	        out.close();
//		} catch (IOException e) {
//			logger.error("向浏览器输出HTML异常", e);
//		}
//		return null;
//	}
//	
//	@RequestMapping(value = "/member/common/fileupload/delete")
//	public String delete(ProductAlbumImg productAlbumImg, RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response) {
//		String id=request.getParameter("id");
//		String type=request.getParameter("type");
//		Map<String,String> map=new HashMap<String,String>();
//		if(id!=null){
//			if(type.equals("1")){
//				productAlbumImgService.deleteById(id);
//				map.put("status","1");
//			}else{
//				productAlbumPdfService.deleteById(id);
//				map.put("status","1");
//			}
//		}else{
//			map.put("status", "0");
//		}
//		String json=JsonMapper.getInstance().toJson(map);
//		try {
//			response.setContentType("application/json;charset=UTF-8");
//			response.setCharacterEncoding("UTF-8"); //设置编码
//	        response.setHeader("Pragma", "No-cache");
//	        response.setHeader("Cache-Control", "no-cache");
//	        response.setDateHeader("Expires", 0);
//	        PrintWriter out = response.getWriter();
//			out.write(json);
//	        out.flush();
//	        out.close();
//		} catch (IOException e) {
//			logger.error("向浏览器输出HTML异常", e);
//		}
//		return null;
//		//return "redirect:"+Global.getMemberPath()+"/common/fileupload/index.htm";
//	}
//	
//	@RequestMapping(value="/member/common/fileupload/selectBum")  
//	@ResponseBody
//	public String seletBum(HttpServletRequest request,HttpServletResponse response,ProductAlbum productAlbum,Model model){
//		String bumId=request.getParameter("bumId");
//		String type=request.getParameter("type");
//		String onSelect=request.getParameter("onSelect");
//		String json="";
//		if(bumId.equals("null")){
//			productAlbum.setMemId(LoginUtil.getLoginUser(request).getId());
//			Page<ProductAlbum> bumpage = productAlbumService.selectByWhere(new Page<ProductAlbum>(request, response), productAlbum);
//			List<ProductAlbum> albumList=bumpage.getList();
//			bumId=albumList.get(0).getId();
//		}
//		if("1".equals(type)){
//			List<ProductAlbumImg> imgpage=new ArrayList<ProductAlbumImg>();
//			ProductAlbumImg bumImg=new ProductAlbumImg();
//			bumImg.setAlbumId(bumId);
//			imgpage=productAlbumImgService.selectByWhere(bumImg);
//			json=JsonMapper.getInstance().toJson(imgpage);
//		}else{
//			List<ProductAlbumPdf> imgpdf=new ArrayList<ProductAlbumPdf>();
//			ProductAlbumPdf bumPdf=new ProductAlbumPdf();
//			bumPdf.setAlbumId(bumId);
//			imgpdf=productAlbumPdfService.selectByWhere(bumPdf);
//			json=JsonMapper.getInstance().toJson(imgpdf);
//		}
//		model.addAttribute("onSelect",onSelect);
//		return json;
//	}
//}
