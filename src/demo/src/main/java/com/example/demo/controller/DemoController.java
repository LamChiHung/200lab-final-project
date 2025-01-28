package com.example.demo.controller;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping
@RequiredArgsConstructor
public class DemoController {
    private static final Logger log = LoggerFactory.getLogger(DemoController.class);

    @GetMapping()
    public String hello() {
        log.info("Hello!");
        return "Hello";
    }

    @GetMapping("/exception")
    public String exception() {
        throw new RuntimeException("Exception!");
    }

    @GetMapping("/log-exception")
    public String logException() {
        try {
            throw new RuntimeException("Exception!");
        } catch (RuntimeException e) {
            log.error("Exception",e);
        }
        return "Exception";
    }
}
