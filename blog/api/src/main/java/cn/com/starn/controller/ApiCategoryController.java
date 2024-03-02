package cn.com.starn.controller;

import cn.com.starn.common.ResponseResult;
import cn.com.starn.service.ApiCategoryService;
import cn.com.starn.service.CategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * 分类处理器
 * @author blue
 */
@Api(tags = "分类API-V1")
@RestController
@RequestMapping("v1/category")
@RequiredArgsConstructor
public class ApiCategoryController {

    private final ApiCategoryService categoryService;

    @RequestMapping(value = "/",method = RequestMethod.GET)
    @ApiOperation(value = "分类列表", httpMethod = "GET", response = ResponseResult.class, notes = "分类列表")
    public ResponseResult selectCategoryList(){
        return categoryService.selectCategoryList();
    }
}
