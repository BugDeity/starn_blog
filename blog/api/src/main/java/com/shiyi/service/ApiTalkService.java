package com.shiyi.service;


import com.shiyi.common.ResponseResult;

public interface ApiTalkService {


    /**
     * 获取话题列表
     * @return
     */
    ResponseResult selectList();

    /**
     * 解析网页地址
     * @param url
     * @return
     */
    ResponseResult analysis(String url);
}
