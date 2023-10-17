package com.shiyi.vo.talk;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.shiyi.utils.DateUtil;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author: 拾壹
 * @date: 2023/10/17
 * @describe:
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ApiForumCommentListVO {

    @ApiModelProperty(value = "主键id")
    private Integer id;


    @ApiModelProperty(value = "用户id")
    private String userId;

    @ApiModelProperty(value = "用户昵称")
    private String nickname;

    @ApiModelProperty(value = "用户头像")
    private String avatar;

    @ApiModelProperty(value = "回复用户id")
    private String replyUserId;

    @ApiModelProperty(value = "回复用户昵称")
    private String replyNickname;

    @ApiModelProperty(value = "恢复用户头像")
    private String replyAvatar;

    @ApiModelProperty(value = "内容")
    private String content;

    @ApiModelProperty(value = "圈子内容id")
    private Integer forumId;

    @ApiModelProperty(value = "ip归属地")
    private String address;


    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    private List<ApiForumCommentListVO> children = new ArrayList<>();

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = DateUtil.MM_DD,timezone="GMT+8")
    private String createTimeStr;
}
