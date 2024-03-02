package cn.com.starn.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import cn.com.starn.entity.ImRoom;
import cn.com.starn.vo.ImRoomListVO;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 * </p>
 *
 * @author blue
 * @since 2021-08-18
 */
@Repository
public interface ImRoomMapper extends BaseMapper<ImRoom> {


    List<ImRoomListVO> selectListByUserId(String userId);
}
