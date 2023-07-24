package com.shiyi.controller;


import com.shiyi.annotation.BusinessLogger;
import com.shiyi.annotation.OperationLogger;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.FriendLink;
import com.shiyi.service.ApiFriendLinkService;
import com.shiyi.service.FriendLinkService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 友情链接表 前端控制器
 * </p>
 *
 * @author blue
 * @since 2021-08-18
 */
@RestController
@RequestMapping("/v1/link")
@Api(tags = "友情链接API-V1")
@RequiredArgsConstructor
public class ApiFriendLinkController {

    private final ApiFriendLinkService friendLinkService;

    @BusinessLogger(value = "友链模块-用户访问页面",type = "查询",desc = "友链列表")
    @RequestMapping(value = "/",method = RequestMethod.GET)
    @ApiOperation(value = "友链列表", httpMethod = "GET", response = ResponseResult.class, notes = "友链列表")
    public ResponseResult selectFriendLinkList(){
        return friendLinkService.selectFriendLinkList();
    }

    @OperationLogger(save = false,value = "用户申请友链")
    @BusinessLogger(value = "友链模块-用户申请友链",type = "添加",desc = "用户申请友链")
    @RequestMapping(value = "/",method = RequestMethod.POST)
    @ApiOperation(value = "申请友链", httpMethod = "POST", response = ResponseResult.class, notes = "申请友链")
    public ResponseResult insertFriendLink(@RequestBody FriendLink friendLink){
        return friendLinkService.insertFriendLink(friendLink);
    }



}

