package com.shiyi.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.shiyi.utils.DateUtil;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;
import java.util.Map;

@Data
public class ImMessageVO {

    @ApiModelProperty(value = "主键id")
    private String id;

    @ApiModelProperty(value = "消息类型")
    private Integer code;

    @ApiModelProperty(value = "接收用户Id")
    private String toUserId;

    @ApiModelProperty(value = "发送用户id")
    private String fromUserId;

    @ApiModelProperty(value = "发送用户头像")
    private String fromUserAvatar;

    @ApiModelProperty(value = "发送用户昵称")
    private String fromUserNickname;

    @ApiModelProperty(value = "内容")
    private String content;

    @ApiModelProperty(value = "ip")
    private String ip;

    @ApiModelProperty(value = "ip地址")
    private String ipSource;

    @ApiModelProperty(value = "是否撤回")
    private int isWithdraw;

    @ApiModelProperty(value = "选中下标")
    private Integer index;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = DateUtil.YYYY_MM_DD_HH_MM,timezone="GMT+8")
    private Date createTime;

    @ApiModelProperty(value = "创建时间")
    private String createTimeStr;

    @ApiModelProperty(value = "扩展信息")
    private Map<String, Object> ext;
}
