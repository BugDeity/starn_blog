package com.shiyi.vo.sponsor;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.shiyi.utils.DateUtil;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.models.auth.In;
import lombok.Data;

import java.util.Date;

/**
 * @author: 拾壹
 * @date: 2023/10/25
 * @describe:
 */
@Data
public class SystemSponsorListVO {

    @ApiModelProperty(value = "id")
    private Integer id;

    @ApiModelProperty(value = "昵称")
    private String nickname;

    @ApiModelProperty(value = "支付截图")
    private String payImg;

    @ApiModelProperty(value = "金额")
    private double money;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = DateUtil.FORMAT_STRING,timezone="GMT+8")
    private Date createTime;
}
