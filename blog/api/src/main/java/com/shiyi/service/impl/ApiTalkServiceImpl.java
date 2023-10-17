package com.shiyi.service.impl;

import com.shiyi.common.ResponseResult;
import com.shiyi.mapper.TalkMapper;
import com.shiyi.service.ApiTalkService;
import com.shiyi.vo.talk.ApiTalkListVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

/**
 * @author: 拾壹
 * @date: 2023/10/16
 * @describe:
 */

@Slf4j
@Service
@RequiredArgsConstructor
public class ApiTalkServiceImpl implements ApiTalkService {

    private final TalkMapper talkMapper;

    @Override
    public ResponseResult selectList() {
        List<ApiTalkListVO> list = talkMapper.selectTalkListApi();
        return ResponseResult.success(list);
    }

    @Override
    public ResponseResult analysis(String url) {
        try {
            Document doc = Jsoup.connect(url).get();
            return ResponseResult.success(doc.title());
        } catch (IOException e) {
            log.info("网页地址解析失败，错误原因:{}",e.getMessage());
            return null;
        }
    }
}
