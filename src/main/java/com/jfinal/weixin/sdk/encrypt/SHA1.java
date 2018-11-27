/**
 * 对公众平台发送给公众账号的消息加解密示例代码.
 *
 * @copyright Copyright (c) 1998-2014 Tencent Inc.
 */

// ------------------------------------------------------------------------

package com.jfinal.weixin.sdk.encrypt;

import com.jfinal.kit.LogKit;

import java.security.MessageDigest;
import java.util.Arrays;

/**
 * SHA1 class
 *
 * 计算公众平台的消息签名接口.
 */
public class SHA1 {

	/**
	 * 用SHA1算法生成安全签名
	 * 
	 * @param token
	 *            票据
	 * @param timestamp
	 *            时间戳
	 * @param nonce
	 *            随机字符串
	 * @param encrypt
	 *            密文
	 * @return 安全签名
	 * @throws AesException
	 */
	public static String getSHA1(String token, String timestamp, String nonce, String encrypt) throws AesException {
		try {
			String[] array = new String[] { token, timestamp, nonce, encrypt };
			StringBuffer sb = new StringBuffer();
			// 字符串排序
			Arrays.sort(array);
			for (int i = 0; i < 4; i++) {
				sb.append(array[i]);
			}
			String str = sb.toString();
			// SHA1签名生成
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			md.update(str.getBytes());
			byte[] digest = md.digest();

			StringBuffer hexstr = new StringBuffer();
			String shaHex = "";
			for (int i = 0; i < digest.length; i++) {
				shaHex = Integer.toHexString(digest[i] & 0xFF);
				if (shaHex.length() < 2) {
					hexstr.append(0);
				}
				hexstr.append(shaHex);
			}
			return hexstr.toString();
		} catch (Exception e) {
			LogKit.error(e.getMessage(), e);
			throw new AesException(AesException.ComputeSignatureError);
		}
	}
	/** 
	 * 获取媒体文件 
	 *  
	 * @param accessToken 
	 *      接口访问凭证 
	 * @param media_id 
	 *      媒体文件id 
	 * */
//	public static String downloadMedia(String mediaId,HttpServletRequest request) { 
//	  String requestUrl = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=ACCESS_TOKEN&media_id=MEDIA_ID"; 
//	  requestUrl = requestUrl.replace("ACCESS_TOKEN", WxTokenThread.accessToken.getToken()).replace( 
//	      "MEDIA_ID", mediaId); 
//	  HttpURLConnection conn = null; 
//	  try { 
//	    URL url = new URL(requestUrl); 
//	    conn = (HttpURLConnection) url.openConnection(); 
//	    conn.setDoInput(true); 
//	    conn.setRequestMethod("GET"); 
//	    conn.setConnectTimeout(30000); 
//	    conn.setReadTimeout(30000); 
//	    BufferedInputStream bis = new BufferedInputStream( 
//	        conn.getInputStream()); 
//	    ByteArrayOutputStream swapStream = new ByteArrayOutputStream();  
//	    byte[] buff = new byte[100];  
//	    int rc = 0;  
//	    while ((rc = bis.read(buff, 0, 100)) > 0) {  
//	      swapStream.write(buff, 0, rc);  
//	    }  
//	    byte[] filebyte = swapStream.toByteArray();  
//	    return PictureStore.getInstance().getImageServerUrl() + PictureStore.getInstance().store(filebyte); 
//	  } catch (Exception e) { 
//	    e.printStackTrace(); 
//	  } finally { 
//	    if(conn != null){ 
//	      conn.disconnect(); 
//	    } 
//	  } 
//	  return ""; 
//	}
	public static String getSHA1HexString(String str) throws Exception {
        // SHA1签名生成
        MessageDigest md = MessageDigest.getInstance("SHA-1");
        md.update(str.getBytes());
        byte[] digest = md.digest();

        StringBuffer hexstr = new StringBuffer();
        String shaHex = "";
        for (int i = 0; i < digest.length; i++) {
            shaHex = Integer.toHexString(digest[i] & 0xFF);
            if (shaHex.length() < 2) {
                hexstr.append(0);
            }
            hexstr.append(shaHex);
        }
        return hexstr.toString();
    }
	/**
	 * 用SHA1算法生成安全签名(要求url拼接)这套路不对
	 * 
	 * @param token
	 *            票据
	 * @param timestamp
	 *            时间戳
	 * @param nonce
	 *            随机字符串
	 * @param encrypt
	 *            密文
	 * @return 安全签名
	 * @throws AesException
	 */
	public static String getSHA1Url(String token, String timestamp, String nonce, String encrypt) throws AesException {
		try {
			String[] array = new String[] { "jsapi_ticket=" + token, "noncestr=" + nonce, "timestamp=" + timestamp,
					"url=" + encrypt };
			StringBuffer sb = new StringBuffer();
			// 字符串排序
			Arrays.sort(array);
			for (int i = 0; i < 4; i++) {
				sb.append(array[i] + (i == 3 ? "" : "&"));
			}
			System.out.println(sb.toString());
			String str = sb.toString();
			// SHA1签名生成
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			md.update(str.getBytes());
			byte[] digest = md.digest();

			StringBuffer hexstr = new StringBuffer();
			String shaHex = "";
			for (int i = 0; i < digest.length; i++) {
				shaHex = Integer.toHexString(digest[i] & 0xFF);
				if (shaHex.length() < 2) {
					hexstr.append(0);
				}
				hexstr.append(shaHex);
			}
			return hexstr.toString();
		} catch (Exception e) {
			LogKit.error(e.getMessage(), e);
			throw new AesException(AesException.ComputeSignatureError);
		}
	}
}
