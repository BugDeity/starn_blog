package com.shiyi.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.dev33.satoken.annotation.SaCheckPermission;
import com.shiyi.annotation.OperationLogger;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.Sponsor;
import com.shiyi.service.SponsorService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author: 拾壹
 * @date: 2023/10/25
 * @describe:
 */
@RestController
@RequestMapping("/system/sponsor")
@Api(tags = "后台打赏管理")
@RequiredArgsConstructor
public class SponsorController {
    private final SponsorService sponsorService;

    @SaCheckLogin
    @GetMapping(value = "/list")
    @ApiOperation(value = "打赏列表", httpMethod = "GET", response = ResponseResult.class, notes = "打赏列表")
    public ResponseResult selectSponsorList() {
        return sponsorService.selectSponsorList();
    }

    @SaCheckLogin
    @GetMapping(value = "/info")
    @ApiOperation(value = "打赏详情", httpMethod = "GET", response = ResponseResult.class, notes = "打赏详情")
    public ResponseResult selectSponsorInfo(Integer id) {
        return sponsorService.selectSponsorInfo(id);
    }


    @PutMapping(value = "/update")
    @OperationLogger(value = "修改打赏")
    @SaCheckPermission("/system/sponsor/update")
    @ApiOperation(value = "修改打赏", httpMethod = "PUT", response = ResponseResult.class, notes = "修改打赏")
    public ResponseResult update(@RequestBody Sponsor sponsor) {
        return sponsorService.updateSponsor(sponsor);
    }

    @DeleteMapping(value = "/delete")
    @OperationLogger(value = "删除打赏")
    @SaCheckPermission("/system/sponsor/delete")
    @ApiOperation(value = "删除打赏", httpMethod = "DELETE", response = ResponseResult.class, notes = "删除打赏")
    public ResponseResult delete(@RequestBody List<Integer> ids) {
        return sponsorService.deleteSponsor(ids);
    }
}
