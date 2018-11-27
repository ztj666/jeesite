package com.qhwl.common.thirdpart;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.qhwl.common.config.Global;

public class TokenPost{

	protected int MAX_RECEIVE_SIZE = 1000 * 1000;//
	protected String METHOD = "POST";// 方法
	protected boolean doinput = true;//
	protected boolean dooutput = true;//
	protected boolean followRedirects = true;// 跟随重定向
	protected int timeoutForConnect = 3000;// 连接超时
	protected int timeoutForRead = 10000;// 读取超时
	protected Map<String, List<String>> headerMap = null;//请求头键值
	private static final String URL ="http://oauth.hc360.com/oauth/accessToken";//请求地址
	protected Logger logger = LoggerFactory.getLogger(getClass());//日志对象
	/**
	 * 主方法，用于测试
	 * http://www.hcicmall.com:8080/oauth/hclogin.htm
	 */
	public static void main(String[] args) {
		String clinet_id=Global.getConfig("hc_openplatform_clinet_id");//慧聪开放平台秘钥id
		String clinet_secret=Global.getConfig("hc_openplatform_clinet_secret");//慧聪开放平台秘钥密码
		TokenPost d = new TokenPost();
		Map<String, String> map= new HashMap<String, String>();
		map.put("client_id", clinet_id);
		map.put("client_secret", clinet_secret);
		map.put("grant_type", "authorization_code");
		map.put("code", "605091d6f1cf4a3dd04cad3791783d38");
		map.put("state", "123");
		map.put("redirect_uri", "http://www.hcicmall.com:8080/hcxc/oauth/hclogin.htm");
		String str2= d.httpPost(URL,map);
		System.out.println(str2);
//		JSONObject object = JSON.parseObject(str2);  
//		System.out.println(object.get("access_token"));  
		Token token = (Token) JSON.parseObject(str2, Token.class);
		String access_token=token.getAccess_token();
		System.out.println(access_token); 
		
	}
	/**
	 * 在请求头中设置userAgent
	 * @param userAgent
	 */
	public void setUserAgent(String userAgent) {
		setHeader("User-Agent", userAgent);
	}
	/**
	 * 设置(请求地址)中的键值
	 * @param key
	 * @param value
	 */
	public void setHeader(String key, String value) {
		if (key == null) {
			throw new NullPointerException("key is null");
		}
		if (value == null) {
			throw new NullPointerException("value is null");
		}
		if (headerMap == null) {
			headerMap = new HashMap<String, List<String>>();
		}
		List<String> valueList = new ArrayList<String>();
		valueList.add(value);
		headerMap.put(key, valueList);
	}
	/**
	 * http get
	 * @param targetUrl 目标URL
	 * @return
	 */
	public String httpPost(String targetUrl,Map<String, String> maps) {
        PrintWriter out = null;
        BufferedReader br = null;
        String result = "";
		try {
			URL url = new URL(targetUrl);
			HttpURLConnection con = null;
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod(METHOD);
			con.setInstanceFollowRedirects(followRedirects);
			con.setDoInput(doinput);
			con.setDoOutput(dooutput);
			con.setConnectTimeout(timeoutForConnect);
			con.setReadTimeout(timeoutForRead);
			if (headerMap != null) {
				for (Entry<String, List<String>> entry : headerMap.entrySet()) {
					String key = entry.getKey();
					List<String> valueList = entry.getValue();
					for (String value : valueList) {
						con.addRequestProperty(key, value);
					}
				}
			}
			 // 发送POST请求必须设置如下两行
            con.setDoOutput(true);
            con.setDoInput(true);
            // 获取HttpURLConnection对象对应的输出流
            out = new PrintWriter(con.getOutputStream());
            // 准备参数
            StringBuilder sbl=new StringBuilder();
            for(String key:maps.keySet()){
            	String value=maps.get(key);
            	sbl.append(key);
            	sbl.append("=");
            	sbl.append(value);
            	sbl.append("&");
            }
            // 发送请求参数
            out.print(sbl.toString());// post的关键所在！
            // flush输出流的缓冲
            out.flush();
            // 定义BufferedReader输入流来读取URL的响应
            br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
            String line;
            while ((line = br.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            logger.debug("发送 POST 请求出现异常！" + e);
        }
        // 使用finally块来关闭输出流、输入流
        finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (br != null) {
                	br.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }
	public String fastJson1(String code) {//json解析
		String clinet_id=Global.getConfig("hc_openplatform_clinet_id");//慧聪开放平台秘钥id
		String clinet_secret=Global.getConfig("hc_openplatform_clinet_secret");//慧聪开放平台秘钥密码
		String redirect_uri=Global.getConfig("redirect_uri");//慧聪开放平台的redirect_uri
		TokenPost d = new TokenPost();
		Map<String, String> map= new HashMap<String, String>();
		map.put("client_id", clinet_id);
		map.put("client_secret", clinet_secret);
		map.put("grant_type", "authorization_code");
		map.put("code", code);
		map.put("state", "123");
		map.put("redirect_uri", redirect_uri);
		String str2= d.httpPost(URL,map);
		Token token = (Token) JSON.parseObject(str2, Token.class);
		String access_token=token.getAccess_token();
		return access_token;
	}
}
