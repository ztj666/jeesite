/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.common.persistence;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.qhwl.common.config.Global;

/**
 * 分页类
 * 
 * @author Admin
 * @version 2013-7-2
 * @param <T>
 */
public class Page<T> {
	static String PAGESIZE = "pageSize";// 常量
	static String PAGENO = "pageNo";// 常量

	public String encod = "UTF-8"; // 编码，从request中取参数时，可能要使用它
	private String pageURL; // 分页导航的URL+查询参数

	private int pageNo = 1; // 当前页码
	private int pageSize = Integer.valueOf(Global.getConfig("page.pageSize")); // 页面大小，设置为“-1”表示不进行分页（分页无效）

	private long count;// 总记录数，设置为“-1”表示不查询总数

	private int first;// 首页索引
	private int last;// 尾页索引
	private int prev;// 上一页索引
	private int next;// 下一页索引
	private boolean firstPage;// 是否是第一页

	private boolean lastPage;// 是否是最后一页

	private int length = 8;// 显示页面长度
	private int slider = 1;// 前后显示页面长度

	private List<T> list = new ArrayList<T>();

	private String orderBy = ""; // 标准查询有效， 实例： updatedate desc, name asc
	private String message = ""; // 设置提示消息，显示在“共n条”之后

	// 计划淘汰以下两个参数
	private String funcName = "page"; // 设置点击页码调用的js函数名称，默认为page，在一页有多个分页对象时使用。
	private String funcParam = ""; // 函数的附加参数，第三个参数值。

	/**
	 * 构造方法
	 * 
	 * @param request
	 *            传递 repage 参数，来记住页码
	 * @param response
	 *            用于设置 Cookie，记住页码
	 */
	public Page(HttpServletRequest request, HttpServletResponse response) {
		this(request, response, -2);
	}

	/**
	 * 构造方法
	 * 
	 * @param request
	 *            传递 repage 参数，记住页码,   2016-8-13 赵磊修改：使用RepageInterceptor来实现，替换cookie实现
	 * @param response
	 *            用于设置 Cookie，记住页码
	 * @param defaultPageSize
	 *            默认分页大小，如果传递 -1 则为不分页，返回所有数据
	 */
	public Page(HttpServletRequest request, HttpServletResponse response, int defaultPageSize) {
		// 设置页码参数（传递repage参数，来记住页码）
		String no = request.getParameter(PAGENO);
		if (StringUtils.isNumeric(no)) {
//			CookieUtils.setCookie(request, response, PAGENO, no);
			this.setPageNo(Integer.parseInt(no));
//		} else if (request.getParameter("repage") != null) {
//			no = CookieUtils.getCookie(request, PAGENO);
//			if (StringUtils.isNumeric(no)) {
//				this.setPageNo(Integer.parseInt(no));
//			}
		}
		// 设置页面大小参数（传递repage参数，来记住页大小）
		String size = request.getParameter(PAGESIZE);
		if (StringUtils.isNumeric(size)) {
//			CookieUtils.setCookie(request, response, PAGESIZE, size);
			this.setPageSize(Integer.parseInt(size));
//		} else if (request.getParameter("repage") != null) {
//			no = CookieUtils.getCookie(request, PAGESIZE);
//			if (StringUtils.isNumeric(size)) {
//				this.setPageSize(Integer.parseInt(size));
//			}
		} else if (defaultPageSize != -2) {
			this.pageSize = defaultPageSize;
		}
		// 设置排序参数
		String orderBy = request.getParameter("orderBy");
		if (StringUtils.isNotBlank(orderBy)) {
			this.setOrderBy(orderBy);
		}

		// 构造分页导航的URL，包含查询参数
		// 用于点击“下一页”时，能带参数进行查询
		buildPageURL(request);
	}

	/**
	 * 构造方法
	 */
	public Page() {
		this.pageSize = -1;
	}

	/**
	 * 构造方法
	 * 
	 * @param pageNo
	 *            当前页码
	 * @param pageSize
	 *            分页大小
	 */
	public Page(int pageNo, int pageSize) {
		this(pageNo, pageSize, 0);
	}

