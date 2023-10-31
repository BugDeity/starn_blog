package com.shiyi.controller;

import com.shiyi.common.ResponseResult;
import com.shiyi.service.GenerateService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import java.io.IOException;


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
}
