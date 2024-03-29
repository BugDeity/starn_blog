package cn.com.starn.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.com.starn.annotation.OperationLogger;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.service.CloudOssService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;


@RestController
@RequestMapping("/file")
@Api(tags = "图片上传-接口")
@RequiredArgsConstructor
public class UploadController {

    private final CloudOssService cloudOssService;

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    @SaCheckPermission("/file/list")
    @ApiOperation(value = "图片列表",httpMethod = "GET", response = ResponseResult.class, notes = "图片列表")
    public ResponseResult list(int strategyModel,int pageNo, int pageSize){
        return cloudOssService.list(strategyModel,pageNo,pageSize);
    }

    @SaCheckLogin
    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    @ApiOperation(value = "上传图片",httpMethod = "POST", response = ResponseResult.class, notes = "上传图片")
    public ResponseResult upload(MultipartFile multipartFile){
        return cloudOssService.upload(multipartFile);
    }

    @OperationLogger("批量删除图片")
    @SaCheckPermission("/file/delBatchFile")
    @RequestMapping(value = "/delBatchFile",method = RequestMethod.POST)
    @ApiOperation(value = "批量删除文件",httpMethod = "POST", response = ResponseResult.class, notes = "批量删除文件")
    public ResponseResult delBatchFile(String key){
        return cloudOssService.delBatchFile(key);
    }
}
