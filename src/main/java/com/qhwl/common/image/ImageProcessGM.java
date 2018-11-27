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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.MemoryCacheImageInputStream;

import org.apache.log4j.Logger;
import org.im4java.core.ConvertCmd;
import org.im4java.core.IMOperation;
import org.im4java.core.IdentifyCmd;
import org.im4java.core.Info;
import org.im4java.process.ArrayListOutputConsumer;
import org.im4java.process.Pipe;

import com.qhwl.common.utils.FileUtils;
import com.sun.imageio.plugins.bmp.BMPImageReader;
import com.sun.imageio.plugins.gif.GIFImageReader;
import com.sun.imageio.plugins.jpeg.JPEGImageReader;
import com.sun.imageio.plugins.png.PNGImageReader;


/**
 * GraphicsMagick+Im4Java图片处理工具类 （缩略图、裁剪）
 *
 * 2013年1月，图片架构3.0项目立项。为了提高缩略图上的画质与图片处理的稳定性，图片处理使用GraphicsMagick+Im4Java。
 * 
 * @author zhaolei 2012-12-26
 */
@SuppressWarnings("restriction")
public class ImageProcessGM  {
	private static final Logger logger = Logger.getLogger(ImageProcessGM.class);
	public static String FILE_SEPARATOR = System.getProperty("file.separator");
	
	static{
		//true：使用GM , false使用：IM
		System.setProperty("im4java.useGM", "true");
	}
	
