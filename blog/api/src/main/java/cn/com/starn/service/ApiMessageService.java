package cn.com.starn.service;


import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.Message;

public interface ApiMessageService {

    /**
     * 获取所有留言
     * @return
     */
    ResponseResult selectMessageList();

    /**
     * 添加留言
     * @param message
     * @return
     */
    ResponseResult insertMessage(Message message);
}
