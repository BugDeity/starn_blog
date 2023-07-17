package com.shiyi.service.impl;


import cn.dev33.satoken.stp.StpUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.ImMessage;
import com.shiyi.entity.ImRoom;
import com.shiyi.exception.BusinessException;
import com.shiyi.handle.RelativeDateFormat;
import com.shiyi.im.MessageCodeConstant;
import com.shiyi.im.WebSocketInfoService;
import com.shiyi.mapper.ImMessageMapper;
import com.shiyi.mapper.ImRoomMapper;
import com.shiyi.mapper.UserMapper;
import com.shiyi.service.ApiImMessageService;
import com.shiyi.utils.*;
import com.shiyi.vo.ImMessageVO;
import com.shiyi.vo.ImOnlineUserVO;
import com.shiyi.vo.ImRoomListVO;
import com.shiyi.vo.UserInfoVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author blue
 * @since 2021-11-10
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ApiImMessageServiceImpl  implements ApiImMessageService {

    private final ImMessageMapper imMessageMapper;

    private final ImRoomMapper imRoomMapper;

    private final UserMapper userMapper;

    private final WebSocketInfoService webSocketInfoService;

    private Pattern pattern = Pattern.compile("(http|https)://[\\w\\d.-]+(/[\\w\\d./?=#&-]*)?");

    @Override
    public ResponseResult selectHistoryList() {
        Page<ImMessageVO> page = imMessageMapper.selectPublicHistoryList(new Page<>(PageUtils.getPageNo(),
                        PageUtils.getPageSize()));
        formatCreateTime(page);
        return ResponseResult.success(page);
    }

    @Override
    public List<ImOnlineUserVO> selectOnlineUserList(Set<String> keys) {
        return imMessageMapper.selectPublicOnlineUserList(keys);
    }

    @Override
    public ResponseResult selectUserImHistoryList(String fromUserId, String toUserId) {
        Page<ImMessageVO> page = imMessageMapper.selectPublicUserImHistoryList(new Page<>(PageUtils.getPageNo(), PageUtils.getPageSize()),
                fromUserId,toUserId);
        formatCreateTime(page);
        return ResponseResult.success(page);
    }

    /**
     * 获取房间列表
     * @return
     */
    @Override
    public ResponseResult selectRoomList() {
        List<ImRoomListVO> list = new ArrayList<>();
        List<ImRoom> imRooms = imRoomMapper.selectList(new LambdaQueryWrapper<ImRoom>().like(ImRoom::getMember, StpUtil.getLoginIdAsString()).orderByDesc(ImRoom::getCreateTime));
        for (ImRoom imRoom : imRooms) {
            String[] userIds = imRoom.getMember().split(",");
            for (String userId : userIds) {
                if (!userId.equals(StpUtil.getLoginIdAsString())) {
                    UserInfoVO userInfoVO = userMapper.selectInfoByUserId(userId);
                    ImRoomListVO vo = ImRoomListVO.builder().id(imRoom.getId()).receiveId(userId).nickname(userInfoVO.getNickname())
                            .avatar(userInfoVO.getAvatar()).createTimeStr(RelativeDateFormat.format(imRoom.getCreateTime())).build();
                    int readNum = imMessageMapper.selectListReadByUserId(userId,StpUtil.getLoginIdAsString());
                    vo.setReadNum(readNum);
                    list.add(vo);
                }
            }
        }
        return ResponseResult.success(list);
    }

    /**
     * 创建房间
     * @param userId
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult addRoom(String userId) {
        if (StringUtils.isBlank(userId)) {
            throw new BusinessException("请选择用户！");
        }
        if (userId.equals(StpUtil.getLoginIdAsString())) {
            throw new BusinessException("不能跟自己聊天！");
        }
        ImRoomListVO vo = null;
        String member = StpUtil.getLoginIdAsString() + "," + userId;
        ImRoom imRoom = imRoomMapper.selectOne(new LambdaQueryWrapper<ImRoom>().eq(ImRoom::getMember, member));
        if (imRoom == null) {
            imRoom = ImRoom.builder().type(1).member(member).build();
            imRoomMapper.insert(imRoom);
            UserInfoVO userInfoVO = userMapper.selectInfoByUserId(userId);
            vo = ImRoomListVO.builder().id(imRoom.getId()).receiveId(userId).nickname(userInfoVO.getNickname())
                    .avatar(userInfoVO.getAvatar()).createTimeStr(RelativeDateFormat.format(imRoom.getCreateTime())).build();
        }
        return ResponseResult.success(vo);
    }

    /**
     * 已读消息
     * @param userId
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult read(String userId) {
        imMessageMapper.updateRead(userId,StpUtil.getLoginIdAsString());
        return ResponseResult.success();
    }

    /**
     * 删除房间
     * @param roomId 房间id
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult deleteRoom(String roomId) {
        imRoomMapper.deleteById(roomId);
        return ResponseResult.success();
    }

    /**
     * 发送消息
     * @param obj 消息
     * @param request
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult chat(ImMessageVO obj, HttpServletRequest request) {
        Matcher matcher = pattern.matcher(obj.getContent());
        //字符串找出http地址
        String content = obj.getContent();
        String url = null;
        try {
            while (matcher.find()) {
                url = matcher.group();
                Document doc = Jsoup.connect(url).get();
                String hrefContent = String.format("<a href=\"%s\" target=\"_blank\" >%s</a>", url, doc.title());
                content = content.replace(url, hrefContent);
            }
        } catch (IOException e) {
            log.error("website {} analysis error", url);
        }
        //过滤敏感词
        String filterContent = SensitiveUtils.filter(content);
        obj.setContent(filterContent);
        obj.setIp(IpUtil.getIp(request));
        obj.setIpSource(IpUtil.getIp2region(obj.getIp()));

        ImMessage imMessage = BeanCopyUtils.copyObject(obj, ImMessage.class);
        //保存消息到数据库
        imMessageMapper.insert(imMessage);
        obj.setId(imMessage.getId());
        obj.setCreateTimeStr(RelativeDateFormat.format(imMessage.getCreateTime()));

        webSocketInfoService.chat(obj);
        return ResponseResult.success();
    }

    /**
     * 撤回消息
     * @param message 消息对象
     * @param request
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult withdraw(ImMessageVO message, HttpServletRequest request) {
        ImMessage entity = imMessageMapper.selectById(message.getId());
        if (DateUtil.getDiffDateToMinutes(entity.getCreateTime(),DateUtil.getNowDate()) >= 2) {
            throw new BusinessException("撤回失败，只能撤回俩分钟以内的消息！");
        }
        if (!entity.getFromUserId().equals(StpUtil.getLoginIdAsString())) {
            throw new BusinessException("只能撤回自己的消息哦！");
        }
        ImMessage imMessage = BeanCopyUtils.copyObject(message, ImMessage.class);
        imMessage.setIp(IpUtil.getIp(request));
        imMessage.setIpSource(IpUtil.getIp2region(imMessage.getIp()));

        //修改消息
        imMessageMapper.updateById(imMessage);
        //发送消息
        webSocketInfoService.chat(message);

        return ResponseResult.success();
    }

    private static void formatCreateTime(Page<ImMessageVO> page) {
        page.getRecords().forEach(item ->{
            item.setCreateTimeStr(RelativeDateFormat.format(item.getCreateTime()));
        });
    }

}
