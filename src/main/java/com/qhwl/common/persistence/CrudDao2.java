/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.common.persistence;

import java.util.List;

/**
 * <p>标题: DAO支持类实现</p>
 * <p>描述: </p>
 * <p>公司: 谦亨科技 www.qhwl.net</p>
 * @author zhaolei
 * @date 2016年5月15日 下午8:47:13
 * @param <T>
 */
public interface CrudDao2<T> extends BaseDao {

	/**
	 * 获取单条数据
	 * @param id 主键
	 * @return
	 */
	public T selectById(String id);
	
	
	/**
	 * 查询 select * from a where id in(…)
	 * @param list 主键集合
	 * @return
	 */
	public List<T> selectByIdIn(List<Object> list);
	
	/**
	 * 查询数据列表，如果需要分页，请设置分页对象，如：entity.setPage(new Page<T>());
	 * @param entity 查询条件，可为null。或new一个实体对象，用于控制order by 排序、控制del_flag、控制distinct
	 * @return
	 */
	public List<T> selectByWhere(T entity);
	
	/**
	 * 查询所有数据列表
	 * @param entity 可为null。或new一个实体对象，用于控制order by 排序、控制del_flag、控制distinct
	 * @return
	 */
	public List<T> selectAll(T entity);
	
	/**
	 * 插入数据
	 * 如果要在entity中带回自增长生成的主键值，mybatis的xml中要添加<insert id="insertSelective" keyProperty="pageId" useGeneratedKeys="true">
	 * @param entity
	 * @return 受影响的行数
	 */
	public int insert(T entity);
	
	/**
	 * 插入,只把非空的值插入到对应的字段
	 * 如果要在entity中带回自增长生成的主键值，mybatis的xml中要添加<insert id="insertSelective" keyProperty="pageId" useGeneratedKeys="true">
	 * @param entity
	 * @return 受影响的行数
	 */
	public int insertSelective(T entity);
	
	/**
	 * 根据主键更新记录,更新除了主键的所有字段
	 * @param entity
	 * @return 受影响的行数
	 */
	public int updateById(T entity);
	/**
	 * 根据条件更新记录,更新除了主键的所有字段
	 * @param entity
	 * @return 受影响的行数
	 */
	public int updateByWhere(T entity);
	/**
	 * 根据主键更新记录,只把非空的值更到对应的字段
	 * @param entity
	 * @return 受影响的行数
	 */
	public int updateByIdSelective(T entity);
	/**
	 * 根据条件更新记录,只把非空的值更到对应的字段
	 * @param entity
	 * @return 受影响的行数
	 */
	public int updateByWhereSelective(T entity);
	
	/**
	 * 删除数据
	 * （如果有del_flag字段，就逻辑删除，更新del_flag字段为1）
	 * （如果无del_flag字段，就物理删除）
	 * @param id 主键
	 * @return 受影响的行数
	 */
	public int deleteById(String id);

	
	/**
	 * 删除数据（物理删除）
	 * @param entity 删除条件，可为null。
	 * @return 受影响的行数
	 */
	public int deleteByWhere(T entity);
	
	/**
	 * 根据条件查询记录总数
	 * @param entity 可为null。或new一个实体对象，用于控制del_flag、控制distinct
	 * @return 总行数
	 */
	public int countByWhere(T entity);
	
}