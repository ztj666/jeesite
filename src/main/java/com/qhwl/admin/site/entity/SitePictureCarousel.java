/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.site.entity;

import org.hibernate.validator.constraints.Length;

import com.qhwl.common.persistence.DataEntity;

/**
 * 轮播图片管理Entity
 * @author 张加利
 * @version 2016-07-02
 */
public class SitePictureCarousel extends DataEntity<SitePictureCarousel> {
	
	private static final long serialVersionUID = 1L;
	private String path;		// 图片路径
	private String taget;		// 超链接
	private String title;		// 标题
	private Long sort;		// 排序
	private String type;		// 类型（1首页，2积分商城首页,3文章）
	private String status;		// 状态（1启用，0停用）
	private String bak1;		// 备用字段1
	private String bak2;		// 备用字段2
	private String bak3;		// 备用字段3
	private String bak4;		// 备用字段4
	private String bak5;		// 备用字段5
	
	public SitePictureCarousel() {
		super();
	}

	public SitePictureCarousel(String id){
		super(id);
	}

	@Length(min=0, max=1024, message="图片路径长度必须介于 0 和 1024 之间")
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
	@Length(min=0, max=64, message="超链接长度必须介于 0 和 64 之间")
	public String getTaget() {
		return taget;
	}

	public void setTaget(String taget) {
		this.taget = taget;
	}
	
	@Length(min=0, max=64, message="标题长度必须介于 0 和 64 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public Long getSort() {
		return sort;
	}

	public void setSort(Long sort) {
		this.sort = sort;
	}
	
	@Length(min=0, max=64, message="类型（1首页，2积分商城首页）长度必须介于 0 和 64 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=1, message="状态（1启用，0停用）长度必须介于 0 和 1 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=256, message="备用字段1长度必须介于 0 和 256 之间")
	public String getBak1() {
		return bak1;
	}

	public void setBak1(String bak1) {
		this.bak1 = bak1;
	}
	
	@Length(min=0, max=256, message="备用字段2长度必须介于 0 和 256 之间")
	public String getBak2() {
		return bak2;
	}

	public void setBak2(String bak2) {
		this.bak2 = bak2;
	}
	
	@Length(min=0, max=256, message="备用字段3长度必须介于 0 和 256 之间")
	public String getBak3() {
		return bak3;
	}

	public void setBak3(String bak3) {
		this.bak3 = bak3;
	}
	
	@Length(min=0, max=256, message="备用字段4长度必须介于 0 和 256 之间")
	public String getBak4() {
		return bak4;
	}

	public void setBak4(String bak4) {
		this.bak4 = bak4;
	}
	
	@Length(min=0, max=256, message="备用字段5长度必须介于 0 和 256 之间")
	public String getBak5() {
		return bak5;
	}

	public void setBak5(String bak5) {
		this.bak5 = bak5;
	}
	
}