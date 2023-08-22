package com.shiyi.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Followed;
import com.shiyi.entity.ImMessage;
import com.shiyi.exception.BusinessException;
import com.shiyi.handle.SystemNoticeHandle;
import com.shiyi.im.MessageConstant;
import com.shiyi.mapper.FollowedMapper;
import com.shiyi.mapper.ImMessageMapper;
import com.shiyi.service.ApiFollowedService;
import com.shiyi.utils.IpUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@Service
@RequiredArgsConstructor
public class ApiFollowedServiceImpl implements ApiFollowedService {

    private final FollowedMapper followedMapper;

    private final ImMessageMapper imMessageMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult insertFollowed(String userId, HttpServletRequest request) {
        if (StringUtils.isBlank(userId)) {
            throw new BusinessException("被关注用户id不能为空！");
        }
        if (userId.equals(StpUtil.getLoginIdAsString())) {
            throw new BusinessException("不能关注自己哦！");
        }
        Followed followed = Followed.builder().userId(StpUtil.getLoginIdAsString()).followedUserId(userId).build();
        followedMapper.insert(followed);
        // 发送系统通知
        SystemNoticeHandle.sendNotice(request,userId,MessageConstant.MESSAGE_WATCH_NOTICE,MessageConstant.SYSTEM_MESSAGE_CODE,null,null);
        return ResponseResult.success();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult deleteFollowed(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new BusinessException("被关注用户id不能为空！");
        }
        followedMapper.delete(new LambdaQueryWrapper<Followed>().eq(Followed::getUserId,StpUtil.getLoginIdAsString()).eq(Followed::getFollowedUserId,userId));
        return ResponseResult.success();
    }
}
