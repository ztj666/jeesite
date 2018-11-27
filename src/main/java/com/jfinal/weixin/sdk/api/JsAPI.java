package com.jfinal.weixin.sdk.api;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.weixin.sdk.api.JsTicketApi.JsApiType;
import com.jfinal.weixin.sdk.api.entity.GetSignatureResponse;
import com.jfinal.weixin.sdk.encrypt.AesException;
import com.jfinal.weixin.sdk.encrypt.SHA1;
import com.jfinal.weixin.sdk.utils.BeanUtil;
import com.jfinal.weixin.sdk.utils.JsApiUtil;
import com.qhwl.common.config.Global;

/**
 * 微信js-sdk相关API
 * 
 * @author peiyu
 */
public class JsAPI {

	private static final Logger LOG = LoggerFactory.getLogger(JsAPI.class);

	/**
	 * 获取js签名9.10最新套路(其他都是坑)
	 * 
	 * @param request
	 * @return
	 */
	public static Map<String, String> getJsSign(HttpServletRequest request) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("appId", Global.getConfig("appId"));
		map.put("timestamp", new Date().getTime() + "");
		map.put("nonceStr", UUID.randomUUID().toString());
		String signature;
		try {
			signature = SHA1.getSHA1Url(JsTicketApi.getTicket(JsApiType.jsapi).getTicket(), map.get("timestamp"),
					map.get("nonceStr"),
					request.getRequestURL() + (request.getQueryString() != null && !request.getQueryString().equals("") ? "?" + request.getQueryString() : ""));
			map.put("signature", signature);
		} catch (AesException e) {
			LOG.debug(e.toString());
		}
		return map;
	}

	/**
	 * 获取js-sdk所需的签名，简化逻辑 不太在意随机数和时间戳的场景，使用更加方便
	 * 
	 * @param url
	 *            当前网页的URL，不包含#及其后面部分
	 * @return 签名以及相关参数
	 */
	public static GetSignatureResponse getSignature(String url) {
		BeanUtil.requireNonNull(url, "请传入当前网页的URL，不包含#及其后面部分");
		// 当前时间的秒数
		long timestame = System.currentTimeMillis() / 1000;
		// 使用UUID来当随机字符串
		String nonceStr = UUID.randomUUID().toString().replaceAll("-", "");
		return getSignature(nonceStr, timestame, url);
	}

	/**
	 * 获取js-sdk所需的签名，给调用者最大的自由度，控制生成签名的参数
	 * 
	 * @param nonceStr
	 *            随机字符串
	 * @param timestame
	 *            时间戳
	 * @param url
	 *            当前网页的URL，不包含#及其后面部分
	 * @return 签名以及相关参数
	 */
	public static GetSignatureResponse getSignature(String nonceStr, long timestame, String url) {
		BeanUtil.requireNonNull(url, "请传入当前网页的URL，不包含#及其后面部分");
		GetSignatureResponse response = new GetSignatureResponse();
		String jsApiTicket = JsTicketApi.getTicket(JsApiType.jsapi).getTicket();
		String sign;
		try {
			sign = JsApiUtil.sign(jsApiTicket, nonceStr, timestame, url);
		} catch (Exception e) {
			LOG.error("获取签名异常:", e);
			// response.setErrcode(ResultType.OTHER_ERROR.getCode().toString());
			response.setErrmsg("获取签名异常");
			return response;
		}
		response.setNoncestr(nonceStr);
		response.setSignature(sign);
		response.setTimestamp(timestame);
		response.setUrl(url);
		// response.setErrcode(ResultType.SUCCESS.getCode().toString());
		return response;
	}
}