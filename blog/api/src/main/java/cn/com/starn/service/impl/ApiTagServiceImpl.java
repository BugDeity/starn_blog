package cn.com.starn.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.Tags;
import cn.com.starn.mapper.TagsMapper;
import cn.com.starn.service.ApiTagService;
import cn.com.starn.vo.ApiTagListVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ApiTagServiceImpl implements ApiTagService {

    private final TagsMapper tagsMapper;

    /**
     *  标签列表
     * @return
     */
    @Override
    public ResponseResult selectTagList() {
        List<ApiTagListVO> list = tagsMapper.selectTagListApi();
        return ResponseResult.success(list);
    }
}
