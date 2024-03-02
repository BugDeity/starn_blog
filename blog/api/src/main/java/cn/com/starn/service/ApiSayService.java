package cn.com.starn.service;

import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.Say;
import cn.com.starn.entity.SayComment;

public interface ApiSayService {


    /**
     * 说说列表
     * @return
     */
    ResponseResult selectSayList();

    /**
     * 点赞说说
     * @param sayId
     * @return
     */
    ResponseResult like(String sayId);

    /**
     * 评论说说
     * @param sayComment
     * @return
     */
    ResponseResult comment(SayComment sayComment);

    /**
     * 添加说说说
     * @param say
     * @return
     */
    ResponseResult insertSay(Say say);

}
