package com.shiyi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Sponsor;

import java.util.List;


/**
 *  打赏服务类
 *
 * @author blue
 * @since 2021-11-10
 */
public interface SponsorService extends IService<Sponsor> {


    /**
     * 列表
     * @return
     */
    ResponseResult selectSponsorList();


    /**
     * 打赏详情
     * @param id
     * @return
     */
    ResponseResult selectSponsorInfo(Integer id);

    /**
     * 修改
     * @param sponsor
     * @return
     */
    ResponseResult updateSponsor(Sponsor sponsor);

    /**
     * 删除打赏
     * @param ids
     * @return
     */
    ResponseResult deleteSponsor(List<Integer> ids);

}
