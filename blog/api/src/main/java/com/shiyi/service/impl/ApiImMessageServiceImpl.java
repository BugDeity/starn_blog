package com.shiyi.service.impl;


import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.shiyi.common.ResponseResult;
import com.shiyi.entity.ImMessage;
import com.shiyi.entity.ImRoom;
import com.shiyi.exception.BusinessException;
import com.shiyi.handle.RelativeDateFormat;
import com.shiyi.mapper.ImMessageMapper;
import com.shiyi.mapper.ImRoomMapper;
import com.shiyi.mapper.UserMapper;
import com.shiyi.service.ApiImMessageService;
import com.shiyi.utils.BeanCopyUtils;
import com.shiyi.utils.IpUtil;
import com.shiyi.utils.PageUtils;
import com.shiyi.vo.ImMessageVO;
import com.shiyi.vo.ImOnlineUserVO;
import com.shiyi.vo.ImRoomListVO;
import com.shiyi.vo.UserInfoVO;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;


/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author blue
 * @since 2021-11-10
 */
@Service
@RequiredArgsConstructor
public class ApiImMessageServiceImpl  implements ApiImMessageService {

    private final ImMessageMapper imMessageMapper;

    private final ImRoomMapper imRoomMapper;

    private final UserMapper userMapper;

    @Override
    public ResponseResult selectHistoryList() {
        Page<ImMessageVO> page = imMessageMapper.selectPublicHistoryList(new Page<>(PageUtils.getPageNo(),
                        PageUtils.getPageSize()));
        formatCreateTime(page);
        return ResponseResult.success(page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ImMessageVO updateOrInsert(ImMessageVO obj, HttpServletRequest request) {
        ImMessage imMessage = BeanCopyUtils.copyObject(obj, ImMessage.class);
        imMessage.setIp(IpUtil.getIp(request));
        imMessage.setIpSource(IpUtil.getIp2region(imMessage.getIp()));
        //撤回消息
        if (obj.getIsWithdraw() == 1) {
            imMessageMapper.updateById(imMessage);
        }else {
            //保存消息到数据库
            imMessageMapper.insert(imMessage);
        }
        obj.setId(imMessage.getId());
        obj.setCreateTimeStr(RelativeDateFormat.format(imMessage.getCreateTime()));
        obj.setIpSource(imMessage.getIpSource());
        return obj;
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

    private static void formatCreateTime(Page<ImMessageVO> page) {
        page.getRecords().forEach(item ->{
            item.setCreateTimeStr(RelativeDateFormat.format(item.getCreateTime()));
        });
    }
}
