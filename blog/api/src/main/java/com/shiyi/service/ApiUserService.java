package com.shiyi.service;

import com.shiyi.common.ResponseResult;
import com.shiyi.dto.EmailLoginDTO;
import com.shiyi.dto.UserInfoDTO;
import me.chanjar.weixin.mp.bean.message.WxMpXmlMessage;
import me.zhyd.oauth.model.AuthResponse;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

public interface ApiUserService {
    /**
     * 邮箱登录
     * @param emailLoginDTO
     * @return
     */
    public ResponseResult emailLogin(EmailLoginDTO emailLoginDTO);

    /**
     * 获取微信登录验证码
     * @return
     */
    public ResponseResult getWechatLoginCode();

    /**
     * 微信公众号登录
     * @param message
     * @return
     */
    public String wechatLogin(WxMpXmlMessage message);

    /**
     * 判断用户是否微信登录成功
     * @param loginCode 登录码
     * @return
     */
    public ResponseResult wxIsLogin(String loginCode);


    /**
     * 获取用户信息
     * @return
     */
    public ResponseResult selectUserInfo();

    /**
     * 修改用户信息
     * @param vo
     * @return
     */
    public ResponseResult updateUser(UserInfoDTO vo);

    /**
     * 根据token获取用户信息
     * @param token
     * @return
     */
    public ResponseResult selectUserInfoByToken(String token);


    /**
     * 第三方登录授权之后的逻辑
     * @param response
     * @param source
     * @param httpServletResponse
     * @throws IOException
     */
    public void authLogin(AuthResponse response, String source, HttpServletResponse httpServletResponse) throws IOException;

}
