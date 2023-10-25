package com.shiyi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.entity.Sponsor;
import com.shiyi.vo.sponsor.SponsorListVO;
import org.apache.ibatis.annotations.Param;
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

    Page<SponsorListVO> selectSponsorList(@Param("objectPage")Page<Object> objectPage,@Param("status") Integer status);
}
