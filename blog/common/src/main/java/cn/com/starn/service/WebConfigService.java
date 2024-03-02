package cn.com.starn.service;

import com.baomidou.mybatisplus.extension.service.IService;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.WebConfig;

/**
 * <p>
 * 网站配置表 服务类
 * </p>
 *
 * @author blue
 * @since 2021-11-27
 */
public interface WebConfigService extends IService<WebConfig> {

    ResponseResult listWebConfig();

    ResponseResult updateWebConfig(WebConfig webConfig);
}
