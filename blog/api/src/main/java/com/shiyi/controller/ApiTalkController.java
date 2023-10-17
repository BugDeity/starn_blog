package com.shiyi.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import com.shiyi.annotation.BusinessLogger;
import com.shiyi.common.ResponseResult;
import com.shiyi.service.ApiTalkService;
import com.shiyi.service.ApiUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author: 拾壹
 * @date: 2023/10/16
 * @describe:
 */
@RequestMapping("/v1/talk")
@RestController
@Api(tags = "话题接口")
@RequiredArgsConstructor
public class ApiTalkController {

    private final ApiTalkService apiTalkService;

    @GetMapping("list")
    @ApiOperation(value = "话题列表", httpMethod = "GET", response = ResponseResult.class, notes = "话题列表")
    public ResponseResult selectList(){
        return apiTalkService.selectList();
    }

    @GetMapping("analysis")
    @ApiOperation(value = "解析网页地址", httpMethod = "GET", response = ResponseResult.class, notes = "解析网页地址")
    public ResponseResult analysis(String url){
        return apiTalkService.analysis(url);
    }

}
