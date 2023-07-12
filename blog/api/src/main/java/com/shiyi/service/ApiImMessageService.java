package com.shiyi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.ImMessage;
import com.shiyi.vo.ImMessageVO;
import com.shiyi.vo.ImOnlineUserVO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Set;

/**
 *  聊天服务类
 *
 * @author blue
 * @since 2021-11-10
 */
public interface ApiImMessageService {


    /**
     * 获取历史聊天记录
     * @return
     */
    ResponseResult selectHistoryList();

    /**
     * 添加或修改消息（如发送消息和撤回消息）
     * @param obj
     */
    ImMessageVO updateOrInsert(ImMessageVO obj, HttpServletRequest request);

    /**
     * 获取在线用户列表
     */
    List<ImOnlineUserVO> selectOnlineUserList(Set<String> strings);

    /**
     * 获取单聊历史消息
     * @return
     */
    ResponseResult selectUserImHistoryList(String fromUserId, String toUserId);

    /**
     * 获取房间列表
     * @return
     */
    ResponseResult selectRoomList();

    /**
     * 创建房间
     * @param userId
     * @return
     */
    ResponseResult addRoom(String userId);
}
