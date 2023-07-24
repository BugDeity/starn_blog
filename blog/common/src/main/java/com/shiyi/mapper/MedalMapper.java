package com.shiyi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.shiyi.entity.Medal;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
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

    void insertMedalByUserId(@Param("medalId") int medalId, @Param("userId") String userId, @Param("time") Date date);
}
