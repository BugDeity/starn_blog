package cn.com.starn.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import cn.com.starn.utils.DateUtil;
import lombok.Data;

import java.util.Date;

/**
 * @author: 思易
 * @date: 2023/10/30
 * @describe:
 */
@Data
public class TableListVO {

    private String  name;

    private String  comment;

    @JsonFormat(pattern = DateUtil.FORMAT_STRING,timezone="GMT+8")
    private Date  createTime;

    @JsonFormat(pattern = DateUtil.FORMAT_STRING,timezone="GMT+8")
    private Date updateTime;
}
