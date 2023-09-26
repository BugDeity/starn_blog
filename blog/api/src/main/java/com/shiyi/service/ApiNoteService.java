package com.shiyi.service;

import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Note;
import io.swagger.models.auth.In;

public interface ApiNoteService {
    /**
     * 获取笔记列表
     * @return
     */
    ResponseResult selectNoteList(Integer categoryId);

    /**
     * 添加笔记
     * @param note 笔记对象
     * @return
     */
    ResponseResult insertNote(Note note);

    /**
     * 获取我的笔记列表
     * @return
     */
    ResponseResult selectNoteByUserId(String userId, Integer status);


    /**
     * 删除我的笔记
     * @param id 笔记id
     * @return
     */
    ResponseResult deleteMyNote(Integer id);

}
