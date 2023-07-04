package com.shiyi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.entity.Note;
import com.shiyi.vo.ApiNoteListVO;
import org.springframework.stereotype.Repository;

/**
 * <p>
 * </p>
 *
 * @author blue
 * @since 2021-08-18
 */
@Repository
public interface NoteMapper extends BaseMapper<Note> {

    /**
     *  获取笔记列表
     * @param apiNoteListVOPage
     * @return
     */
    Page<ApiNoteListVO> selectPublicNoteList(Page<ApiNoteListVO> apiNoteListVOPage);
}
