package com.shiyi.service;

import com.shiyi.common.ResponseResult;
import com.shiyi.entity.SayComment;

public interface ApiSayService {


    ResponseResult selectSayList();

    ResponseResult like(String sayId);

    ResponseResult comment(SayComment sayComment);

}
