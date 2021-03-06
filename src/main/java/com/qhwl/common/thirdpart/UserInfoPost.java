package com.qhwl.common.thirdpart;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.qhwl.common.config.Global;
import com.qhwl.common.utils.StringUtils;

public class UserInfoPost{
	protected int MAX_RECEIVE_SIZE = 1000 * 1000;//
	protected String METHOD = "POST";// 方法
	protected boolean doinput = true;//
	protected boolean dooutput = true;//
	protected boolean followRedirects = true;// 跟随重定向
	protected int timeoutForConnect = 3000;// 连接超时
	protected int timeoutForRead = 10000;// 读取超时
	protected Map<String, List<String>> headerMap = null;//请求头键值
	private static final String URL ="http://open.hc360.com/open/userinfo/getUser";//请求地址
	protected Logger logger = LoggerFactory.getLogger(getClass());//日志对象
	//private static final String CHARSET = "UTF-8";
	/**
	 * 主方法测试
	 * */
	public static void main(String[] args) {
		UserInfoPost d = new UserInfoPost();
		String client_id=Global.getConfig("hc_openplatform_clinet_id");//慧聪开放平台秘钥id
		String client_secret=Global.getConfig("hc_openplatform_clinet_secret");//慧聪开放平台秘钥密码
		String grant_type="code";
		String access_token="446228146b6e5040bbc1513c544063a2";
		String time_stamp=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        StringBuilder sbl=new StringBuilder();
        sbl.append("{");
        sbl.append("client_id:'"+ client_id+"',");
        sbl.append("client_secret:'"+ client_secret+"',");
        sbl.append("grant_type:'"+ grant_type+"',");
        sbl.append("access_token:'"+ access_token+"',");
        sbl.append("time_stamp:'"+ time_stamp+"'");
        sbl.append("}");
        Map<String, String> map1= new HashMap<String, String>();
		map1.put("param",sbl.toString());
		String str1= d.httpPost1(URL,map1);
		System.out.println(str1);
        JSONObject object = JSON.parseObject(str1);  
        Object jsonArray = object.get("userInfo");  
        System.out.println(jsonArray);  
        HCUser userInfo = (HCUser) JSON.parseObject(jsonArray.toString(), HCUser.class);
        System.out.println(userInfo.getAddress());  
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
	public String httpPost1(String targetUrl,Map<String, String> maps){
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
            }
            // 发送请求参数
            //out.print(sbl.toString().getBytes(CHARSET));// post的关键所在！
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
	
	public HCUser fastJson2(String token) {
		String client_id=Global.getConfig("hc_openplatform_clinet_id");//慧聪开放平台秘钥id
		String client_secret=Global.getConfig("hc_openplatform_clinet_secret");//慧聪开放平台秘钥密码
		String grant_type="code";
		String access_token=token;
		String time_stamp=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        StringBuilder sbl=new StringBuilder();
        sbl.append("{");
        sbl.append("client_id:'"+ client_id+"',");
        sbl.append("client_secret:'"+ client_secret+"',");
        sbl.append("grant_type:'"+ grant_type+"',");
        sbl.append("access_token:'"+ access_token+"',");
        sbl.append("time_stamp:'"+ time_stamp+"'");
        sbl.append("}");
        Map<String, String> map1= new HashMap<String, String>();
		map1.put("param",sbl.toString());
		String str1= httpPost1(URL,map1);
		HCUser userInfo=new HCUser();
		if(StringUtils.isNotBlank(str1)){
	        JSONObject object = JSON.parseObject(str1);  
	        Object jsonArray = object.get("userInfo");  
	        userInfo = (HCUser) JSON.parseObject(jsonArray.toString(), HCUser.class);
		}
		return userInfo;
	}
}
