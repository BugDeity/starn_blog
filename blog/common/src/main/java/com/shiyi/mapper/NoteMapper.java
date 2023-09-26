package com.shiyi.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.entity.Note;
import com.shiyi.vo.ApiNoteListVO;
import com.shiyi.vo.SystemNoteListVO;
import org.apache.ibatis.annotations.Param;
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
    Page<ApiNoteListVO> selectPublicNoteList(Page<ApiNoteListVO> apiNoteListVOPage,@Param("categoryId") Integer categoryId,
                                             @Param("userId") String userId);

    Page<ApiNoteListVO> selectNoteByUserId(Page<ApiNoteListVO> apiNoteListVOPage,@Param("userId") String userId,@Param("status") Integer status);

    /**
     * 后台系统-获取笔记列表
     * @param systemNoteListVOPage
     * @return
     */
    Page<SystemNoteListVO> selectSystemNoteList(Page<SystemNoteListVO> systemNoteListVOPage);

}
