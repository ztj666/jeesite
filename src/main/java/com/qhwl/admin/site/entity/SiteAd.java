/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.entity;

import org.hibernate.validator.constraints.Length;

import com.qhwl.common.persistence.DataEntity;

/**
 * 广告Entity
 * @author 蔡龙
 * @version 2016-07-22
 */
public class SiteAd extends DataEntity<SiteAd> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 广告标题
	private String bak1;		// bak1
	private String bak2;		// bak2
	private String bak3;		// bak3
	private String bak4;		// bak4
	private String bak5;		// bak5
	private String content;		// 广告内容
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public SiteAd() {
		super();
	}

	public SiteAd(String id){
		super(id);
	}

	@Length(min=0, max=256, message="广告标题长度必须介于 0 和 256 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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