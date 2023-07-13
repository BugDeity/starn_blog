package com.shiyi.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Sign;
import com.shiyi.exception.BusinessException;
import com.shiyi.mapper.SignMapper;
import com.shiyi.service.ApiSignService;
import com.shiyi.utils.DateUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ApiSignServiceImpl implements ApiSignService {

    private final SignMapper signMapper;

    /**
     * 用户的签到记录
     * @param startTime 开始时间
     * @param endTime 结束时间
     * @return
     */
    @Override
    public ResponseResult getSignRecords(String startTime, String endTime) {
        List<String> list = signMapper.getSignRecordsByUserId(startTime,endTime,StpUtil.getLoginIdAsString());
        return ResponseResult.success(list);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult sign(String time) {
        String userId = StpUtil.getLoginIdAsString();
        String todayStr = DateUtil.dateTimeToStr(new Date(), DateUtil.YYYY_MM_DD);
        if (!todayStr.equals(time)) {
            throw new BusinessException("时间已过，不能签到！");
        }
        Sign sign = signMapper.selctSignByUserIdAndTime(userId,time);
        if (sign != null) {
            throw new BusinessException("当日已签到，无需再次签到！");
        }
        sign = Sign.builder().userId(userId).createTime(DateUtil.strToDateTime(time,DateUtil.YYYY_MM_DD)).build();
        signMapper.insert(sign);
        return ResponseResult.success();
    }
}
