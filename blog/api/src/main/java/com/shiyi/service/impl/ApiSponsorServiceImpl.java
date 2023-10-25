package com.shiyi.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Sponsor;
import com.shiyi.mapper.SponsorMapper;
import com.shiyi.service.ApiSponsorService;
import com.shiyi.utils.PageUtils;
import com.shiyi.vo.sponsor.SponsorListVO;
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
    public ResponseResult selectSponsorList() {
        Page<SponsorListVO> page = sponsorMapper.selectSponsorList(new Page<>(PageUtils.getPageNo(),PageUtils.getPageSize()),1);
        return ResponseResult.success(page);
    }

    @Override
    @Transactional(rollbackFor =  Exception.class)
    public ResponseResult addSponsor(String payImage) {
        Sponsor sponsor = Sponsor.builder().userId(StpUtil.getLoginIdAsString()).payImg(payImage).build();
        sponsorMapper.insert(sponsor);
        return ResponseResult.success();
    }


}
