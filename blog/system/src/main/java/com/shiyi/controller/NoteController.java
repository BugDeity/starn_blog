package com.shiyi.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.dev33.satoken.annotation.SaCheckPermission;
import com.shiyi.common.ResponseResult;
import com.shiyi.service.NoteService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/system/note")
@Api(tags = "笔记管理-接口")
@RequiredArgsConstructor
public class NoteController {

    private final NoteService noteService;

    @SaCheckLogin
    @RequestMapping(value="/list",method = RequestMethod.GET)
    @ApiOperation(value = "笔记列表", httpMethod = "GET", response = ResponseResult.class, notes = "笔记列表")
    public ResponseResult list(){
        return noteService.selectNoteList();
    }

    @SaCheckPermission("/system/note/delete")
    @RequestMapping(value="/delete",method = RequestMethod.DELETE)
    @ApiOperation(value = "删除笔记", httpMethod = "DELETE", response = ResponseResult.class, notes = "删除笔记")
    public ResponseResult delete(@RequestBody List<Integer> ids){
        return noteService.deleteNoteByIds(ids);
    }

}