	/**
	 * 构造方法
	 * 
	 * @param pageNo
	 *            当前页码
	 * @param pageSize
	 *            分页大小
	 * @param count
	 *            数据条数
	 */
	public Page(int pageNo, int pageSize, long count) {
		this(pageNo, pageSize, count, new ArrayList<T>());
	}

	/**
	 * 构造方法
	 * 
	 * @param pageNo
	 *            当前页码
	 * @param pageSize
	 *            分页大小
	 * @param count
	 *            数据条数
	 * @param list
	 *            本页数据对象列表
	 */
	public Page(int pageNo, int pageSize, long count, List<T> list) {
		this.setCount(count);
		this.setPageNo(pageNo);
		this.pageSize = pageSize;
		this.list = list;
	}

	/**
	 * 初始化参数
	 */
	public void initialize() {

		// 1
		this.first = 1;

		this.last = (int) (count / (this.pageSize < 1 ? 20 : this.pageSize) + first - 1);

		if (this.count % this.pageSize != 0 || this.last == 0) {
			this.last++;
		}

		if (this.last < this.first) {
			this.last = this.first;
		}

		if (this.pageNo <= 1) {
			this.pageNo = this.first;
			this.firstPage = true;
		}

		if (this.pageNo >= this.last) {
			this.pageNo = this.last;
			this.lastPage = true;
		}

		if (this.pageNo < this.last - 1) {
			this.next = this.pageNo + 1;
		} else {
			this.next = this.last;
		}

		if (this.pageNo > 1) {
			this.prev = this.pageNo - 1;
		} else {
			this.prev = this.first;
		}

		// 2
		if (this.pageNo < this.first) {// 如果当前页小于首页
			this.pageNo = this.first;
		}

		if (this.pageNo > this.last) {// 如果当前页大于尾页
			this.pageNo = this.last;
		}

	}

	/**
	 * 默认输出当前分页标签 <div class="page">${page}</div>
	 */
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		if (pageNo == first) {
			// 如果是首页,"上一页"不可点击
			sb.append("<li class=\"disabled\"><a href=\"javascript:\">&#171; 上一页</a></li>\n");
		} else {
			// 如果不是首页,"上一页"可点击
			sb.append("<li><a href=\"" + pageURL + prev + "\" >&#171; 上一页</a></li>\n");
		}

		int begin = pageNo - (length / 2);// 左边的起始页码，如当前是第50页，最左边的页码是46

		if (begin < first) {
			begin = first;// 防止出现负数
		}

		int end = begin + length - 1;// 右边的结束页码，如当前是第50页，最右边的页码是54

		if (end >= last) {
			end = last; // 防止超过总页数
			begin = end - length + 1;
			if (begin < first) {
				begin = first;
			}
		}

		// 在循环中生成 左边的页码。slider为1时，作用就是“首页”
		if (begin > first) {
			int i = 0;
			for (i = first; i < first + slider && i < begin; i++) {
				sb.append("<li><a href=\"" + pageURL + i + "\" >" + (i + 1 - first) + "</a></li>\n");
			}
			if (i < begin) {
				sb.append("<li class=\"disabled\"><a href=\"javascript:\">...</a></li>\n");
			}
		}

		// 在循环中生成 中间的页码，如当前是第50页，46，47，48，49，50，51，52，53，54，并且50页不可点击
		for (int i = begin; i <= end; i++) {
			if (i == pageNo) {
				sb.append("<li class=\"active\"><a href=\"javascript:\">" + (i + 1 - first) + "</a></li>\n");
			} else {
				sb.append("<li><a href=\"" + pageURL + i + "\" >" + (i + 1 - first) + "</a></li>\n");
			}
		}

		if (last - end > slider) {
			sb.append("<li class=\"disabled\"><a href=\"javascript:\">...</a></li>\n");
			end = last - slider;
		}

		// 在循环中生成 右边的页码。slider为1时，作用就是“尾页”
		for (int i = end + 1; i <= last; i++) {
			sb.append("<li><a href=\"" + pageURL + i + "\" >" + (i + 1 - first) + "</a></li>\n");
		}

