package com.qhwl.common.fileStorage;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * 文件存储服务
 * 
 * 海量小文件存储服务设计
 * 什么是“小文件”：网站中用户上传的图片(原图70K，缩略图5~15K)、生成的静态化页面，平均大小 50K。
 * 文件存储服务是一个基础服务，以接口形式提供。有多种不同的实现，每个实现适用的场景不同、成本不同。
 * 
 * 本“服务”有以下特点：
 * 提供多种存储方式的实现：本地文件夹、FTP远程存储、阿里云OSS存储、FastDFS、TFS等知名的分布式文件系统。
 * 业务层调用接口，可实现给文件的保存、修改、删除。
 * 业务层不用关心，存储空间扩展、目录结构、IO性能等问题。
 * 
 * @author zhaolei 2012-12-7
 */
public interface FileStorage {
	
	/**
	 * 生成文件名（无扩展名）
	 * @return 文件名： /20/99/99/5263bcec293d4c998b758143525654ee
	 */
	public String fileName();
	/**
	 * 生成文件名（含扩展名）
	 * @param fileExtName 文件扩展名
	 * @return 文件名： /20/99/99/5263bcec293d4c998b758143525654ee.png
	 */
	public String fileName(String fileExtName);
		
	
	/**
	 * 写入文件（自动生成文件名）
	 * byte[]可表示任何类型的文件，本方法把一个byte[]存储到文件系统.并返回生成的文件名
	 * 
	 * @param data 字节数组，不可为空
	 * @param fileExtName 扩展名，不可为空，不需要"."，统一转换为小写字母。
	 * @return 生成的文件名+扩展名，例：/20/99/99/5263bcec293d4c998b758143525654ee.png   
	 * @throws IOException 
	 * 	
	 */
	public String write(byte[] data,String fileExtName) throws IOException;
	
	/**
	 * 写入文件（外部传入文件名）
	 * byte[]可表示任何类型的文件，本方法把一个byte[]，使用指定的文件名，存储到文件系统.并返回原文件名
	 * 
	 * 由外部传入文件,可实现主从文件
	 * 主文件：/20/99/99/5263bcec293d4c998b758143525654ee.png（原图）
	 * 从文件：/20/99/99/5263bcec293d4c998b758143525654ee.png@!118x99b（缩略图）
	 * @param data 文件内容
	 * @param fileAllPath 文件名，示例：/20/99/99/5263bcec293d4c998b758143525654ee.png@!118x99b
	 * @return 原文件名
	 * @throws IOException 
	 */
	public String write2(byte[] data,String fileAllPath) throws IOException;
	
	/**
	 * 向已有文件追加内容(用于把一个大文件分批写入)
	 * 
	 * @param data 文件内容
	 * @param fileAllPath 远程文件名,例：/20/99/99/5263bcec293d4c998b758143525654ee.png@!118x99b
	 * @return  true:成功，false:失败
	 * @throws IOException 
	 */
	public boolean append(byte[] data,String fileAllPath) throws IOException;
	
	
	/**
	 * 读取文件
	 * @param fileAllPath 远程文件名，例：/20/99/99/5263bcec293d4c998b758143525654ee.png@!118x99b
	 * @return 文件内容的字节数组，返回null表示失败。
	 * @throws IOException 
	 */
	public byte[] read(String fileAllPath) throws IOException;
	
	/**
	 * 读取文件（用于把一个大文件分批读出）
	 * @param fileAllPath 远程文件名，例：/20/99/99/5263bcec293d4c998b758143525654ee.png@!118x99b
	 * @param  offset 文件偏移量 
	 * @param  size 下载文件大小 
	 * @return 文件内容的字节数组，返回null表示失败。
	 */
	public byte[] read(String fileAllPath, long offset,long size); 
	
	
	/**
	 * 替换文件
	 * 
	 * @param fileAllPath 远程文件名,例：/20/99/99/5263bcec293d4c998b758143525654ee.png@!118x99b
	 * @param newFile 新文件内容
	 * @return  true:成功，false:失败
	 * @throws IOException 
	 */
	public boolean modify(byte[] newFile,String fileAllPath) throws IOException;
	
	/**
	 * 删除文件
	 * 
	 * @param fileAllPath 文件名，例：/20/99/99/5263bcec293d4c998b758143525654ee.png@!118x99b
	 * @return true:成功，false:失败
	 * 
	 */
	public boolean delete(String fileAllPath);
	
	/**
	 * 返回文件大小（字节数），用于判断文件的长度 
	 * 
	 * @param fileAllPath 文件名，例：/20/99/99/5263bcec293d4c998b758143525654ee.png@!118x99b
	 * @return 正常时返回文件大小，无此文件时返回-1
	 */
	public long size(String fileAllPath);
	
	/**
	 * 获得一个输入流
	 * @param fileAllPath 文件名，例：/20/99/99/5263bcec293d4c998b758143525654ee.png
	 * @return
	 * @throws IOException 
	 */
	public InputStream openInputStream(String fileAllPath) throws IOException;
	
	/**
	 * 获得一个输出流
	 * @param fileAllPath  文件名，例：/20/99/99/5263bcec293d4c998b758143525654ee.png
	 * @param append 是否追加
	 * @return
	 * @throws IOException
	 */
	public OutputStream openOutputStream(String fileAllPath, boolean append) throws IOException;
	
	/**
	 * 文件是否存在
	 * @param fileAllPath
	 * @return
	 */
	boolean exists(String fileAllPath);
	
	
}
