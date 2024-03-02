package cn.com.starn.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import cn.com.starn.entity.FriendLink;
import cn.com.starn.vo.ApiFriendLinkVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 * 友情链接表 Mapper 接口
 * </p>
 *
 * @author blue
 * @since 2021-08-18
 */
@Repository
public interface FriendLinkMapper extends BaseMapper<FriendLink> {

    Integer getMaxSort();

    void top(@Param("id") Integer id, @Param("sort") int sort);

    List<ApiFriendLinkVO> selectLinkList(@Param("status") Integer status);

}
