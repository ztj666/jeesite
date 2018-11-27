package com.qhwl.common.thirdpart;

public class Token {

	/**
	 * {"re_expires_in":"365",
		"state":"123",
		"expires_in":184,
		"token_type":"bearer",
		"refresh_token":"11dee5d327229aa1e118ee2f9d55d0be",
		"access_token":"446228146b6e5040bbc1513c544063a2"}
	 * */
	private int re_expires_in;
	private String state;
	private int expires_in;
	private String token_type;
	private String refresh_token;
	private String access_token;
	public int getRe_expires_in() {
		return re_expires_in;
	}
	public void setRe_expires_in(int re_expires_in) {
		this.re_expires_in = re_expires_in;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getExpires_in() {
		return expires_in;
	}
	public void setExpires_in(int expires_in) {
		this.expires_in = expires_in;
	}
	public String getToken_type() {
		return token_type;
	}
	public void setToken_type(String token_type) {
		this.token_type = token_type;
	}
	public String getRefresh_token() {
		return refresh_token;
	}
	public void setRefresh_token(String refresh_token) {
		this.refresh_token = refresh_token;
	}
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
}
