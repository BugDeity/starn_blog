package com.shiyi.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.shiyi.annotation.OperationLogger;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Talk;
import com.shiyi.service.TalkService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author: 拾壹
 * @date: 2023/10/18
 * @describe:
 */
@RestController
@RequestMapping("/system/talk")
@Api(tags = "圈子管理")
@RequiredArgsConstructor
public class TalkController {

    private final TalkService talkService;

    @GetMapping("list")
    @SaCheckPermission("/system/talk/list")
    @ApiOperation(value = "圈子列表",httpMethod = "GET", response = ResponseResult.class, notes = "圈子列表")
    public ResponseResult selectSystemTalkList(String name){
        return talkService.selectSystemTalkList(name);
    }

    @GetMapping("info")
    @ApiOperation(value = "圈子详情",httpMethod = "GET", response = ResponseResult.class, notes = "圈子详情")
    public ResponseResult selectSystemTalkById(Integer id){
        return talkService.selectSystemTalkById(id);
    }

    @PostMapping("add")
    @OperationLogger(value = "添加圈子")
    @SaCheckPermission("/system/talk/add")
    @ApiOperation(value = "添加圈子",httpMethod = "POST", response = ResponseResult.class, notes = "添加圈子")
    public ResponseResult addTalk(@RequestBody Talk talk){
        return talkService.addTalk(talk);
    }

    @PutMapping("update")
    @OperationLogger(value = "修改圈子")
    @SaCheckPermission("/system/talk/update")
    @ApiOperation(value = "修改圈子",httpMethod = "PUT", response = ResponseResult.class, notes = "修改圈子")
    public ResponseResult updateTalk(@RequestBody Talk talk){
        return talkService.updateTalk(talk);
    }

    @DeleteMapping("delete")
    @OperationLogger(value = "删除圈子")
    @SaCheckPermission("/system/talk/delete")
    @ApiOperation(value = "删除圈子",httpMethod = "DELETE", response = ResponseResult.class, notes = "删除圈子")
    public ResponseResult deleteTalk(@RequestBody List<Integer> ids){
        return talkService.deleteTalk(ids);
    }
}
