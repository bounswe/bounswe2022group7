package com.group7.artshare.controller

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class printa {

    @GetMapping("/printHello")
    fun printHello() {
        print("Hello")
    }
}