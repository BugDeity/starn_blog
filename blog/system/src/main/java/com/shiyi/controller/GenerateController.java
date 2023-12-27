package com.shiyi.controller;

import com.shiyi.common.ResponseResult;
import com.shiyi.service.GenerateService;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;


@RestController
@RequiredArgsConstructor
@RequestMapping("/system/generate")
public class GenerateController {

    private final GenerateService generateService;


    @GetMapping(value = "/list")
    public ResponseResult list() throws IOException {
        return generateService.selectListTables();
    }

    @GetMapping(value = "/preview/{tableName}")
    public ResponseResult index(@PathVariable String tableName) throws IOException {
        return generateService.generation(tableName);
    }

    /**
     * 生成代码（下载方式）
     */
    @GetMapping("/download")
    public void download(String tableName,String downloadPath) throws IOException
    {
        generateService.download(tableName,downloadPath);
    }
}
