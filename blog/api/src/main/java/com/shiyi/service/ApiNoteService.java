package com.shiyi.service;

import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Note;

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
}
