package com.jfinal.weixin.sdk.api.entity;

import org.noggit.JSONUtil;

/**
 * 抽象实体类
 *
 * @author peiyu
 */
@SuppressWarnings("serial")
public abstract class BaseModel implements Model {
    @Override
    public String toJsonString() {
		return JSONUtil.toJSON(this);
    }
}
