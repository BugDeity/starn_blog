package com.shiyi.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import com.shiyi.annotation.BusinessLogger;
import com.shiyi.annotation.OperationLogger;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.FeedBack;
import com.shiyi.service.ApiFeedBackService;
import com.shiyi.service.FeedBackService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author blue
 * @date 2022/1/13
 * @apiNote
 */
@RestController
@RequestMapping("/v1/feedback")
@RequiredArgsConstructor
@Api(tags = "反馈API-V1")
public class ApiFeedBackController {

    private final ApiFeedBackService feedBackService;

    @SaCheckLogin
    @OperationLogger(save = false,value = "添加反馈")
    @PostMapping(value = "/")
    @ApiOperation(value = "添加反馈", httpMethod = "POST", response = ResponseResult.class, notes = "添加反馈")
    public ResponseResult insertFeedback(@RequestBody FeedBack feedBack) {
        return  feedBackService.insertFeedback(feedBack);
    }

}
