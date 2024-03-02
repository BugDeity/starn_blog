package cn.com.starn.service;

import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.FeedBack;

public interface ApiFeedBackService {
    /**
     * 添加反馈
     * @return
     */
    public ResponseResult insertFeedback(FeedBack feedBack);


}
