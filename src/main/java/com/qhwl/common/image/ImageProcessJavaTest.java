/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.common.image;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import org.apache.commons.io.FileUtils;
import org.junit.Test;

/**
 * 单元测试类
 * <p>标题: </p>
 * <p>描述: </p>
 * <p>公司: 谦亨科技 www.qhwl.net</p>
 * @author zhaolei
 * @date 2016年7月31日 下午10:14:40
 */
public class ImageProcessJavaTest {
	static String rootPath="/Users/zhaolei/Desktop";

	@Test
	public void resize() throws IOException {
		String sourcePath=rootPath + "/test_image/JPEG/a1.jpg";
		String outputPath=rootPath + "/test_image/JPEG/a1_out9.jpg";
		InputStream inputStream = new FileInputStream(sourcePath);
		byte[] data = ImageProcessJava.resize(inputStream, 185, 185, 95, "jpg");
		inputStream.close();
		FileUtils.writeByteArrayToFile(new File(outputPath), data);
	}
	@Test
	public void resize2() throws IOException {
		String sourcePath=rootPath + "/test_image/PNG/p1.png";
		String outputPath=rootPath + "/test_image/PNG/p1_out2.jpg";
		InputStream inputStream = new FileInputStream(sourcePath);
		byte[] data = ImageProcessJava.resize(inputStream, 185, 185, 95, "PNG");
		inputStream.close();
		FileUtils.writeByteArrayToFile(new File(outputPath), data);
	}
	@Test
	public void resize3() throws IOException {
		String sourcePath=rootPath + "/test_image/GIF/g2.gif";
		String outputPath=rootPath + "/test_image/GIF/g2_out2.gif";
		InputStream inputStream = new FileInputStream(sourcePath);
		byte[] data = ImageProcessJava.resize(inputStream, 185, 185, 95, "gif");
		inputStream.close();
		FileUtils.writeByteArrayToFile(new File(outputPath), data);
	}
	
	@Test
	public void resizeAndCut() throws IOException {
		String sourcePath=rootPath + "/test_image/JPEG/a1.jpg";
		String outputPath=rootPath + "/test_image/JPEG/a1_out8.jpg";
		InputStream inputStream = new FileInputStream(sourcePath);
		byte[] data = ImageProcessJava.resizeAndCut(inputStream, 185, 185, 95, "jpg");
		inputStream.close();
		FileUtils.writeByteArrayToFile(new File(outputPath), data);
	}
	/**
	 * 透明 PNG 处理测试
	 * @throws IOException
	 */
	@Test
	public void png() throws IOException {
		String sourcePath=rootPath + "/test_image/透明背景/32位深透明.png";
		String outputPath=rootPath + "/test_image/透明背景/32位深透明_out2.png";
		InputStream inputStream2 =new FileInputStream(sourcePath);
		String format=ImageProcessJava.getFormat(inputStream2);
		if("png".equals(format)){
			format="png";//有一小部分png图片是透明背景的，格式一定要使用png格式,不然透明背景会变黑
		}else{
			format="jpg";//非PNG格式都转为jpg存储，可以在保持较高清析度的同时占用较少的存储空间。
		}
		inputStream2.close();
		InputStream inputStream = new FileInputStream(sourcePath);
		byte[] data = ImageProcessJava.resize(inputStream, 185, 185, 95, format);
		inputStream.close();
		FileUtils.writeByteArrayToFile(new File(outputPath), data);
	}
}