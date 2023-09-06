package com.shiyi.aspect;

import cn.dev33.satoken.stp.StpUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.shiyi.annotation.OperationLogger;
import com.shiyi.entity.AdminLog;
import com.shiyi.entity.ExceptionLog;
import com.shiyi.exception.BusinessException;
import com.shiyi.mapper.AdminLogMapper;
import com.shiyi.mapper.ExceptionLogMapper;
import com.shiyi.utils.AspectUtils;
import com.shiyi.utils.DateUtil;
import com.shiyi.utils.IpUtil;
import com.shiyi.vo.SystemUserVO;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;

import static com.shiyi.common.Constants.CURRENT_USER;
import static com.shiyi.common.ResultCode.NOT_LOGIN;

/**
 * 日志切面
 *
 * @author blue
 * @date 2020年12月31日21:26:04
 */
@Aspect
@Component
@RequiredArgsConstructor
public class OperationLoggerAspect {

    private static final Logger logger = LoggerFactory.getLogger(OperationLoggerAspect.class);

    private final AdminLogMapper adminLogMapper;

    private final ExceptionLogMapper exceptionLogMapper;

    /**
     * 开始时间
     */
    Date startTime;

    @Pointcut(value = "@annotation(operationLogger)")
    public void pointcut(OperationLogger operationLogger) {

    }

    @Around(value = "pointcut(operationLogger)")
    public Object doAround(ProceedingJoinPoint joinPoint, OperationLogger operationLogger) throws Throwable {
        //因给了演示账号所有权限以供用户观看，所以执行业务前需判断是否是管理员操作
        if (!StpUtil.hasRole("admin") && !StpUtil.hasRole("user")) {
            throw new BusinessException(NOT_LOGIN);
        }

        startTime = DateUtil.getNowDate();

        //先执行业务
        Object result = joinPoint.proceed();
        try {
            // 日志收集
            handle(joinPoint, IpUtil.getRequest());

        } catch (Exception e) {
            logger.error("日志记录出错!", e);
        }

        return result;
    }


    @AfterThrowing(value = "pointcut(operationLogger)", throwing = "e")
    public void doAfterThrowing(JoinPoint joinPoint, OperationLogger operationLogger, Throwable e) throws Exception {
        String ip = IpUtil.getIp();
        String operationName = AspectUtils.INSTANCE.parseParams(joinPoint.getArgs(), operationLogger.value());
        // 获取参数名称字符串
        String paramsJson = getParamsJson((ProceedingJoinPoint) joinPoint);
        SystemUserVO user = (SystemUserVO) StpUtil.getSession().get(CURRENT_USER);

        ExceptionLog exception = ExceptionLog.builder().ip(ip).ipSource(IpUtil.getIp2region(ip))
                .params(paramsJson).username(user.getUsername()).method(joinPoint.getSignature().getName())
                .exceptionJson(JSON.toJSONString(e)).exceptionMessage(e.getMessage()).operation(operationName)
                .createTime(DateUtil.getNowDate()).build();
        exceptionLogMapper.insert(exception);
    }

    /**
     * 管理员日志收集
     *
     * @param point
     * @throws Exception
     */
    private void handle(ProceedingJoinPoint point, HttpServletRequest request) throws Exception {

        Method currentMethod = AspectUtils.INSTANCE.getMethod(point);

        //获取操作名称
        OperationLogger annotation = currentMethod.getAnnotation(OperationLogger.class);

        boolean save = annotation.save();

        String operationName = AspectUtils.INSTANCE.parseParams(point.getArgs(), annotation.value());
        if (!save) {
            return;
        }
        // 获取参数名称字符串
        String paramsJson = getParamsJson(point);

        // 当前操作用户
        SystemUserVO user = (SystemUserVO) StpUtil.getSession().get(CURRENT_USER);
        String type = request.getMethod();
        String ip = IpUtil.getIp();
        String url = request.getRequestURI();

        // 存储日志
        Date endTime = new Date();
        Long spendTime = endTime.getTime() - startTime.getTime();
        AdminLog adminLog = new AdminLog(ip, IpUtil.getIp2region(ip), type, url, user.getNickname(),
                paramsJson, point.getTarget().getClass().getName(),
                point.getSignature().getName(), operationName, spendTime);
        adminLogMapper.insert(adminLog);
    }

    private String getParamsJson(ProceedingJoinPoint joinPoint) throws ClassNotFoundException, NoSuchMethodException {
        // 参数值
        Object[] args = joinPoint.getArgs();
        Signature signature = joinPoint.getSignature();
        MethodSignature methodSignature = (MethodSignature) signature;
        String[] parameterNames = methodSignature.getParameterNames();

        // 通过map封装参数和参数值
        HashMap<String, Object> paramMap = new HashMap<>();
        for (int i = 0; i < parameterNames.length; i++) {
            paramMap.put(parameterNames[i], args[i]);
        }

        boolean isContains = paramMap.containsKey("request");
        if (isContains) paramMap.remove("request");
        return JSONObject.toJSONString(paramMap);
    }
}
