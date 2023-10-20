package com.shiyi.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Sponsor;
import com.shiyi.mapper.SponsorMapper;
import com.shiyi.service.ApiSponsorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author blue
 * @since 2021-11-10
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ApiSponsorServiceImpl implements ApiSponsorService {

    private final SponsorMapper sponsorMapper;


    @Override
    @Transactional(rollbackFor =  Exception.class)
    public ResponseResult addSponsor(String payImage) {
        Sponsor sponsor = Sponsor.builder().userId(StpUtil.getLoginIdAsString()).payImg(payImage).build();
        sponsorMapper.insert(sponsor);
        return ResponseResult.success();
    }
}
