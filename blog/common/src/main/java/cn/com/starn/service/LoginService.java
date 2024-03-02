package cn.com.starn.service;


import cn.com.starn.common.ResponseResult;
import cn.com.starn.dto.Captcha;
import cn.com.starn.dto.LoginDTO;

/**
 * @author blue
 * @description:
 * @date 2021/7/30 14:58
 */
public interface LoginService {

    ResponseResult login(LoginDTO vo);

    ResponseResult getCaptcha(Captcha captcha);
}
