package com.shiyi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.shiyi.entity.Talk;
import com.shiyi.vo.talk.ApiTalkListVO;
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
public interface TalkMapper extends BaseMapper<Talk> {

    /**
     * 门户获取话题列表
     * @return
     */
    List<ApiTalkListVO> selectTalkListApi();


}
