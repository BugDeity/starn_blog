package com.shiyi.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Note;
import com.shiyi.mapper.NoteMapper;
import com.shiyi.service.NoteService;
import com.shiyi.utils.PageUtils;
import com.shiyi.vo.SystemNoteListVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author blue
 * @since 2021-11-10
 */
@Service
public class NoteServiceImpl extends ServiceImpl<NoteMapper, Note> implements NoteService {


    @Override
    public ResponseResult selectNoteList() {
        Page<SystemNoteListVO> page = baseMapper.selectSystemNoteList(new Page<SystemNoteListVO>(PageUtils.getPageNo(),PageUtils.getPageSize()));
        return ResponseResult.success(page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult deleteNoteByIds(List<Integer> ids) {
        baseMapper.deleteBatchIds(ids);
        return ResponseResult.success();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult updateNote(Note note) {
        baseMapper.updateById(note);
        return ResponseResult.success();
    }
}
