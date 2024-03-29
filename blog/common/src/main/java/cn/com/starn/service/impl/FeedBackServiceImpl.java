package cn.com.starn.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.com.starn.common.FieldConstants;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.FeedBack;
import cn.com.starn.mapper.FeedBackMapper;
import cn.com.starn.service.FeedBackService;
import cn.com.starn.utils.PageUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author blue
 * @since 2022-01-13
 */
@Service
public class FeedBackServiceImpl extends ServiceImpl<FeedBackMapper, FeedBack> implements FeedBackService {

    /**
     * 反馈列表
     * @param type
     * @return
     */
    @Override
    public ResponseResult listFeedBack(Integer type) {
        QueryWrapper<FeedBack> queryWrapper = new QueryWrapper<FeedBack>()
                .orderByDesc(FieldConstants.CREATE_TIME).eq(type != null, FieldConstants.TYPE,type);
        Page<FeedBack> feedBackPage = baseMapper.selectPage(new Page<>(PageUtils.getPageNo(), PageUtils.getPageSize()), queryWrapper);
        return ResponseResult.success(feedBackPage);
    }

    /**
     * 删除反馈
     * @param ids
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult deleteBatch(List<Integer> ids) {
        int rows = baseMapper.deleteBatchIds(ids);
        return rows > 0 ? ResponseResult.success(): ResponseResult.error("删除反馈失败");
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult updateFeedBack(FeedBack feedBack) {
        baseMapper.updateById(feedBack);
        return ResponseResult.success();
    }

}
