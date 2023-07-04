package com.shiyi.service;

import com.shiyi.common.ResponseResult;

public interface ApiNoteService {
    /**
     * 获取笔记列表
     * @return
     */
    ResponseResult selectNoteList();

    /**
     * 添加笔记
     * @param content 内容
     * @return
     */
    ResponseResult insertNote(String content);
}
