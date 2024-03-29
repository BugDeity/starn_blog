package cn.com.starn.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.com.starn.annotation.OperationLogger;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.dto.SystemUserDTO;
import cn.com.starn.entity.User;
import cn.com.starn.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author blue
 * @description:
 * @date 2021/7/30 17:12
 */
@RestController
@RequestMapping("/system/user")
@Api(tags = "系统用户管理-接口")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping(value = "/list")
    @SaCheckLogin
    @ApiOperation(value = "用户列表", httpMethod = "GET", response = ResponseResult.class, notes = "用户列表")
    public ResponseResult list(String username, Integer loginType) {
        return userService.listUser(username,loginType);
    }

    @PostMapping(value = "/create")
    @SaCheckPermission("/system/user/create")
    @ApiOperation(value = "添加用户", httpMethod = "POST", response = ResponseResult.class, notes = "添加用户")
    @OperationLogger(value = "添加用户")
    public ResponseResult insert(@RequestBody SystemUserDTO user) {
        return userService.insertUser(user);
    }

    @GetMapping(value = "/info")
    @SaCheckPermission("/system/user/info")
    @ApiOperation(value = "用户详情", httpMethod = "GET", response = ResponseResult.class, notes = "用户详情")
    public ResponseResult getUserById(String id) {
        return userService.getUserById(id);
    }

    @PostMapping(value = "/update")
    @SaCheckPermission("/system/user/update")
    @ApiOperation(value = "修改用户", httpMethod = "POST", response = ResponseResult.class, notes = "修改用户")
    @OperationLogger(value = "修改用户")
    public ResponseResult update(@RequestBody User user) {
        return userService.updateUser(user);
    }

    @RequestMapping(value = "/remove",method = RequestMethod.DELETE)
    @SaCheckPermission("/system/user/remove")
    @ApiOperation(value = "删除用户", httpMethod = "DELETE", response = ResponseResult.class, notes = "删除用户")
    @OperationLogger(value = "删除用户")
    public ResponseResult deleteBatch(@RequestBody List<String> ids) {
        return userService.deleteBatch(ids);
    }

    @PostMapping(value = "/getCurrentUserInfo")
    @SaCheckLogin
    @ApiOperation(value = "获取当前登录用户信息", httpMethod = "POST", response = ResponseResult.class, notes = "获取当前登录用户信息")
    public ResponseResult getCurrentUserInfo() {
        return userService.getCurrentUserInfo();
    }

    @PostMapping(value = "/getUserMenu")
    @SaCheckLogin
    @ApiOperation(value = "获取用户菜单", httpMethod = "POST", response = ResponseResult.class, notes = "获取用户菜单")
    public ResponseResult getCurrentUserMenu() {
        return userService.getCurrentUserMenu();
    }

    @PostMapping(value = "/updatePassword")
    @SaCheckPermission("/system/user/updatePassword")
    @ApiOperation(value = "修改密码", httpMethod = "POST", response = ResponseResult.class, notes = "修改密码")
    @OperationLogger(value = "修改密码")
    public ResponseResult updatePassword(@RequestBody Map<String,String> map) {
        return userService.updatePassword(map);
    }

    @GetMapping(value = "/online")
    @SaCheckLogin
    @ApiOperation(value = "查看在线用户", httpMethod = "GET", response = ResponseResult.class, notes = "查看在线用户")
    public ResponseResult listOnlineUsers(String keywords) {
        return userService.listOnlineUsers(keywords);
    }

    @GetMapping(value = "/kick")
    @SaCheckPermission("/system/user/kick")
    @OperationLogger(value = "踢人下线")
    @ApiOperation(value = "踢人下线", httpMethod = "GET", response = ResponseResult.class, notes = "踢人下线")
    public ResponseResult kick(String token) {
        return userService.kick(token);
    }
}
