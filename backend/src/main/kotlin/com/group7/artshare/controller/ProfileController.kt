package com.group7.artshare.controller

import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.service.ProfileService
import org.springframework.web.bind.annotation.*

@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping("profile")
class ProfileController(
    private val profileService: ProfileService
) {

    @GetMapping("{username}")
    fun getUserByUsername(
        @PathVariable(value = "username") username: String,
        @RequestHeader(value = "Authorization", required = false) authorizationHeader: String?
    ): RegisteredUser {
        return profileService.getUserByUsername(username, authorizationHeader)
    }

    @GetMapping()
    fun getUserByUsername(
        @RequestHeader(value = "Authorization", required = true) authorizationHeader: String
    ): RegisteredUser {
        return profileService.getUserByUsername(null, authorizationHeader)
    }


}