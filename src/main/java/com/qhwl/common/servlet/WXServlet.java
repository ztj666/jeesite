package com.qhwl.common.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.qhwl.common.service.WXService;
import com.qhwl.member.util.SignUtil;

/**
 * 处理微信服务器请求的Servlet URL地址：http://xxx/weixin/dealwith.do
 * 
 * @author marker
 * @blog www.yl-blog.com
 * @weibo http://t.qq.com/wuweiit
 */
public class WXServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(WXServlet.class);

	// TOKEN 是你在微信平台开发模式中设置的字符串
	public static final String TOKEN = "YourToken";

	/**
	 * 处理微信服务器验证 http://wallimn.iteye.com, 2014-09-11
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String signature = request.getParameter("signature");// 微信加密签名
		String timestamp = request.getParameter("timestamp");// 时间戳
		String nonce = request.getParameter("nonce");// 随机数
		String echostr = request.getParameter("echostr");// 随机字符串
		Writer out = response.getWriter();
		System.out.println("收到验证请求：");
		System.out.println("　　signature=" + signature);
		System.out.println("　　timestamp=" + timestamp);
		System.out.println("　　nonce=" + nonce);
		System.out.println("　　echostr=" + echostr);
		if (signature == null || timestamp == null || nonce == null || echostr == null) {
			// 这几个参数为空时，排序会报错。
			out.write("parameter is null!");
		} else {
			// 重写totring方法，得到三个参数的拼接字符串
			// List<String> list = new ArrayList<String>(3) {
			// private static final long serialVersionUID =
			// 2621444383666420433L;
			//
			// public String toString() {
			// return this.get(0) + this.get(1) + this.get(2);
			// }
			// };
			// list.add(TOKEN);
			// list.add(timestamp);
			// list.add(nonce);
			// Collections.sort(list);// 排序
			// String tmpStr = new MySecurity().encode(list.toString(),
			// MySecurity.SHA_1);// SHA-1加密
			// if (signature.equals(tmpStr)) {
			// 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
			if (SignUtil.checkSignature(signature, timestamp, nonce)) {
				out.write(echostr);// 请求验证成功，返回随机码
			} else {
				out.write("check error!");
			}
		}
		out.flush();
		out.close();
	}

	/**
	 * 处理微信服务器发过来的各种消息，包括：文本、图片、地理位置、音乐等等 http://wallimn.iteye.com, 2014-09-11
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 log.info("收到POST请求：" + (new Date()));
		// request.setCharacterEncoding("utf-8");
		// response.setContentType("text/html; charset=utf-8");
		// InputStream is = request.getInputStream();
		// OutputStream os = response.getOutputStream();
		// TODO:写微信平台推送过来的各种信息的处理逻辑
		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		// 调用核心业务类接收消息、处理消息
		String respMessage = WXService.processRequest(request);

		// 响应消息
		PrintWriter out = response.getWriter();
		out.print(respMessage);

		out.close();
	}
}
