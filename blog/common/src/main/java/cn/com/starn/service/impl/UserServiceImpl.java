package cn.com.starn.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.config.satoken.MySaTokenListener;
import cn.com.starn.config.satoken.OnlineUser;
import cn.com.starn.dto.SystemUserDTO;
import cn.com.starn.entity.Menu;
import cn.com.starn.entity.User;
import cn.com.starn.entity.UserInfo;
import cn.com.starn.enums.LoginTypeEnum;
import cn.com.starn.exception.BusinessException;
import cn.com.starn.mapper.RoleMapper;
import cn.com.starn.mapper.UserInfoMapper;
import cn.com.starn.mapper.UserMapper;
import cn.com.starn.service.MenuService;
import cn.com.starn.service.UserService;
import cn.com.starn.utils.AesEncryptUtils;
import cn.com.starn.utils.DateUtil;
import cn.com.starn.utils.PageUtils;
import cn.com.starn.vo.SystemUserInfoVO;
import cn.com.starn.vo.SystemUserVO;
import cn.com.starn.vo.UserInfoVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import java.util.*;
import java.util.stream.Collectors;

import static cn.com.starn.common.ResultCode.ERROR_USER_NOT_EXIST;

/**
 * @author blue
 * @description:
 * @date 2021/7/30 17:25
 */
@Slf4j
@Service
@RequiredArgsConstructor(onConstructor = @__(@Autowired))
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    private final MenuService menuService;

    private final UserInfoMapper userInfoMapper;

    private final RoleMapper roleMapper;


    /**
     * 用户列表
     * @param username
     * @param loginType
     * @return
     */
    @Override
    public ResponseResult listUser(String username, Integer loginType) {
        Page<SystemUserInfoVO> page = baseMapper.selectPageRecord(new Page<>(PageUtils.getPageNo(), PageUtils.getPageSize()),username,loginType);
        return ResponseResult.success(page);
    }

    /**
     * 用户详情
     * @param id
     * @return
     */
    @Override
    public ResponseResult getUserById(String id) {
        SystemUserVO user = baseMapper.getById(id);
        return ResponseResult.success(user);
    }

    /**
     *  添加用户
     * @param dto
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult insertUser(SystemUserDTO dto) {
        UserInfoVO userInfoVO = baseMapper.selectByUserName(dto.getUsername());
        if (userInfoVO != null) {
            throw new BusinessException("用户名已存在!");
        }
        //添加用户信息
        UserInfo userInfo = UserInfo.builder().nickname(dto.getNickname()).avatar(dto.getAvatar()).build();
        userInfoMapper.insert(userInfo);

        //添加用户账号
        User user = User.builder().username(dto.getUsername()).password(AesEncryptUtils.aesEncrypt(dto.getPassword()))
                .status(dto.getStatus()).userInfoId(userInfo.getId()).roleId(dto.getRoleId()).loginType(LoginTypeEnum.EMAIL.getType()).build();

        baseMapper.insert(user);
        return ResponseResult.success(user);
    }

    /**
     *  修改用户
     * @param user
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult updateUser(User user) {
        baseMapper.updateById(user);
        return ResponseResult.success();
    }

    /**
     * 删除用户
     * @param ids
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult deleteBatch(List<String> ids) {
        //先删除用户账号
         baseMapper.deleteBatchIds(ids);
         //删除用户信息
        userInfoMapper.deleteByUserIds(ids);
        return ResponseResult.success();
    }

    /**
     * 获取当前登录用户详情
     * @return
     */
    @Override
    public ResponseResult getCurrentUserInfo() {
        return ResponseResult.success("获取当前登录用户信息成功", baseMapper.getById(StpUtil.getLoginIdAsString()));
    }

    /**
     * 获取当前登录用户所拥有的菜单权限
     * @return
     */
    @Override
    public ResponseResult getCurrentUserMenu() {
        List<Integer> menuIds = baseMapper.getMenuId(StpUtil.getLoginIdAsString());
        List<Menu> menus = menuService.listByIds(menuIds);
        List<Menu> menuTree = menuService.listMenuTree(menus);
        return ResponseResult.success(menuTree);
    }

    /**
     * 修改密码
     * @param map
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult updatePassword(Map<String, String> map) {

        User user = baseMapper.selectById(StpUtil.getLoginIdAsString());
        Assert.notNull(user,ERROR_USER_NOT_EXIST.getDesc());

        boolean isValid = AesEncryptUtils.validate(user.getPassword(),map.get("oldPassword"));
        Assert.isTrue(isValid,"旧密码校验不通过!");

        String newPassword = AesEncryptUtils.aesEncrypt(map.get("newPassword"));
        user.setPassword(newPassword);
        baseMapper.updateById(user);
        return ResponseResult.success("修改成功");
    }

    /**
     * 在线用户
     * @param keywords
     * @return
     */
    @Override
    public ResponseResult listOnlineUsers(String keywords) {
        int pageNo = PageUtils.getPageNo().intValue();
        int pageSize = PageUtils.getPageSize().intValue();

        List<OnlineUser> onlineUsers = MySaTokenListener.ONLINE_USERS;
        //根据关键词过滤
        if (StringUtils.isNotBlank(keywords)) {
            onlineUsers = MySaTokenListener.ONLINE_USERS.stream().filter(item -> item.getNickname().contains(keywords)).collect(Collectors.toList());
        }
        //排序
        onlineUsers.sort((o1,o2)->{
            if (o2.getLoginTime().getTime() > o1.getLoginTime().getTime()) {
                return 1;
            }else {
                return -1;
            }
        });
        int fromIndex = (pageNo-1) * pageSize;
        int toIndex = onlineUsers.size() - fromIndex > pageSize ? fromIndex + pageSize : onlineUsers.size();
        List<OnlineUser> userOnlineList = onlineUsers.subList(fromIndex, toIndex);
        logger.info("memory用户数：{}", userOnlineList.size());

        Map<String,Object> map = new HashMap<>();
        map.put("total",onlineUsers.size());
        map.put("records",userOnlineList);
        return ResponseResult.success(map);
    }

    /**
     * 踢人下线
     * @param token
     * @return
     */
    @Override
    public ResponseResult kick(String token) {
        logger.info("当前踢下线的用户token为:{}",token);
        StpUtil.kickoutByTokenValue(token);
        return ResponseResult.success();
    }
}
