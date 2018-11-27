package com.qhwl.common.fileStorage;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Random;
import java.util.UUID;

import com.qhwl.common.config.Global;
import com.qhwl.common.utils.FileUtils;
import com.qhwl.common.utils.StringUtils;

/**
  * 文件存储服务--本地文件系统实现
 * 
 * 海量小文件存储服务设计
 * 什么是“小文件”：网站中用户上传的图片(原图70K，缩略图5~15K)、生成的静态化页面，平均大小 50K。
 * 文件存储服务是一个基础服务，以接口形式提供。有多种不同的实现，每个实现适用的场景不同、成本不同。
 * 
 * <p>标题: </p>
 * <p>描述: </p>
 * <p>公司: 谦亨科技 www.qhwl.net</p>
 * @author zhaolei
 * @date 2016年7月3日 下午1:04:44
 */
public class LocalFileSystem implements FileStorage {
	
	Random random=new Random();// 定义随机类
	int layer1=20;//1层目录00~19，不包含20
	int layer2=100;//2层目录00~99，不包含100
	int layer3=100;//3层目录00~99，不包含100
	
	//String dir=Global.getConfig("localFileStorageDir");//文件存储的根目录
	
	//文件存储的根目录,会根据fdp.properties中的userfiles.basedir配置来决定
	//是存储在某个决对路径中，还是存储在tomcat的webapps中的工程目录中。
	String dir=Global.getUserfilesBaseDir() + Global.FILESTORAGE_BASE_URL;
	
	private static FileStorage fileStorage=null;
	
	private LocalFileSystem(){}
	
	public static FileStorage getInstance(){
		if(fileStorage==null){
			synchronized (LocalFileSystem.class) {
				if(fileStorage==null){
					fileStorage=new LocalFileSystem();
				}
			}
		}
		return fileStorage;
	}

	/**
	 * 生成文件名（无扩展名）
	 * 目录随机选择，文件名是使用UUID
	 * 
	 * @return 文件名： /20/99/99/5263bcec293d4c998b758143525654ee
	 */
	@Override
	public String fileName() {
		int r1=random.nextInt(layer1);// 返回[0,20)集合中的整数，注意不包括20
		int r2=random.nextInt(layer2);// 返回[0,100)集合中的整数，注意不包括100
		int r3=random.nextInt(layer3);// 返回[0,100)集合中的整数，注意不包括100
		
		String dir1=r1<10?"0"+r1:""+r1;
		String dir2=r2<10?"0"+r2:""+r2;
		String dir3=r3<10?"0"+r3:""+r3;
		
		String uuid=UUID.randomUUID().toString().replaceAll("-", "");
		
		StringBuilder sbl=new StringBuilder();
		sbl.append("/").append(dir1).append("/").append(dir2).append("/").append(dir3).append("/").append(uuid);
		return sbl.toString();
	}

	/**
	 * 生成文件名（含扩展名）
	 * 目录随机选择，文件名是使用UUID
	 * 
	 * @param fileExtName 文件扩展名,不需要带.只传入jpg就可
	 * @return 文件名： /20/99/99/5263bcec293d4c998b758143525654ee.png
	 */
	@Override
	public String fileName(String fileExtName) {
		if(StringUtils.isNotBlank(fileExtName)){
			if(!fileExtName.startsWith(".")){
				fileExtName="."+fileExtName.toLowerCase();//扩展名统一转成小写字节
			}else{
				fileExtName=fileExtName.toLowerCase();//扩展名统一转成小写字节
			}
			return fileName()+fileExtName;
		}else{
			return fileName();
		}
	}

	@Override
	public String write(byte[] data, String fileExtName) throws IOException {
		String fileName=this.fileName(fileExtName);
		File file=new File(dir+fileName);
		
		if (file.exists()) {
			if (file.isDirectory()) {
				throw new IOException("File '" + file + "' exists but is a directory");
			}
			if (file.canWrite() == false) {
				throw new IOException("File '" + file + "' cannot be written to");
			}
		} else {
			File parent = file.getParentFile();
			if (parent != null) {
				if (!parent.mkdirs() && !parent.isDirectory()) {
					throw new IOException("Directory '" + parent + "' could not be created");
				}
			}
		}
		FileUtils.writeByteArrayToFile(file, data, false);
		return fileName;
	}

