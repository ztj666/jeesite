package com.qhwl.mobile.front.entity;

public class ResBean {

	private Integer code = 0; // 状态码，1表示成功，0，表示失败
	private String message = "内部错误"; // 错误信息
	private Object data;

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	/**
	 * 设置访问状态的方法
	 * @param bool true 访问成功，false 访问失败
	 */
	public void setStatus(boolean bool){
		if(bool) {
			this.code = 1;
			this.message = "success";
		}else {
			this.code = 0;
			this.message = "false";
		}
	}
	
	public ResBean() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ResBean(Integer code, String message,Object data) {
		super();
		this.code = code;
		this.message = message;
		this.data = data;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
