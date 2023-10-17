package com.shiyi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.entity.ForumComment;
import com.shiyi.vo.talk.ApiForumCommentListVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;


@Repository
public interface ForumCommentMapper extends BaseMapper<ForumComment> {

    Page<ApiForumCommentListVO> selectListByForumId(@Param("page")Page<Object> page,@Param("forumId") Integer forumId);
}
