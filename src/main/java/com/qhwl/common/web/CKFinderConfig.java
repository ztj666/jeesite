/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.common.web;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;

import com.ckfinder.connector.configuration.Configuration;
import com.ckfinder.connector.data.AccessControlLevel;
import com.ckfinder.connector.utils.AccessControlUtil;
import com.qhwl.admin.sys.security.SystemAuthorizingRealm.Principal;
import com.qhwl.admin.sys.utils.UserUtils;
import com.qhwl.common.config.Global;
import com.qhwl.common.utils.FileUtils;

/**
 * CKFinder配置
 * @author Admin
 * @version 2014-06-25
 */
public class CKFinderConfig extends Configuration {

	public CKFinderConfig(ServletConfig servletConfig) {
        super(servletConfig);  
    }
	
	@Override
    protected Configuration createConfigurationInstance() {
		Principal principal = (Principal) UserUtils.getPrincipal();
		if (principal == null){
			return new CKFinderConfig(this.servletConf);
		}
		boolean isView = true;//UserUtils.getSubject().isPermitted("cms:ckfinder:view");
		boolean isUpload = true;//UserUtils.getSubject().isPermitted("cms:ckfinder:upload");
		boolean isEdit = true;//UserUtils.getSubject().isPermitted("cms:ckfinder:edit");
		AccessControlLevel alc = this.getAccessConrolLevels().get(0);
		alc.setFolderView(isView);
		alc.setFolderCreate(isEdit);
		alc.setFolderRename(isEdit);
		alc.setFolderDelete(isEdit);
		alc.setFileView(isView);
		alc.setFileUpload(isUpload);
		alc.setFileRename(isEdit);
		alc.setFileDelete(isEdit);
//		for (AccessControlLevel a : this.getAccessConrolLevels()){
//			System.out.println(a.getRole()+", "+a.getResourceType()+", "+a.getFolder()
//					+", "+a.isFolderView()+", "+a.isFolderCreate()+", "+a.isFolderRename()+", "+a.isFolderDelete()
//					+", "+a.isFileView()+", "+a.isFileUpload()+", "+a.isFileRename()+", "+a.isFileDelete());
//		}
		AccessControlUtil.getInstance(this).loadACLConfig();
		try {
//			Principal principal = (Principal)SecurityUtils.getSubject().getPrincipal();
//			this.baseURL = ServletContextFactory.getServletContext().getContextPath()+"/userfiles/"+principal+"/";
			this.baseURL = FileUtils.path(Servlets.getRequest().getContextPath() + Global.USERFILES_BASE_URL + principal + "/");
			this.baseDir = FileUtils.path(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + principal + "/");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return new CKFinderConfig(this.servletConf);
    }

    /**
     * 在这里控制，CKFinder的访问权限
     * 可以在checkAuthentication()方法里编写关于用户认证的一些判断，比如用户是否登录系统，用户是否有权限管理上传文件。
     * 如果符合条件，就返回ture，否则返回false。
     */
    @Override  
    public boolean checkAuthentication(final HttpServletRequest request) {
    	//管理后台用户登录后就可以访问、使用CKFinder
    	boolean b1=UserUtils.getPrincipal() != null;
    	//会员中心用户登录后就可以访问、使用CKFinder
//    	boolean b2=LoginUtil.getLoginUser(request)!=null;
    	if(b1 || b1){//b2
    		return true;
    	}else{
    		return false;
    	}
    }
}
