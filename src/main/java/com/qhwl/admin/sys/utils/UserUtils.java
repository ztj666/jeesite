/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.utils;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.UnavailableSecurityManagerException;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import com.qhwl.admin.sys.dao.AreaDao;
import com.qhwl.admin.sys.dao.MenuDao;
import com.qhwl.admin.sys.dao.OfficeDao;
import com.qhwl.admin.sys.dao.RoleDao;
import com.qhwl.admin.sys.dao.UserDao;
import com.qhwl.admin.sys.entity.Area;
import com.qhwl.admin.sys.entity.Menu;
import com.qhwl.admin.sys.entity.Office;
import com.qhwl.admin.sys.entity.Role;
import com.qhwl.admin.sys.entity.User;
import com.qhwl.admin.sys.security.SystemAuthorizingRealm.Principal;
import com.qhwl.common.service.BaseService;
import com.qhwl.common.utils.CacheUtils;
import com.qhwl.common.utils.SpringContextHolder;

/**
 * 用户工具类
 * 
 * @author Admin
 * @version 2013-12-05
 */
public class UserUtils {

	private static UserDao userDao = SpringContextHolder.getBean(UserDao.class);
	private static RoleDao roleDao = SpringContextHolder.getBean(RoleDao.class);
	private static MenuDao menuDao = SpringContextHolder.getBean(MenuDao.class);
	private static AreaDao areaDao = SpringContextHolder.getBean(AreaDao.class);
	private static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);

	public static final String USER_CACHE = "userCache";
	public static final String USER_CACHE_ID_ = "id_";
	public static final String USER_CACHE_LOGIN_NAME_ = "ln";
	public static final String USER_CACHE_LIST_BY_OFFICE_ID_ = "oid_";
	public static final String USER_CACHE_All = "userCacheAll";

	public static final String CACHE_ROLE_LIST = "roleList";
	public static final String CACHE_MENU_LIST = "menuList";
	public static final String CACHE_AREA_LIST = "areaList";
	public static final String CACHE_OFFICE_LIST = "officeList";
	public static final String CACHE_OFFICE_ALL_LIST = "officeAllList";

	/**
	 * 根据ID获取用户
	 * 
	 * @param id
	 * @return 取不到返回null
	 */
	public static User get(String id) {
		User user = (User) CacheUtils.get(USER_CACHE, USER_CACHE_ID_ + id);
		if (user == null) {
			user = userDao.get(id);
			if (user == null) {
				return null;
			}
			user.setRoleList(roleDao.findList(new Role(user)));
			CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
			CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(), user);
		}
		return user;
	}

	/**
	 * 获取所有用户
	 * 
	 * @param name
	 * @return
	 */
	public static List<User> getUserAllList() {
		// List<Dict> dictList= new ArrayList<>();
		// for(User u:){
		// Dict dict=new Dict();
		// dict.setValue(u.getId());
		// dict.setLabel(u.getName());
		// dictList.add(dict);
		// }
		@SuppressWarnings("unchecked")
		List<User> user = (List<User>) CacheUtils.get(USER_CACHE, USER_CACHE_All);
		if (user == null) {
			user = userDao.findAllList(new User());
			CacheUtils.put(USER_CACHE, USER_CACHE_All, user);
		}
		return user;
	}

	/**
	 * 根据id获取用户label
	 * 
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String getUserLabel(String value, String defaultValue) {
		// List<Dict> dictList= new ArrayList<>();
		// for(User u:userDao.findAllList()){
		// Dict dict=new Dict();
		// dict.setValue(u.getId());
		// dict.setLabel(u.getName());
		// dictList.add(dict);
		// }
		List<User> user = (List<User>) CacheUtils.get(USER_CACHE, USER_CACHE_All);
		if (user == null) {
			user = userDao.findAllList(new User());
			CacheUtils.put(USER_CACHE, USER_CACHE_All, user);
		}
		for (User u : user) {
			if (value.equals(u.getId())) {
				return u.getName();
			}
		}
		return defaultValue;
	}
	/**
	 * 根据id获取用户label
	 * 
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static User getUserObj(String value) {
		List<User> user = (List<User>) CacheUtils.get(USER_CACHE, USER_CACHE_All);
		if (user == null) {
			user = userDao.findAllList(new User());
			CacheUtils.put(USER_CACHE, USER_CACHE_All, user);
		}
		for (User u : user) {
			if (value.equals(u.getId())) {
				return u;
			}
		}
		return null;
	}
	// /**
	// * 根据name获取用户
	// * @param name
	// * @return 取不到返回null
	// */
	// public static User getByName(String name){
	// User user = (User)CacheUtils.get(USER_CACHE, USER_CACHE_LOGIN_NAME_ +
	// loginName);
	// if (user == null){
	// user = userDao.getByName(new User(null, name));
	// if (user == null){
	// return null;
	// }
	// user.setRoleList(roleDao.findList(new Role(user)));
	// CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
	// CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(),
	// user);
	// }
	// return user;
	// }
	/**
	 * 根据登录名获取用户
	 * 
	 * @param loginName
	 * @return 取不到返回null
	 */
	public static User getByLoginName(String loginName) {
		User user = (User) CacheUtils.get(USER_CACHE, USER_CACHE_LOGIN_NAME_ + loginName);
		if (user == null) {
			user = userDao.getByLoginName(new User(null, loginName));
			if (user == null) {
				return null;
			}
			user.setRoleList(roleDao.findList(new Role(user)));
			CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
			CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName(), user);
		}
		return user;
	}

	/**
	 * 清除当前用户缓存
	 */
	public static void clearCache() {
		removeCache(CACHE_ROLE_LIST);
		removeCache(CACHE_MENU_LIST);
		removeCache(CACHE_AREA_LIST);
		removeCache(CACHE_OFFICE_LIST);
		removeCache(CACHE_OFFICE_ALL_LIST);
		UserUtils.clearCache(getUser());
	}

	/**
	 * 清除指定用户缓存
	 * 
	 * @param user
	 */
	public static void clearCache(User user) {
		CacheUtils.remove(USER_CACHE, USER_CACHE_ID_ + user.getId());
		CacheUtils.remove(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getLoginName());
		CacheUtils.remove(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getOldLoginName());
		if (user.getOffice() != null && user.getOffice().getId() != null) {
			CacheUtils.remove(USER_CACHE, USER_CACHE_LIST_BY_OFFICE_ID_ + user.getOffice().getId());
		}
	}

	/**
	 * 获取当前用户
	 * 
	 * @return 取不到返回 new User()
	 */
	public static User getUser() {
		Principal principal = getPrincipal();
		if (principal != null) {
			User user = get(principal.getId());
			if (user != null) {
				return user;
			}
			return new User();
		}
		// 如果没有登录，则返回实例化空的User对象。
		return new User();
	}

	/**
	 * 获取当前用户角色列表
	 * 
	 * @return
	 */
	public static List<Role> getRoleList() {
		@SuppressWarnings("unchecked")
		List<Role> roleList = (List<Role>) getCache(CACHE_ROLE_LIST);
		if (roleList == null) {
			User user = getUser();
			if (user.isAdmin()) {
				roleList = roleDao.findAllList(new Role());
			} else {
				Role role = new Role();
				role.getSqlMap().put("dsf", BaseService.dataScopeFilter(user.getCurrentUser(), "o", "u"));
				roleList = roleDao.findList(role);
			}
			putCache(CACHE_ROLE_LIST, roleList);
		}
		return roleList;
	}

	/**
	 * 获取当前用户授权菜单
	 * 
	 * @return
	 */
	public static List<Menu> getMenuList() {
		@SuppressWarnings("unchecked")
		List<Menu> menuList = (List<Menu>) getCache(CACHE_MENU_LIST);
		if (menuList == null) {
			User user = getUser();
			if (user.isAdmin()) {
				menuList = menuDao.findAllList(new Menu());
			} else {
				Menu m = new Menu();
				m.setUserId(user.getId());
				menuList = menuDao.findByUserId(m);
			}
			putCache(CACHE_MENU_LIST, menuList);
		}
		return menuList;
	}

	/**
	 * 获取当前用户授权的区域
	 * 
	 * @return
	 */
	public static List<Area> getAreaList() {
		@SuppressWarnings("unchecked")
		List<Area> areaList = (List<Area>) getCache(CACHE_AREA_LIST);
		if (areaList == null) {
			areaList = areaDao.findAllList(new Area());
			putCache(CACHE_AREA_LIST, areaList);
		}
		return areaList;
	}
	/**
	 * 根据id获取区域label
	 * 
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static String getAreaLabel(String value, String defaultValue) {
		List<Area> areaList = (List<Area>) CacheUtils.get(USER_CACHE, CACHE_AREA_LIST);
		if (areaList == null) {
			areaList = areaDao.findAllList(new Area());
			CacheUtils.put(USER_CACHE, CACHE_AREA_LIST, areaList);
		}
		for (Area u : areaList) {
			if (value.equals(u.getId())) {
				return u.getName();
			}
		}
		return defaultValue;
	}

	/**
	 * 获取当前用户有权限访问的部门
	 * 
	 * @return
	 */
	public static List<Office> getOfficeList() {
		@SuppressWarnings("unchecked")
		List<Office> officeList = (List<Office>) getCache(CACHE_OFFICE_LIST);
		if (officeList == null) {
			User user = getUser();
			if (user.isAdmin()) {
				officeList = officeDao.findAllList(new Office());
			} else {
				Office office = new Office();
				office.getSqlMap().put("dsf", BaseService.dataScopeFilter(user, "a", ""));
				officeList = officeDao.findList(office);
			}
			putCache(CACHE_OFFICE_LIST, officeList);
		}
		return officeList;
	}

	/**
	 * 获取当前用户有权限访问的部门
	 * 
	 * @return
	 */
	public static List<Office> getOfficeAllList() {
		@SuppressWarnings("unchecked")
		List<Office> officeList = (List<Office>) getCache(CACHE_OFFICE_ALL_LIST);
		if (officeList == null) {
			officeList = officeDao.findAllList(new Office());
		}
		return officeList;
	}

	/**
	 * 获取授权主要对象
	 */
	public static Subject getSubject() {
		return SecurityUtils.getSubject();
	}

	/**
	 * 获取当前登录者对象
	 */
	public static Principal getPrincipal() {
		try {
			Subject subject = SecurityUtils.getSubject();
			Principal principal = (Principal) subject.getPrincipal();
			if (principal != null) {
				return principal;
			}
			// subject.logout();
		} catch (UnavailableSecurityManagerException e) {
			// 取不到登录者对象，不应输出异常，很干扰发开人员的分析，直接返回null就很好。
			// e.printStackTrace();
		} catch (InvalidSessionException e) {
			// 取不到登录者对象，不应输出异常，很干扰发开人员的分析，直接返回null就很好。
			// e.printStackTrace();
		}
		return null;
	}

	public static Session getSession() {
		try {
			Subject subject = SecurityUtils.getSubject();
			Session session = subject.getSession(false);
			if (session == null) {
				session = subject.getSession();
			}
			if (session != null) {
				return session;
			}
			// subject.logout();
		} catch (InvalidSessionException e) {

		}
		return null;
	}

	// ============== User Cache ==============

	public static Object getCache(String key) {
		return getCache(key, null);
	}

	public static Object getCache(String key, Object defaultValue) {
		// Object obj = getCacheMap().get(key);
		Object obj = getSession().getAttribute(key);
		return obj == null ? defaultValue : obj;
	}

	public static void putCache(String key, Object value) {
		// getCacheMap().put(key, value);
		getSession().setAttribute(key, value);
	}

	public static void removeCache(String key) {
		// getCacheMap().remove(key);
		getSession().removeAttribute(key);
	}

	// public static Map<String, Object> getCacheMap(){
	// Principal principal = getPrincipal();
	// if(principal!=null){
	// return principal.getCacheMap();
	// }
	// return new HashMap<String, Object>();
	// }

}
