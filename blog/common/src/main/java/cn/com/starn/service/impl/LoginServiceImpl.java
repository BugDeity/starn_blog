package cn.com.starn.service.impl;

import cn.dev33.satoken.stp.SaLoginModel;
import cn.dev33.satoken.stp.StpUtil;
import cn.com.starn.common.Constants;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.dto.Captcha;
import cn.com.starn.dto.LoginDTO;
import cn.com.starn.entity.User;
import cn.com.starn.exception.BusinessException;
import cn.com.starn.mapper.UserMapper;
import cn.com.starn.service.LoginService;
import cn.com.starn.utils.AesEncryptUtils;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static cn.com.starn.common.ResultCode.ERROR_PASSWORD;

/**
 * @author blue
 * @description:
 * @date 2021/7/30 14:59
 */
@Service
@RequiredArgsConstructor(onConstructor = @__(@Autowired))
public class LoginServiceImpl implements LoginService {

    private final UserMapper userMapper;

    private final CaptchaServiceImpl captchaService;

    @Override
    public ResponseResult getCaptcha(Captcha captcha) {
        return ResponseResult.success(captchaService.getCaptcha(captcha));
    }

    @Override
    public ResponseResult login(LoginDTO dto) {

        //先校验验证码
        String msg = captchaService.checkImageCode(dto.getNonceStr(),dto.getValue());
        if (StringUtils.isNotBlank(msg)) {
            return ResponseResult.error(msg);
        }

        //校验用户名和密码
        User user = userMapper.selectNameAndPassword(dto.getUsername(), AesEncryptUtils.aesEncrypt(dto.getPassword()));
        if (user == null){
            throw new BusinessException(ERROR_PASSWORD.desc);
        }

        if (dto.getRememberMe()) {
            StpUtil.login(user.getId(),new SaLoginModel().setTimeout(60 * 60 * 24 * 7));
        }else {
            StpUtil.login(user.getId(),"system");
        }
        StpUtil.getSession().set(Constants.CURRENT_USER,userMapper.getById(user.getId()));
        return ResponseResult.success(StpUtil.getTokenValue());
    }


}
