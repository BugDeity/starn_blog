package com.shiyi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.ImMessage;
import com.shiyi.vo.ImMessageVO;
import com.shiyi.vo.ImOnlineUserVO;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
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

    /**
     * 已读消息
     * @param userId
     * @return
     */
    ResponseResult read(String userId);

    /**
     * 删除房间
     * @param roomId 房间id
     * @return
     */
    ResponseResult deleteRoom(String roomId);

    /**
     * 发送消息
     * @param message 消息
     * @param request
     * @return
     */
    ResponseResult chat(ImMessageVO message, HttpServletRequest request);

    /**
     * 撤回消息
     * @param message 消息对象
     * @param request
     * @return
     */
    ResponseResult withdraw(ImMessageVO message, HttpServletRequest request);

    /**
     * 获取跟当前用户有关的系统通知
     * @return
     */
    ResponseResult getMessageNotice(Integer type);

    /**
     * 获取未读的最新系统通知
     * @return
     */
    ResponseResult getNewSystemNotice();

    /**
     * 根绝类型删除所有消息
     * @param type
     * @return
     */
    ResponseResult deleteByNoticeType(String id,Integer type);

}
