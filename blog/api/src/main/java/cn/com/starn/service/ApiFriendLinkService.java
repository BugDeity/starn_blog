package cn.com.starn.service;

import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.FriendLink;

public interface ApiFriendLinkService {
    /**
     * 获取所有友链
     * @return
     */
    ResponseResult selectFriendLinkList();

    /**
     * 用户申请友链
     * @param friendLink
     * @return
     */
    ResponseResult insertFriendLink(FriendLink friendLink);


}
