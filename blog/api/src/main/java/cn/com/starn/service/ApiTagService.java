package cn.com.starn.service;

import cn.com.starn.common.ResponseResult;

public interface ApiTagService {
    /**
     * 获取所有标签
     * @return
     */
    public ResponseResult selectTagList();

}
