/**
 * Copyright &copy; 2015-2050 谦亨科技 All rights reserved.
 */
package com.qhwl.admin.test.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.qhwl.common.service.TreeService;
import com.qhwl.common.utils.StringUtils;
import com.qhwl.admin.test.entity.TestTrees;
import com.qhwl.admin.test.dao.TestTreesDao;

/**
 * 测试树Service
 * @author ztj
 * @version 2016-09-13
 */
@Service
@Transactional(readOnly = true)
public class TestTreesService extends TreeService<TestTreesDao, TestTrees> {

	public TestTrees get(String id) {
		return super.get(id);
	}
	
	public List<TestTrees> findList(TestTrees testTrees) {
		if (StringUtils.isNotBlank(testTrees.getParentIds())){
			testTrees.setParentIds(","+testTrees.getParentIds()+",");
		}
		return super.findList(testTrees);
	}
	
	@Transactional(readOnly = false)
	public void save(TestTrees testTrees) {
		super.save(testTrees);
	}
	
	@Transactional(readOnly = false)
	public void delete(TestTrees testTrees) {
		super.delete(testTrees);
	}
	
}