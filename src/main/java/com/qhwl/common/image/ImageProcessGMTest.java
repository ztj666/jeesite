/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.common.image;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.junit.Test;

import com.qhwl.common.utils.FileUtils;

/**
 * CommonImageOperateGM 测试类
 * 
 * @author zhaolei 2013-1-17
 */
public class ImageProcessGMTest {
	//String srcFilePath="d:\\ETX-001.jpg";
	//String outFilePath="d:\\test_out.jpg";
	String srcFilePath="D:\\"+"888.jpg";
	String outFilePath="D:\\"+"gao_out.jpg";
	
	File inImg = new File(srcFilePath);
	File outImg = new File(outFilePath);
	
	int width=180;
	int height=180;
	int quality=85;
	
	@Test
	public void testConvertImgType() throws  IOException{
		byte[]  data=readFileUtil("d://gp0.jpg");
		data=ImageProcessGM.convertFormat(data, "jpg");
		System.out.println(data);
	}
	
	
	
	@Test
	public void testResizeByte() throws  IOException{
		
		File file = new File(srcFilePath);
		byte[] inFile = new byte[(int)file.length()];
		FileInputStream fis = new FileInputStream(file);
		fis.read(inFile);
		fis.close();
		
		ImageProcessGM.resize(inFile, 100, 100, quality,FileUtils.fileSuff(srcFilePath));
	}

	@Test
	public void testResize() {
		ImageProcessGM.resize(srcFilePath, outFilePath, width, height, quality);
	}
	
	@Test
	public void testResizeAndCut() throws Exception{
		String suffex=FileUtils.fileSuff(srcFilePath);
		File file = new File(srcFilePath);
		byte[] inFile = FileUtils.readFileToByteArray(file);
		byte[] data = ImageProcessGM.resizeAndCut(inFile,  width, height, quality,suffex);
		File file_out = new File("d:\\1_out."+suffex);
		FileUtils.writeByteArrayToFile(file_out, data);
//		FileUtils.writeToFile(file_out, context, false);
//		CommonFileOperate.createFileByByte(file_out,context);
	}
	
	@Test
	public void testResizeAndFiller() throws Exception{
		String suffex=FileUtils.fileSuff(srcFilePath);
		File file = new File(srcFilePath);
		byte[] inFile = FileUtils.readFileToByteArray(file);
		byte[] data = ImageProcessGM.resizeAndFiller(inFile,  width, height, quality,suffex,null);
		File file_out = new File("d:\\1_out."+suffex);
		FileUtils.writeByteArrayToFile(file_out, data);
	}
	
	@Test
	public void testResizeLoop() {
		long t1=System.currentTimeMillis();
		for(int i=0;i<100;i++){
			ImageProcessGM.resize(srcFilePath, outFilePath, width, height, quality);
		}
		long t2=System.currentTimeMillis();
		System.out.println(t2-t1);
	}
	
	@Test
	public void testSetQuality(){
		ImageProcessGM.setQuality(srcFilePath, outFilePath,quality);
	}
	
	@Test
	public void testShowImageInfo() {
		ImageInfo info=ImageProcessGM.getImageInfo(srcFilePath);
		System.out.println(info);
	}	
	@Test
	public void testCutImg(){
		ImageProcessGM.cut(srcFilePath, outFilePath,0, 0, 771, 558);
	}
	
	@Test
	public void testGetImageInfo() throws IOException {
		//for(int i=0;i<10;i++){
			byte[] picbyte=FileUtils.readFileToByteArray(new File("d:\\wKgs-FJkn16EQkraAAAAAG5FGQc805.jpg"));
			//byte[] picbyte=CommonFileOperate.findFileContext(new File("d:\\a.txt"));
			ImageInfo imginfo = ImageProcessGM.getImageInfo(picbyte);
			picbyte=ImageProcessGM.cut(picbyte, 0,0, 100, 100,"jpg");
			imginfo = ImageProcessGM.getImageInfo(picbyte);
		//}
	}
	
	@Test
	public void testCropImg() throws IOException {
		byte[] picbyte=FileUtils.readFileToByteArray(new File("d:\\413.jpg"));
		ImageInfo info=ImageProcessGM.getImageInfo(picbyte);
		System.out.println(info.getWidth());
		System.out.println(info.getHeight());
		
		byte[] fileContext = ImageProcessGM.cut(picbyte, 0, 0,  0, 0, "jpg");
		ImageInfo info2=ImageProcessGM.getImageInfo(fileContext);
		System.out.println(info2.getWidth());
		System.out.println(info2.getHeight());
	}

    
	/**
	 * 把文件读到byte[]
	 * @param filePath  文件路径
	 * @return byte[]
	 */
	private static byte[] readFileUtil(String filePath){
		if(filePath==null){
			throw new RuntimeException("读取文件异常，filePath=null");
		}
		try{
			File file = new File(filePath);
			byte[] rs = new byte[(int)file.length()];
			FileInputStream fis = new FileInputStream(file);
			fis.read(rs);
			return rs;
		}catch(Exception e ){
			throw new RuntimeException("读取文件异常，filePath="+filePath,e);
		}
	}
	
}
