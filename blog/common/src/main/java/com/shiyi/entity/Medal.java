package com.shiyi.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.shiyi.utils.DateUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.io.Serializable;
import java.util.Date;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
@TableName("b_medal")
@ApiModel(value="Medal", description="")
public class Medal implements Serializable {
    private static final long serialVersionUID=1L;


    @ApiModelProperty(value = "主键id")
    @TableId(value = "id", type = IdType.ASSIGN_UUID)
    private String id;

    @ApiModelProperty(value = "勋章分类id")
    private Integer categoryId;

    @ApiModelProperty(value = "勋章名")
    private String name;

    @ApiModelProperty(value = "图片地址")
    private String url;

    @ApiModelProperty(value = "勋章描述")
    private String info;

    @ApiModelProperty(value = "类型 1svg地址 2图片地址")
    private Integer type;

    @ApiModelProperty(value = "创建时间")
    @TableField(fill = FieldFill.INSERT)
    @JsonFormat(pattern = DateUtil.FORMAT_STRING,timezone="GMT+8")
    private Date createTime;
}
