/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.admin.sys.dao.DictDao;
import com.qhwl.admin.sys.entity.Dict;
import com.qhwl.admin.sys.utils.DictUtils;
import com.qhwl.common.service.CrudService;
import com.qhwl.common.utils.CacheUtils;

/**
 * 字典Service
 * @author Admin
 * @version 2014-05-16
 */
@Service
@Transactional(readOnly = true)
public class DictService extends CrudService<DictDao, Dict> {
	@Autowired
	protected DictDao dictDao;
	/**
	 * 查询字段类型列表
	 * @return
	 */
	//按类型查询字典记录  并排序  升序 
	public List<Dict> selectList(Dict dict){
		return dictDao.selectList(dict);
	}
	//按标签名查询字典记录
	public Dict selectByLabel(String label){
		return dictDao.selectByLabel(label);
	}
	//按数据值查询字典记录
	public Dict selectByValue(String value){
		return dictDao.selectByValue(value);
	}
	public List<String> findTypeList(){
		return dao.findTypeList(new Dict());
	}

	@Transactional(readOnly = false)
	public void save(Dict dict) {
		super.save(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

	@Transactional(readOnly = false)
	public void delete(Dict dict) {
		super.delete(dict);
		CacheUtils.remove(DictUtils.CACHE_DICT_MAP);
	}

}
