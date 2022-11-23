package com.group7.artshare.controller

import com.group7.artshare.entity.RegisteredUser
import com.group7.artshare.service.JwtService
import com.group7.artshare.service.ProfileService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException

@RestController
@CrossOrigin(origins = ["*"], allowedHeaders = ["*"])
@RequestMapping
class UserInteractionController(
    private val profileService: ProfileService,
    private val jwtService: JwtService
) {

    @PostMapping("/follow/{username}")
    fun followUser(
        @PathVariable(value = "username") username: String,
        @RequestHeader(value = "Authorization", required = true) authorizationHeader: String
    ): RegisteredUser {
        try {
            authorizationHeader.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return profileService.followUser(username , user)
            }
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }
}