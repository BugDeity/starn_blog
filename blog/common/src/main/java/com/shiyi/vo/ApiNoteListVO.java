package com.shiyi.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.shiyi.utils.DateUtil;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * 笔记列表vo
 */
@Data
public class ApiNoteListVO {

    @ApiModelProperty(value = "id")
    private Integer id;

    @ApiModelProperty(value = "用户昵称")
    private String nickname;

    @ApiModelProperty(value = "用户头像")
    private String avatar;

    @ApiModelProperty(value = "内容")
    private String content;

    @ApiModelProperty(value = "分类名")
    private String categoryName;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = DateUtil.YYYY_MM_DD_HH_MM_SS,timezone="GMT+8")
    private Date createTime;
}
