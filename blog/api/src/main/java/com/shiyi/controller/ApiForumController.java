package com.shiyi.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Forum;
import com.shiyi.entity.ForumComment;
import com.shiyi.service.ApiForumService;
import com.shiyi.service.ApiTalkService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * @author: 拾壹
 * @date: 2023/10/16
 * @describe:
 */
@RequestMapping("/v1/forum")
@RestController
@Api(tags = "圈子内容接口")
@RequiredArgsConstructor
public class ApiForumController {

    private final ApiForumService apiForumService;

    @GetMapping("list")
    @ApiOperation(value = "话题列表", httpMethod = "GET", response = ResponseResult.class, notes = "话题列表")
    public ResponseResult selectForumListByTalkId(Integer talkId){
        return apiForumService.selectForumListByTalkId(talkId);
    }

    @SaCheckLogin
    @PostMapping("add")
    @ApiOperation(value = "添加圈子内容", httpMethod = "POST", response = ResponseResult.class, notes = "添加圈子内容")
    public ResponseResult addForum(@RequestBody Forum forum){
        return apiForumService.addForum(forum);
    }

    @SaCheckLogin
    @PostMapping("comment")
    @ApiOperation(value = "圈子内容评论", httpMethod = "POST", response = ResponseResult.class, notes = "圈子内容评论")
    public ResponseResult comment(@RequestBody ForumComment forumComment){
        return apiForumService.comment(forumComment);
    }

    @GetMapping("commentList")
    @ApiOperation(value = "圈子内容评论列表", httpMethod = "GET", response = ResponseResult.class, notes = "圈子内容评论列表")
    public ResponseResult commentList(Integer forumId){
        return apiForumService.commentList(forumId);
    }

}
