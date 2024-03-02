package cn.com.starn.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.Article;
import cn.com.starn.entity.Collect;
import cn.com.starn.entity.Tags;
import cn.com.starn.handle.SystemNoticeHandle;
import cn.com.starn.im.MessageConstant;
import cn.com.starn.mapper.ArticleMapper;
import cn.com.starn.mapper.CollectMapper;
import cn.com.starn.mapper.TagsMapper;
import cn.com.starn.service.ApiCollectService;
import cn.com.starn.utils.PageUtils;
import cn.com.starn.vo.ApiArticleListVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ApiCollectServiceImpl implements ApiCollectService {

    private final CollectMapper collectMapper;

    private final ArticleMapper articleMapper;

    private final TagsMapper tagsMapper;

    /**
     * 我的收藏列表
     * @return
     */
    @Override
    public ResponseResult selectCollectList() {
        Page<ApiArticleListVO> list = collectMapper.selectCollectList(new Page<ApiArticleListVO>(PageUtils.getPageNo(),PageUtils.getPageSize()),StpUtil.getLoginIdAsString());
        list.getRecords().forEach(item ->{
            List<Tags> tags = tagsMapper.selectTagByArticleId(item.getId());
            item.setTagList(tags);
        });
        return ResponseResult.success(list);
    }

    /**
     * 收藏文章
     * @param articleId 文章id
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult collect(Integer articleId) {
        Collect collect = Collect.builder().userId(StpUtil.getLoginIdAsString()).articleId(articleId).build();
        collectMapper.insert(collect);
        // 发送系统通知
        Article article = articleMapper.selectById(articleId);
        SystemNoticeHandle.sendNotice(article.getUserId(),MessageConstant.MESSAGE_COLLECT_NOTICE,MessageConstant.SYSTEM_MESSAGE_CODE,articleId,null,null);
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
