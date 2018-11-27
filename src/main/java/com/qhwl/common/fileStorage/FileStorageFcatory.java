package com.qhwl.common.fileStorage;

import com.qhwl.common.utils.StringUtils;

/**
 * 
 * FileStorageFcatory
 * 
 * FileStorage的工厂类，通过工厂获得FileStorage接口的实现
 * 
 * <p>标题: </p>
 * <p>描述: </p>
 * <p>公司: 谦亨科技 www.qhwl.net</p>
 * @author zhaolei
 * @date 2016年7月3日 下午8:13:52
 */
public class FileStorageFcatory {
	
	/**
	 * 取得一个默认的FileStorage接口的实现方案
	 * 默认方案是：本地文件系统方案
	 * 
	 * @return
	 */
	public static FileStorage get(){
		return get("1");
	}
	
	/**
	 * 取得一个默认的FileStorage接口的实现方案
	 * 默认方案是：本地文件系统方案
	 * 
	 * @param name 方案名称 1：本地文件系统方案，目前暂无其它实现方案
	 * @return
	 */
	public static FileStorage get(String name){
		
		if(StringUtils.isBlank(name)){
			return null;
		}
		
		if("1".equals(name.toLowerCase())){
			FileStorage fileStorage=LocalFileSystem.getInstance();
			return fileStorage;
		}else if("2".equals(name.toLowerCase())){
			return null;
		}else{
			return null;
		}
		
	}
}
