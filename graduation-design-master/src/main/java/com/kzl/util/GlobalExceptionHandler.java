package com.kzl.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.SQLException;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    //处理数据库连接异常
    @ExceptionHandler({SQLException.class, DataAccessException.class})
    @ResponseBody
    public Result handleDatabaseException(Exception e){
        logger.error("数据库操作异常: " + e.getMessage(), e);
        return Result.createFail(500, "数据库连接失败，请稍后重试或联系管理员");
    }

    //处理其他未捕获异常
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result handleException(Exception e){
        logger.error("系统异常: " + e.getMessage(), e);
        return Result.createFail(500, "系统内部错误，请稍后重试");
    }
}
