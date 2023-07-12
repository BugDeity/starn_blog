package com.shiyi.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Note;
import com.shiyi.exception.BusinessException;
import com.shiyi.handle.RelativeDateFormat;
import com.shiyi.mapper.NoteMapper;
import com.shiyi.service.ApiNoteService;
import com.shiyi.utils.PageUtils;
import com.shiyi.vo.ApiNoteListVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ApiNoteServiceImpl implements ApiNoteService {

    private final NoteMapper noteMapper;

    @Override
    public ResponseResult selectNoteList(Integer categoryId) {
        Page<ApiNoteListVO> result =  noteMapper.selectPublicNoteList(new Page<ApiNoteListVO>(PageUtils.getPageNo(),PageUtils.getPageSize()),
                categoryId,null);
        result.getRecords().forEach(item ->{
            item.setCreateTimeStr(RelativeDateFormat.format(item.getCreateTime()));
        });
        return ResponseResult.success(result);
    }

    /**
     * 添加笔记
     * @param note 笔记对象
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult insertNote(Note note) {
        if (StringUtils.isBlank(note.getContent())) {
            throw new BusinessException("笔记内容不能为空！");
        }
        note.setUserId(StpUtil.getLoginIdAsString());
        noteMapper.insert(note);
        return ResponseResult.success();
    }

    /**
     * 获取我的笔记列表
     * @return
     */
    @Override
    public ResponseResult selectMyNote() {
        Page<ApiNoteListVO> notePage = noteMapper.selectPublicNoteList(new Page<>(PageUtils.getPageNo(), PageUtils.getPageSize()),
                null,StpUtil.getLoginIdAsString());
        return ResponseResult.success(notePage);
    }

    /**
     * 删除我的笔记
     * @param id 笔记id
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult deleteMyNote(Integer id) {
        Note note = noteMapper.selectById(id);
        if (note == null) {
            throw new BusinessException("笔记不存在!");
        }
        if (!note.getUserId().equals(StpUtil.getLoginIdAsString())) {
            throw new BusinessException("只能删除自己的笔记!");
        }
        noteMapper.deleteById(id);
        return ResponseResult.success();
    }
}