	/**
	 * 清晰度取值范围 1-100，请不要轻易调整此值。默认值 90
	 */
	public static final int QUALITY=90;
	
	
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
			    	type="notknow";
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
			String type = getFormat(fileContent);
			map.put("format", type);
			long t3=System.currentTimeMillis();    		
    		logger.info("getImageHeightWidth 方法执行耗时：" + (t2-t1) + "ms,getImageTypeSupport方法耗时：" + (t3-t2) + "ms "  + "byte[]");
    	}catch(NullPointerException e){
    		//发生成NullPointerException，是因为入参byte[] fileContent不是图片文件。
    		//非图片文件无法取出宽与高，就不处理了。
    		throw new RuntimeException("入参byte[] fileContent不是图片文件,无法取出宽与高",e);
    		
    	}catch(Exception e){
    		//如果java图片解析异常了，则调用gm方法再解析
    		//一般什么情况会走到这里？
    		//答：ImageIOUtil.getPicImage(fileContent)处理 位深度是32的图片时会产生IOException,会走到这里
			logger.error("byte[]" + "java图片解析异常了，调用gm方法再解析, ",e);
    	    try{
    	    	long t1=System.currentTimeMillis();
    	    	ByteArrayInputStream  stream = new ByteArrayInputStream(fileContent);
        		Info imageInfo =  new Info("-",stream,true);
    	    	map=new HashMap<String,String>();
    			map.put("width",  String.valueOf(imageInfo.getImageWidth()));
    			map.put("height", String.valueOf(imageInfo.getImageHeight()));
    			map.put("format", imageInfo.getImageFormat());
    	    	long t2=System.currentTimeMillis();
    			logger.info("getImageInfo(byte) 方法执行耗时："+(t2-t1)+"ms");
    		} catch (Exception e2) {  
    	    	logger.error(e2);
    		}
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
	    	try {  
	    		map=new HashMap<String,String>();
	    		long t1=System.currentTimeMillis();
	    		Info imageInfo = new Info(imagePath,true);
	    		map.put("width",  String.valueOf(imageInfo.getImageWidth()));
	    		map.put("height", String.valueOf(imageInfo.getImageHeight()));
	    		map.put("format", imageInfo.getImageFormat());
	    		long t2=System.currentTimeMillis();
	    		logger.info("getImageInfo 方法执行耗时："+(t2-t1)+"ms,"+imagePath);
	    	} catch (Exception e) {  
	        	logger.error(imagePath,e);
	    	}  
		}
		ImageInfo info=new ImageInfo();
		info.setFormat(map.get("format"));
		info.setHeight(Integer.valueOf(map.get("height")));
		info.setWidth(Integer.valueOf(map.get("width")));
    	return info;  
    } 
    /** 
     * 取得图片信息 （宽、高、大小）,如果是GIF会有多帧，返回每一帧的信息
     * 
     * 返回信息格式：
     * 		分隔符：多个帧用#分隔， 一 帧内信息用,分隔。   
     * 		帧分隔示例：第一帧#第二帧#第三帧#
     * 		帧内信息用分隔示例：width:250,height:200,name:465k.gif,type:GIF,size:465.8K#
     * 注：jpg,png图片只有一帧，gif图片会有多帧。
     * 
     * @param imagePath  源图片
     * @return  字符串：width:250,height:200,name:465k.gif,format:GIF,size:465.8K#
     */  
	public static String getFrames(String imagePath)  {
		//格式化文件路径 
		//java可以识别不规范的路径，如 ： e:\imguppic\pic\\15/credit/187\b\证书.jpg
		//但GM无法识别不规范的路径，要处理成规范的路径格式。
		imagePath=new File(imagePath).getAbsolutePath();
		String line = null;
		try {
			long t1=System.currentTimeMillis();
			IMOperation op = new IMOperation();
			op.format("width:%w,height:%h,name:%f,format:%m,size:%b#");
			op.addImage(1);
			IdentifyCmd identifyCmd = new IdentifyCmd(true);
			ArrayListOutputConsumer output = new ArrayListOutputConsumer();
			identifyCmd.setOutputConsumer(output);
			identifyCmd.run(op, imagePath);
			ArrayList<String> cmdOutput = output.getOutput();
			assert cmdOutput.size() == 1;
			line = cmdOutput.get(0);
			long t2=System.currentTimeMillis();
			logger.info("getImageInfoFrame 方法执行耗时："+(t2-t1)+"ms,"+imagePath);
		} catch (Exception e) {
        	logger.error(imagePath,e);
		}
		return line;
	}
	/**
	 * 生成缩略图，保持图片原有长宽比例
	 * 只有当图片的宽与高，大于给定的宽与高时，才进行“缩小”操作
	 * 默认处理多帧的GIF时，会保留动画效果.
	 * 如不想保留GIF的动画效果，只取第一帧，请使用"d:\\380k.gif[0]"做为源图片文件名。
	 * 
	 * @param inImgPath 源图片路径
	 * @param outImgPath 输出图片路径
	 * @param width 宽
	 * @param height 高
	 */
	public static void resize(String inImgPath,String outImgPath,int width,int height){
		resize(inImgPath,outImgPath,width,height,QUALITY);
	}

	/**
	 * 生成缩略图，保持图片原有长宽比例
	 * 只有当图片的宽与高，大于给定的宽与高时，才进行“缩小”操作
	 * 默认处理多帧的GIF时，会保留动画效果.
	 * 如不想保留GIF的动画效果，只取第一帧，请使用"d:\\380k.gif[0]"做为源图片文件名。
	 * 
	 * @param inImgPath 源图片路径
	 * @param outImgPath 输出图片路径
	 * @param width 宽，像素
	 * @param height 高，像素
	 * @param quality 清晰度，1-100
	 */
	public static void resize(String inImgPath,String outImgPath,int width,int height,int quality){
		long t1=System.currentTimeMillis();
		//格式化文件路径 
		//java可以识别不规范的路径，如 ： e:\imguppic\pic\\15/credit/187\b\证书.jpg
		//但GM无法识别不规范的路径，要处理成规范的路径格式。
		inImgPath=new File(inImgPath).getAbsolutePath();
		outImgPath=new File(outImgPath).getAbsolutePath();
		FileUtils.createDirectory(outImgPath);
		//判断是否是pdf文件结尾 
		if(inImgPath!=null && inImgPath.toLowerCase().endsWith("pdf") ){//如果是pdf文件结尾的，不做处理
			return ;
		}
		try{
	        IMOperation op = new IMOperation();
	        
	        //性能优化，对于处理200x200以下的图片，加速效果明显
	        //在这个例子中,'-size 120x120'给了JPEG解码器一个暗示,图像将会缩减到120x120,
			//允许它运行得更快通过避免返回GraphicsMagick全分辨率图像对后续的调整操作。
	        //这里不可以采用过大的值，如果你设置了400x400,但实际图片尺寸是 230x200(小于你设置的值),只会降低性能。
	        if(width<=200 && height<=200){
	        	op.size(width, height);
	        }

	        //根据宽度、高度缩放图片
	        //只有当图片的宽与高，大于给定的宽与高时，才进行“缩小”操作
	        //不进行放大操作。
            op.resize(width, height,">"); 
            
			//IE6-8,无法显示大于8位（windows的24位）的jpg图片，这里把图片统一处理成8位。
            //GM使用1个像素8位，windows使用3个像素24位，所以GM的8位=windows的24位。
			//图片32位转24位
			op.colorspace("RGB");

            //设置清晰度
	        op.quality(Double.valueOf(quality));
	        
	        //去掉照片中的Exif信息
	        op.strip();

	        //锐化图片,建议值：arg0=1.0 arg1=5.0，会使图片变得清晰好看，不可以多次锐化
	        //决定不使用锐化
			//op.sharpen(1.0, 5.0);
	        op.addImage(inImgPath);
	        op.addImage(outImgPath);
	        //true：使用GM , false使用：IM
	        ConvertCmd convert = new ConvertCmd(true);
	        convert.run(op);
	        
	        long t2=System.currentTimeMillis();
	        logger.info("resize 方法执行耗时："+(t2-t1)+"ms,"+inImgPath+","+outImgPath);
		}catch(Exception e){
        	logger.error("resize异常，文件："+inImgPath+","+outImgPath,e);
		}
	}
	
	/**
	 * 生成缩略图，保持图片原有长宽比例
	 * 只有当图片的宽与高，大于给定的宽与高时，才进行“缩小”操作
	 * 默认处理多帧的GIF时，会保留动画效果.
	 * 如不想保留GIF的动画效果，只取第一帧，请使用"d:\\380k.gif[0]"做为源图片文件名。
	 * 
	 * @param inImgPath 源图片路径
	 * @param outImgPath 输出图片路径
	 * @param width 宽，像素
	 * @param height 高，像素
	 * @param quality 清晰度，1-100
	 * @param suffix  文件后最 
	 */
	public static byte[] resize(byte[] fileContent,int width,int height,String suffix){
		return resize(fileContent, width, height,QUALITY,suffix);
	}
	public static byte[] resize(byte[] fileContent,int width,int height,int quality,String suffix){
		if(fileContent==null){
			return null;
		}
		
		long t1=System.currentTimeMillis();
		byte[] res =null;
		try{
	        IMOperation op = new IMOperation();
	        
	        //性能优化，对于处理200x200以下的图片，加速效果明显
	        //在这个例子中,'-size 120x120'给了JPEG解码器一个暗示,图像将会缩减到120x120,
			//允许它运行得更快通过避免返回GraphicsMagick全分辨率图像对后续的调整操作。
	        //这里不可以采用过大的值，如果你设置了400x400,但实际图片尺寸是 230x200(小于你设置的值),只会降低性能。
	        if(width<=200 && height<=200){
	        	op.size(width, height);
	        }
	        
	        //根据宽度、高度缩放图片
	        //只有当图片的宽与高，大于给定的宽与高时，才进行“缩小”操作
	        //为进行放大操作。
            op.resize(width, height,">"); 
            //设置清晰度
	        op.quality(Double.valueOf(quality));
	        //去掉照片中的Exif信息
	        op.strip();
	        //锐化图片,建议值：arg0=1.0 arg1=5.0，会使图片变得清晰好看，不可以多次锐化
	        //决定不使用锐化
	        //op.sharpen(1.0, 5.0);	        
	        op.addImage("-");
	        op.addImage(suffix==null?"jpg":suffix + ":-"); 
	        
	        ByteArrayInputStream  inputStream = new ByteArrayInputStream(fileContent);
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			Pipe pipeIn  = new Pipe(inputStream,null);
			Pipe pipeOut = new Pipe(null,outputStream);
			ConvertCmd convert = new ConvertCmd(true);			
		    convert.setInputProvider(pipeIn);
		    convert.setOutputConsumer(pipeOut);
		    convert.run(op);
		    res = outputStream.toByteArray();
	        long t2=System.currentTimeMillis();
	        logger.info("resize 方法执行耗时："+(t2-t1)+"ms,"+"文件长" + fileContent.length);
	        return res;
		}catch(Exception e){
        	logger.error("resize异常，文件长" + fileContent.length,e);
		}
		return res;
	}
	
	/**
	 * 按“最小边”生成指定宽与高的缩略图，由于图片长宽比不同造成的“超出”，将切掉
	 * 
	 * gm convert input.jpg -thumbnail "100x100^" -gravity center -extent 100x100 output_3.jpg
	 * 裁剪后保证等比缩图
	 * 生成的图片大小是：100x100，还保证了比例。不过图片经过了裁剪，剪了图片左右两边才达到1:1
	 * 
	 * 注：本功能，第一个用户是，为搜狗搜索、360搜索准备合格的图片
	 * 
	 * @param fileContent
	 * @param width
	 * @param height
	 * @param quality
	 * @param suffix
	 * @return
	 */
	public static byte[] resizeAndCut(byte[] fileContent,int width,int height,int quality,String suffix){
		if(fileContent==null){
			return null;
		}
		long t1=System.currentTimeMillis();
		byte[] res =null;
		try{
	        IMOperation op = new IMOperation();
	        
	        //根据宽度、高度缩放图片
	        //按“最小边”生成指定宽与高的缩略图
	        //由于图片长宽比不同造成的“超出”，将切掉
            op.resize(width, height,"^"); 
            //设置清晰度
	        op.quality(Double.valueOf(quality));
	        //去掉照片中的Exif信息
	        op.strip();
	        
//	        op.background(bgColor==null?"white":bgColor);//填充的颜色
	        op.gravity("center");//从中心点开始计算
	        op.extent(width, height);//填充的宽与高，从op.gravity("center")的位置计算
	        
	        op.addImage("-");
	        op.addImage(suffix==null?"jpg":suffix + ":-"); 
	        
	        ByteArrayInputStream  inputStream = new ByteArrayInputStream(fileContent);
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			Pipe pipeIn  = new Pipe(inputStream,null);
			Pipe pipeOut = new Pipe(null,outputStream);
			ConvertCmd convert = new ConvertCmd(true);			
		    convert.setInputProvider(pipeIn);
		    convert.setOutputConsumer(pipeOut);
		    convert.run(op);
		    res = outputStream.toByteArray();
	        long t2=System.currentTimeMillis();
	        logger.info("resizeAndCut 方法执行耗时："+(t2-t1)+"ms,"+"文件长" + fileContent.length);
	        return res;
		}catch(Exception e){
        	logger.error("resizeAndCut异常，文件长" + fileContent.length,e);
		}
		return res;
	}
	
	/**
	 * 缩小图片并补白
	 * 缩小图片，由于长宽比不同，补白的位置，补指定颜色的背景。产出目标尺寸的图片
	 * 如果源图小于目标尺寸，会放大原图
	 * 注：本功能，第一个用户是，为搜狗搜索、360搜索准备合格的图片
	 * 
	 * @param fileContent
	 * @param width  目标宽
	 * @param height 目标高
	 * @param quality 清晰度
	 * @param suffix 扩展名
	 * @param bgColor 用于填充的背景景色
	 * @return
	 */
	public static byte[] resizeAndFiller(byte[] fileContent,int width,int height,int quality,String suffix,String bgColor){
			if(fileContent==null){
				return null;
			}
			long t1=System.currentTimeMillis();
			byte[] res =null;
			try{
		        IMOperation op = new IMOperation();
		        
		        //根据宽度、高度缩放图片(会放大图片)
	            op.resize(width, height); 
	            //设置清晰度
		        op.quality(Double.valueOf(quality));
		        //去掉照片中的Exif信息
		        op.strip();
		        
		        op.background(bgColor==null?"white":bgColor);//填充的颜色
		        op.gravity("center");//从中心点开始计算
		        op.extent(width, height);//填充的宽与高，从op.gravity("center")的位置计算
		        
		        op.addImage("-");
		        op.addImage(suffix==null?"jpg":suffix + ":-"); 
		        
		        ByteArrayInputStream  inputStream = new ByteArrayInputStream(fileContent);
				ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				Pipe pipeIn  = new Pipe(inputStream,null);
				Pipe pipeOut = new Pipe(null,outputStream);
				ConvertCmd convert = new ConvertCmd(true);			
			    convert.setInputProvider(pipeIn);
			    convert.setOutputConsumer(pipeOut);
			    convert.run(op);
			    res = outputStream.toByteArray();
		        long t2=System.currentTimeMillis();
		        logger.info("resizeAndFiller 方法执行耗时："+(t2-t1)+"ms,"+"文件长" + fileContent.length);
		        return res;
			}catch(Exception e){
	        	logger.error("resizeAndFiller异常，文件长" + fileContent.length,e);
			}
			return res;
		}
	
	/**
	 * 设定图片的品质(清晰度)
	 * 品质下降后，图片大小(字节)也会变小 
	 * @param inImgPath 源图片路径
	 * @param outImgPath 输出图片路径
	 * @param quality 品质 1-100 ，一般85比较合适
	 */
	public static void setQuality(String inImgPath,String outImgPath,int quality){
		//格式化文件路径 
		//java可以识别不规范的路径，如 ： e:\imguppic\pic\\15/credit/187\b\证书.jpg
		//但GM无法识别不规范的路径，要处理成规范的路径格式。
		inImgPath=new File(inImgPath).getAbsolutePath();
		outImgPath=new File(outImgPath).getAbsolutePath();
		FileUtils.createDirectory(outImgPath);
		try{
			long t1=System.currentTimeMillis();
	        IMOperation op = new IMOperation();
	        op.addImage(inImgPath);
	        op.quality(Double.valueOf(quality));//清晰度，品质
	        op.addImage(outImgPath);
	        ConvertCmd convert = new ConvertCmd(true);
	        convert.run(op);
	        long t2=System.currentTimeMillis();
	        logger.info("setQuality 方法执行耗时："+(t2-t1)+"ms,"+inImgPath+","+outImgPath);
		}catch(Exception e){
        	logger.error(inImgPath+","+outImgPath,e);
		}
	}
	
	/**
	 * 设定图片的品质(清晰度)
	 * 品质下降后，图片大小(字节)也会变小 
	 * @param inImgPath 源图片路径
	 * @param outImgPath 输出图片路径
	 * @param quality 品质 1-100 ，一般85比较合适
	 */
	public static byte[] setQuality(byte[] fileContent,int quality,String suffix){
		if(fileContent==null){
			return null;
		}
		byte[] res =null;
		try{		
			long t1=System.currentTimeMillis();
	        IMOperation op = new IMOperation();	        
	        op.quality(Double.valueOf(quality));//清晰度，品质
	        op.addImage("-");
	        op.addImage(suffix + ":-");
	        
	        ByteArrayInputStream  inputStream = new ByteArrayInputStream(fileContent);
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			Pipe pipeIn  = new Pipe(inputStream,null);
			Pipe pipeOut = new Pipe(null,outputStream);
				
			ConvertCmd convert = new ConvertCmd(true);			
		    convert.setInputProvider(pipeIn);
		    convert.setOutputConsumer(pipeOut);
	        convert.run(op);
	        res = outputStream.toByteArray();
	        
	        long t2=System.currentTimeMillis();
	        logger.info("setQuality(byte)方法执行耗时："+(t2-t1)+"ms");
		}catch(Exception e){
        	logger.error("设定图片的品质" + quality,e);
		}
		return res;
	}
	
	/**
	 * 裁剪图片
	 * @param inImgPath 来源图片
	 * @param outImgPath 输出图片
	 * @param x 保留区的起点坐标
	 * @param y 保留区的起点坐标
	 * @param width 保留区的宽度
	 * @param height 保留区的高度
	 */
	public static void cut(String inImgPath, String outImgPath,int x, int y, int width, int height)  {
		//格式化文件路径 
		//java可以识别不规范的路径，如 ： e:\imguppic\pic\\15/credit/187\b\证书.jpg
		//但GM无法识别不规范的路径，要处理成规范的路径格式。
		inImgPath=new File(inImgPath).getAbsolutePath();
		outImgPath=new File(outImgPath).getAbsolutePath();
		FileUtils.createDirectory(outImgPath);
		try{
			long t1=System.currentTimeMillis();
			IMOperation op = new IMOperation();  
			op.addImage();  
			//切割图片      Integer width, Integer height, Integer x, Integer y
			op.append().crop(width, height, x, y);
			op.addImage();  
			ConvertCmd convert = new ConvertCmd(true);  
			convert.run(op, inImgPath, outImgPath); 
			long t2=System.currentTimeMillis();
			logger.info("cut 方法执行耗时："+(t2-t1)+"ms,"+inImgPath+","+outImgPath);
		}catch(Exception e){
        	logger.error("cut时异常，"+inImgPath+","+outImgPath,e);
		}
	}
	public static byte[] cut(byte[] fileContent,int x, int y, int width, int height,String suffix){
		if(fileContent==null){
			return null;
		}
		byte[] res =null;
		try{
			long t1=System.currentTimeMillis();
			IMOperation op = new IMOperation();  
			///op.addImage();  
			op.addImage("-");
			//切割图片      Integer width, Integer height, Integer x, Integer y
			op.append().crop(width, height, x, y);
			//op.addImage();  
			op.addImage(suffix + ":-"); 
			 
			ByteArrayInputStream  inputStream = new ByteArrayInputStream(fileContent);
			ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
			Pipe pipeIn  = new Pipe(inputStream,null);
			Pipe pipeOut = new Pipe(null,outputStream);    
			ConvertCmd convert = new ConvertCmd(true);			
		    convert.setInputProvider(pipeIn);
		    convert.setOutputConsumer(pipeOut);
		    convert.run(op);
		    res = outputStream.toByteArray();
			long t2=System.currentTimeMillis();
			logger.info("cut 方法执行耗时："+(t2-t1)+"ms,"+ fileContent.length);
			return res;
		}catch(Exception e){
        	logger.error("cut时异常，文件长：" + fileContent.length,e);
		}
		return res;
	}

    /** 
     * 旋转图片 
     * 
     * @param inImagePath 输入图片
     * @param outImagePath 输出图片
     * @param angle 角度
     */  
    public static void rotate(String inImagePath, String outImagePath, double angle) {  
		//格式化文件路径 
		//java可以识别不规范的路径，如 ： e:\imguppic\pic\\15/credit/187\b\证书.jpg
		//但GM无法识别不规范的路径，要处理成规范的路径格式。
    	inImagePath=new File(inImagePath).getAbsolutePath();
    	outImagePath=new File(outImagePath).getAbsolutePath();
    	FileUtils.createDirectory(outImagePath);
        try {  
        	long t1=System.currentTimeMillis();
            IMOperation op = new IMOperation();  
            op.rotate(angle);  
            op.addImage(inImagePath);  
            op.addImage(outImagePath);  
            ConvertCmd cmd = new ConvertCmd(true);  
            cmd.run(op);  
            long t2=System.currentTimeMillis();
            logger.info("rotate 方法执行耗时："+(t2-t1)+"ms,"+inImagePath+","+outImagePath);
        } catch (Exception e) {  
        	logger.error("rotate时异常，"+inImagePath+","+outImagePath,e); 
        }  
    }  
    
	/**
	 * 转换图片格式
	 * 
	 * @param imageContent
	 * @param format 图片的格式：jpg\png\bmp
	 * @return
	 */
	public static byte[] convertFormat(byte[] imageContent,String format){
		if(imageContent==null || format==null){
			return null;
		}
		ByteArrayInputStream  inputStream = new ByteArrayInputStream(imageContent);
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		Pipe pipeIn  = new Pipe(inputStream,null);
		Pipe pipeOut = new Pipe(null,outputStream);
		
		try {
			long t1=System.currentTimeMillis();
			IMOperation op = new IMOperation();
			op.addImage("-"); // read from stdin
		    op.addImage(format+":-");//  write to stdout in jpg-format 注意这里的jpg可以根据你的图片格式而改变，但是必须要有，否则不知道你要以何格式生成转换后的图片
			ConvertCmd convert = new ConvertCmd(true);			
		    convert.setInputProvider(pipeIn);
		    convert.setOutputConsumer(pipeOut);
		    convert.run(op);
		    byte[] res = outputStream.toByteArray();
			long t2=System.currentTimeMillis();
			logger.info("convertFormat(byte) 方法执行耗时："+(t2-t1)+"ms");
		    return res;
		}catch(Exception e){
	    	logger.error("convertFormat(byte) 时异常",e);
		}
		return null;
	}
}
