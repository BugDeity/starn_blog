package cn.com.starn.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import cn.com.starn.entity.SystemConfig;
import cn.com.starn.vo.TableListVO;

/**
 * <p>
 * 系统配置表 Mapper 接口
 * </p>
 *
 * @author blue
 * @since 2021-11-25
 */
public interface SystemConfigMapper extends BaseMapper<SystemConfig> {

    Page<TableListVO> selectTables(Page<Object> objectPage);
}
