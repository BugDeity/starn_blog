package com.shiyi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.entity.Sponsor;
import com.shiyi.vo.sponsor.ApiSponsorListVO;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * </p>
 *
 * @author blue
 * @since 2021-08-18
 */
@Repository
public interface SponsorMapper extends BaseMapper<Sponsor> {

    Page<ApiSponsorListVO> selectSponsorList(Page<Object> objectPage);
}
