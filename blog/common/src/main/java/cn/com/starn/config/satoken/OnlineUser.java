package cn.com.starn.config.satoken;

import com.fasterxml.jackson.annotation.JsonFormat;
import cn.com.starn.utils.DateUtil;
import lombok.Builder;
import lombok.Data;

import java.util.Date;

/**
 * @author blue
 * @date 2022/3/10
 * @apiNote
 */
@Data
@Builder
public class OnlineUser {
    private String loginId;
    private String userId;
    private String nickname;
    private String avatar;
    private String ip;
    private String os;
    private String city;
    private String browser;
    private String tokenValue;
    /**
     * 登录时间
     */
    @JsonFormat(pattern = DateUtil.FORMAT_STRING, timezone = "GMT+8")
    private Date loginTime;
    /**
     * 最近一次操作时间
     */
    @JsonFormat(pattern = DateUtil.FORMAT_STRING, timezone = "GMT+8")
    private Date lastActivityTime;
}

