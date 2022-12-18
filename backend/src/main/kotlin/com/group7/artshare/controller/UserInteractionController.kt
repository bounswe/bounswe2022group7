package com.group7.artshare.controller

import com.group7.artshare.service.JwtService
import com.group7.artshare.service.ProfileService
import com.group7.artshare.service.SearchService
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException

@RestController
class UserInteractionController(
    private val profileService: ProfileService,
    private val jwtService: JwtService,
    private val searchService: SearchService
) {

    @PostMapping("/follow/{username}")
    @ResponseStatus(HttpStatus.ACCEPTED)
    fun followUser(
        @PathVariable(value = "username") username: String,
        @RequestHeader(value = "Authorization", required = true) authorizationHeader: String
    ) {
        try {
            authorizationHeader.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                profileService.followUser(username , user)
            }
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }



    @GetMapping("search")
    fun search(
        @RequestParam(value = "keywords") keywords: List<String>,
        @RequestHeader(
            value = "Authorization",
            required = false
        ) authorizationHeader: String?
    ): List<Any> {
        try {
            authorizationHeader?.let {
                val user =
                    jwtService.getUserFromAuthorizationHeader(authorizationHeader) ?: throw Exception("Invalid token")
                return searchService.search(keywords)

            } ?: return searchService.search(keywords) //if we want to customize the search results according to user, replace the method call here
        } catch (e: Exception) {
            if (e.message == "Invalid token") {
                throw ResponseStatusException(HttpStatus.UNAUTHORIZED, e.message)
            } else {
                throw ResponseStatusException(HttpStatus.BAD_REQUEST, e.message)
            }
        }
    }

}