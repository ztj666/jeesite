/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.common.persistence.CrudDao2;
import com.qhwl.common.persistence.DataEntity;
import com.qhwl.common.persistence.Page;

/**
 * <p>标题:Service基类 </p>
 * <p>描述: </p>
 * <p>公司: 谦亨科技 www.qhwl.net</p>
 * @author zhaolei
 * @date 2016年5月15日 下午9:19:04
 * @param <D>
 * @param <T>
 */
@Transactional(readOnly = true)
public abstract class CrudService2<D extends CrudDao2<T>, T extends DataEntity<T>> extends BaseService {
	
	/**
	 * 持久层对象
	 */
	@Autowired
	protected D dao;
	
	/**
	 * 获取单条数据
	 * @param id 主键
	 * @return
	 */
	public T selectById(String id) {
		return dao.selectById(id);
	}
	
	
	/**
	 * 查询 select * from a where id in(…)
	 * @param list 主键集合
	 * @return
	 */
	public List<T> selectByIdIn(List<Object> list){
		return dao.selectByIdIn(list);
	}
	
	/**
	 * 查询分页数据
	 * 查询数据列表，如果需要分页，请设置分页对象，如：entity.setPage(new Page<T>());
	 * @param page 分页对象
	 * @param entity 查询条件，可为null。或new一个实体对象，用于控制order by 排序、控制del_flag、控制distinct
	 * @return
	 */
	public Page<T> selectByWhere(Page<T> page, T entity) {
		entity.setPage(page);
		List<T> list=dao.selectByWhere(entity);
		if(page==null){
			page=new Page<T>();
		}
		page.setList(list);
		return page;
	}
	
	/**
	 * 查询列表数据
	 * 查询数据列表，如果需要分页，请设置分页对象，如：entity.setPage(new Page<T>());
	 * @param entity 查询条件，可为null。或new一个实体对象，用于控制order by 排序、控制del_flag、控制distinct
	 * @return
	 */
	public List<T> selectByWhere(T entity) {
		return dao.selectByWhere(entity);
	}
	
	/**
	 * 查询所有数据列表，无条件
	 * @param entity  可为null。或new一个实体对象，用于控制order by 排序、控制del_flag、控制distinct
	 * @return
	 */
	public List<T> selectAll(T entity){
		return dao.selectAll(entity);
	}
	
	/**
	 * 保存数据（插入或更新）
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public int saveOrUpdate(T entity) {
		if (entity.getIsNewRecord()){
			entity.preInsert();
			//插入,只把非空的值插入到对应的字段
			return dao.insertSelective(entity);
		}else{
			entity.preUpdate();
			//根据主键更新记录,只把非空的值更到对应的字段
			return dao.updateByIdSelective(entity);
		}
	}
	
	/**
	 * 插入数据
	 * 如果要在entity中带回自增长生成的主键值，mybatis的xml中要添加<insert id="insertSelective" keyProperty="pageId" useGeneratedKeys="true">
	 * @param entity
	 * @return 受影响的行数
	 */
	public int insert(T entity){
		entity.preInsert();
		return dao.insert(entity);
	}
	
	/**
	 * 插入,只把非空的值插入到对应的字段
	 * 如果要在entity中带回自增长生成的主键值，mybatis的xml中要添加<insert id="insertSelective" keyProperty="pageId" useGeneratedKeys="true">
	 * @param entity
	 * @return 受影响的行数
	 */
	@Transactional(readOnly = false)
	public int insertSelective(T entity){
		entity.preInsert();
		return dao.insertSelective(entity);
	}
	
	/**
	 * 根据主键更新记录,更新除了主键的所有字段
	 * @param entity
	 * @return 受影响的行数
	 */
	public int updateById(T entity){
		entity.preUpdate();
		return dao.updateById(entity);
	}
	/**
	 * 根据条件更新记录,更新除了主键的所有字段
	 * @param entity
	 * @return 受影响的行数
	 */
	public int updateByWhere(T entity){
		entity.preUpdate();
		return dao.updateByWhere(entity);
	}
	/**
	 * 修改数据(主键)
	 * 根据主键更新记录,只把非空的值更到对应的字段
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public int updateByIdSelective(T entity) {
		entity.preUpdate();
		return dao.updateByIdSelective(entity);
	}
	
	/**
	 * 修改数据(条件)
	 * 根据条件更新记录,只把非空的值更到对应的字段
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public int updateByWhereSelective(T entity) {
		entity.preUpdate();
		return dao.updateByWhereSelective(entity);
	}
	
	/**
	 * 根据主键删除记录
	 * @param id
	 */
	@Transactional(readOnly = false)
	public int deleteById(String id) {
		return dao.deleteById(id);
	}
	
	/**
	 * 根据条件删除记录
	 * @param entity
	 */
	@Transactional(readOnly = false)
	public int deleteByWhere(T entity) {
		return dao.deleteByWhere(entity);
	}
	
	/**
	 * 根据条件查询记录总条数
	 * @param entity 可为null。或new一个实体对象，用于控制del_flag、控制distinct
	 * @return
	 */
	public int countByWhere(T entity) {
		return dao.countByWhere(entity);
	}

}
