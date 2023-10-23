package com.shiyi.service;

import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Forum;
import com.shiyi.entity.ForumComment;

/**
 * @author: 拾壹
 * @date: 2023/10/16
 * @describe:
 */
public interface ApiForumService {
    /**
     * 根据圈子id获取内容
     * @param talkId
     * @return
     */
    ResponseResult selectForumListByTalkId(Integer talkId,String orderBy);

    /**
     * 添加圈子内容
     * @param forum
     * @return
     */
    ResponseResult addForum(Forum forum);

    /**
     * 圈子内容评论
     * @param forumComment
     * @return
     */
    ResponseResult comment(ForumComment forumComment);

    /**
     * 圈子内容评论列表
     * @param forumId
     * @return
     */
    ResponseResult commentList(Integer forumId);

    /**
     * 内容点赞
     * @param forumId
     * @return
     */
    ResponseResult like(Integer forumId);

    /**
     * 内容点赞列表
     * @param forumId
     * @return
     */
    ResponseResult likeList(Integer forumId);
}
