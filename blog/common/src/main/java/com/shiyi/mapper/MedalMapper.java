package com.shiyi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.shiyi.entity.Medal;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 * </p>
 *
 * @author blue
 * @since 2021-08-18
 */
@Repository
public interface MedalMapper extends BaseMapper<Medal> {

    List<Medal> selectMedalByUserId(String userId);
}
