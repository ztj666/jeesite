/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.common.image;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.MemoryCacheImageInputStream;

import org.apache.log4j.Logger;

import com.sun.imageio.plugins.bmp.BMPImageReader;
import com.sun.imageio.plugins.gif.GIFImageReader;
import com.sun.imageio.plugins.jpeg.JPEGImageReader;
import com.sun.imageio.plugins.png.PNGImageReader;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.Thumbnails.Builder;
import net.coobird.thumbnailator.geometry.Positions;

/**
 * <p>标题: Java实现的图片处理工具类 （缩略图、裁剪）</p>
 * <p>描述: 使用了Thumbnails图片片库</p>
 * <p>公司: 谦亨科技 www.qhwl.net</p>
 * @author zhaolei
 * @date 2016年7月31日 下午10:14:54
 * 
 * 需要注意的是，对于CMYK模式的图像，由于JDK的Bug，目前还不能够处理
 * 纯Java处理CMYK格式(32位色深)的JPEG文件!!
 * http://www.udpwork.com/item/12394.html
 */
@SuppressWarnings("restriction")
public class ImageProcessJava  {
	private static final Logger logger = Logger.getLogger(ImageProcessJava.class);
	
	/**
	 * 清晰度取值范围 1-100，请不要轻易调整此值。默认值 90
	 */
	public static final int QUALITY=95;
	
	/**
	 * 生成缩略图，保持图片原有长宽比例
	 * @param inputStream
	 * @param width 宽，像素
	 * @param height 高，像素
	 * @param quality 清晰度，1-100
	 * @param format 文件后缀
	 * @return
	 */
	public static byte[] resize(InputStream inputStream,int width,int height,int quality,String format){
		long t1=System.currentTimeMillis();
		byte[] data =null;
		try{
			BufferedImage image = ImageCMYK.read(inputStream);  
			//图片的宽与高
			int imageWidth = image.getWidth();  
			int imageHeitht = image.getHeight(); 
			
			//只缩小不放大
        	if(width>imageWidth){
        		width=imageWidth;
        	}
        	if(height>imageHeitht){
        		height=imageHeitht;
        	}
	    	ByteArrayOutputStream bo=new ByteArrayOutputStream();
			Thumbnails.of(image).size(width, height).outputFormat(format).toOutputStream(bo);
			data=bo.toByteArray();
			long t2=System.currentTimeMillis();
		    logger.info("resize 执行耗时："+(t2-t1)+"ms");
		}catch(Exception e){
        	logger.error("resize异常",e);
		}
		return data;
	}
	
