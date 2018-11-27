/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.gen.entity;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.google.common.collect.Lists;
import com.qhwl.common.persistence.DataEntity;
import com.qhwl.common.utils.StringUtils;

/**
 * 业务表Entity
 * @author Admin
 * @version 2013-10-15
 */
public class GenTable extends DataEntity<GenTable> {
	
	private static final long serialVersionUID = 1L;
	private String name; 	// 名称
	private String comments;		// 描述
	private String className;		// 实体类名称
	private String parentTable;		// 关联父表
	private String parentTableFk;		// 关联父表外键

	private List<GenTableColumn> columnList = Lists.newArrayList();	// 表列

	private String nameLike; 	// 按名称模糊查询
	
	private List<String> pkList; // 当前表主键列表
	
	private GenTable parent;	// 父表对象
	private List<GenTable> childList = Lists.newArrayList();	// 子表列表
	
	public GenTable() {
		super();
	}

	public GenTable(String id){
		super(id);
	}

	@Length(min=1, max=200)
	public String getName() {
		return StringUtils.lowerCase(name);
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getParentTable() {
		return StringUtils.lowerCase(parentTable);
	}

	public void setParentTable(String parentTable) {
		this.parentTable = parentTable;
	}

	public String getParentTableFk() {
		return StringUtils.lowerCase(parentTableFk);
	}

	public void setParentTableFk(String parentTableFk) {
		this.parentTableFk = parentTableFk;
	}

	public List<String> getPkList() {
		return pkList;
	}
	
	
	/**
	 * Add by zhaolei 2016-5-15
	 * 执行insert语句时，若表主键是自增长的，需要返回生成的主键供后面的业务使用，
	 * 需要获取主键的列名，用于生成以下xml文件片段
	 * <insert id="insert" keyProperty="id" useGeneratedKeys="true">
	 * 
	 * 未处理联合主键的情况，现在只能使用一个列做为主键列，如遇到“联合主键”需要再开发
	 * 
	 * @return
	 */
	public String getPkName() {
		for(GenTableColumn column:columnList){
			if("1".equals(column.getIsPk())){
				return column.getJavaField();
			}
		}
		return "id";//默认主键列的名称是id
		
//		List<String> pkList=getPkList();
//		if(pkList==null || pkList.size()==0){
//			return "id";//默认主键列的名称是id
//		}else{
//			//TODO 未处理联合主键的情况，现在只能使用一个列做为主键列，如遇到“联合主键”需要再开发
//			return pkList.get(0);
//		}
	}

	public void setPkList(List<String> pkList) {
		this.pkList = pkList;
	}

	public String getNameLike() {
		return nameLike;
	}

	public void setNameLike(String nameLike) {
		this.nameLike = nameLike;
	}

	public GenTable getParent() {
		return parent;
	}

	public void setParent(GenTable parent) {
		this.parent = parent;
	}

	public List<GenTableColumn> getColumnList() {
		return columnList;
	}

	public void setColumnList(List<GenTableColumn> columnList) {
		this.columnList = columnList;
	}

	public List<GenTable> getChildList() {
		return childList;
	}

	public void setChildList(List<GenTable> childList) {
		this.childList = childList;
	}
	
	/**
	 * 获取列名和说明
	 * @return
	 */
	public String getNameAndComments() {
		return getName() + (comments == null ? "" : "  :  " + comments);
	}

	/**
	 * 获取导入依赖包字符串
	 * @return
	 */
	public List<String> getImportList(){
		List<String> importList = Lists.newArrayList(); // 引用列表
		for (GenTableColumn column : getColumnList()){
			if (column.getIsNotBaseField() || ("1".equals(column.getIsQuery()) && "between".equals(column.getQueryType())
							&& ("createDate".equals(column.getSimpleJavaField()) || "updateDate".equals(column.getSimpleJavaField())))){
				// 导入类型依赖包， 如果类型中包含“.”，则需要导入引用。
				if (StringUtils.indexOf(column.getJavaType(), ".") != -1 && !importList.contains(column.getJavaType())){
					importList.add(column.getJavaType());
				}
			}
			if (column.getIsNotBaseField()){
				// 导入JSR303、Json等依赖包
				for (String ann : column.getAnnotationList()){
					if (!importList.contains(StringUtils.substringBeforeLast(ann, "("))){
						importList.add(StringUtils.substringBeforeLast(ann, "("));
					}
				}
			}
		}
		// 如果有子表，则需要导入List相关引用
		if (getChildList() != null && getChildList().size() > 0){
			if (!importList.contains("java.util.List")){
				importList.add("java.util.List");
			}
			if (!importList.contains("com.google.common.collect.Lists")){
				importList.add("com.google.common.collect.Lists");
			}
		}
		return importList;
	}
	
	/**
	 * 是否存在父类
	 * @return
	 */
	public Boolean getParentExists(){
		return parent != null && StringUtils.isNotBlank(parentTable) && StringUtils.isNotBlank(parentTableFk);
	}

	/**
	 * 是否存在create_date列
	 * @return
	 */
	public Boolean getCreateDateExists(){
		for (GenTableColumn c : columnList){
			if ("create_date".equals(c.getName())){
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 是否存在update_date列
	 * @return
	 */
	public Boolean getUpdateDateExists(){
		for (GenTableColumn c : columnList){
			if ("update_date".equals(c.getName())){
				return true;
			}
		}
		return false;
	}

	/**
	 * 是否存在del_flag列
	 * @return
	 */
	public Boolean getDelFlagExists(){
		for (GenTableColumn c : columnList){
			if ("del_flag".equals(c.getName())){
				return true;
			}
		}
		return false;
	}
}


