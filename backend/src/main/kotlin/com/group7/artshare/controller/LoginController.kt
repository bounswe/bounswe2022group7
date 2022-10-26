package com.group7.artshare.controller

import com.group7.artshare.request.LoginRequest
import com.group7.artshare.service.LoginService
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController
import javax.validation.Valid


@RestController
class LoginController(private val loginService: LoginService) {
    @PostMapping("/login")
    fun login(@RequestBody loginRequest: @Valid LoginRequest?): String? {
        return loginService.login(loginRequest!!)
    }
}