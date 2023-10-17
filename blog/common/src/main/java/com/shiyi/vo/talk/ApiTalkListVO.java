package com.shiyi.vo.talk;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


/**
 * @author: 拾壹
 * @date: 2023/10/16
 * @describe:
 */
@Data
public class ApiTalkListVO {

    @ApiModelProperty(value = "主键id")
    private Integer id;


    @ApiModelProperty(value = "话题名")
    private String name;

    @ApiModelProperty(value = "话题图标")
    private String icon;

}
