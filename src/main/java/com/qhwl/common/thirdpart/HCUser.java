package com.qhwl.common.thirdpart;

public class HCUser {
/**
 * {"result":true,
"userInfo":{"memtypeid":6,
"id":100002800874,
"mp":"",
"username":"haomeng62",
"address":"个梵蒂冈",
"email":"haomeng@163.com",
"zipcode":"",
"name":"北京花卉公司",
"userid":30640197},
"access_token":"446228146b6e5040bbc1513c544063a2"}
 * */
	
	private int memtypeid;//用户类型（>=4为会员）
	private String id;//唯一主键
	private String mp;//手机号
	private String username;//用户名称
	private String address;//地址
	private String email;//邮件
	private String zipcode;//邮编
	private String name;//公司名称
	private String userid;//sso主键id
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getMemtypeid() {
		return memtypeid;
	}
	public void setMemtypeid(int memtypeid) {
		this.memtypeid = memtypeid;
	}
	public String getMp() {
		return mp;
	}
	public void setMp(String mp) {
		this.mp = mp;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	
}
