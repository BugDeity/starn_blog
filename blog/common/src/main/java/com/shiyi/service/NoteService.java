package com.shiyi.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Note;

import java.util.List;

public interface NoteService extends IService<Note> {


    /**
     * 获取笔记列表
     * @return
     */
    ResponseResult selectNoteList();


    /**
     * 批量删除笔记
     * @param ids 笔记id集合
     * @return
     */
    ResponseResult deleteNoteByIds(List<Integer> ids);
}
