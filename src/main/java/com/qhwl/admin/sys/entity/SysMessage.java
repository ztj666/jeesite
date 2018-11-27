/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.entity;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.qhwl.common.persistence.DataEntity;

/**
 * 消息管理Entity
 * @author ztj
 * @version 2016-09-29
 */
public class SysMessage extends DataEntity<SysMessage> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// user_id
	private String type;		// 1系统 2管理员
	private String content;		// content
	private String subject;		// subject
	private String bak1;		// bak1
	private String bak2;		// bak2
	private String bak3;		// bak3
	private String bak4;		// bak4
	private String bak5;		// bak5
	
	public SysMessage() {
		super();
	}

	public SysMessage(String id){
		super(id);
	}

	@NotNull(message="user_id不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	@Length(min=1, max=1, message="1系统 2管理员长度必须介于 1 和 1 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=512, message="content长度必须介于 0 和 512 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=0, max=64, message="subject长度必须介于 0 和 64 之间")
	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
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