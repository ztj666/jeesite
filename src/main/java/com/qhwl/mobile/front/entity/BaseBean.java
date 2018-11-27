package com.qhwl.mobile.front.entity;

import java.util.List;

public class BaseBean<T> {

	private List<T> t;

	public List<T> getT() {
		return t;
	}

	public void setT(List<T> t) {
		this.t = t;
	}

}
