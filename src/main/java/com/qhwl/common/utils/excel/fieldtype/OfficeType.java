/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.common.utils.excel.fieldtype;

import com.qhwl.admin.sys.entity.Office;
import com.qhwl.admin.sys.utils.UserUtils;
import com.qhwl.common.utils.StringUtils;

/**
 * 字段类型转换
 * @author Admin
 * @version 2013-03-10
 */
public class OfficeType {

	/**
	 * 获取对象值（导入）
	 */
	public static Object getValue(String val) {
		for (Office e : UserUtils.getOfficeList()){
			if (StringUtils.trimToEmpty(val).equals(e.getName())){
				return e;
			}
		}
		return null;
	}

	/**
	 * 设置对象值（导出）
	 */
	public static String setValue(Object val) {
		if (val != null && ((Office)val).getName() != null){
			return ((Office)val).getName();
		}
		return "";
	}
}
