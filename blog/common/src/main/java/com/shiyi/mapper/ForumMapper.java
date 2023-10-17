package com.shiyi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.entity.Forum;
import com.shiyi.vo.talk.ApiForumLikeListVO;
import com.shiyi.vo.talk.ApiForumListVO;
import org.apache.ibatis.annotations.Param;
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
public interface ForumMapper extends BaseMapper<Forum> {

    Page<ApiForumListVO> selectForumListByTalkId(@Param("page") Page<Object> page, @Param("talkId") Integer talkId);

    void insertForumLike(@Param("forumId") Integer forumId, @Param("userId")String userId);

    int selectForumUserIsLike(@Param("forumId") Integer forumId, @Param("userId")String userId);

    void deleteForumLikeByUerIdAndForumId(@Param("forumId") Integer forumId, @Param("userId")String userId);

    int countForumLike(Integer forumId);

    Page<ApiForumLikeListVO> selectForumLikeList(@Param("page") Page<Object> page,@Param("forumId") Integer forumId);

}
