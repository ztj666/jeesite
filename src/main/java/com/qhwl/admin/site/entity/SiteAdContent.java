/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.entity;

import org.hibernate.validator.constraints.Length;

import com.qhwl.common.persistence.DataEntity;

/**
 * 广告内容Entity
 * @author 蔡龙
 * @version 2016-07-22
 */
public class SiteAdContent extends DataEntity<SiteAdContent> {
	
	private static final long serialVersionUID = 1L;
	private String adid;		// 关联SITE_AD表主键
	private String content;		// 广告内容
	private String status;		// 状态
	private String bak1;		// bak1
	private String bak2;		// bak2
	private String bak3;		// bak3
	private String bak4;		// bak4
	private String bak5;		// bak5
	
	public SiteAdContent() {
		super();
	}

	public SiteAdContent(String id){
		super(id);
	}

	@Length(min=1, max=64, message="关联SITE_AD表主键长度必须介于 1 和 64 之间")
	public String getAdid() {
		return adid;
	}

	public void setAdid(String adid) {
		this.adid = adid;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=1, max=1, message="状态长度必须介于 1 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=256, message="bak1长度必须介于 0 和 256 之间")
	public String getBak1() {
		return bak1;
	}

	public void setBak1(String bak1) {
		this.bak1 = bak1;
	}
	
	@Length(min=0, max=256, message="bak2长度必须介于 0 和 256 之间")
	public String getBak2() {
		return bak2;
	}

	public void setBak2(String bak2) {
		this.bak2 = bak2;
	}
	
	@Length(min=0, max=256, message="bak3长度必须介于 0 和 256 之间")
	public String getBak3() {
		return bak3;
	}

	public void setBak3(String bak3) {
		this.bak3 = bak3;
	}
	
	@Length(min=0, max=256, message="bak4长度必须介于 0 和 256 之间")
	public String getBak4() {
		return bak4;
	}

	public void setBak4(String bak4) {
		this.bak4 = bak4;
	}
	
	@Length(min=0, max=256, message="bak5长度必须介于 0 和 256 之间")
	public String getBak5() {
		return bak5;
	}

	public void setBak5(String bak5) {
		this.bak5 = bak5;
	}
	
}