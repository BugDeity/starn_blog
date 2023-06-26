package com.shiyi.service;

import com.shiyi.common.ResponseResult;
import com.shiyi.entity.FriendLink;

public interface ApiFriendLinkService {
    /**
     * 获取所有友链
     * @return
     */
    ResponseResult selectLinkList();

    /**
     * 用户申请友链
     * @param friendLink
     * @return
     */
    ResponseResult insertLink(FriendLink friendLink);


}