		if (pageNo == last) {
			// 如果是尾页,"下一页"不可点击
			sb.append("<li class=\"disabled\"><a href=\"javascript:\">下一页 &#187;</a></li>\n");
		} else {
			// 如果不是尾页,"下一页"可点击
			sb.append("<li><a href=\"" + pageURL + next + "\" >" + "下一页 &#187;</a></li>\n");
		}

		sb.append("<li class=\"disabled controls\"><a href=\"javascript:\">跳到 ");
		sb.append("<input type=\"text\" value=\"" + pageNo + "\" href=\"" + pageURL + "\" ");
		sb.append("onkeypress=\"var e=window.event||this;var c=e.keyCode||e.which;if(c==13)");
		sb.append("window.location.href=this.getAttribute('href')+(this.value)\" onclick=\"this.select();\"/> ");
		sb.append("共 " + count + " 条" + (message != null ? message : "") + "</a></li>\n");
		sb.insert(0, "<ul>\n").append("</ul>\n");
		sb.append("<div style=\"clear:both;\"></div>");
		return sb.toString();
	}

	// /**
	// * 默认输出当前分页标签 --使用js翻页对搜索引擎不友好，已停止使用
	// * <div class="page">${page}</div>
	// */
	// public String toString2() {
	// StringBuilder sb = new StringBuilder();
	// if (pageNo == first) {// 如果是首页
	// sb.append("<li class=\"disabled\"><a href=\"javascript:\">&#171;
	// 上一页</a></li>\n");
	// } else {
	// sb.append("<li><a href=\"javascript:\"
	// onclick=\""+funcName+"("+prev+","+pageSize+",'"+funcParam+"');\">&#171;
	// 上一页</a></li>\n");
	// }
	//
	// int begin = pageNo - (length / 2);
	//
	// if (begin < first) {
	// begin = first;
	// }
	//
	// int end = begin + length - 1;
	//
	// if (end >= last) {
	// end = last;
	// begin = end - length + 1;
	// if (begin < first) {
	// begin = first;
	// }
	// }
	//
	// if (begin > first) {
	// int i = 0;
	// for (i = first; i < first + slider && i < begin; i++) {
	// sb.append("<li><a href=\"javascript:\"
	// onclick=\""+funcName+"("+i+","+pageSize+",'"+funcParam+"');\">"
	// + (i + 1 - first) + "</a></li>\n");
	// }
	// if (i < begin) {
	// sb.append("<li class=\"disabled\"><a
	// href=\"javascript:\">...</a></li>\n");
	// }
	// }
	//
	// for (int i = begin; i <= end; i++) {
	// if (i == pageNo) {
	// sb.append("<li class=\"active\"><a href=\"javascript:\">" + (i + 1 -
	// first)
	// + "</a></li>\n");
	// } else {
	// sb.append("<li><a href=\"javascript:\"
	// onclick=\""+funcName+"("+i+","+pageSize+",'"+funcParam+"');\">"
	// + (i + 1 - first) + "</a></li>\n");
	// }
	// }
	//
	// if (last - end > slider) {
	// sb.append("<li class=\"disabled\"><a
	// href=\"javascript:\">...</a></li>\n");
	// end = last - slider;
	// }
	//
	// for (int i = end + 1; i <= last; i++) {
	// sb.append("<li><a href=\"javascript:\"
	// onclick=\""+funcName+"("+i+","+pageSize+",'"+funcParam+"');\">"
	// + (i + 1 - first) + "</a></li>\n");
	// }
	//
	// if (pageNo == last) {
	// sb.append("<li class=\"disabled\"><a href=\"javascript:\">下一页
	// &#187;</a></li>\n");
	// } else {
	// sb.append("<li><a href=\"javascript:\"
	// onclick=\""+funcName+"("+next+","+pageSize+",'"+funcParam+"');\">"
	// + "下一页 &#187;</a></li>\n");
	// }
	//
	// sb.append("<li class=\"disabled controls\"><a href=\"javascript:\">当前 ");
	// sb.append("<input type=\"text\" value=\""+pageNo+"\" onkeypress=\"var
	// e=window.event||this;var c=e.keyCode||e.which;if(c==13)");
	// sb.append(funcName+"(this.value,"+pageSize+",'"+funcParam+"');\"
	// onclick=\"this.select();\"/> / ");
	// sb.append("<input type=\"text\" value=\""+pageSize+"\" onkeypress=\"var
	// e=window.event||this;var c=e.keyCode||e.which;if(c==13)");
	// sb.append(funcName+"("+pageNo+",this.value,'"+funcParam+"');\"
	// onclick=\"this.select();\"/> 条，");
	// sb.append("共 " + count + " 条"+(message!=null?message:"")+"</a></li>\n");
	// sb.insert(0,"<ul>\n").append("</ul>\n");
	// sb.append("<div style=\"clear:both;\"></div>");
	// return sb.toString();
	// }

	/**
	 * 获取分页HTML代码
	 * 
	 * @return
	 */
	public String getHtml() {
		return toString();
	}

	// public static void main(String[] args) {
	// Page<String> p = new Page<String>(3, 3);
	// System.out.println(p);
	// System.out.println("首页："+p.getFirst());
	// System.out.println("尾页："+p.getLast());
	// System.out.println("上页："+p.getPrev());
	// System.out.println("下页："+p.getNext());
	// }
	public static String getParam(String queryString) {
		return queryString.substring(queryString.indexOf("?") + 1).replace("&amp;", "&");
	}

	/**
	 * 获取设置总数
	 * 
	 * @return
	 */
	public long getCount() {
		return count;
	}

	/**
	 * 设置数据总数
	 * 
	 * @param count
	 */
	public void setCount(long count) {
		this.count = count;
		if (pageSize >= count) {
			pageNo = 1;
		}
		initialize();
	}

	/**
	 * 获取当前页码
	 * 
	 * @return
	 */
	public int getPageNo() {
		return pageNo;
	}

	/**
	 * 设置当前页码
	 * 
	 * @param pageNo
	 */
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	/**
	 * 获取页面大小
	 * 
	 * @return
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * 设置页面大小（最大500）
	 * 
	 * @param pageSize
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize <= 0 ? 10 : pageSize;// > 500 ? 500 : pageSize;
	}

	/**
	 * 首页索引
	 * 
	 * @return
	 */
	@JsonIgnore
	public int getFirst() {
		return first;
	}

	/**
	 * 尾页索引
	 * 
	 * @return
	 */
	@JsonIgnore
	public int getLast() {
		return last;
	}

	/**
	 * 获取页面总数
	 * 
	 * @return getLast();
	 */
	@JsonIgnore
	public int getTotalPage() {
		return getLast();
	}

	/**
	 * 是否为第一页
	 * 
	 * @return
	 */
	@JsonIgnore
	public boolean isFirstPage() {
		return firstPage;
	}

	/**
	 * 是否为最后一页
	 * 
	 * @return
	 */
	@JsonIgnore
	public boolean isLastPage() {
		return lastPage;
	}

	/**
	 * 上一页索引值
	 * 
	 * @return
	 */
	@JsonIgnore
	public int getPrev() {
		if (isFirstPage()) {
			return pageNo;
		} else {
			return pageNo - 1;
		}
	}

	/**
	 * 下一页索引值
	 * 
	 * @return
	 */
	@JsonIgnore
	public int getNext() {
		if (isLastPage()) {
			return pageNo;
		} else {
			return pageNo + 1;
		}
	}

	/**
	 * 获取本页数据对象列表
	 * 
	 * @return List<T>
	 */
	public List<T> getList() {
		return list;
	}

	/**
	 * 设置本页数据对象列表
	 * 
	 * @param list
	 */
	public Page<T> setList(List<T> list) {
		this.list = list;
		initialize();
		return this;
	}

	/**
	 * 获取查询排序字符串
	 * 
	 * @return
	 */
	@JsonIgnore
	public String getOrderBy() {
		// SQL过滤，防止注入
		String reg = "(?:')|(?:--)|(/\\*(?:.|[\\n\\r])*?\\*/)|"
				+ "(\\b(select|update|and|or|delete|insert|trancate|char|into|substr|ascii|declare|exec|count|master|into|drop|execute)\\b)";
		Pattern sqlPattern = Pattern.compile(reg, Pattern.CASE_INSENSITIVE);
		if (sqlPattern.matcher(orderBy).find()) {
			return "";
		}
		return orderBy;
	}

	/**
	 * 设置查询排序，标准查询有效， 实例： updatedate desc, name asc
	 */
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	/**
	 * 获取点击页码调用的js函数名称 function ${page.funcName}(pageNo){location=
	 * "${ctx}/list-${category.id}${urlSuffix}?pageNo="+i;}
	 * 
	 * @return
	 */
	@JsonIgnore
	public String getFuncName() {
		return funcName;
	}

	/**
	 * 设置点击页码调用的js函数名称，默认为page，在一页有多个分页对象时使用。
	 * 
	 * @param funcName
	 *            默认为page
	 */
	public void setFuncName(String funcName) {
		this.funcName = funcName;
	}

	/**
	 * 获取分页函数的附加参数
	 * 
	 * @return
	 */
	@JsonIgnore
	public String getFuncParam() {
		return funcParam;
	}

	/**
	 * 设置分页函数的附加参数
	 * 
	 * @return
	 */
	public void setFuncParam(String funcParam) {
		this.funcParam = funcParam;
	}

	/**
	 * 设置提示消息，显示在“共n条”之后
	 * 
	 * @param message
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * 分页是否有效
	 * 
	 * @return this.pageSize==-1
	 */
	@JsonIgnore
	public boolean isDisabled() {
		return this.pageSize == -1;
	}

	/**
	 * 是否进行总数统计
	 * 
	 * @return this.count==-1
	 */
	@JsonIgnore
	public boolean isNotCount() {
		return this.count == -1;
	}

	/**
	 * 获取 Hibernate FirstResult
	 */
	public int getFirstResult() {
		int firstResult = (getPageNo() - 1) * getPageSize();
		if (firstResult >= getCount()) {
			firstResult = 0;
		}
		return firstResult;
	}

	/**
	 * 获取 Hibernate MaxResults
	 */
	public int getMaxResults() {
		return getPageSize();
	}

	/**
	 * 构造分页导航的URL，包含查询参数 用于点击“下一页”时，能带参数进行查询
	 * 
	 * @param request
	 */
	private void buildPageURL(HttpServletRequest request) {
		String sPageURLPara = buildParameter(request);
		if (sPageURLPara.length() > 0) {
			pageURL = "?" + sPageURLPara.substring(1) + "&";
		} else {
			pageURL = "?";
		}
		pageURL = request.getRequestURI() + pageURL + "pageNo=";

	}

	/**
	 * 从HttpServletRequest取参数，刨除pageNo参数（页码）
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @return 参数的字符串形式，如 &a=1&b=2
	 */
	@SuppressWarnings("rawtypes")
	private String buildParameter(HttpServletRequest request) {

		Map map = request.getParameterMap();
		Set set = map.keySet();
		Iterator it = set.iterator();
		StringBuilder sbf = new StringBuilder();
		while (it.hasNext()) {
			String key = (String) it.next();
			if ((!key.equals(PAGENO)) && (!key.equals(PAGESIZE))) {
				String[] values = (String[]) map.get(key);
				for (String v : values) {
					sbf.append("&");
					sbf.append(key);
					sbf.append("=");
					if (request.getCharacterEncoding() == null) {
						// 如果request没设置编码，就要解码
						try {
							sbf.append(new String(v.getBytes("iso-8859-1"), encod));
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					} else {
						// 如果request已设置编码，直接取值就OK
						sbf.append(v);
					}
				}
			}
		}

		// 若有多个pageSize参数，只取最后一个，只拼接一次
		// 一般情况pageSize参数只会有一个
		String[] pageSize_value = request.getParameterValues(PAGESIZE);
		if (pageSize_value != null) {
			for (int i = pageSize_value.length - 1; i >= 0; i--) {
				String v = pageSize_value[i];
				if (StringUtils.isNoneBlank(v)) {
					sbf.append("&").append(PAGESIZE).append("=").append(v);
					break;// 从最后开始找，找到一个就返回了
				}
			}
		}

		return sbf.toString();
	}

	public String getPageURL() {
		return pageURL;
	}

	public int getLength() {
		return length;
	}

	public int getSlider() {
		return slider;
	}

	public String getMessage() {
		return message;
	}
}