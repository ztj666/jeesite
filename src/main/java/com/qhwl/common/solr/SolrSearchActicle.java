//package com.qhwl.common.solr;
//
//import java.io.IOException;
//import java.math.BigDecimal;
//import java.util.ArrayList;
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
//import com.qhwl.admin.cms.entity.Article;
//import com.qhwl.admin.cms.entity.ArticleData;
//import com.qhwl.admin.cms.entity.Category;
//import com.qhwl.admin.member.entity.MemberCompany;
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
// * <p>标题:Solr搜索 客户端 </p>
// * <p>描述: </p>
// * <p>公司: 谦亨科技 www.qhwl.net</p>
// * @author zhaolei
// * @date 2016年7月27日 下午2:38:55
// */
//public class SolrSearchActicle {
//	private static final Logger log = LoggerFactory.getLogger(SolrSearchActicle.class);
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
//	 * 搜索文章  String queryStr,String channel_id
//	 * @param queryStr 搜索的关键词
//	 * @param channel_id 栏目ID
//	 * @param page 分页对象
//	 * @return
//	 */
//	public static List<Article> searchAritcle(Map<String,Object> paramMap,Page<Article> page){
//		String solr_core_article = Global.getConfig("solr_core_article");
//		
//		//建立连接
//		if(server==null){
//			synchronized (SolrSearchActicle.class) {
//				if(server==null){
//					init(solr_core_article);
//				}
//			}
//		}
//		
//		/////////////
//		//准备查询条件
//		/////////////	
//		//查询条件
//		SolrQuery query = new SolrQuery();
//		StringBuilder sbl2=new StringBuilder();
//		if(paramMap!=null && paramMap.size()>0){
//			for(String key:paramMap.keySet()){
//				String value=(String)paramMap.get(key);
//				if(StringUtils.isNotBlank(key) && StringUtils.isNotBlank(value)){
//					if("text".equals(key)){
//						sbl2.append(" AND ");//AND
//						sbl2.append("(");
//						sbl2.append("title");//text会查询title和content两个字段，or的关系
//						sbl2.append(":");
//						sbl2.append("'"+parseKeywords(value)+"'");
//						sbl2.append(" OR ");
//						sbl2.append("content");//text会查询title和content两个字段，or的关系
//						sbl2.append(":");
//						sbl2.append("'"+parseKeywords(value)+"'");
//						sbl2.append(")");
//					}else{
//						sbl2.append(" AND ");//AND
//						sbl2.append(key);
//						sbl2.append(":");
//						sbl2.append("'"+parseKeywords(value)+"'");
//					}
//				}
//			}
//		}
//		
//		if(sbl2.length()>0){
//			String s=sbl2.toString();
//			s=s.substring ( " AND ".length() , sbl2.length() );
//			query.setQuery(s);//按条件查询
//		}else{
//			query.setQuery("*:*");//无参数，就查全部
//		}
//		
//		
//		//分页
//		int start=(page.getPageNo() - 1) * page.getPageSize();
//		int size=page.getPageSize();
//		
//		//将初始偏移量指定到结果集中。可用于对结果进行分页。默认值为 0
//		query.set("start", start);
//		
//		//返回文档的最大数目。默认值为 10。
//		query.set("rows", size);
//		
//		//高亮
//		query.setHighlight(true);
//		query.setHighlightSnippets(2);//结果分片数，默认为1,若为0就不会高亮显示
//		query.setParam("hl.fl", "title,content");//那些字段高亮显示，可以用空格或者逗号分隔
//		//高亮显示字段前后添加html代码
//		query.setHighlightSimplePre("<span class='blue'>");
//		query.setHighlightSimplePost("</span>");
//		query.setHighlightFragsize(35); //每个分片的最大长度，默认为100
//		//取文章的摘要，包含高亮部分.显示第一个匹配关键字附近的部分内容
//		
//		//指定文档结果中应返回的 Field 集，作为逗号分隔。默认为 “*”，指所有的字段。“score” 指还应返回记分。
//		query.setParam("fl", "score,*");
//
//		///////////
//		//执行查询
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
//		
//		SolrDocumentList results = response.getResults();
//		
//		//处理分段，每个分段后面加上...
//		//solr把高亮后的字段，单独放在一个map中
//		for (int i = 0; i < results.size(); ++i) {
//			SolrDocument resultDoc = results.get(i);
//			String id = (String) resultDoc.getFieldValue("id"); // id is the uniqueKey field
//			if (response.getHighlighting().get(id.toString()) != null) {
//				//第一个Map的键是文档的ID，第二个Map的键是高亮显示的字段名
//				Map<String, Map<String, List<String>>> map = response.getHighlighting();
//				List<String> highlightSnippets = map.get(id.toString()).get("title");
//				List<String> highlightSnippets2 = map.get(id.toString()).get("content");
//				
//				//高亮后的摘要在这里输出
//				if(highlightSnippets!=null && highlightSnippets.size()>0){
//					StringBuilder sbl=new StringBuilder();
//					for(String s:highlightSnippets){
//						sbl.append(s);
////						sbl.append("...");
//					}
//					resultDoc.setField("title",sbl.toString());//复盖
//				}else{
//					//resultDoc.setField("body2",(String)resultDoc.get("title"));//复盖
//				}
//				if(highlightSnippets2!=null && highlightSnippets2.size()>0){
//					StringBuilder sbl=new StringBuilder();
//					for(int j=0;j<highlightSnippets2.size();j++){
//						String s=highlightSnippets2.get(j);
//						sbl.append(s);
//						if(j!=(highlightSnippets2.size()-1)){
//							sbl.append("...");
//						}
//					}
//					resultDoc.setField("content",sbl.toString());//复盖
//				}else{
//					//resultDoc.setField("title2",(String)resultDoc.get("content"));//复盖
//				}
//			}
//		}
//		
//		long rowCount = results.getNumFound();//搜索到的总条数
//		int QTime=response.getQTime();//
//		int status=response.getStatus();//
//		
//		page.setCount(rowCount);//总条数
//		
//		Search search = new Search();
//		search.setStatus(String.valueOf(status));
//		search.setRequestId("request_id");
//		
//		Result result=new Result();
//		result.setNum(0);//页大小，未传进来，先设个0吧
//		result.setSearchtime(QTime);//搜索耗时
//		result.setTotal((int)rowCount);//搜索到的总条数
//		//result.setViewtotal((int)(rowCount>5000?5000:rowCount));//可显示的总条数，5000封顶
//		result.setViewtotal((int)(rowCount));
//		search.setResult(result);
//		
//		List<Article> list= new ArrayList<Article>();
//		
//		for (int i = 0; i < results.size(); ++i) {
//			SolrDocument resultDoc = results.get(i);
//			Article article =new Article();
//            
//			article.setId((String)resultDoc.get("id"));
//			
//			//文章栏目
//			Category category=new Category();
//			category.setId((String)resultDoc.get("category_id"));
//			article.setCategory(category);
//			
//			article.setTitle((String)resultDoc.get("title"));
//			article.setLink((String)resultDoc.get("link"));
//			article.setColor((String)resultDoc.get("color"));
//			article.setImage((String)resultDoc.get("image"));
//			article.setKeywords((String)resultDoc.get("keywords"));
//			article.setDescription((String)resultDoc.get("description"));
//			article.setWeight((Integer)resultDoc.get("weight"));
//			article.setWeightDate((Date)resultDoc.get("weight_date"));
//			article.setHits((Integer)resultDoc.get("hits"));
//			
//			article.setPosid((String)resultDoc.get("posid"));
//			article.setCustomContentView((String)resultDoc.get("custom_content_view"));
//			article.setCreateDate((Date)resultDoc.get("create_date"));
//			article.setUpdateDate((Date)resultDoc.get("update_date"));//更新日期
//			article.setRemarks((String)resultDoc.get("remarks"));
//			
//			ArticleData articleData=new ArticleData();
//			articleData.setContent((String)resultDoc.get("content"));
//			articleData.setCopyfrom((String)resultDoc.get("copyfrom"));
//			
//			article.setArticleData(articleData);
//			list.add(article);
//		}
//		return list;
//	}
//	
//	/**
//	 * 测试方法
//	 * @param a
//	 */
//	public static void main(String[] a){
//		//准备查询条件
//		Map<String,Object> paramMap=new HashMap<String,Object>();
//		//paramMap.put("text", "加多宝");//text会查询title和content两个字段，or的关系
//		paramMap.put("category_id", "756790819658661888");//category_id 是栏目ID
//		//paramMap.put("id", "757418809380438016");//category_id 是栏目ID
//		//paramMap.put("title", "加多宝");//category_id 是栏目ID
//				
//		List<Article> list= SolrSearchActicle.searchAritcle(paramMap,new Page(1,20));
//		for (int i = 0; i < list.size(); ++i) {
//			Article article = list.get(i);
//			System.out.println(article.getTitle());
//			System.out.println(article.getArticleData().getContent());
//		}
//	}
//}