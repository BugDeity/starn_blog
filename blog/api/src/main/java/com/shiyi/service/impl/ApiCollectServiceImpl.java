package com.shiyi.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Article;
import com.shiyi.entity.Collect;
import com.shiyi.entity.ImMessage;
import com.shiyi.im.MessageConstant;
import com.shiyi.mapper.ArticleMapper;
import com.shiyi.mapper.CollectMapper;
import com.shiyi.mapper.ImMessageMapper;
import com.shiyi.service.ApiCollectService;
import com.shiyi.utils.IpUtil;
import com.shiyi.utils.PageUtils;
import com.shiyi.vo.ApiArticleListVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@Service
@RequiredArgsConstructor
public class ApiCollectServiceImpl implements ApiCollectService {

    private final CollectMapper collectMapper;

    private final ImMessageMapper imMessageMapper;

    private final ArticleMapper articleMapper;

    /**
     * 我的收藏列表
     * @return
     */
    @Override
    public ResponseResult selectCollectList() {
        Page<ApiArticleListVO> result = collectMapper.selectCollectList(new Page<ApiArticleListVO>(PageUtils.getPageNo(),PageUtils.getPageSize()),StpUtil.getLoginIdAsString());
        return ResponseResult.success(result);
    }

    /**
     * 收藏文章
     * @param articleId 文章id
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult collect(Integer articleId, HttpServletRequest request) {
        Collect collect = Collect.builder().userId(StpUtil.getLoginIdAsString()).articleId(articleId).build();
        collectMapper.insert(collect);
        try {
            Article article = articleMapper.selectById(articleId);
            String ip = IpUtil.getIp(request);
            ImMessage message = ImMessage.builder().fromUserId(StpUtil.getLoginIdAsString()).toUserId(article.getUserId())
                    .noticeType(MessageConstant.MESSAGE_COLLECT_NOTICE).code(MessageConstant.SYSTEM_MESSAGE_CODE)
                    .ip(ip).ipSource(IpUtil.getIp2region(ip)).articleId(articleId).build();
            imMessageMapper.insert(message);
        } catch (Exception e) {
            //添加失败的话不抛异常，还是要点赞执行成功
            log.error("生成收藏消息通知失败，错误原因：{}",e.getMessage());
        }
        return ResponseResult.success();
    }

    /**
     * 取消收藏
     * @param articleId 文章id
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult cancel(Integer articleId) {
        collectMapper.delete(new LambdaQueryWrapper<Collect>().eq(Collect::getUserId,StpUtil.getLoginIdAsString()).eq(Collect::getArticleId,articleId));
        return ResponseResult.success();
    }
}
