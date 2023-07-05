package com.shiyi.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Note;
import com.shiyi.service.ApiNoteService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * @author blue
 * @date 2022/1/13
 * @apiNote
 */
@RestController
@RequestMapping("/v1/note")
@RequiredArgsConstructor
@Api(tags = "笔记API-V1")
public class ApiNoteController {

    private final ApiNoteService apiNoteService;

    @GetMapping(value = "/")
    @ApiOperation(value = "笔记列表", httpMethod = "GET", response = ResponseResult.class, notes = "笔记列表")
    public ResponseResult selectNoteList(Integer categoryId) {
        return apiNoteService.selectNoteList(categoryId);
    }

    @SaCheckLogin
    @PostMapping(value = "/")
    @ApiOperation(value = "添加笔记", httpMethod = "POST", response = ResponseResult.class, notes = "添加笔记")
    public ResponseResult insertNote(@RequestBody  Note note) {
        return apiNoteService.insertNote(note);
    }

    @SaCheckLogin
    @GetMapping(value = "/getMyNote")
    @ApiOperation(value = "我的笔记列表", httpMethod = "GET", response = ResponseResult.class, notes = "我的笔记列表")
    public ResponseResult selectMyNote() {
        return apiNoteService.selectMyNote();
    }

    @SaCheckLogin
    @DeleteMapping(value = "/delete")
    @ApiOperation(value = "删除笔记", httpMethod = "DELETE", response = ResponseResult.class, notes = "删除笔记")
    public ResponseResult deleteMyNote(Integer id) {
        return apiNoteService.deleteMyNote(id);
    }

}
