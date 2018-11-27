package com.qhwl.common.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.qhwl.common.config.Global;
import com.qhwl.common.fileStorage.FileStorage;
import com.qhwl.common.fileStorage.FileStorageFcatory;
import com.qhwl.common.image.ImageProcessJava;
import com.qhwl.common.utils.FileUtils;

/**
 * 从文件存储系统下载文件，图片可实时生成缩略图
 * 
 */
public class FileStorageDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String cacheControl="public, max-age=604800";//缓存7天
       
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		fileOutputStream(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		fileOutputStream(request, response);
	}

	public void fileOutputStream(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//获取请求url路径.
		//如：/hcxc/filestorage/10/63/35/9d68e4c0fcc14f15abf233ee1e746a1e.jpg@!300x200
		String url = req.getRequestURI().toString().trim().toLowerCase();
		
		String filePath="";//文件路径，如：/10/63/35/9d68e4c0fcc14f15abf233ee1e746a1e.jpg
		String size=null;//生成缩略图的尺寸，如300x200
		
		//查找url是否包含@！
		int haveFlag1=url.indexOf("@!");
		int haveFlag2=url.indexOf("@");
		
		int index = url.indexOf(Global.FILESTORAGE_BASE_URL);
		String storageUrl=url.substring(index+Global.FILESTORAGE_BASE_URL.length());
		
		//截取文件路径，如:/10/63/35/9d68e4c0fcc14f15abf233ee1e746a1e.jpg
		if(haveFlag1!=-1){
			filePath = url.substring(index + Global.FILESTORAGE_BASE_URL.length(),haveFlag1);
			size=url.substring(haveFlag1+2);
		}else if(haveFlag2!=-1){
			filePath = url.substring(index + Global.FILESTORAGE_BASE_URL.length(),haveFlag2);
			size=url.substring(haveFlag2+1);
		}else{
			filePath = url.substring(index + Global.FILESTORAGE_BASE_URL.length());
		}
		
		//文件扩展名
		String suffix=FileUtils.fileSuff(filePath);
		
		
		//从文件系统中读取文件
		String fileAllPath = url.substring(index + Global.FILESTORAGE_BASE_URL.length());
		FileStorage fileStorage = FileStorageFcatory.get();
		if(fileStorage.exists(fileAllPath)){
			//若文件存在，就直接响应请求
			resp.setContentType(doHeader(suffix));//响应头
			//resp.setHeader("Cache-Control",cacheControl);//缓存
			logger.info("文件存在，直接响应请求"+fileAllPath);
			BufferedInputStream in=new BufferedInputStream(fileStorage.openInputStream(fileAllPath));
			BufferedOutputStream os=new BufferedOutputStream(resp.getOutputStream());
			byte[] buffer = new byte[1024 * 16];
			int length = 0;
            while (  (length=in.read(buffer)) != -1  ) {
            	os.write(buffer, 0, length);
            }
            os.close();
            in.close();
            return;
		}else{
			//若文件不存在，就使用原图生成目标图，存储后再响应请求
			if( !fileStorage.exists(filePath)){
				//原图不存在,直接响应404
				write404(resp,fileAllPath);
				return;
			}else{
				//原图存在,就使用原图生成目标图，存储后再响应请求
				
				if(suffix==null || !(suffix.equalsIgnoreCase("jpg") 
						|| suffix.equalsIgnoreCase("jpeg")
						|| suffix.equalsIgnoreCase("gif")
						|| suffix.equalsIgnoreCase("bmp")
						|| suffix.equalsIgnoreCase("png"))  ){
					//非图片（pdf、xls文件）都从这里放走
					logger.info("非图片（pdf、xls文件）都从这里放走"+fileAllPath);
					resp.setStatus(404);
					return;
				}
				
		     	if(size==null){
		     		//格式不对,直接响应404 
		     		write404(resp,fileAllPath);
					return;
		     	}
		     	
				String [] sizeData=size.split("x|X");
				if(sizeData.length!=2){
					//格式不对,直接响应404
					write404(resp,fileAllPath);
					return;
				}
				Integer widthSize=0;
				Integer heightSize=0;
				try{
					widthSize=Integer.parseInt(sizeData[0]);
					heightSize=Integer.parseInt(sizeData[1]);
				}catch(Exception e){
					//格式不对,直接响应404
					write404(resp,fileAllPath);
					return;
				}
				
				//判断文件格式,png文件要照顾透明背景的图片
				String format=null;
				if(suffix.equalsIgnoreCase("png")){
					format="png";//有一小部分png图片是透明背景的，格式一定要使用png格式,不然透明背景会变黑
				}else{
					format="jpg";//非PNG格式都转为jpg存储，可以在保持较高清析度的同时占用较少的存储空间。
				}
				
				if(haveFlag1!=-1){
					//执行缩切
					logger.info("执行缩切"+fileAllPath);
					BufferedInputStream in=new BufferedInputStream(fileStorage.openInputStream(filePath));//读原图
					byte[] data = ImageProcessJava.resizeAndCut(in, widthSize, heightSize, 95, format);//执行缩切
					FileStorageFcatory.get().write2(data, storageUrl);//存储到文件系统
					BufferedOutputStream os=new BufferedOutputStream(resp.getOutputStream());
	            	os.write(data);//响应用户的请求
		            os.close();
		            in.close();
				}else if(haveFlag2!=-1){
					//执行等比缩放
					logger.info("执行等比缩放"+fileAllPath);
					BufferedInputStream in=new BufferedInputStream(fileStorage.openInputStream(filePath));//读原图
					byte[] data = ImageProcessJava.resize(in, widthSize, heightSize, 95, format);//执行等比缩放
					FileStorageFcatory.get().write2(data, storageUrl);//存储到文件系统
					BufferedOutputStream os=new BufferedOutputStream(resp.getOutputStream());
					os.write(data);//响应用户的请求
		            os.close();
		            in.close();
				}else{
					//格式不对,直接响应404
					write404(resp,fileAllPath);
					return;
				}
			}
		}
	}

	private void write404(HttpServletResponse resp,String fileAllPath) {
		resp.setContentType("text/html;charset=UTF-8");//响应头
		logger.info("原图不存在,直接响应404,"+fileAllPath);
		resp.setStatus(404);
		try {
			resp.getWriter().write("<html>File not find,404</html>");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 确定文件的Content-Type
	 * 
	 * @param path
	 * @return map
	 */
	private String doHeader(String suffix) {
		if (suffix == null) {
			return "application/octet-stream";
		}
		if (suffix.toLowerCase().equals("jpg")) {
			return "image/jpeg";
		}
		if (suffix.toLowerCase().equals("jpeg")) {
			return "image/jpeg";
		}
		if (suffix.toLowerCase().equals("png")) {
			return "image/png";
		}
		if (suffix.toLowerCase().equals("gif")) {
			return "image/gif";
		}
		if (suffix.toLowerCase().equals("bmp")) {
			return "image/bmp";
		}
		if (suffix.toLowerCase().equals("pdf")) {
			return "application/pdf";
		}
		if (suffix.toLowerCase().equals("doc")) {
			return "application/msword";
		}
		if (suffix.toLowerCase().equals("docx")) {
			return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
		}
		if (suffix.toLowerCase().equals("xls")) {
			return "application/vnd.ms-excel";
		}
		if (suffix.toLowerCase().equals("xlsx")) {
			return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
		}
		return "application/octet-stream";
	}
//
//	   try {
//			FileStorage fileStorage = FileStorageFcatory.get();
//         	byte[] data=fileStorage.read(filePath);
//         	if (null==data||data.length==0) {
//         		resp.setStatus(404);
//			}
//        	//判断文件是否为图片，并且确定返回Content-Type参数
//        	Map<String,Object>map=doHeader(suffix);
//        	if ((boolean) map.get("flag")) {
//				resp.setHeader("Content-Type",map.get("Content-Type").toString());
//			}
//        	OutputStream os = resp.getOutputStream();
//        	byte[] osByte=null;
//        	//为@截取缩略图
//			if(haveFlag>0&&!(haveFlag2>-1)){
//				//实时生成缩略图
//				//@100x100  按最长边等比例缩图
//				//最后存入份文件分布式系统中一份
//				String StorageUrl=url.substring(index+Global.FILESTORAGE_BASE_URL.length());
//				String size=url.substring(haveFlag+1);
//				String [] sizeData=size.split("x|X");
//				Integer widthSize=Integer.parseInt(sizeData[0]);
//				Integer heightSize=Integer.parseInt(sizeData[1]);
//				//将byte作为输入流；
//	        	ByteArrayInputStream in = new ByteArrayInputStream(data);
//	        	BufferedImage image = ImageIO.read(in);  //将in作为输入流，读取图片存入image中;
//	        	Integer width=image.getWidth();
//	        	Integer height=image.getHeight();
//	        	if (width>height) {
//	        		heightSize=height/(width/widthSize);
//				}
//	        	if (width<height) {
//	        		widthSize=widthSize/(height/heightSize);
//				}
//	        	//将缩略后的流放入输出流
//	        	//把缩略尺寸入参
//	        	ByteArrayOutputStream bo=new ByteArrayOutputStream();
//				Thumbnails.of(image).size(widthSize, heightSize).outputFormat("png").toOutputStream(bo);
//				osByte=bo.toByteArray();
//	        	FileStorage lf=FileStorageFcatory.get();		 
//    			lf.write2(osByte, StorageUrl);
//    			os.write(osByte);
//			}else if(haveFlag2>=0){
//				//实时生成缩略图
//				//@!100x100 按最短边等比例切缩图
//				//最后存入份文件分布式系统中一份
//				String StorageUrl=url.substring(index+Global.FILESTORAGE_BASE_URL.length());
//				String size=url.substring(haveFlag2+2);
//				String [] sizeData=size.split("x");
//	        	ByteArrayInputStream in = new ByteArrayInputStream(data);    //将b作为输入流；
//	        	BufferedImage image = ImageIO.read(in);//将in作为输入流，读取图片存入image中;
//	        	Integer width=image.getWidth();
//	        	Integer height=image.getHeight();
//	        	Integer widthSize=Integer.parseInt(sizeData[0]);
//	        	Integer heightSize=Integer.parseInt(sizeData[1]);
//	        	if (width<height) {
//	        		heightSize=height/(width/widthSize);
//				}
//	        	if (width>height) {
//	        		widthSize=widthSize/(height/heightSize);
//				}
//	        	//将缩略后的流放入输出流
//	        	//把缩略尺寸入参
//	        	ByteArrayOutputStream bo=new ByteArrayOutputStream();
//				Thumbnails.of(image).sourceRegion(Positions.CENTER, widthSize, heightSize).size(widthSize, heightSize)
//						.keepAspectRatio(false).outputFormat("png").toOutputStream(bo);
//        	    osByte=bo.toByteArray();
//        	    FileStorage lf=FileStorageFcatory.get();		 
//   			    lf.write2(osByte, StorageUrl);
//   			    os.write(osByte);
//			}else{
//				 os.write(data);
//			}
//			   os.close();
//		} catch (Exception e) {
//			e.printStackTrace();
//			resp.setStatus(500);
//		}

	
//	private void cut(int width,int height, HttpServletResponse resp){
//    	if (width>height) {
//    		heightSize=height/(width/widthSize);
//		}
//    	if (width<height) {
//    		widthSize=widthSize/(height/heightSize);
//		}
//    	//将缩略后的流放入输出流
//    	//把缩略尺寸入参
//    	ByteArrayOutputStream bo=new ByteArrayOutputStream();
//		Thumbnails.of(image).size(widthSize, heightSize).outputFormat("png").toOutputStream(bo);
//		osByte=bo.toByteArray();
//    	FileStorage lf=FileStorageFcatory.get();		 
//		lf.write2(osByte, StorageUrl);
//		os.write(osByte);
//	}

	
//	private  Map<String, Object> doHeader(String path){
//		Map<String, Object>map=new HashMap<String,Object>();
//		if(path==null || "".equals(path)){
//			map.put("flag", false);
//			map.put("Content-Type", "application/octet-stream");
//			return map;
//		}
//		//初始几种处理图片
//		//String imgArry="jpg,png,jpeg,gif,bmp";
//		Set<String> set=new HashSet<String>();
//		set.add("jpg");
//		set.add("png");
//		set.add("jpeg");
//		set.add("gif");
//		set.add("bmp");
//	    Iterator<String> it=set.iterator();
//	       while(it.hasNext()){
//	    	   String pathName=it.next().toString().trim().toLowerCase();
//	    		if (pathName.equals(path)) {
//	    			map.put("flag", true);
//	    			if (path.equals("jpg")) {
//	    				map.put("Content-Type", "image/jpeg");
//					}else if (path.equals("png")) {
//						map.put("Content-Type", "image/png");
//					}else if(path.equals("jpeg")) {
//						map.put("Content-Type", "image/jpeg");
//					}else if(path.equals("gif")){
//						map.put("Content-Type", "image/gif");
//					}else if(path.equals("bmp")){
//						map.put("Content-Type", "image/bmp");
//					}else{
//						map.put("Content-Type", "application/octet-stream");
//					}
//	    		}
//	       }
//		return map;
//	}
//	/**
//	 * ryl
//	 * 验证路径的可用性
//	 */
//	private boolean validationFilePath(String path){
//		boolean flag=true;
//		if (null==path||""==path) {
//			flag=false;
//			return flag;
//		}
//		StringBuilder pathIndex=new StringBuilder();
//		//验证路径是否最少4级
//		String newPath=path.trim().toLowerCase();
//		Integer num1=newPath.indexOf("/");
//		Integer num2=newPath.indexOf("\\");
//		if (num1>0||num2>0) {
//			if (newPath.split("/").length>3||newPath.split("\\").length>3) {
//				pathIndex.append("true");
//			}else{
//				pathIndex.append("false");
//			}
//		}else{
//			pathIndex.append("false");
//		}
//		if (pathIndex.indexOf("false")>-1) {
//			flag=false;
//			return flag;
//		}
//		//验证路径中最后一个.是否在最后一个/或者\\的后面
//		Integer num4=newPath.lastIndexOf("\\");
//		Integer num5=newPath.lastIndexOf("/");
//		Integer num6=newPath.lastIndexOf(".");
//		if (num6>0) {
//			if (num4<num6||num5<num6) {
//				pathIndex.append("true");
//			}else{
//				pathIndex.append("false");
//			}
//		}else{
//			pathIndex.append("false");
//		}
//		if (pathIndex.indexOf("false")>-1) {
//			flag=false;
//			return flag;
//		}
//		Integer num7=newPath.lastIndexOf("@");
//		Integer num8=newPath.split("@").length;
//		if (flag) {
//			
//		}
//		return (Boolean) null;
//	}

}
