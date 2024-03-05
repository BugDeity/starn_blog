package cn.com.starn.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.com.starn.common.FieldConstants;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.Tags;
import cn.com.starn.exception.BusinessException;
import cn.com.starn.mapper.TagsMapper;
import cn.com.starn.service.TagsService;
import cn.com.starn.utils.PageUtils;
import cn.com.starn.vo.SystemTagListVo;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.util.List;

import static cn.com.starn.common.FieldConstants.LIMIT_ONE;

/**
 * <p>
 * 博客标签表 服务实现类
 * </p>
 *
 * @author blue
 * @since 2021-09-09
 */
@Service
public class TagsServiceImpl extends ServiceImpl<TagsMapper, Tags> implements TagsService {

    /**
     * 标签列表
     * @param name
     * @return
     */
    @Override
    public ResponseResult listTags(String name) {
        Page<SystemTagListVo> list = baseMapper.selectPageRecord(new Page<>(PageUtils.getPageNo(), PageUtils.getPageSize()),name);
        return ResponseResult.success(list);
    }

    /**
     * 标签详情
     * @param id
     * @return
     */
    @Override
    public ResponseResult getTagsById(Long id) {
        Tags tags = baseMapper.selectById(id);
        return ResponseResult.success(tags);
    }

    /**
     * 添加标签
     * @param tags
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult insertTag(Tags tags) {
        validateName(tags.getName());
        baseMapper.insert(tags);
        return ResponseResult.success();
    }

    /**
     * 修改标签
     * @param tags
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult updateTag(Tags tags) {
        Tags entity = baseMapper.selectById(tags.getId());
        if (!entity.getName().equalsIgnoreCase(tags.getName())){
            validateName(tags.getName());
        }
        baseMapper.updateById(tags);
        return ResponseResult.success();
    }

    /**
     * 删除标签
     * @param id
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult deleteById(Long id) {
        validateTagIdIsExistArticle(id);
        baseMapper.deleteById(id);
        return ResponseResult.success();
    }

    /**
     * 批量删除标签
     * @param ids
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult deleteBatch(List<Long> ids) {
        for (Long id : ids) {
            validateTagIdIsExistArticle(id);
        }
        baseMapper.deleteBatchIds(ids);
        return ResponseResult.success();
    }

    private void validateTagIdIsExistArticle(Long id) {
        int count = baseMapper.validateTagIdIsExistArticle(id);
        if (count > 0){
            throw new BusinessException("标签下有文章，无法删除");
        }
    }

    /**
     * 置顶标签
     * @param id
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult top(Long id) {
        Tags tags = baseMapper.selectOne(new QueryWrapper<Tags>()
                .last(LIMIT_ONE).orderByDesc(FieldConstants.SORT));
        Assert.isTrue(!tags.getId().equals(id),"改标签已在最顶端!");
        Tags entity = Tags.builder().id(id).sort(tags.getSort()+1).build();
        int rows = baseMapper.updateById(entity);
        return rows > 0 ? ResponseResult.success(): ResponseResult.error();
    }


    public void validateName(String name){
        Tags entity = baseMapper.selectOne(new QueryWrapper<Tags>().eq(FieldConstants.NAME,name));
        if (ObjectUtils.isNotEmpty(entity)) {
            throw new BusinessException("标签名已存在");
        }
    }
}