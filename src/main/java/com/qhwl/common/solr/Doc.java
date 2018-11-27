package com.qhwl.common.solr;

import java.util.Date;


/**
 * Doc表示一个来自open search的文档
 * 由于open search的容量价格限制，Doc中包含的字段只有核心字段（具体有哪些字段要登录open search平台看数据结构）
 * 
 * Doc与Content对象共同拥有的字段，有着相同的方法签名，要模板中调用时可达到互通。
 * 例如${doc.title}会调用getTitle()方法，Doc与Content对象都有getTitle()方法，不用修改模板。
 * 
 * 但由于Doc中包含的字段少，不能达到100%互通，只是核心字段互通。
 *
 * @author zhaolei
 *
 */
public class Doc{
	String id;
	String title;//原始的title
	String title2;//solr给加了高亮后的title
	String author;
	Date releaseDate;
	String body;//原始的body
	String body2;//solr给加了高亮后的body
	boolean hasImage;
	String url;
	String imgUrl;
	Float score;//solr的评分
	
	public Doc(){
		
	}
	
	public String toString(){
		StringBuilder sbl=new StringBuilder();
		sbl.append("id:"+id);
		sbl.append(",score:"+score);
		sbl.append(",title:"+title);
		sbl.append(",author:"+author);
		sbl.append(",releaseDate:"+releaseDate);
		sbl.append(",hasImage:"+hasImage);
		sbl.append(",imgUrl:"+imgUrl);
		sbl.append(",url:"+url);
		String b=null;
		if(body!=null){
			if(body.length()>30){
				b=body.substring(0, 30);
			}
		}
		sbl.append(",body:"+b);
		return sbl.toString();
	}
	
	//下面的get方法是扩展出来的，保持与Content对像方法签名相同，便于在模板中调用
	public String getShortTitle() {
		return getTitle();
	}
	public Boolean getHasTitleImg () {
		return isHasImage();
	}
	public String getUrl(){
		return url;
	}
	public String getTitleImg(){
		return getImgUrl();
	}
	public String getDesc() {
		return getBody() ;
	}
	public String getDescription() {
		return getBody() ;
	}
	public Date getDate() {
		return getReleaseDate();
	}
	
	
	//下面的get方法是原生的
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public Date getReleaseDate() {
		return releaseDate;
	}
	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public boolean isHasImage() {
		return hasImage;
	}
	public void setHasImage(boolean hasImage) {
		this.hasImage = hasImage;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public Float getScore() {
		return score;
	}
	public void setScore(Float score) {
		this.score = score;
	}
	public String getBody2() {
		return body2;
	}
	public void setBody2(String body2) {
		this.body2 = body2;
	}
	public String getTitle2() {
		return title2;
	}
	public void setTitle2(String title2) {
		this.title2 = title2;
	}
	
	
}