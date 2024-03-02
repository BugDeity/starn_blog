package cn.com.starn.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import cn.com.starn.entity.UserInfo;
import cn.com.starn.mapper.UserInfoMapper;
import cn.com.starn.service.UserInfoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author blue
 * @since 2021-12-25
 */
@Slf4j
@Service
@RequiredArgsConstructor(onConstructor = @__(@Autowired))
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements UserInfoService {

}
