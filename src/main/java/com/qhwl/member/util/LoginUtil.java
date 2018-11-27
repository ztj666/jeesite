package com.qhwl.member.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.qhwl.admin.sys.entity.User;

public class LoginUtil {
	/**
	 * 获取登录用户
	 * 
	 * @param request
	 * @return
	 */
	public static User getLoginUser(HttpServletRequest request) {
		return (User) request.getSession().getAttribute("userInfo");
	}

	/**
	 * 设置登录信息
	 * 
	 * @param request
	 * @param memberUser
	 */
	public static void setLoginUser(HttpServletRequest request, User memberUser) {
		HttpSession session = request.getSession();
		session.setAttribute("userInfo", memberUser);
		session.setAttribute("token", session.getId());
	}
	/**
	 * 移除登录信息
	 * 
	 * @param request
	 * @param memberUser
	 */
	public static void removeLoginUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("userInfo");
		session.removeAttribute("token");
	}
}
