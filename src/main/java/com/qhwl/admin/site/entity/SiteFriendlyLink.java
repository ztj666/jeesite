/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.entity;

import org.hibernate.validator.constraints.Length;

import com.qhwl.common.persistence.DataEntity;

/**
 * 友情链接Entity
 * @author ztj
 * @version 2016-08-04
 */
public class SiteFriendlyLink extends DataEntity<SiteFriendlyLink> {
	
	private static final long serialVersionUID = 1L;
	private String type;		// type
	private String img;		// img
	private String name;		// name
	private String url;		// url
	private String sort;		// sort
	private String bak1;		// bak1
	private String bak2;		// bak2
	private String bak3;		// bak3
	private String bak4;		// bak4
	private String bak5;		// bak5
	
	public SiteFriendlyLink() {
		super();
	}

	public SiteFriendlyLink(String id){
		super(id);
	}

	@Length(min=1, max=8, message="type长度必须介于 1 和 8 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=64, message="img长度必须介于 0 和 64 之间")
	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
	
	@Length(min=0, max=64, message="name长度必须介于 0 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=128, message="url长度必须介于 0 和 128 之间")
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	@Length(min=0, max=16, message="sort长度必须介于 0 和 16 之间")
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@Length(min=0, max=255, message="bak1长度必须介于 0 和 255 之间")
	public String getBak1() {
		return bak1;
	}

	public void setBak1(String bak1) {
		this.bak1 = bak1;
	}
	
	@Length(min=0, max=255, message="bak2长度必须介于 0 和 255 之间")
	public String getBak2() {
		return bak2;
	}

	public void setBak2(String bak2) {
		this.bak2 = bak2;
	}
	
	@Length(min=0, max=255, message="bak3长度必须介于 0 和 255 之间")
	public String getBak3() {
		return bak3;
	}

	public void setBak3(String bak3) {
		this.bak3 = bak3;
	}
	
	@Length(min=0, max=255, message="bak4长度必须介于 0 和 255 之间")
	public String getBak4() {
		return bak4;
	}

	public void setBak4(String bak4) {
		this.bak4 = bak4;
	}
	
	@Length(min=0, max=255, message="bak5长度必须介于 0 和 255 之间")
	public String getBak5() {
		return bak5;
	}

	public void setBak5(String bak5) {
		this.bak5 = bak5;
	}
	
}