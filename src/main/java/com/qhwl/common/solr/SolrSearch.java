package com.qhwl.common.solr;

import org.apache.solr.client.solrj.impl.HttpSolrServer;

import com.qhwl.common.config.Global;

/**
 * <p>标题: solr搜索的父类</p>
 * <p>描述: </p>
 * <p>公司: 谦亨科技 www.qhwl.net</p>
 * @author zhaolei
 * @date 2016年7月28日 下午2:33:27
 */
public class SolrSearch {
	protected static String host = Global.getConfig("solr_url");//solr服务器地址
	protected static HttpSolrServer server=null;
	
	/**
	 * solr 官方的处理方法
	 * 如果query中带有非法字符串，结果直接报错，所以你对用户的输入必须要先做处理
	 * @param s
	 * @return
	 */
	protected static String parseKeywords(String s) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			// These characters are part of the query syntax and must be escaped
			if (c == '\\' || c == '+' || c == '-' || c == '!' || c == '(' || c == ')' || c == ':' || c == '^' || c == '[' || c == ']' || c == '\"'
					|| c == '{' || c == '}' || c == '~' || c == '*' || c == '?' || c == '|' || c == '&' || c == ';' || c == '/'
					|| Character.isWhitespace(c)) {
				sb.append('\\');
			}
			sb.append(c);
		}
		return sb.toString();
	}
	
	/**
	 * 与open search 建立连接
	 */
	protected static void init(String appName){
		server = new HttpSolrServer(host+appName);
		server.setMaxRetries(0); // defaults to 0. > 1 not recommended.
		server.setConnectionTimeout(5000); // 5 seconds to establish TCP
		server.setSoTimeout(1000*60); // socket read timeout
		server.setDefaultMaxConnectionsPerHost(100);
		server.setMaxTotalConnections(100);
		server.setFollowRedirects(false); // defaults to false
		// allowCompression defaults to false.
		// Server side must support gzip or deflate for this to have any effect.
		server.setAllowCompression(false);
	}
}
