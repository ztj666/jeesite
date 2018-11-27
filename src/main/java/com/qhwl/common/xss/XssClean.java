package com.qhwl.common.xss;

import org.apache.commons.lang3.ArrayUtils;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * 使用白名单，过滤掉html中的有xss攻击危险代码
 * 
 * 问题
 * 在做网站的时候，经常会提供用户评论的功能。有些不怀好意的用户，会搞一些脚本到评论内容中，而这些脚本可能会破坏整个页面的行为，更严重的是获取一些机要信息，此时需要清理该HTML，以避免跨站脚本cross-site scripting攻击（XSS）。
 * 方法
 * 使用jsoup HTML Cleaner 方法进行清除，但需要指定一个可配置的 Whitelist。
 * 示例
 * String unsafe ="<p><a href='http://example.com/' onclick='stealCookies()'>Link</a></p>";
 * String safe = Jsoup.clean(unsafe, Whitelist.basic());
 * // now: <p><a href="http://example.com/" rel="nofollow">Link</a></p>
 * 
 * jsoup提供了一系列的Whitelist基本配置，能够满足大多数要求；但如有必要，也可以进行修改，不过要小心。
 * 这个cleaner非常好用不仅可以避免XSS攻击，还可以限制用户可以输入的标签范围。
 * 
 * 五种基本白名单
 * Whitelist.none() 这个白名单只允许文本节点：所有HTML将被过滤。
 * Whitelist.simpleText() 这个白名单只允许简单的文本格式：b, em, i, strong, u。所有其他HTML（标签和属性）都将被删除。
 * Whitelist.basic() 这个白名单允许更全面的文本节点：a, b, blockquote, br, cite, code, dd, dl, dt, em, i, li, ol, p, pre, q, small, span, strike, strong, sub, sup, u, ul。和适当的属性。链接可以指向HTTP，HTTPS，FTP，邮件，有一个强制rel= nofollow属性。
 * Whitelist.basicWithImages() 这个白名单与basic()相同，又加上了IMG标签，可有适当的属性，src可指向HTTP或HTTPS。
 * Whitelist.relaxed() 这个白名单允许全方位的文本和HTML标签：a, b, blockquote, br, caption, cite, code, col, colgroup, dd, div, dl, dt, em, h1, h2, h3, h4, h5, h6, i, img, li, ol, p, pre, q, small, span, strike, strong, sub, sup, table, tbody, td, tfoot, th, thead, tr, u, ul
 * 链接没有强制rel= nofollow属性，但是你可以添加，如果需要的话。
 * 
 * 
 * @author zhaolei
 */
public class XssClean{
    public static final Logger LOG = LoggerFactory.getLogger(XssClean.class);

    private String whitelistBase="relaxed";//值范围none、simpleText、basic、basicWithImages、relaxed
    private String[] addTags;
    private String[] removeTags;
    
    //数据结构：使用，$两种符号隔开的二维结构
    //示例：":all,id,class$table,width,height,xxx"      :all表示全部标签
    //语法："全部标签,id属性,class属性$table标签,width属性,height属性,xxx属性"
    private String addAttributes=null;
    
    //数据结构：使用，$两种符号隔开的二维结构
    //示例："img,src,data,ftp$img,src,data,ftp"      不支持:all
    //语法："标签名,src属性,支持data协议,支持ftp协议"
    private String addProtocols=null;
    
    

    public String getWhitelistBase() {
		return whitelistBase;
	}

	public void setWhitelistBase(String whitelistBase) {
		this.whitelistBase = whitelistBase;
	}

	public String[] getAddTags() {
		return addTags;
	}

	public void setAddTags(String[] addTags) {
		this.addTags = addTags;
	}

	public String[] getRemoveTags() {
		return removeTags;
	}

	public void setRemoveTags(String[] removeTags) {
		this.removeTags = removeTags;
	}

	public String getAddAttributes() {
		return addAttributes;
	}

	public void setAddAttributes(String addAttributes) {
		this.addAttributes = addAttributes;
	}

	public String getAddProtocols() {
		return addProtocols;
	}

	public void setAddProtocols(String addProtocols) {
		this.addProtocols = addProtocols;
	}

	/**
     * 使用白名单，过滤掉html中的有xss攻击危险代码
     * 
     * @param unsafeHtml  有xss攻击危险代码的html代码
     * @return  干净的html代码
     */
	public String baseClean(String unsafeHtml) {
		// 构造白名单
		Whitelist whitelist = null;
		if (whitelistBase.equals("none")) {
			whitelist = Whitelist.none();
		} else if (whitelistBase.equals("simpleText")) {
			whitelist = Whitelist.simpleText();
		} else if (whitelistBase.equals("basic")) {
			whitelist = Whitelist.basic();
		} else if (whitelistBase.equals("basicWithImages")) {
			whitelist = Whitelist.basicWithImages();
		} else if (whitelistBase.equals("relaxed")) {
			whitelist = Whitelist.relaxed();
		}
		if (addTags != null) {
			for (String tag : addTags) {
				if (tag != null && !"".equals(tag.trim())) {
					whitelist.addTags(tag.trim());
				}
			}
		}
		if (removeTags != null) {
			for (String tag : removeTags) {
				if (tag != null && !"".equals(tag.trim())) {
					whitelist.removeTags(tag.trim());
				}
			}
		}
		if (addAttributes != null) {
			String[] a = addAttributes.split("\\$");// 示例：":all,id,class$table,width,height,xxx"
			for (String b : a) {
				String[] c = b.split(",");
				String[] d = ArrayUtils.subarray(c, 1, c.length);
				whitelist.addAttributes(c[0], d);
			}
		}
		if (addProtocols != null) {
			String[] a = addProtocols.split("\\$");// 示例："img,src,data,ftp$img,src,ftp"
			for (String b : a) {
				String[] c = b.split(",");
				String[] d = ArrayUtils.subarray(c, 2, c.length);
				whitelist.addProtocols(c[0], c[1], d);
			}
		}

		// 执行白名单过滤
		String safeHtml = Jsoup.clean(unsafeHtml, whitelist);
		return safeHtml;
	}
	
	/**
     * 使用白名单，过滤掉html中的有xss攻击危险代码
     * 
     * @param unsafeHtml  有xss攻击危险代码的html代码
     * @return  干净的html代码
     */
	public static String clean(String unsafeHtml) {
		XssClean xss=new XssClean();
    	xss.setWhitelistBase("relaxed");//Whitelist.relaxed() 这个白名单,本白名单包含了哪些html标签请看类上的注释
    	xss.setAddAttributes(":all,id,class,name,style,width,height");//向白名单添加 html标签的属性
    	String safeHtml = xss.baseClean(unsafeHtml);
    	return safeHtml;
	}

    public static void main(String[] input) {
    	String unsafe = "<p id='abc' class='c1' name='n2' >"
    			+ "<a href='http://example.com/' onclick='stealCookies()'>Link</a>"
    			+ "<img width='300' height='200' src='javascript:alert(123);'></img>"
    			+ "</p>";
    	
    	String safe=XssClean.clean(unsafe);
    	System.out.println(safe);
    	// now: <p><a href="http://example.com/" rel="nofollow">Link</a></p>
    }
}
