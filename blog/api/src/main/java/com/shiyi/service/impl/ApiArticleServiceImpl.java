package com.shiyi.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.common.Constants;
import com.shiyi.common.RedisConstants;
import com.shiyi.common.ResponseResult;
import com.shiyi.dto.ArticleInsertDTO;
import com.shiyi.entity.*;
import com.shiyi.enums.PublishEnum;
import com.shiyi.exception.BusinessException;
import com.shiyi.mapper.*;
import com.shiyi.service.ApiArticleService;
import com.shiyi.service.RedisService;
import com.shiyi.utils.BeanCopyUtils;
import com.shiyi.utils.ElasticsearchUtil;
import com.shiyi.utils.IpUtil;
import com.shiyi.utils.PageUtils;
import com.shiyi.vo.ApiArchiveVO;
import com.shiyi.vo.ApiArticleInfoVO;
import com.shiyi.vo.ApiArticleListVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

import static com.shiyi.common.RedisConstants.*;
import static com.shiyi.common.ResultCode.ERROR_EXCEPTION_MOBILE_CODE;

@Slf4j
@Service
@RequiredArgsConstructor
public class ApiArticleServiceImpl implements ApiArticleService {
    
    private final ArticleMapper articleMapper;

    private final CategoryMapper categoryMapper;

    private final UserMapper userMapper;

    private final RedisService redisService;

    private final TagsMapper tagsMapper;

    private final CommentMapper commentMapper;

    private final HttpServletRequest request;

    private final ElasticsearchUtil elasticsearchUtil;

    private final UserInfoMapper userInfoMapper;
    /**
     *  获取文章列表
     * @return
     */
    @Override
    public ResponseResult selectPublicArticleList(Integer categoryId,Integer tagId) {
        Page<ApiArticleListVO> articlePage = articleMapper.selectArticleList(new Page<>(PageUtils.getPageNo(), PageUtils.getPageSize()),
                categoryId,tagId);
        articlePage.getRecords().forEach(this::setCommentAndLike);
        return ResponseResult.success(articlePage);
    }

    /**
     *  获取文章详情
     * @return
     */
    @Override
    public ResponseResult selectPublicArticleInfo(Integer id) {
        ApiArticleInfoVO apiArticleInfoVO = articleMapper.selectArticleByIdToVO(id);
        //获取标签
        List<Tags> list = tagsMapper.selectTagByArticleId(apiArticleInfoVO.getId());
        apiArticleInfoVO.setTagList(list);
        //获取评论数量
        List<Comment> comments = commentMapper.selectList(
                new LambdaQueryWrapper<Comment>().eq(Comment::getArticleId, id));
        apiArticleInfoVO.setCommentCount(comments.size());
        //获取点赞数量
        Map<String, Object> map = redisService.getCacheMap(ARTICLE_LIKE_COUNT);
        if (map!= null && map.size() > 0){
            apiArticleInfoVO.setLikeCount(map.get(id.toString()));
        }
        //获取当前登录用户是否点赞该文章
        Object userId = StpUtil.getLoginIdDefaultNull();
        if (userId != null){
            String articleLikeKey = ARTICLE_USER_LIKE + userId;
            if (redisService.sIsMember(articleLikeKey, id)) {
                apiArticleInfoVO.setIsLike(true);
            }
        }
        //获取文章作者信息
        User user = userMapper.selectById(apiArticleInfoVO.getUserId());
        UserInfo userInfo = userInfoMapper.selectById(user.getUserInfoId());
        apiArticleInfoVO.setUserInfo(userInfo);
        //增加文章阅读量
        redisService.incrArticle(id.longValue(),ARTICLE_READING);
        return ResponseResult.success(apiArticleInfoVO);
    }

    /**
     *  获取归档
     * @return
     */
    @Override
    public ResponseResult archive() {
        List<ApiArchiveVO> articleList = articleMapper.selectListArchive();
        //按日期分组
        Map<String, List<ApiArchiveVO>> resultList = articleList.stream().collect(Collectors.groupingBy(ApiArchiveVO::getTime));
        Object[] keyArr = resultList.keySet().toArray();  //获取resultList的所有key值数组
        Arrays.sort(keyArr);
        List<Map<String,Object>> result = new ArrayList<>();
        for (int i = keyArr.length - 1; i >= 0; i--) {
            Map<String,Object> map = new HashMap<>();
            map.put("time",keyArr[i]);
            List<ApiArchiveVO> list = resultList.get(keyArr[i]);
            Collections.sort(list, (o1, o2) -> o2.getFormatTime().compareTo(o1.getFormatTime()));
            map.put("list",list);
            result.add(map);
        }
        return ResponseResult.success(result).putExtra("total",articleList.size());
    }

    /**
     *  搜索文章
     * @return
     */
    @Override
    public ResponseResult publicSearchArticle(String keywords) {
//        if (StringUtils.isBlank(keywords)) {
//            throw new BusinessException(PARAMS_ILLEGAL.getDesc());
//        }
//        //获取搜索模式（es搜索或mysql搜索）
//        SystemConfig systemConfig = systemConfigService.getCustomizeOne();
//        String strategy = SearchModelEnum.getStrategy(systemConfig.getSearchModel());
//        //搜索逻辑
//        List<ArticleSearchVO> articleSearchVOS = searchStrategyContext.executeSearchStrategy(strategy, keywords);
        Page<ApiArticleListVO> articlePage = articleMapper.publicPageSearchArticle(new Page<>(PageUtils.getPageNo(), PageUtils.getPageSize()),
                keywords);
        articlePage.getRecords().forEach(item -> {
            item.setTitle(item.getTitle().replaceAll("(?i)" + keywords, Constants.PRE_TAG + keywords + Constants.POST_TAG));
            setCommentAndLike(item);
        });

        return ResponseResult.success(articlePage);
    }

