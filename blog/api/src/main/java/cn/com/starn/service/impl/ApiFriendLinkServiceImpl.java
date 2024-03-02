package cn.com.starn.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import cn.com.starn.common.FieldConstants;
import cn.com.starn.common.ResponseResult;
import cn.com.starn.entity.FriendLink;
import cn.com.starn.exception.BusinessException;
import cn.com.starn.mapper.FriendLinkMapper;
import cn.com.starn.service.ApiFriendLinkService;
import cn.com.starn.service.EmailService;
import cn.com.starn.vo.ApiFriendLinkVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static cn.com.starn.enums.FriendLinkEnum.APPLY;
import static cn.com.starn.enums.FriendLinkEnum.UP;

@Service
@RequiredArgsConstructor
public class ApiFriendLinkServiceImpl implements ApiFriendLinkService {

    private final FriendLinkMapper friendLinkMapper;

    private final EmailService emailService;

    /**
     * 友链列表
     * @return
     */
    @Override
    public ResponseResult selectFriendLinkList() {
        List<ApiFriendLinkVO> list = friendLinkMapper.selectLinkList(UP.code);
        return ResponseResult.success(list);
    }

    /**
     * 申请友链
     * @param friendLink
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResponseResult insertFriendLink(FriendLink friendLink) {

        //如果已经申请过友链 再次接入则会进行下架处理 需重新审核
        FriendLink entity = friendLinkMapper.selectOne(new QueryWrapper<FriendLink>()
                .eq(FieldConstants.URL,friendLink.getUrl()));
        if (entity != null){
            throw new BusinessException("友链已存在，如需修改请留言!");
        }
        friendLink.setStatus(APPLY.getCode());
        friendLinkMapper.insert(friendLink);
        //异步操作邮箱发送
        emailService.emailNoticeMe("友链接入通知","网站有新的友链接入啦("+friendLink.getUrl()+")，快去审核吧!!!");
        return ResponseResult.success();
    }
}