	@Override
	public String write2(byte[] data, String fileAllPath) throws IOException {
		if(StringUtils.isBlank(fileAllPath)){
			throw new IOException("入参fileAllPath不可为空");
		}
		String fileName=fileAllPath;
		File file=new File(dir+fileName);
		if (file.exists()) {
			if (file.isDirectory()) {
				throw new IOException("File '" + file + "' exists but is a directory");
			}
			if (file.canWrite() == false) {
				throw new IOException("File '" + file + "' cannot be written to");
			}
		} else {
			File parent = file.getParentFile();
			if (parent != null) {
				if (!parent.mkdirs() && !parent.isDirectory()) {
					throw new IOException("Directory '" + parent + "' could not be created");
				}
			}
		}
		FileUtils.writeByteArrayToFile(file, data, false);
		return fileName;
	}

	@Override
	public boolean append(byte[] data, String fileAllPath) throws IOException {
		if(StringUtils.isBlank(fileAllPath)){
			throw new IOException("入参fileAllPath不可为空");
		}
		String fileName=fileAllPath;
		File file=new File(dir+fileName);
		FileUtils.writeByteArrayToFile(file, data, true);
		return true;
	}

	@Override
	public boolean exists(String fileAllPath) {
		File file=new File(dir+fileAllPath);
		if (file.exists()) {
			return true;
		} else {
			return false;
		}
	}
	@Override
	public byte[] read(String fileAllPath) throws IOException {
		if(StringUtils.isBlank(fileAllPath)){
			throw new IOException("入参fileAllPath不可为空");
		}
		String fileName=fileAllPath;
		File file=new File(dir+fileName);
		
		if (file.exists()) {
            if (file.isDirectory()) {
                throw new IOException("File '" + file + "' exists but is a directory");
            }
            if (file.canRead() == false) {
                throw new IOException("File '" + file + "' cannot be read");
            }
        } else {
            throw new FileNotFoundException("File '" + file + "' does not exist");
        }
		
		return FileUtils.readFileToByteArray(file);
	}
	 
	@Override
	public byte[] read(String fileAllPath, long offset, long size) {
		// TODO 未实现
		return null;
	}


	@Override
	public boolean modify(byte[] newFile, String fileAllPath) throws IOException {
		delete(fileAllPath);
		write2(newFile,fileAllPath);
		return true;
	}

	@Override
	public boolean delete(String fileAllPath) {
		if(StringUtils.isBlank(fileAllPath)){
			return false;
		}
		String fileName=fileAllPath;
		File file=new File(dir+fileName);
		FileUtils.deleteQuietly(file);
		return true;
	}

	@Override
	public long size(String fileAllPath) {
		if(StringUtils.isBlank(fileAllPath)){
			return 0;
		}
		String fileName=fileAllPath;
		File file=new File(dir+fileName);
		
		return FileUtils.sizeOf(file);
	}
	
	@Override
	public InputStream openInputStream(String fileAllPath) throws IOException {
		if(StringUtils.isBlank(fileAllPath)){
			throw new IOException("入参fileAllPath不可为空");
		}
		String fileName=fileAllPath;
		File file=new File(dir+fileName);
		
		if (file.exists()) {
            if (file.isDirectory()) {
                throw new IOException("File '" + file + "' exists but is a directory");
            }
            if (file.canRead() == false) {
                throw new IOException("File '" + file + "' cannot be read");
            }
        } else {
            throw new FileNotFoundException("File '" + file + "' does not exist");
        }
        return new FileInputStream(file);
	}
	
	@Override
	public OutputStream openOutputStream(String fileAllPath, boolean append) throws IOException {
		if (StringUtils.isBlank(fileAllPath)) {
			throw new IOException("入参fileAllPath不可为空");
		}
		String fileName = fileAllPath;
		File file = new File(dir + fileName);

		if (file.exists()) {
			if (file.isDirectory()) {
				throw new IOException("File '" + file + "' exists but is a directory");
			}
			if (file.canWrite() == false) {
				throw new IOException("File '" + file + "' cannot be written to");
			}
		} else {
			File parent = file.getParentFile();
			if (parent != null) {
				if (!parent.mkdirs() && !parent.isDirectory()) {
					throw new IOException("Directory '" + parent + "' could not be created");
				}
			}
		}
		return new FileOutputStream(file, append);
	}

}
