package cn.com.starn.service;

import com.baomidou.mybatisplus.extension.service.IService;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.Comment;
import cn.com.starn.entity.Say;

import java.util.List;

/**
 * <p>
 * 博客文章表 服务类
 * </p>
 *
 * @author blue
 * @since 2021-08-18
 */
public interface SayService extends IService<Say> {


    ResponseResult selectSayList(String keywords);

    ResponseResult insertSay(Say say);

    ResponseResult deleteSay(List<String> ids);

    ResponseResult selectSayById(String id);

    ResponseResult updateSayById(Say say);
}
