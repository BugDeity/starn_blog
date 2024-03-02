package cn.com.starn.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.Followed;
import cn.com.starn.exception.BusinessException;
import cn.com.starn.handle.SystemNoticeHandle;
import cn.com.starn.im.MessageConstant;
import cn.com.starn.mapper.FollowedMapper;
import cn.com.starn.service.ApiFollowedService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Slf4j
@Service
@RequiredArgsConstructor
public class ApiFollowedServiceImpl implements ApiFollowedService {

    private final FollowedMapper followedMapper;


    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult insertFollowed(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new BusinessException("被关注用户id不能为空！");
        }
        if (userId.equals(StpUtil.getLoginIdAsString())) {
            throw new BusinessException("不能关注自己哦！");
        }
        Followed followed = Followed.builder().userId(StpUtil.getLoginIdAsString()).followedUserId(userId).build();
        followedMapper.insert(followed);
        // 发送系统通知
        SystemNoticeHandle.sendNotice(userId,MessageConstant.MESSAGE_WATCH_NOTICE,MessageConstant.SYSTEM_MESSAGE_CODE,null,null,null);
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
