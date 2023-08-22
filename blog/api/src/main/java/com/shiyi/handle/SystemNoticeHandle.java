package com.shiyi.handle;

import cn.dev33.satoken.stp.StpUtil;
import com.shiyi.entity.ImMessage;
import com.shiyi.im.MessageConstant;
import com.shiyi.mapper.ImMessageMapper;
import com.shiyi.utils.IpUtil;
import com.shiyi.utils.SpringUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Slf4j
public class SystemNoticeHandle {


    /**
     *
     * 发送系统通知
     * @param toUserId
     * @param noticeType
     * @param noticeCode
     */
    public static void sendNotice(HttpServletRequest request,String toUserId,Integer noticeType,Integer noticeCode,Integer articleId,Integer commentMark) {
        ImMessageMapper imMessageMapper = SpringUtils.getBean(ImMessageMapper.class);
        try {
            String ip = IpUtil.getIp(request);

            ImMessage message = ImMessage.builder().fromUserId(StpUtil.getLoginIdAsString()).toUserId(toUserId)
                    .noticeType(noticeType).code(noticeCode).ip(ip).ipSource(IpUtil.getIp2region(ip)).articleId(articleId).build();
            imMessageMapper.insert(message);
        } catch (Exception e) {
            //添加失败的话不抛异常，还是要点赞执行成功
            log.error("生成消息通知失败，错误原因：{}",e.getMessage());
        }
    }
}
