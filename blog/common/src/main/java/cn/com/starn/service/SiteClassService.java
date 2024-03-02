package cn.com.starn.service;

import com.baomidou.mybatisplus.extension.service.IService;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.SiteClass;

import java.util.List;


/**
 * <p>
 *  服务类
 * </p>
 *
 * @author blue
 * @since 2022-01-13
 */
public interface SiteClassService extends IService<SiteClass> {


    ResponseResult selectSiteClassList();


    ResponseResult insertSiteClass(SiteClass siteClass);

    ResponseResult updateSiteClass(SiteClass siteClass);


    ResponseResult deleteBatch(List<Integer> ids);

}
