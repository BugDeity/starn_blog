package cn.com.starn.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.Navigation;
import cn.com.starn.entity.SiteClass;
import cn.com.starn.mapper.NavigationMapper;
import cn.com.starn.mapper.SiteClassMapper;
import cn.com.starn.service.NavigationService;
import cn.com.starn.service.SiteClassService;
import cn.com.starn.utils.PageUtils;
import io.swagger.models.auth.In;
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
public class NavigationServiceImpl extends ServiceImpl<NavigationMapper, Navigation> implements NavigationService {


    @Override
    public ResponseResult selectNavigationList(Integer siteClassId) {
        Page<Navigation> siteClassPage = baseMapper.selectPage(new Page<>(PageUtils.getPageNo(), PageUtils.getPageSize()),
                new LambdaQueryWrapper<Navigation>().eq(Navigation::getSiteClassId,siteClassId));
        return ResponseResult.success(siteClassPage);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult insertNavigation(Navigation navigation) {
        baseMapper.insert(navigation);
        return ResponseResult.success();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult updateNavigation(Navigation navigation) {
        baseMapper.updateById(navigation);
        return ResponseResult.success();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult deleteBatch(List<Integer> ids) {
        baseMapper.deleteBatchIds(ids);
        return ResponseResult.success();
    }
}
