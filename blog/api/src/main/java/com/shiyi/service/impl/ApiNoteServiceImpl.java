package com.shiyi.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Note;
import com.shiyi.exception.BusinessException;
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
    public ResponseResult selectNoteList() {
        Page<ApiNoteListVO> result =  noteMapper.selectPublicNoteList(new Page<ApiNoteListVO>(PageUtils.getPageNo(),PageUtils.getPageSize()));
        return ResponseResult.success(result);
    }

    /**
     * 添加笔记
     * @param content 内容
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult insertNote(String content) {
        if (StringUtils.isBlank(content)) {
            throw new BusinessException("笔记内容不能为空！");
        }
        Note note = Note.builder().userId(StpUtil.getLoginIdAsString()).content(content).build();
        noteMapper.insert(note);
        return ResponseResult.success();
    }
}
