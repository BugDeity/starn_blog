package com.shiyi.im;



import com.alibaba.fastjson.JSONObject;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.ImMessage;
import com.shiyi.service.ApiImMessageService;
import com.shiyi.utils.SpringUtils;
import com.shiyi.vo.ImMessageVO;
import io.netty.channel.Channel;
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame;
import lombok.RequiredArgsConstructor;
import org.jetbrains.annotations.NotNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class WebSocketInfoService {

    private static final Logger logger = LoggerFactory.getLogger(WebSocketInfoService.class);


    /**
     * 清除会话信息
     * @param channel
     */
    public void clearSession(Channel channel) {
        String userId = NettyAttrUtil.getUserId(channel);
        // 清除会话信息
        SessionHolder.channelGroup.remove(channel);
        SessionHolder.channelMap.remove(userId);
    }

    /**
     * 广播 ping 信息
     */
    public void sendPing() {
        ImMessageVO webSocketMessage = new ImMessageVO();
        webSocketMessage.setCode(MessageCodeConstant.PING_MESSAGE_CODE);
        String message = JSONObject.toJSONString(webSocketMessage);
        TextWebSocketFrame tws = new TextWebSocketFrame(message);
        SessionHolder.channelGroup.writeAndFlush(tws);
    }

    /**
     * 从缓存中移除Channel，并且关闭Channel
     */
    public void scanNotActiveChannel() {
        Map<String, Channel> channelMap = SessionHolder.channelMap;
        if (channelMap.size() == 0) {
            return;
        }
        for (Channel channel : channelMap.values()) {
            long lastHeartBeatTime = NettyAttrUtil.getLastHeartBeatTime(channel);
            long intervalMillis = (System.currentTimeMillis() - lastHeartBeatTime);
            if (!channel.isOpen()
                    || !channel.isActive()
                    || intervalMillis > 90000L) {
                channelMap.remove(channel);
                SessionHolder.channelGroup.remove(channel);
                if (channel.isOpen() || channel.isActive()) {
                    channel.close();
                }
            }
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public void chat(String message,HttpServletRequest request) {

        ImMessageVO messageData = parseMessage(message);
        ApiImMessageService imMessageService = getImMessageService();
        messageData = imMessageService.updateOrInsert(messageData,request);

        if (messageData.getToUserId() != null) {
            messageData.setCode(MessageCodeConstant.PRIVATE_CHAT_CODE);
        }else {
            messageData.setCode(MessageCodeConstant.GROUP_CHAT_CODE);
        }

        message = JSONObject.toJSONString(messageData);
        TextWebSocketFrame tws = new TextWebSocketFrame(message);
        SessionHolder.channelGroup.writeAndFlush(tws);
    }

    @NotNull
    private static ApiImMessageService getImMessageService() {
        return SpringUtils.getBean(ApiImMessageService.class);
    }

    private ImMessageVO parseMessage(String message){
        JSONObject jsonObject = JSONObject.parseObject(message);
        return jsonObject.getObject("messageData", ImMessageVO.class);
    }

}

