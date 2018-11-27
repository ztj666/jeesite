package com.qhwl.common.enterprise;

import java.util.Date;

public class EnterpriseInfo {
	private String  compnayName;//公司名
	private String  name;//联系人
	private String  nameqq;//联系人qq
	private String  telephoneNum;//联系电话
	private String  cphoneNum;//移动手机
	private String  province;//省id
	private String  cityid;//市id
	private String  manageModel;//经营模式
	private String  fax;//传真号
	private String  comAddress;//传真号
	private String  sellProduct;//主营（销售产品）
	private String  memberRank;//会员等级
	private String  operateType;//经营模式
	private Date  yearTime;//会员年限
	public String getOperateType() {
		return operateType;
	}
	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}
	public Date getYearTime() {
		return yearTime;
	}
	public void setYearTime(Date yearTime) {
		this.yearTime = yearTime;
	}
	public String getMemberRank() {
		return memberRank;
	}
	public void setMemberRank(String memberRank) {
		this.memberRank = memberRank;
	}
	public String getSellProduct() {
		return sellProduct;
	}
	public void setSellProduct(String sellProduct) {
		this.sellProduct = sellProduct;
	}
	public String getComAddress() {
		return comAddress;
	}
	public void setComAddress(String comAddress) {
		this.comAddress = comAddress;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCityid() {
		return cityid;
	}
	public void setCityid(String cityid) {
		this.cityid = cityid;
	}
	public String getCompnayName() {
		return compnayName;
	}
	public void setCompnayName(String compnayName) {
		this.compnayName = compnayName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNameqq() {
		return nameqq;
	}
	public void setNameqq(String nameqq) {
		this.nameqq = nameqq;
	}
	public String getTelephoneNum() {
		return telephoneNum;
	}
	public void setTelephoneNum(String telephoneNum) {
		this.telephoneNum = telephoneNum;
	}
	public String getCphoneNum() {
		return cphoneNum;
	}
	public void setCphoneNum(String cphoneNum) {
		this.cphoneNum = cphoneNum;
	}
	public String getManageModel() {
		return manageModel;
	}
	public void setManageModel(String manageModel) {
		this.manageModel = manageModel;
	}
}
