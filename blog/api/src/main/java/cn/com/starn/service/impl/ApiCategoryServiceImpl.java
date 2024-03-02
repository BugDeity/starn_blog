package cn.com.starn.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.Category;
import cn.com.starn.mapper.CategoryMapper;
import cn.com.starn.service.ApiCategoryService;
import cn.com.starn.vo.ApiCategoryListVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ApiCategoryServiceImpl implements ApiCategoryService {

    private final CategoryMapper categoryMapper;

    /**
     * 首页分类列表
     * @return
     */
    @Override
    public ResponseResult selectCategoryList() {
        List<ApiCategoryListVO> list = categoryMapper.selectCategoryListApi();
        return ResponseResult.success(list);
    }
}
