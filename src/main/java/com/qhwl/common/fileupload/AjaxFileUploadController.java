package com.qhwl.common.fileupload;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.qhwl.common.fileStorage.FileStorage;
import com.qhwl.common.fileStorage.FileStorageFcatory;
import com.qhwl.common.utils.FileSizeHelper;
import com.qhwl.common.utils.FileUtils;
import com.qhwl.common.web.BaseController;

/**
 * <p>标题:文件上传组件1的服务端 </p>
 * <p>描述:文件上传组件1的客户端使用的是ajaxFileUpload.js </p>
 * <p>公司: 谦亨科技 www.qhwl.net</p>
 * @author zhaolei
 * @date 2016年8月9日 下午6:51:16
 */
public class AjaxFileUploadController extends BaseController {
	
	/**
	 * 管理后台上传,要求登陆后可上：@RequiresPermissions("user")
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value="${adminPath}/common/ajaxfileupload")
	@ResponseBody
	public Object index1(@RequestParam("picUrl1") MultipartFile[] fileList) {
		return upload(fileList);
	}
	/**
	 * 
	 * 会员中心上传，/member/* 会被会员中心登陆拦截器拦截
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/member/common/ajaxfileupload")
	@ResponseBody
	public Object index2(@RequestParam("picUrl1") MultipartFile[] fileList) {
		return upload(fileList);
	}
	
	//可上传的文件类型，请在这里添加
	private String[] extArr={"jpg","jpeg","bmp","png","pdf","xls","xlsx"};
	//最大文件大小,单位字节,请在这里修改
	private int maxFileSize=5242880;//5M
	
	private Object upload(@RequestParam("picUrl1") MultipartFile[] fileList) {
		List<FileMsg> jsonList=new ArrayList<FileMsg>();	
		
		if(fileList!=null && fileList.length>0){
			for(int i = 0;i<fileList.length;i++){
				MultipartFile file=fileList[i];
				String fileName = file.getOriginalFilename();//文件原名
				String ext=FileUtils.fileSuff(fileName);//文件扩展名
				
				FileMsg msg=new FileMsg();
				jsonList.add(msg);
				msg.fileName=fileName;
				try {
					byte[] data = file.getBytes();
					msg.fileize=data.length;//文件大小
					//最大可上传5M的文件
					if (data.length>=maxFileSize) {
						msg.status=0;//上传失败
						msg.errorMsg="你的文件大小是"+FileSizeHelper.getHumanReadableFileSize(data.length)
						+",超过"+FileSizeHelper.getHumanReadableFileSize(maxFileSize)+"的最大限制";
					}
					boolean check=false;
					for(String e:extArr){
						if(e.equalsIgnoreCase(ext)){
							check=true;
							break;
						}
					}
					if(!check){
						msg.status=0;//上传失败
						msg.errorMsg="你的文件类型不合格";
					}
					
					if(msg.status==1){
						//把文件写存储系统
						FileStorage lf = FileStorageFcatory.get();
						String fileStorageName = lf.write(data, ext);
						msg.fileStorageName=fileStorageName;
					}
				} catch (IOException e1) {
					logger.error("文件上传失败", e1);
					msg.status=0;//上传失败
					msg.errorMsg="文件上传失败,"+e1.toString();
				}
			}
		}
		return jsonList;
	}
	
	/**
	 * 返回的json串的数据格式
	 */
	@SuppressWarnings("unused")
	private class FileMsg{
		public String fileName;//文件原名
		public String fileStorageName;//文件存储名
		public int fileize=0;//文件大小，字节
		public int status=1;//成功标记  1成功，0失败
		public String errorMsg;//错误信息
		public String bak;
	}
	
}
