package com.shiyi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.entity.Forum;
import com.shiyi.vo.talk.ApiForumListVO;
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
public interface ForumMapper extends BaseMapper<Forum> {

    Page<ApiForumListVO> selectForumListByTalkId(@Param("page") Page<Object> page, @Param("talkId") Integer talkId);
}
