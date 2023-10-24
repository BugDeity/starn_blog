package com.shiyi.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.*;
import com.shiyi.handle.RelativeDateFormat;
import com.shiyi.mapper.FollowedMapper;
import com.shiyi.mapper.ForumCommentMapper;
import com.shiyi.mapper.ForumMapper;
import com.shiyi.mapper.UserInfoMapper;
import com.shiyi.service.ApiForumService;
import com.shiyi.utils.IpUtil;
import com.shiyi.utils.PageUtils;
import com.shiyi.vo.talk.ApiForumCommentListVO;
import com.shiyi.vo.talk.ApiForumLikeListVO;
import com.shiyi.vo.talk.ApiForumListVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @author: 拾壹
 * @date: 2023/10/16
 * @describe:
 */
@Service
@RequiredArgsConstructor
public class ApiForumServiceImpl implements ApiForumService {

    private final ForumMapper forumMapper;

    private final ForumCommentMapper forumCommentMapper;

    private final UserInfoMapper userInfoMapper;

    private final FollowedMapper followedMapper;

    @Override
    public ResponseResult selectForumListByTalkId(Integer talkId, String orderBy) {
        Page<ApiForumListVO> page = new Page<>();
        if (StringUtils.isNotBlank(orderBy) && orderBy.equals("followed") &&  StpUtil.isLogin()) {
            List<Followed>  followedList = followedMapper.selectList(new LambdaQueryWrapper<Followed>().eq(Followed::getUserId, StpUtil.getLoginIdAsString()));
            if (followedList.size() > 0) {
                page = forumMapper.selectForumListByTalkId(new Page<>(PageUtils.getPageNo(),PageUtils.getPageSize()),talkId,followedList);
            }
        }else {
            page = forumMapper.selectForumListByTalkId(new Page<>(PageUtils.getPageNo(),PageUtils.getPageSize()),talkId,null);
        }

        page.getRecords().forEach(item ->{
            String format = RelativeDateFormat.format(item.getCreateTime());
            Integer count = forumCommentMapper.selectCount(new LambdaQueryWrapper<ForumComment>().eq(ForumComment::getForumId, item.getId()));
            item.setCommentCount(count);
            int likeCount = forumMapper.countForumLike(item.getId());
            item.setLikeCount(likeCount);
            if (StpUtil.getLoginIdDefaultNull() != null) {
                int flag = forumMapper.selectForumUserIsLike(item.getId(), StpUtil.getLoginIdAsString());
                item.setIsLike(flag);
            }
            Page<ApiForumLikeListVO> likePages = forumMapper.selectForumLikeList(new Page<>(1,3),item.getId());
            item.setLikeListVO(likePages.getRecords());
            item.setCreateTimeStr(format);
        });
        return ResponseResult.success(page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult addForum(Forum forum) {
        forum.setUserId(StpUtil.getLoginIdAsString());
        forumMapper.insert(forum);
        return ResponseResult.success();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult comment(ForumComment forumComment) {
        forumComment.setUserId(StpUtil.getLoginIdAsString());
        String ip = IpUtil.getIp();
        String address = IpUtil.getIp2region(ip);
        forumComment.setIp(ip);
        forumComment.setAddress(address);
        forumCommentMapper.insert(forumComment);
        return ResponseResult.success();
    }

    @Override
    public ResponseResult commentList(Integer forumId) {
        Page<ApiForumCommentListVO> list = forumCommentMapper.selectListByForumId(new Page<>(PageUtils.getPageNo(),PageUtils.getPageSize()),forumId);
        //获取子级
        for (ApiForumCommentListVO vo : list.getRecords()) {
            List<ForumComment> commentList = forumCommentMapper.selectList(
                    new LambdaQueryWrapper<ForumComment>().eq(ForumComment::getParentId, vo.getId()).orderByDesc(ForumComment::getCreateTime));
            for (ForumComment e : commentList) {
                UserInfo replyUserInfo = userInfoMapper.getByUserId(e.getReplyUserId());
                UserInfo userInfo1 = userInfoMapper.getByUserId(e.getUserId());
                ApiForumCommentListVO apiForumCommentListVO = ApiForumCommentListVO.builder()
                        .id(e.getId())
                        .userId(e.getUserId())
                        .replyUserId(e.getReplyUserId())
                        .nickname(userInfo1.getNickname())
                        .replyNickname(replyUserInfo.getNickname())
                        .content(e.getContent())
                        .avatar(userInfo1.getAvatar())
                        .createTimeStr(RelativeDateFormat.format(e.getCreateTime()))
                        .address(e.getAddress())
                        .build();
                vo.getChildren().add(apiForumCommentListVO);
            }
            vo.setCreateTimeStr(RelativeDateFormat.format(vo.getCreateTime()));
        }
        return ResponseResult.success(list);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult like(Integer forumId) {
        int count = forumMapper.selectForumUserIsLike(forumId, StpUtil.getLoginIdAsString());
        if (count > 0) {
            forumMapper.deleteForumLikeByUerIdAndForumId(forumId, StpUtil.getLoginIdAsString());
            return ResponseResult.success("取消点赞");

        }
        forumMapper.insertForumLike(forumId, StpUtil.getLoginIdAsString());
        return ResponseResult.success("点赞成功");
    }

    @Override
    public ResponseResult likeList(Integer forumId) {
        Object userId = StpUtil.getLoginIdDefaultNull();
        Page<ApiForumLikeListVO> likePages = forumMapper.selectForumLikeList(new Page<>(PageUtils.getPageNo(),PageUtils.getPageSize()),forumId);
        likePages.getRecords().forEach(item ->{
            if (userId != null){
                int count = followedMapper.selectCount(new LambdaQueryWrapper<Followed>().eq(Followed::getUserId,userId).eq(Followed::getFollowedUserId,item.getUserId()));
                item.setIsFollowed(count);
            }
        });
        return ResponseResult.success(likePages);
    }
}
