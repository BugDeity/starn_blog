package com.shiyi.service;

import com.shiyi.common.ResponseResult;

/**
 *  打赏服务类
 *
 * @author blue
 * @since 2021-11-10
 */
public interface ApiSponsorService {

    /**
     * 记录列表
     * @return
     */
    ResponseResult selectSponsorList();



    /**
     * 添加记录
     * @param payImage 支付截图
     * @return
     */
    ResponseResult addSponsor(String payImage);



}