	/**
	 * 按“最小边”生成指定宽与高的缩略图，由于图片长宽比不同造成的“超出”，将切掉
	 * 
	 * @param inputStream
	 * @param width 宽，像素
	 * @param height 高，像素
	 * @param quality 清晰度，1-100
	 * @param format 文件后缀
	 * @return
	 */
	public static byte[] resizeAndCut(InputStream inputStream,int width,int height,int quality,String format){
		long t1=System.currentTimeMillis();
		byte[] data =null;
		
		try{
			BufferedImage image = ImageCMYK.read(inputStream);  
			Builder<BufferedImage> builder = null;  
			ByteArrayOutputStream output=new ByteArrayOutputStream();
			
			//图片的宽与高
			int imageWidth = image.getWidth();  
			int imageHeitht = image.getHeight();  
			
			//只缩小不放大
        	if(width>imageWidth){
        		width=imageWidth;
        	}
        	if(height>imageHeitht){
        		height=imageHeitht;
        	}
			
			//计算比例
			float w_scale=(float)width/imageWidth;
			float h_scale=(float)height/imageHeitht;
			float new_scale=w_scale > h_scale?w_scale:h_scale;
			
			//按比例缩小图片(缩小或放大)
			image = Thumbnails.of(image).scale(new_scale).asBufferedImage();  
		    builder = Thumbnails.of(image).sourceRegion(Positions.CENTER, width, height);  
			builder.outputQuality(quality/100F).size(width, height);
			builder.outputFormat(format).toOutputStream(output);
			data=output.toByteArray(); 
	        
	        long t2=System.currentTimeMillis();
	        logger.info("resizeAndCut 执行耗时："+(t2-t1)+"ms");
	        return data;
		}catch(Exception e){
        	logger.error("resizeAndCut 异常",e);
		}
		return data;
	}
	
	
	/**
	 * 获取图片文件类型 
	 * @param fileContent 图片内容的byte[] 
	 * @return jpg\gif\bmp\gif
	 */
    public static String getFormat(byte[] fileContent){
    	if(fileContent==null){
    		return "";
    	}
    	try {
			ByteArrayInputStream in=new ByteArrayInputStream(fileContent);
			return getFormat(in);
		}catch(Exception e){
			logger.error("getFormat"+e.getMessage() ,e);
		}
		return "";
    }
	/**
	 * 获取图片文件类型 
	 * @param filePathName 文件路径 
	 * @return jpg\gif\bmp\gif
	 */
	public static String getFormat(String filePathName){
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(filePathName);
			return getFormat(fis);
		}catch(IOException e){
			logger.error("getFormat"+e.getMessage() ,e);
		}finally {
			if(fis!=null){
				try {fis.close();} catch (IOException e) {}
			}
		}
		return "";
	}
	
	/**
	 * 获取图片文件类型 
	 * @param inputStream 输入流
	 * @return jpg\gif\bmp\gif
	 */
	public static String getFormat(InputStream inputStream){
		String type = "";
		ByteArrayInputStream bais = null;   
		MemoryCacheImageInputStream mcis = null;
		try {
		    mcis = new MemoryCacheImageInputStream(inputStream);   
		    Iterator<ImageReader> itr = ImageIO.getImageReaders(mcis);   
		    while (itr.hasNext()){   
			    ImageReader reader = (ImageReader) itr.next();
			    if (reader instanceof GIFImageReader){   
			    	type = "gif";   
			    }else if(reader instanceof JPEGImageReader){   
			    	type = "jpg";   
			    }else if (reader instanceof BMPImageReader){
			    	type = "bmp";
			    }else if (reader instanceof PNGImageReader){
			    	type = "png";
			    }else{
			    	type="unknow";
			    }
		    }   
		}catch(Exception e){
			logger.error("getFormat"+e.getMessage() ,e);
		}finally{
			if (bais != null){
				try {bais.close(); } catch (IOException ioe){}   
			}
			if (mcis != null) {
				try {mcis.close();}catch (IOException ioe){}
			}
		}   
		return type;   
	}   
	
	/**
     * 取得图片信息 （宽、高、图片类型）
     * @param fileContent 文件内容字节数组
     * @return ImageInfo
     */
    public static ImageInfo getImageInfo(byte[] fileContent)  {
    	if(fileContent==null){
			return null;
		}
    	Map<String,String> map=null; 
    	try {
    		//优先使用java方式取出图片的宽和高
    		long t1=System.currentTimeMillis();
    		map=new HashMap<String,String>();
    		ByteArrayInputStream in = new ByteArrayInputStream(fileContent);
        	BufferedImage image = ImageIO.read(in);  //将in作为输入流，读取图片存入image中;
    		map.put("width","" + image.getWidth(null));
    		map.put("height","" + image.getHeight(null) );
			long t2=System.currentTimeMillis();
			//取出图片的格式
			String format = getFormat(fileContent);
			map.put("format", format);
			long t3=System.currentTimeMillis();    		
    		logger.info("getImageHeightWidth 方法执行耗时：" + (t2-t1) + "ms,getFormat方法耗时：" + (t3-t2) + "ms "  + "byte[]");
    	}catch(NullPointerException e){
    		//发生成NullPointerException，是因为入参byte[] fileContent不是图片文件。
    		//非图片文件无法取出宽与高，就不处理了。
    		throw new RuntimeException("入参byte[] fileContent不是图片文件,无法取出宽与高",e);
    		
    	}
    	catch(Exception e){
    		//如果java图片解析异常了，则调用gm方法再解析
    		//一般什么情况会走到这里？
    		//答：ImageIOUtil.getPicImage(fileContent)处理 位深度是32的图片时会产生IOException,会走到这里
			logger.error("byte[]" + "java图片解析异常了，调用gm方法再解析, ",e);
    	}
		ImageInfo info=new ImageInfo();
		info.setFormat(map.get("format"));
		info.setHeight(Integer.valueOf(map.get("height")));
		info.setWidth(Integer.valueOf(map.get("width")));
    	return info;  
    }
    
    /**
     * 取得图片信息 （宽、高、图片类型）
     * @param imagePath  图片存储路径
     * @return ImageInfo
     */
    public static ImageInfo getImageInfo(String imagePath )  {  
		//格式化文件路径 
		//java可以识别不规范的路径，如 ： e:\imguppic\pic\\15/credit/187\b\证书.jpg
		//但GM无法识别不规范的路径，要处理成规范的路径格式。
    	imagePath=new File(imagePath).getAbsolutePath();
    	Map<String,String> map=null;    	
    	try {
    		//优先使用java方式取出图片的宽和高
    		long t1=System.currentTimeMillis();
    		map=new HashMap<String,String>();
    		FileInputStream fis = null;
			fis = new FileInputStream(imagePath);
        	BufferedImage image = ImageIO.read(fis);  //将in作为输入流，读取图片存入image中;
    		map.put("width","" + image.getWidth(null));
    		map.put("height","" + image.getHeight(null) );
			long t2=System.currentTimeMillis();
			//取出图片的格式
			String type = getFormat(imagePath);
			map.put("format", type);
			long t3=System.currentTimeMillis();    		
    		logger.info("getImageHeightWidth 方法执行耗时：" + (t2-t1) + "ms,getImageTypeSupport方法耗时：" + (t3-t2) + "ms "  + imagePath);
		} catch (Exception e1) {
			//如果java图片解析异常了，则调用gm方法再解析
			logger.error(imagePath + "java图片解析异常了，调用gm方法再解析 ",e1);
		}
		ImageInfo info=new ImageInfo();
		info.setFormat(map.get("format"));
		info.setHeight(Integer.valueOf(map.get("height")));
		info.setWidth(Integer.valueOf(map.get("width")));
    	return info;  
    } 

}
