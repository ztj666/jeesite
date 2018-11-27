//package com.qhwl.common.solr;
//
//import java.io.IOException;
//import java.math.BigDecimal;
//import java.util.Currency;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.apache.solr.client.solrj.SolrQuery;
//import org.apache.solr.client.solrj.SolrServerException;
//import org.apache.solr.client.solrj.impl.HttpSolrServer;
//import org.apache.solr.client.solrj.response.QueryResponse;
//import org.apache.solr.common.SolrDocument;
//import org.apache.solr.common.SolrDocumentList;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//
//import com.qhwl.admin.member.entity.MemberUser;
//import com.qhwl.admin.product.entity.ProductAlbumImg;
//import com.qhwl.admin.product.entity.ProductAlbumPdf;
//import com.qhwl.admin.product.entity.ProductBase;
//import com.qhwl.admin.product.entity.ProductExcel;
//import com.qhwl.common.config.Global;
//import com.qhwl.common.persistence.Page;
//import com.qhwl.common.utils.StringUtils;
//
///**
// * <p>
// * 标题:Solr搜索 客户端
// * </p>
// * <p>
// * 描述:
// * </p>
// * <p>
// * 公司: 谦亨科技 www.qhwl.net
// * </p>
// * 
// * @author zhaolei
// * @date 2016年7月27日 下午2:38:55
// */
//public class SolrSearchProduct {
//	private static final Logger log = LoggerFactory.getLogger(SolrSearchProduct.class);
//	
//	protected static String host = Global.getConfig("solr_url");//solr服务器地址
//	protected static HttpSolrServer server=null;
//	
//	/**
//	 * solr 官方的处理方法
//	 * 如果query中带有非法字符串，结果直接报错，所以你对用户的输入必须要先做处理
//	 * @param s
//	 * @return
//	 */
//	protected static String parseKeywords(String s) {
//		StringBuilder sb = new StringBuilder();
//		for (int i = 0; i < s.length(); i++) {
//			char c = s.charAt(i);
//			// These characters are part of the query syntax and must be escaped
//			if (c == '\\' || c == '+' || c == '-' || c == '!' || c == '(' || c == ')' || c == ':' || c == '^' || c == '[' || c == ']' || c == '\"'
//					|| c == '{' || c == '}' || c == '~' || c == '*' || c == '?' || c == '|' || c == '&' || c == ';' || c == '/'
//					|| Character.isWhitespace(c)) {
//				sb.append('\\');
//			}
//			sb.append(c);
//		}
//		return sb.toString();
//	}
//	
//	/**
//	 * 与open search 建立连接
//	 */
//	protected static void init(String appName){
//		server = new HttpSolrServer(host+appName);
//		server.setMaxRetries(0); // defaults to 0. > 1 not recommended.
//		server.setConnectionTimeout(5000); // 5 seconds to establish TCP
//		server.setSoTimeout(1000*60); // socket read timeout
//		server.setDefaultMaxConnectionsPerHost(100);
//		server.setMaxTotalConnections(100);
//		server.setFollowRedirects(false); // defaults to false
//		// allowCompression defaults to false.
//		// Server side must support gzip or deflate for this to have any effect.
//		server.setAllowCompression(false);
//	}
//
//	/**
//	 * 供应列表、产品列表
//	 * 
//	 * @param paramMap
//	 *            查询条件
//	 * @param sortMap
//	 *            排序
//	 * @param page
//	 *            分页对象
//	 * @return 搜索结果
//	 */
//	public static Search searchProcudt(Map<String, Object> paramMap, Map<String, Object> paramArea,
//			Map<String, String> sortMap, Page page) {
//		String solr_core_product = Global.getConfig("solr_core_product");
//		// 建立连接
//		if (server == null) {
//			synchronized (SolrSearchProduct.class) {
//				if (server == null) {
//					init(solr_core_product);
//				}
//			}
//		}
//
//		// 查询条件
//		SolrQuery query = new SolrQuery();
//		StringBuilder sbl = new StringBuilder();
//		if (paramMap != null && paramMap.size() > 0) {
//			for (String key : paramMap.keySet()) {
//				String value = (String) paramMap.get(key);
//				if (StringUtils.isNotBlank(key) && StringUtils.isNotBlank(value)) {
//					sbl.append(" AND ");// AND
//					sbl.append(key);
//					sbl.append(":");
//					sbl.append("'" + parseKeywords(value) + "'");
//				}
//			}
//		}
//
//		// 查询条件--地区
//		if (paramArea != null && paramArea.size() > 0) {
//			int k = 0;
//			sbl.append(" AND ");// AND
//			sbl.append("(");
//			for (String key : paramArea.keySet()) {
//				k++;
//				String value = (String) paramArea.get(key);
//				if (StringUtils.isNotBlank(key) && StringUtils.isNotBlank(value)) {
//					sbl.append(key);
//					sbl.append(":");
//					sbl.append("'" + parseKeywords(value) + "'");
//					if (k != paramArea.size()) {
//						sbl.append(" OR ");
//					}
//				}
//			}
//			sbl.append(")");
//		}
//
//		if (sbl.length() > 0) {
//			String s = sbl.toString();
//			s = s.substring(" AND ".length(), sbl.length());
//			query.setQuery(s);// 按条件查询
//		} else {
//			query.setQuery("*:*");// 无参数，就查全部
//		}
//
//		// 排序
//		if (sortMap != null)
//			for (String key : sortMap.keySet()) {
//				String value = (String) sortMap.get(key);
//				if ("update_date".equals(key) && StringUtils.isNotBlank(key) && StringUtils.isNotBlank(value)) {
//					query.addSort("update_date", SolrQuery.ORDER.desc);
//				}
//				if ("price".equals(key) && "1".equals(value) && StringUtils.isNotBlank(key)
//						&& StringUtils.isNotBlank(value)) {
//					query.addSort("price2", SolrQuery.ORDER.asc);
//				}
//				if ("price".equals(key) && "2".equals(value) && StringUtils.isNotBlank(key)
//						&& StringUtils.isNotBlank(value)) {
//					query.addSort("price2", SolrQuery.ORDER.desc);
//				}
//			}
//
//		// 过滤条件
//		// if(has_image!=null){
//		// query.addFilterQuery("img:"+has_image);
//		// }
//
//		// 分页
//		int start = (page.getPageNo() - 1) * page.getPageSize();
//		int size = page.getPageSize();
//
//		// 将初始偏移量指定到结果集中。可用于对结果进行分页。默认值为 0
//		query.set("start", start);
//
//		// 返回文档的最大数目。默认值为 10。
//		query.set("rows", size);
//
//		// 指定文档结果中应返回的 Field 集，作为逗号分隔。默认为 “*”，指所有的字段。“score” 指还应返回记分。
//		query.setParam("fl", "score,*");
//
//		///////////
//		// 执行查询
//		///////////
//		QueryResponse response = null;
//		try {
//			response = server.query(query);
//		} catch (SolrServerException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//
//		SolrDocumentList results = response.getResults();
//
//		long rowCount = results.getNumFound();// 搜索到的总条数
//		int QTime = response.getQTime();// 耗时
//		int status = response.getStatus();// 状态
//
//		page.setCount(rowCount);// 总条数
//
//		Search search = new Search();
//		search.setStatus(String.valueOf(status));
//		search.setRequestId("request_id");
//
//		Result result = new Result();
//		result.setNum(0);// 页大小，未传进来，先设个0吧
//		result.setSearchtime(QTime);// 搜索耗时
//		result.setTotal((int) rowCount);// 搜索到的总条数
//		// result.setViewtotal((int)(rowCount>5000?5000:rowCount));//可显示的总条数，5000封顶
//		result.setViewtotal((int) (rowCount));
//		search.setResult(result);
//
//		for (int i = 0; i < results.size(); ++i) {
//			SolrDocument resultDoc = results.get(i);
//			ProductBase product = new ProductBase();
//			product.setId((String) resultDoc.get("id"));
//
//			MemberUser memUser = new MemberUser((String) resultDoc.get("mem_id"));
//			memUser.setOrgName((String) resultDoc.get("company_name"));
//			product.setMemberUser(memUser);
//
//			product.setName((String) resultDoc.get("name"));
//			product.setProductExcel(new ProductExcel((String) resultDoc.get("excel_id")));
//			product.setStatus((String) resultDoc.get("status"));
//			product.setAuditReason((String) resultDoc.get("audit_reason"));
//			product.setBrand((String) resultDoc.get("brand"));
//			product.setBatch((String) resultDoc.get("batch"));
//			product.setProPackage((String) resultDoc.get("pro_package"));
//			product.setModel((String) resultDoc.get("model"));
//			product.setCategoryId((String) resultDoc.get("category_id"));// 分类ID
//			product.setCategoryName((String) resultDoc.get("category_name"));// 分类名称
//			product.setRecommend((String) resultDoc.get("recommend"));// 推荐到首页
//			product.setRecommendSort((Long) resultDoc.get("recommend_sort"));
//
//			ProductAlbumImg img = new ProductAlbumImg();// 图片文件
//			img.setId((String) resultDoc.get("img"));
//			img.setFilePath((String) resultDoc.get("img_path"));
//			product.setImg(img);
//
//			ProductAlbumPdf pdf = new ProductAlbumPdf();// PDF资料文件
//			pdf.setId((String) resultDoc.get("pdf"));
//			pdf.setFilePath((String) resultDoc.get("pdf_path"));
//			product.setPdf(pdf);
//
//			product.setParament((String) resultDoc.get("parament"));
//			String price = (String) resultDoc.get("price");
//			if (price != null) {
//				product.setPrice(new BigDecimal(price));// 价格
//			}else{
//				product.setPrice(new BigDecimal("0"));// 价格
//			}
//			product.setStock((Long) resultDoc.get("stock"));
//			product.setMinimum((Long) resultDoc.get("minimum"));
//			product.setSpotGoods((String) resultDoc.get("spot_goods"));
//			product.setUpdateDate((Date) resultDoc.get("update_date"));// 更新日期
//			result.getItems().add(product);
//		}
//		return search;
//	}
//
//	/**
//	 * 测试方法
//	 * 
//	 * @param a
//	 */
//	public static void main(String[] a) {
////		// 准备查询条件
////		Map<String, Object> paramMap = new HashMap<String, Object>();
////		// paramMap.put("name", "肖特基二级管");
////		paramMap.put("id", "757507006920785920");
////
////		Map<String, Object> param2 = new HashMap<String, Object>();
////
////		// 排序
////		Map<String, String> sortMap = new HashMap<String, String>();
////		sortMap.put("update_date", "desc");
////
////		Search search = SolrSearchProduct.searchProcudt(paramMap, param2, sortMap, new Page(1, 20));
////		List<ProductBase> list = search.getResult().getItems();
////		for (int i = 0; i < list.size(); ++i) {
////			ProductBase resultDoc = list.get(i);
////			System.out.println(resultDoc);
////		}
//		
//		System.out.println(0.045F + 0.011F);
//		System.out.println(0.045D + 0.011D);
//		System.out.println(0.05F + 0.01F);
//		System.out.println(0.05D + 0.01D);
////		BigDecimal b=new BigDecimal(f+f2);
////		System.out.println(b.doubleValue());
//		System.out.println("=======");
//
//		BigDecimal b1=new BigDecimal(0.05D);
//		BigDecimal b2=new BigDecimal(0.01D);
//		BigDecimal b3=b1.add(b2);
//		System.out.println(b3);
//		System.out.println(b3.doubleValue());
//		System.out.println(b3.floatValue());
//		System.out.println("----##---");
//		
//		BigDecimal b21=new BigDecimal("0.05");
//		BigDecimal b222=new BigDecimal("0.01");
//		BigDecimal b31=b21.add(b222);
//		System.out.println(b31);
//		System.out.println(b31.doubleValue());
//		System.out.println("------");
//		
////		Currency price = Currency.getInstance("85");
////		System.out.println(price.toString());
//		
//	}
//}