    /**
     * 文章点赞
     * @param articleId
     * @return
     */
    @Override
    public ResponseResult articleLike(Integer articleId) {
        // 判断是否点赞
        String articleLikeKey = ARTICLE_USER_LIKE + StpUtil.getLoginIdAsString();
        if (redisService.sIsMember(articleLikeKey, articleId)) {
            // 点过赞则删除文章id
            redisService.sRemove(articleLikeKey, articleId);
            // 文章点赞量-1
            redisService.hDecr(ARTICLE_LIKE_COUNT, articleId.toString(), 1L);
        } else {
            // 未点赞则增加文章id
            redisService.sAdd(articleLikeKey, articleId);
            // 文章点赞量+1
            redisService.hIncr(ARTICLE_LIKE_COUNT, articleId.toString(), 1L);
        }
        return ResponseResult.success();
    }

    /**
     * 用户添加文章
     * @param dto
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult publicInsertArticle(ArticleInsertDTO dto) {
        Article article = BeanCopyUtils.copyObject(dto, Article.class);
        article.setIsPublish(PublishEnum.AUDIO.code);
        if (article.getId() != null) {
            if (!article.getUserId().equals(StpUtil.getLoginIdAsString())) {
                throw new BusinessException("只能修改自己的文章！");
            }
            articleMapper.updateById(article);

            //先删出所有标签
            tagsMapper.deleteByArticleIds(Collections.singletonList(article.getId()));
            //然后新增标签
            tagsMapper.saveArticleTags(article.getId(),dto.getTagList());
        }else {
            article.setUserId(StpUtil.getLoginIdAsString());
            int insert = articleMapper.insert(article);
            //添加标签
            if (insert > 0){
                tagsMapper.saveArticleTags(article.getId(),dto.getTagList());
            }
        }

        return ResponseResult.success();
    }

    /**
     * 查询我的文章
     * @return
     */
    @Override
    public ResponseResult publicSelectMyArticle() {
        Page<ApiArticleListVO> list = articleMapper.publicSelectMyArticle(new Page<>(PageUtils.getPageNo(),PageUtils.getPageSize()),StpUtil.getLoginIdAsString());
        return ResponseResult.success(list);
    }

    /**
     * 删除我的文章
     * @param id
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult publicDeleteMyArticle(Long id) {
        Article article = articleMapper.selectById(id);
        if (!article.getUserId().equals(StpUtil.getLoginIdAsString())) {
            throw new BusinessException("只能删除自己的文章！");
        }
        articleMapper.deleteById(id);
        tagsMapper.deleteByArticleIds(Collections.singletonList(id));
        return ResponseResult.success();
    }

    /**
     * 获取我的文章详情
     * @param id
     * @return
     */
    @Override
    public ResponseResult publicSelectMyArticleInfo(Long id) {
        ArticleInsertDTO articleInsertDTO  =  articleMapper.publicSelectMyArticleInfo(id);
        if (!articleInsertDTO.getUserId().equals(StpUtil.getLoginIdAsString())) {
            throw new BusinessException("只能查看自己的文章！");
        }
        List<Tags> tags = tagsMapper.selectTagByArticleId(id);
        List<Long> tagList = tags.stream().map(Tags::getId).collect(Collectors.toList());
        articleInsertDTO.setTagList(tagList);
        return ResponseResult.success(articleInsertDTO);
    }

    /**
     *  校验文章验证码(验证码通过关注公众号获取)
     * @return
     */
    @Override
    public ResponseResult checkSecret(String code) {
        //校验验证码
        String key = RedisConstants.WECHAT_CODE + code;
        Object redisCode = redisService.getCacheObject(key);
        if (ObjectUtil.isNull(redisCode)) {
            throw new BusinessException(ERROR_EXCEPTION_MOBILE_CODE.getDesc());
        }

        //将ip存在redis 有效期一天，当天无需再进行验证码校验
        List<Object> cacheList = redisService.getCacheList(CHECK_CODE_IP);
        if (cacheList.isEmpty()) {
            cacheList = new ArrayList<>();
        }
        cacheList.add(IpUtil.getIp(request));
        redisService.setCacheList(CHECK_CODE_IP,cacheList);
        //通过删除验证码
        redisService.deleteObject(key);
        return ResponseResult.success("验证成功");
    }



    /**
     * 设置评论量和点赞量
     * @param item
     */
    private void setCommentAndLike(ApiArticleListVO item) {
        List<Tags> list = tagsMapper.selectTagByArticleId(item.getId());
        Integer commentCount = commentMapper.selectCount(new LambdaQueryWrapper<Comment>()
                .eq(Comment::getArticleId, item.getId()));
        //获取点赞数量
        Map<String, Object> map = redisService.getCacheMap(ARTICLE_LIKE_COUNT);
        if (map!= null && map.size() > 0){
            Object obj = map.get(item.getId().toString());
            item.setLikeCount(obj == null ? 0 : obj);
        }
        item.setTagList(list);
        item.setCommentCount(commentCount);
    }
}
